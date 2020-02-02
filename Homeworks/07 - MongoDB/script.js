db.createCollection("employee");
db.employee.insert({
	_id: 1,
	name: { first: "Martin", last: "Prvý" },
	email: [ "martinPrvy@gmail.com", "prvmar@pharmacy.com" ],
	position: "pharmacist",
	started: "2018-12-01",
	terminated: "2019-03-31"
});

db.employee.insert({
	_id: 2,
	name: { first: "Ľuboš", last: "Ferenc" },
	email: [ "ferlub@pharmacy.com" ],
	position: "pharmacy assistant",
	started: "2018-12-01"
});

db.employee.insert({
	_id: 3,
	name: { first: "Janka", last: "Nováková" },
	email: [ "novjan@pharmacy.com" ],
	position: "pharmacist",
	started: "2019-04-01"
});

db.employee.insert({
	_id: 4,
	name: { first: "Peter", last: "Nový" },
	email: [ "n.peter123@gmail.com", "novpet@pharmacy.com" ],
	position: "pharmacist",
	started: "2019-06-01"
});

db.employee.insert({
	_id: 5,
	name: { first: "Kristína", last: "Hrušková" },
	email: [ "hrukri@pharmacy.com" ],
	position: "pharmacist",
	started: "2018-12-01",
	terminated: "2019-03-31"
});

// insert drug
db.createCollection("drug");
db.drug.insert({
	_id: 1,
	registration_number: "29/0154/88-CS",
	code: "9258C",
	name: "Ibalgin 400",
	description: "tbl flm 100x400 mg (blis. PVC/Al)",
	otc: "true",
	in_stock: "true",
	price: 144,
	manufacturer: "Zentiva",
	expiration: "2022-10-01"
});

db.drug.insert({
	_id: 2,
	registration_number: "29/0154/88-CS",
	code: "7880A",
	name: "Ibalgin 400",
	description: "tbl flm 48x400 mg (blis. PVC/Al)",
	otc: "true",
	in_stock: "true",
	price: 123,
	manufacturer: "Zentiva",
	expiration: "2022-10-01"
});

db.drug.insert({
	_id: 3,
	registration_number: "EU/1/02/205/002",
	code: "98927",
	name: "LUMIGAN 0,3 mg/ml",
	description: "int opo 3x3 ml/0,9 mg  (fľ.LDPE)",
	otc: "false",
	in_stock: "true",
	price: 358,
	manufacturer: "Allergan",
	expiration: "2021-10-01"
});

db.drug.insert({
	_id: 4,
	registration_number: "07/0148/78-CS",
	code: "86052",
	name: "Paralen 500",
	description: "tbl 24x500 mg (blis.Al/PVC)",
	otc: "true",
	in_stock: "true",
	price: 46,
	manufacturer: "Zentiva",
	expiration: "2022-05-01"
});

db.drug.insert({
	_id: 5,
	registration_number: "07/0067/18-S",
	code: "7085C",
	name: "Aspirin Express 500 mg",
	description: "tbl obd 40x500 mg (strip papier/PE/Al/kopolymér etylénu s kys.metakryl.)",
	otc: "true",
	in_stock: "false",
	price: 89,
	manufacturer: "Baver",
	expiration: "2022-09-01"
});

// insert bill
db.createCollection("bill");
db.bill.save({
	_id: 1,
	info: { telephone: "+420908475673", name: "Extra Pharmacy", ICO: 45398432, DIC: 1234567890 },
	created: "2019-01-24T08:42:59.001+0000",
	salesperson: 1,
	items: [ 
		{ iddrug: 1, quantity: 1 },
		{ iddrug: 4, quantity: 3 },
		{ iddrug: 3, quantity: 1 }
	 ],
	total_price: 640
});

