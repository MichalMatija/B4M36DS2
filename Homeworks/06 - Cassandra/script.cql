CREATE TYPE person_name (
	first text,
	last text
);

CREATE TYPE item (
	registration_number text,
	code text,
	quantity int
);

CREATE TABLE employee (
	id int PRIMARY KEY,
	name person_name,
	emails set<text>,
	phones map<text, text>,
	address tuple<TEXT, TEXT, SMALLINT>,
	position text,
	start date,
	terminated date
);

CREATE INDEX idx_employee_position ON employee (position);

CREATE TABLE drug (
	registration_number text,
	code text,
	name text,
	description text,
	otc boolean,
	in_stock boolean,
	price int,
	manufacturer text,
	expiration date,
	PRIMARY KEY (registration_number, code)
);

CREATE TABLE bill (
	id int,
	created timestamp,
	salesperson int,
	items list<frozen <item>>,
	total_price int,
	PRIMARY KEY ((id), created)
);

// Zamestnanci
INSERT INTO employee (id, name, emails, phones, address, position, start, terminated)
VALUES (1, {first : 'Martin', last : 'Prvý'}, {'martinPrvy@gmail.com', 'prvmar@pharmacy.com'}, {'personal' : '+421907439462', 'work' : '1134'}, ('Lumieru 4', 'Praha', 15000), 'pharmacist', '2018-12-01', '2019-03-31');

INSERT INTO employee (id, name, emails, phones, address, position, start, terminated)
VALUES (2, {first : 'Ľuboš', last : 'Ferenc'}, { 'ferlub@pharmacy.com'}, {'personal' : '+421902456098', 'work' : '1135'}, ('Lumieru 20', 'Praha', 15000), 'pharmacy assistant', '2018-12-01', null);

INSERT INTO employee (id, name, emails, phones, address, position, start, terminated)
VALUES (3, {first : 'Janka', last : 'Nováková'}, { 'novjan@pharmacy.com'}, {'personal' : '+421918365467', 'work' : '1165'}, ('Barandov 15', 'Praha', 15000), 'pharmacist', '2019-04-01', null);

INSERT INTO employee (id, name, emails, phones, address, position, start, terminated) 
VALUES (4, {first : 'Peter', last : 'Nový'}, { 'n.peter123@gmail.com', 'novpet@pharmacy.com'}, {'personal' : '+421904567765', 'work' : '1172'}, ('Hlubocepy 123', 'Praha', 15000), 'pharmacist', '2019-06-01', null);

INSERT INTO employee (id, name, emails, phones, address, position, start, terminated)
VALUES (5, {first : 'Kristína', last : 'Hrušková'}, { 'hrukri@pharmacy.com'}, {'personal' : '+421945284638', 'work' : '1133'}, ('Hlubocepy 14', 'Praha', 15000), 'pharmacist', '2018-12-01', '2019-03-31');

// Lieky

INSERT INTO drug (registration_number, code, name, description, otc, in_stock, price, manufacturer, expiration)
VALUES ('29/0154/88-CS', '9258C', 'Ibalgin 400', 'tbl flm 100x400 mg (blis. PVC/Al)', true, true, 144, 'Zentiva', '2022-10-01');

INSERT INTO drug (registration_number, code, name, description, otc, in_stock, price, manufacturer, expiration)
VALUES ('29/0154/88-CS', '7880A', 'Ibalgin 400', 'tbl flm 48x400 mg (blis. PVC/Al)', true, true, 123, 'Zentiva', '2022-10-01');

INSERT INTO drug (registration_number, code, name, description, otc, in_stock, price, manufacturer, expiration)
VALUES ('EU/1/02/205/002', '98927', 'LUMIGAN 0,3 mg/ml', 'int opo 3x3 ml/0,9 mg  (fľ.LDPE)', false, true, 358, 'Allergan', '2021-10-01');

INSERT INTO drug (registration_number, code, name, description, otc, in_stock, price, manufacturer, expiration)
VALUES ('07/0148/78-CS', '86052', 'Paralen 500', 'tbl 24x500 mg (blis.Al/PVC)', true, true, 46, 'Zentiva', '2022-05-01');

INSERT INTO drug (registration_number, code, name, description, otc, in_stock, price, manufacturer, expiration)
VALUES ('07/0067/18-S', '7085C', 'Aspirin Express 500 mg', 'tbl obd 40x500 mg (strip papier/PE/Al/kopolymér etylénu s kys.metakryl.)', true, false, 89, 'Baver', '2022-09-01');

// Blocky
INSERT INTO bill (id, created, salesperson, items, total_price) 
VALUES (1, '2019-01-24T08:42:59.001+0000', 1, [('29/0154/88-CS', '9258C', 2), ('07/0067/18-S', '7085C', 1)], 377);

INSERT INTO bill (id, created, salesperson, items, total_price) 
VALUES (2, '2019-02-23T10:27:12.001+0000', 1, [('29/0154/88-CS', '9258C', 1), ('07/0148/78-CS', '86052', 3), ('EU/1/02/205/002', '98927', 1)], 640);

INSERT INTO bill (id, created, salesperson, items, total_price) 
VALUES (3, '2019-05-10T12:54:35.001+0000', 2, [('29/0154/88-CS', '7880A', 2)], 246);

INSERT INTO bill (id, created, salesperson, items, total_price) 
VALUES (2, '2019-05-10T18:35:26.001+0000', 4, [('07/0067/18-S', '7085C', 1)], 89);

INSERT INTO bill (id, created, salesperson, items, total_price) 
VALUES (5, '2019-01-24T09:02:56.001+0000', 5, [('29/0154/88-CS', '7880A', 2), ('07/0148/78-CS', '86052', 1)], 292);

// update employee
// replace SET, MAP, TUPLE
UPDATE employee
SET
	emails = {'prvmar01@pharmacy.com'},
	phones = {'work' : '1001'},
	address = ('Jablonecka 10', 'Praha', 19000)
WHERE (id = 1);

// ADD SET, MAP
UPDATE employee
SET
	emails = emails + {'f.lubos345@gmail.com'},
	phones = phones + {'landline' : '002145363'}
WHERE (id = 2);

// REMOVE SET, MAP
UPDATE employee
SET
	emails = emails - {'n.peter123@gmail.com'},
	phones = phones - {'personal'}
WHERE (id = 4);

// update bill
// replace LIST
UPDATE bill
SET
	items = [('29/0154/88-CS', '9258C', 2), ('07/0067/18-S', '7085C', 1), ('29/0154/88-CS', '7880A', 2)], 
	total_price = 500 
where id = 1 and created = '2019-01-24T08:42:59.001+0000';

// add LIST
UPDATE bill
SET
	items = items + [('07/0067/18-S', '7085C', 1)],
	total_price = 335
WHERE id = 3 and created = '2019-05-10T12:54:35.001+0000';

// remove LIST
UPDATE bill
SET
	items = items - [('07/0148/78-CS', '86052', 1)],
	total_price = 246
WHERE id = 5 and created = '2019-01-24T09:02:56.001+0000';

SELECT * FROM bill WHERE id = 2 ORDER BY created desc;

SELECT * FROM drug WHERE otc = true and in_stock = true ALLOW FILTERING;

SELECT * FROM employee WHERE position = 'pharmacist';