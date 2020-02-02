# vlozenie dat pre zamestnancov lekarni
curl -i -X PUT \
-H 'Content-type: application/json' \
-d '{ "idCard": "001", "position": "pharmacist", "name": "Martin prvý", "start": "01-12-2018", "terminated": "31-03-2019" }' \
http://localhost:10011/buckets/$1_employees/keys/em001

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
	    	"idCard": "002",
    	    "position": "pharmacy assistant",
    	    "name": "Ľuboš Ferenc",
    	    "start": "01-12-2018"
	}' \
	http://localhost:10011/buckets/$1_employees/keys/em002

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
	    "idCard": "003",
	    "position": "pharmacist",
	    "name": "Janka Nováková",
	    "start": "01-04-2019"
	}' \
	http://localhost:10011/buckets/$1_employees/keys/em003

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
	    "idCard": "004",
	    "position": "pharmacist",
	    "name": "Peter Nový",
	    "start": "01-06-2019"
	}' \
	http://localhost:10011/buckets/$1_employees/keys/em004

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{ 
	    "idCard": "005",
	    "position": "pharmacist",
	    "name": "Kristína Hrušková",
	    "start": "1-12-2018",
	    "terminated": "31-03-2019"
	}' \
	http://localhost:10011/buckets/$1_employees/keys/em005

# vlozenie ponukanych liekov
curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"registrationNumber": "29/0154/88-CS",
   		"code": "9258C",
    	"name": "Ibalgin 400",
    	"description": "tbl flm 100x400 mg (blis. PVC/Al)",
    	"otc": "Yes",
    	"manufacturer": "Acylpyrin",
    	"expiration": "01-10-2022",
    	"stock": "available",
    	"price": "144"
	}' \
	http://localhost:10011/buckets/$1_drugs/keys/dr001

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
    	"registrationNumber": "29/0154/88-CS",
    	"code": "7880A",
    	"name": "Ibalgin 400",
    	"description": "tbl flm 48x400 mg (blis. PVC/Al)",
    	"otc": "Yes",
	    "manufacturer": "Zentiva",
    	"expiration": "01-10-2022",
    	"stock": "available",
    	"price": "123"
	}' \
	http://localhost:10011/buckets/$1_drugs/keys/dr002

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"registrationNumber": "EU/1/02/205/002",
    	"code": "98927",
    	"name": "LUMIGAN 0,3 mg/ml",
    	"description": "int opo 3x3 ml/0,9 mg  (fľ.LDPE)",
    	"otc": "No",
    	"manufacturer": "Allergan",
    	"expiration": "01-10-2021",
    	"stock": "available",
    	"price": "358"
	}' \
	http://localhost:10011/buckets/$1_drugs/keys/dr003

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"registrationNumber": "07/0148/78-CS",
    	"code": "86052",
    	"name": "Paralen 500",
    	"description": "tbl 24x500 mg (blis.Al/PVC)",
    	"otc": "Yes",
    	"manufacturer": "Zentiva",
    	"expiration": "01-05-2022",
    	"stock": "available",
    	"price": "46"
	}' \
	http://localhost:10011/buckets/$1_drugs/keys/dr004

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"registrationNumber": "07/0067/18-S",
    	"code": "7085C",
    	"name": "Aspirin Express 500 mg",
    	"description": "tbl obd 40x500 mg (strip papier/PE/Al/kopolymér etylénu s kys.metakryl.)",
	    "otc": "Yes",
	    "manufacturer": "Baver",
	    "expiration": "01-09-2022",
    	"stock": "not available",
    	"price": "89"
	}' \
	http://localhost:10011/buckets/$1_drugs/keys/dr005

