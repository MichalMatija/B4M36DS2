(: Zorad vsetky dostupne lieky podla ceny vzostupne(ascending) a vypis to v strukture kde root element bude drug s atributom code a bude obsahovat elementy name, manufacturer a price :)

for $d in //drug
let $p := $d/price
where $d/stock = "available"
order by $p ascending
return 
element drug {
	attribute code { $d/@code },
	element name { data($d/name) },
    element manufacturer { data($d/manufacturer) },
    element price { data($p) }
}