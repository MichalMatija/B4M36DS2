input.txt
Obsahuje data o predajnosti jednotlivych liekov. Pozostava z informacii o lieku ako meno, kod, vyrobca a jeho cena a o predaji lieku kedy bol predany a ake mnozstvo. Kazdy udaj v riadku je oddeleni znakom ";".

Jednotlive stlpce v subore su nasledujuce:
Name;Code;Manufacturer;Timestamp;Quantity;Price

MapReduce.java
MapReduce job vypocita pocet predanych liekov za jednotlivych vyrobcov. Ako kluc sa pouzije spojenie vyrobcu a kodu. Pricom zaujimaju nas len take lieky, ktore boli predane 1. unora a neskor a ich cena (totalPrice = price * quantity) je vacsia ako 130. A celkovy pocet za vyrobcu a kodu je vacsi ako 2.
Map
	-Najde vyrobcov a kody liekov k nim vypocita totalPrice. Aplikuje podmienku na cas a totalPrice. Mapuje vyrobcu s kodom lieku a mnozstvo, ktore bolo predane.
	-condition: timestamp > '2019-01-31' and totalPrice > 130
	-KEYOUT: Manufacturer:Code
	-VALUEOUT: Quantity
	-example: Zentiva:9258C|3
Reduce
	-Redukuje riadky podla vyrobcu a kodu a zisti ich pocet. Zaujima nas pocet vacsi alebo rovny 2.
	-having: count >= 2
	-KEYOUT: Manufacturer:Code
	-VALUEOUT: count
	-example: Zentiva:9258C|3
* Zvisla ciara v example u Map a Reduce sluzi na oddelenie KEYOUT|VALUEOUT pre lepsie pochoponie a nebude sa nachadzat vo vyslednom dokumente(output.txt).
