
(: -------------------------------------------------------------------------- :)
(: 1 :)

//flight
  [@date = "2019-10-18"]
  [line = //line[arrival/airport/@country = "DEU"]/@number]

let $a := //flight[@date = "2019-10-18"][line = //line[arrival/airport/@country = "DEU"]/@number]
return $a

let $a := //line[arrival/airport/@country = "DEU"]/@number
return //flight[@date = "2019-10-18"][line = $a]

let $a := //line[arrival/airport/@country = "DEU"]/@number
for $f in //flight[@date = "2019-10-18"][line = $a]
return $f

let $a := //line[arrival/airport/@country = "DEU"]/@number
for $f in //flight
where ($f/@date = "2019-10-18") and ($f/line = $a)
return $f

(: -------------------------------------------------------------------------- :)
(: 2A :)

for $n in /airport/lines/line
where $n/duration > 60
return
  <line origin="{ $n/departure/airport/@code }" destination="{ $n/arrival/airport/@code }">
    <code>{ data($n/@number) }</code>
    <departure>{ data($n/departure/time) }</departure>
    <arrival>{ data($n/arrival/time) }</arrival>
  </line>

  ...<line origin="{ data($n/departure/airport/@code) }" ...>

  ...<departure>{ $n/departure/time/text() }</departure>
  ...<arrival>{ $n/arrival/time/text() }</arrival>

for $n in /airport/lines/line[duration > 60]
...

(: INCORRECT :)

... <code>{ $n/@number }</code>
... <departure>{ $n/departure/time }</departure>

(: -------------------------------------------------------------------------- :)
(: 2B :)

...
return
  element line {
    attribute origin { $n/departure/airport/@code },
    attribute destination { $n/arrival/airport/@code },
    element code { data($n/@number) },
    element departure { data($n/departure/time) },
    element arrival { data($n/arrival/time) }
  }

(: -------------------------------------------------------------------------- :)
(: 3 :)

for $a in distinct-values(//airline)
let $n := //line[airline = $a]/@number
where
  every $f in //flight[line = $n] satisfies $f/aircraft
return $a

for $a in distinct-values(//airline)
let $n := //line[airline = $a]/@number
where
  every $l in $n satisfies
    every $f in //flight[line = $l] satisfies $f/aircraft
return $a

for $a in distinct-values(//airline)
let $n := //line[airline = $a]/@number
where
  count(//flight[line = $n]) = count(//flight[line = $n][aircraft])
return $a

(: -------------------------------------------------------------------------- :)
(: 4 :)

<table>
  <tr><th>Date</th><th>Time</th><th>Number</th><th>Aircraft</th></tr>
  {
    let $n := //line[departure/airport/@code = "PRG"]/@number
    for $f in //flight[line = $n]
    let $t := //line[@number = $f/line]/departure/time/text()
    order by $f/@date descending, $t ascending
    return
      <tr>
        <td>{ data($f/@date) }</td>
        <td>{ $t }</td>
        <td>{ $f/line/text() }</td>
        <td>
          {
            if ($f/aircraft)
            then data($f/aircraft/@registration)
            else <i>Unknown</i>
          }
        </td>
      </tr>
  }
</table>

(: -------------------------------------------------------------------------- :)
(: 5 :)

let $c :=
  for $f in //flight[line = "EK140"]
  return count($f/tickets/ticket)
let $a := avg($c)
for $f in //flight[line = "EK140"]
where count($f/tickets/ticket) >= $a
return
  <passengers date="{ $f/@date }" tickets="{ count($f/tickets/ticket) }">
    { string-join($f/tickets/ticket/text(), ", ") }
  </passengers>

...
return
  <passengers tickets="...">
    { $f/@date }
    ...
  </passengers>

let $p :=
  for $f in //flight[line = "EK140"]
  return
    <passengers date="{ $f/@date }" tickets="{ count($f/tickets/ticket) }">
      { string-join($f/tickets/ticket/text(), ", ") }
    </passengers>
let $a := avg($p/@tickets)
return $p[@tickets >= $a]

(: -------------------------------------------------------------------------- :)
