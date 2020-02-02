CREATE
	(e1:EMPLOYEE { id: 1, name: "Martin Prvý", position: "pharmacist", started: "2018-12-01", terminated: "2019-03-31"}),
	(e2:EMPLOYEE { id: 2, name: "Ľuboš Ferenc", position: "pharmacy assistant", started: "2018-12-01"}),
	(e3:EMPLOYEE { id: 3, name: "Janka Nováková", position: "pharmacist", started: "2019-04-01"}),
	(e4:EMPLOYEE { id: 4, name: "Peter Nový", position: "pharmacist", started: "2019-06-01"}),
	(e5:EMPLOYEE { id: 5, name: "Kristína Hrušková", position: "pharmacist", started: "2018-12-01", terminated: "2019-03-31"}),
	(d1:DRUG { id: 1, registration_number: "29/0154/88-CS", code: "9258C", name: "Ibalgin 400", description: "tbl flm 100x400 mg (blis. PVC/Al)", otc: "true", in_stock: "true", price: 144, expiration: "2022-10-01"}),
	(d2:DRUG { id: 2, registration_number: "29/0154/88-CS", code: "7880A", name: "Ibalgin 400", description: "tbl flm 48x400 mg (blis. PVC/Al)", otc: "true", in_stock: "true", price: 123, expiration: "2022-10-01"}),
	(d3:DRUG { id: 3, registration_number: "EU/1/02/205/002", code: "98927", name: "LUMIGAN 0,3 mg/ml", description: "int opo 3x3 ml/0,9 mg  (fľ.LDPE)", otc: "false", in_stock: "true", price: 358, expiration: "2021-10-01"}),
	(d4:DRUG { id: 4, registration_number: "07/0148/78-CS", code: "86052", name: "Paralen 500", description: "tbl 24x500 mg (blis.Al/PVC)", otc: "true", in_stock: "true", price: 46, expiration: "2022-05-01"}),
	(d5:DRUG { id: 5, registration_number: "07/0067/18-S", code: "7085C", name: "Aspirin Express 500 mg", description: "tbl obd 40x500 mg (strip papier/PE/Al/kopolymér etylénu s kys.metakryl.)", otc: "true", in_stock: "false", price: 89, expiration: "2022-09-01"}),
	(b1:BILL { id: 1, created: "2019-01-24T08:42:59.001+0000"}),
	(b2:BILL { id: 2, created: "2019-02-23T10:27:12.001+0000"}),
	(b3:BILL { id: 3, created: "2019-05-10T12:54:35.001+0000"}),
	(b4:BILL { id: 4, created: "2019-05-10T18:35:26.001+0000"}),
	(b5:BILL { id: 5, created: "2019-05-10T18:35:26.001+0000"}),
	(b1)-[s1:SOLD { quantity: 1 }]->(d1),
	(b1)-[s2:SOLD { quantity: 3 }]->(d4),
	(b1)-[s3:SOLD { quantity: 1 }]->(d3),
	(b2)-[s4:SOLD { quantity: 2 }]->(d1),
	(b2)-[s5:SOLD { quantity: 1 }]->(d5),
	(b3)-[s6:SOLD { quantity: 2 }]->(d2),
	(b4)-[s7:SOLD { quantity: 1 }]->(d5),
	(b5)-[s8:SOLD { quantity: 2 }]->(d2),
	(b5)-[s9:SOLD { quantity: 1 }]->(d4),
	(b5)-[s10:SOLD { quantity: 3 }]->(d5),
	(b1)-[i1:ISSUED]->(e1),
	(b2)-[i2:ISSUED]->(e1),
	(b3)-[i3:ISSUED]->(e2),
	(b4)-[i4:ISSUED]->(e4),
	(b5)-[i5:ISSUED]->(e5);

// Najdi zamestnanca s menom Peter Nový
// Vypis id, meno, a poziciu
MATCH (e:EMPLOYEE)
	WHERE e.name = "Peter Nový"
RETURN e.id, e.name, e.position;

// Zorad zostupne vsetky lieky, ktore su dostupne
MATCH (d:DRUG)
	WHERE d.in_stock = "true"
RETURN d.name, d.registration_number, d.code, d.price
	ORDER BY d.price DESCENDING;

// Najdi pary Zamestnanci a blocky
// Zahrni aj zamestnancov, ktory este nic nepredali
MATCH (e:EMPLOYEE)
OPTIONAL MATCH (e)<-[:ISSUED]-(b:BILL)
RETURN e.name, e.position, b.created;

// Lieky, ktore boli predane v konkretnom blocku. Vypis len tie, ktore maju pocet predanych liekov viac ako je priemerny pocet predanych liekov za blocky
MATCH (b:BILL)
WITH b, SIZE( (b)-[:SOLD]->(:DRUG)) AS drugs
WITH AVG(drugs) AS average
MATCH (b:BILL)
	WHERE SIZE( (b)-[:SOLD]->(:DRUG)) > average
MATCH (b)-[:SOLD]->(d:DRUG)
RETURN DISTINCT b.id, b.created, d.name;

// Vypis vsetky predane lieky a kto ich predal
// Vystup bill id, drug name, quantity, employee name
MATCH (b:BILL)-[s:SOLD]->(d:DRUG)
MATCH (b)-[:ISSUED]->(e:EMPLOYEE)
RETURN b.id, d.name, s.quantity, e.name;
