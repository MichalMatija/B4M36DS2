
(: -------------------------------------------------------------------------- :)
(: 1A :)

/airport/lines/line/airline
/child::airport/child::lines/child::line/child::airline
//line/airline
//airline

(: -------------------------------------------------------------------------- :)
(: 1B :)

//airport/text()
/descendant-or-self::node()/airport/text()
/descendant-or-self::airport/text()

//line/*/airport/text()
//line/*[name() = "departure" or name() = "arrival"]/airport/text()

(: -------------------------------------------------------------------------- :)
(: 1C :)

data(//airport/@code)
data(//child::airport/attribute::code)

(: -------------------------------------------------------------------------- :)
(: 1D :)

/airport/flights/flight[3]/tickets/ticket[last()]
/airport/flights/flight[position() = 3]/tickets/ticket[position() = last()]

(: -------------------------------------------------------------------------- :)
(: 1E :)

distinct-values(/airport/flights/flight/tickets/ticket/@class)
distinct-values(//ticket/@class)
distinct-values(//@class)
distinct-values(data(//@class))

(: -------------------------------------------------------------------------- :)
(: 2 :)

/airport/flights/
  flight[@date = "2019-10-13"][aircraft/@registration = "A6-EOQ"]/
  line

/airport/flights/
  flight[@date = "2019-10-13" and aircraft/@registration = "A6-EOQ"]/
  line

(: -------------------------------------------------------------------------- :)
(: 3 :)

//flight[tickets/ticket/@class = "F" or tickets/ticket/@class = "C"]

//flight[.//@class = "F" or .//@class = "C"]

//flight[tickets/ticket[@class = "F" or @class = "C"]]

//flight[
  count(tickets/ticket[@class = "F"]) >= 1
  or
  count(tickets/ticket[@class = "C"]) >= 1
]

//flight[.//@class = ("F", "C")]

(: INCORRECT :)
//flight[//@class = "F" or //@class = "C"]

(: -------------------------------------------------------------------------- :)
(: 4 :)

(: INCORRECT :)
//flight[.//ticket][.//@class != "F" and .//@class != "C"]

(: CORRECT :)
//flight[.//ticket][not(.//@class = "F" or .//@class = "C")]

(: CORRECT :)
//flight[count(.//ticket) >= 1][
  count(.//ticket[@class = "F"]) = 0
  and
  count(.//ticket[@class = "C"]) = 0
]

(: INCORRECT :)
//flight[count(.//ticket) >= 1][
  count(.//ticket/@class = "F") = 0
  and
  count(.//ticket/@class = "C") = 0
]

(: -------------------------------------------------------------------------- :)
(: 5 :)

//flight[@date >= "2019-10-18" and not(aircraft)]/line
//flight[attribute::date >= "2019-10-18" and not(child::aircraft)]/line
//flight[./@date >= "2019-10-18" and not(./aircraft)]/line
//flight[self::node()/@date >= "2019-10-18" and not(self::node()/aircraft)]/line
//flight[(@date >= "2019-10-18") and not(aircraft)]/line
//flight[@date >= "2019-10-18"][not(aircraft)]/line
//flight[not(aircraft)][@date >= "2019-10-18"]/line
//flight[@date >= "2019-10-18"][count(aircraft) = 0]/line

//flight/line[../@date >= "2019-10-18" and not(../aircraft)]
//flight/line[parent::node()/@date >= "2019-10-18" and not(parent::node()/aircraft)]
//flight/line[parent::flight/@date >= "2019-10-18" and not(parent::flight/aircraft)]

(: -------------------------------------------------------------------------- :)
(: 6 :)

//line[duration > avg(//line/duration)]
//line[duration > avg(//duration)]
//line[duration/text() > avg(//line/duration/text())]

(: -------------------------------------------------------------------------- :)
(: 7 :)

count(
  //flight
    [@date = "2019-10-18"]
    [line = //line[arrival/airport/@country = "DEU"]/@number]
)

(: -------------------------------------------------------------------------- :)
(: 8 :)

(: INCORRECT :)

//ticket[last()]/text()
//ticket[position() = last()]/text()
/descendant-or-self::node()/ticket[position() = last()]/text()

(: CORRECT :)

/descendant::ticket[last()]/text()
/descendant-or-self::ticket[last()]/text()

//ticket[not(following::ticket) and not(descendant::ticket)]/text()
//ticket[not(following::ticket)]/text()

(//ticket)[last()]/text()

(: -------------------------------------------------------------------------- :)
