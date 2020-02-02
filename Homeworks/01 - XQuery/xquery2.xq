(: Vytvor html tabulku kde bude cislo blocku, cas, celkova cena, ktory zamestnanec to predal a kedy ukoncil pracovny pomer(ak este neukoncil vypln to udajom "empty") :)
<table>
	<tr>
    	<th>BillNumber</th>
        <th>Date</th>
        <th>Total Price</th>
        <th>Employee name</th>
        <th>Termination date</th>
    </tr>
    {
    for $b in //bill
    let $e := /pharmacy/employees/employee[@idCard = $b/salesperson]
    return 
    <tr>
    	<td>{ $b/@number }</td>
        <td>{ $b/@timestamp }</td>
        <td>{ data($b/totalPrice) }</td>
        <td>{ data($e/name) }</td>
        <td>{ if (data($e/terminated))
        then data($e/terminated)
        else "empty"
         }</td>
    </tr>
    }
</table>