(: Vypis cisla blockov kde sa nachadza liek Ibalgin 400, kde jeho cena prekracuje hodnotu 150 :)

let $i := //drug[name = "Ibalgin 400"]/@code
for $b in //bill
where 
	some $n in $b/items/item[@idDrug = $i] satisfies $n[totalItemPrice > 150]
return data($b/@number)