# vlozenie blockov z predanych liekov
curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"number": "2019398593",
    	"timestamp": "2019-01-24+08:42",
    	"salesperson": "em001",
    	"items": {
      	"item": [
	        { "idDrug": "dr001", "quantity": "2", "totalItemPrice": "288" },
    	    { "idDrug": "dr005", "quantity": "1", "totalItemPrice": "89" }
      	]
    	},
    	"totalPrice": "377"
	}' \
	http://localhost:10011/buckets/$1_bills/keys/b001

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"number": "2019399039",
    	"timestamp": "2019-02-23+10:27",
    	"salesperson": "em001",
    	"items": {
      		"item": [
	        	{ "idDrug": "dr001", "quantity": "1", "totalItemPrice": "144" },
    	    	{ "idDrug": "dr004", "quantity": "3", "totalItemPrice": "138" },
        		{ "idDrug": "dr003", "quantity": "1", "totalItemPrice": "358" }
      		]
    	},
    	"totalPrice": "640"
	}' \
	http://localhost:10011/buckets/$1_bills/keys/b002

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"number": "2019399764",
    	"timestamp": "2019-05-10+12:54",
    	"salesperson": "em002",
    	"items": {
      		"item": { "idDrug": "dr002", "quantity": "2", "totalItemPrice": "246" }
    	},
    	"totalPrice": "246"
	}' \
	http://localhost:10011/buckets/$1_bills/keys/b003

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"number": "2019399765",
    	"timestamp": "2019-05-10+18:35",
    	"salesperson": "em004",
    	"items": {
      		"item": { "idDrug": "dr005", "quantity": "1", "totalItemPrice": "89" }
    	},
    	"totalPrice": "89"
	}' \
	http://localhost:10011/buckets/$1_bills/keys/b004

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"number": "2019398595",
    	"timestamp": "2019-01-24+09:02",
    	"salesperson": "em005",
    	"items": {
      		"item": [
	        	{ "idDrug": "dr002", "quantity": "2", "totalItemPrice": "246" },
    	    	{ "idDrug": "dr004", "quantity": "1", "totalItemPrice": "46" }
      		]
    	},
    	"totalPrice": "292"
	}' \
	http://localhost:10011/buckets/$1_bills/keys/b005

#zistenie vsetkych liekov, ktore mam v databazy
curl -i -X GET http://localhost:10011/buckets/$1_drugs/keys?keys=true

#Zmena vyrobcu lieku dr001, pretoze mal nespravneho Acylpyrin ---> Zentiva
curl -i -X PUT \
	-H 'Content-type: application/json' \
	-d '{
		"registrationNumber": "29/0154/88-CS",
   		"code": "9258C",
    	"name": "Ibalgin 400",
    	"description": "tbl flm 100x400 mg (blis. PVC/Al)",
    	"otc": "Yes",
    	"manufacturer": "Zentiva",
    	"expiration": "01-10-2022",
    	"stock": "available",
    	"price": "144"
	}' \
	http://localhost:10011/buckets/$1_drugs/keys/dr001

#linkovanie ku blocku lieky a magister ktory predal liek
curl -i -X PUT \
-H 'Content-type: application/json' \
-H 'Link: </buckets/$1_bills/keys/b001>; riaktag="embill"' \
-H 'Link: </buckets/$1_bills/keys/b002>; riaktag="embill"' \
-d '{ 
	"idCard": "001", 
	"position": "pharmacist", 
	"name": "Martin prvý", 
	"start": "01-12-2018", 
	"terminated": "31-03-2019" }' \
http://localhost:10011/buckets/$1_employees/keys/em001

curl -i -X PUT \
	-H 'Content-type: application/json' \
	-H 'Link: <buckets/$1_bills/keys/b003>; riaktag="embill"' \
	-d '{
	    	"idCard": "002",
    	    "position": "pharmacy assistant",
    	    "name": "Ľuboš Ferenc",
    	    "start": "01-12-2018"
	}' \
	http://localhost:10011/buckets/$1_employees/keys/em002

	curl -i -X PUT \
	-H 'Content-type: application/json' \
	-H 'Link: <buckets/$1_bills/keys/b004>; riaktag="embill"' \
	-d '{
	    "idCard": "004",
	    "position": "pharmacist",
	    "name": "Peter Nový",
	    "start": "01-06-2019"
	}' \
	http://localhost:10011/buckets/$1_employees/keys/em004

	curl -i -X PUT \
	-H 'Content-type: application/json' \
	-H 'Link: </buckets/$1_bills/keys/b005>; riaktag="embill"' \
	-d '{ 
	    "idCard": "005",
	    "position": "pharmacist",
	    "name": "Kristína Hrušková",
	    "start": "1-12-2018",
	    "terminated": "31-03-2019"
	}' \
	http://localhost:10011/buckets/$1_employees/keys/em005

	curl -i -X PUT \
	-H 'Content-type: application/json' \
	-H 'Link: </buckets/$1_bills/keys/b001>; riaktag="drbill"' \
	-H 'Link: </buckets/$1_bills/keys/b002>; riaktag="drbill"' \
	-d '{
		"registrationNumber": "29/0154/88-CS",
   		"code": "9258C",
    	"name": "Ibalgin 400",
    	"description": "tbl flm 100x400 mg (blis. PVC/Al)",
    	"otc": "Yes",
    	"manufacturer": "Acylpyrin",
    	"expiration": "01-10-2022",
    	"stock": "available",
    	"price": "144"
	}' \
	http://localhost:10011/buckets/$1_drugs/keys/dr001