db.bill.save({
	_id: 2,
	info: { telephone: "+420908475673", name: "Extra Pharmacy", ICO: 45398432, DIC: 1234567890 },
	created: "2019-02-23T10:27:12.001+0000",
	salesperson: 1,
	items: [ 
		{ iddrug: 1, quantity: 2 },
		{ iddrug: 5, quantity: 1 }
	 ],
	total_price: 377
});

db.bill.save({
	_id: 3,
	info: { telephone: "+421111111111", name: "No.1 Pharmacy", ICO: 45398432, DIC: 1234567890 },
	created: "2019-05-10T12:54:35.001+0000",
	salesperson: 2,
	items: [ 
		{ iddrug: 2, quantity: 2 }
	 ],
	total_price: 246
});

db.bill.save({
	_id: 4,
	info: { telephone: "+421111111111", name: "No.1 Pharmacy", ICO: 45398432, DIC: 1234567890 },
	created: "2019-05-10T18:35:26.001+0000",
	salesperson: 4,
	items: [ 
		{ iddrug: 5, quantity: 1 }
	 ],
	total_price: 89
});

db.bill.save({
	_id: 5,
	info: { telephone: "+421111111111", name: "No.1 Pharmacy", ICO: 45398432, DIC: 1234567890 },
	created: "2019-05-10T18:35:26.001+0000",
	salesperson: 5,
	items: [ 
		{ iddrug: 2, quantity: 2 },
		{ iddrug: 4, quantity: 1 }
	 ],
	total_price: 292
});

// update employee with id = 2
db.employee.update(
	{ _id: 2 },
	{ name: { first: "Ľuboš", last: "Ferenc" }, 
		email: [ "l.ferenc@gmail.com" ],
		position: "pharmacy assistant",
		started: "2018-12-01",
		terminated: "2019-12-01"
	}
);

db.employee.update(
	{ _id: 6 },
	{ name: { first: "Michal", last: "Nový" },
		email: [ "novmic@pharmacy.com" ],
		position: "pharmacy assistant",
		started: "2019-12-01"
	},
	{ upsert: true }
);

db.employee.update(
	{ _id: 6 },
	{
		$set: { terminated: "2020-01-01" },
		$push: { email: { $each: [ "m.novy@gmail.com" ] } }
	}
);

// quering
// vsetky predane lieky s ID = 4 a predanym mnozstvom 1.
// Vypis id magistra, celkovu cenu blocka a bez id
db.bill.find({ items: { $elemMatch: { iddrug: 4, quantity: 1 } } }, 
		{ salesperson: 1, total_price: 1, _id: 0}).forEach(printjson);

// vsetky volnopredajne lieky od vyrobcu zentiva zoradene vzostupne
db.drug.find({ $and: [ { otc: "true" }, { manufacturer: "Zentiva" } ] }, 
		{ _id: 0, description: 0, otc: 0 }).sort({ price: 1 }).forEach(printjson);

// vypis vsetkych aktualnych zamestnancov, ktory nemaju vypoved( zamestnanec s id = 6 konci k novemu roku)
db.employee.find({ terminated: { $exists: false }}, 
	{ _id: 0 }).forEach(printjson);

// vypis vsetky blocky z dna 5.10.2019 s cenou vyssiou alebo rovnou 100
db.bill.find({ $and: [ { created: { $regex: "2019-05-10*" }}, { total_price: { $gte: 100 }} ] }, 
	{ created: 1, total_price: 1 }).forEach(printjson);

// najdi magistra s přijmenim Prvý
db.employee.find({ position: "pharmacist", "name.last": "Prvý"}).forEach(printjson);

// priemerna hodnota lieku na blocku a jeho predaneho mnozstva
db.bill.mapReduce(
	function() {
		if (this.items) {
			this.items.forEach(
				function(i) { emit(i.iddrug, i.quantity); }
			);
		}
	},
	function(key, values) {
		var sum = 0;
		var count = 0;
		values.forEach(
			function(value) {
				sum += value;
				count++;
			}
		);

		return sum/count;
	},
	{ 
		out: { inline: 1 }
	}
);