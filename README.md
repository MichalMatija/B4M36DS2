# DS2
[Homepage](https://www.ksi.mff.cuni.cz/~svoboda/courses/191-B4M36DS2/)

## Lectures
1. [Introduction](B4M36DS2-Lecture-01-Introduction.pdf)
2. [Data Formats](B4M36DS2-Lecture-01-Introduction.pdf)
3. [XML Databases](B4M36DS2-Lecture-03-XQuery.pdf)
4. [RDF Stores](B4M36DS2-Lecture-04-SPARQL.pdf)
5. [Apache Hadoop](B4M36DS2-Lecture-05-MapReduce.pdf)
6. [Basic Principles](B4M36DS2-Lecture-06-Principles.pdf)
7. [Key-Value Stores](B4M36DS2-Lecture-07-RiakKV.pdf)
8. [Wide Column Stores](B4M36DS2-Lecture-08-Cassandra.pdf)
9. [Document Databases](B4M36DS2-Lecture-09-MongoDB.pdf)
10. [Graph Databases](B4M36DS2-Lecture-10-Neo4j.pdf)
11. [Advanced Aspects](B4M36DS2-Lecture-11-Graph.pdf)
12. [Advanced Aspects](B4M36DS2-Lecture-12-Advanced.pdf)

## Labs
00. [Organization]()
01. [Formats]()
02. [XPath]()
03. [XQuery]()
04. [SPARQL]()
05. [MapReduce]()
06. [Redis]()
07. [RiakKV]()
08. [Cassandra]()
09. [MongoDB]()
10. [MongoDB]()
11. [Neo4j]()
12. [Neo4j]()

## Homeworks

### 1. XQuery
[01-XQuery](Homeworks/01-XQuery)
* Assigment:
	* Create an **XML document** with sample data from the domain of your individual topic
		* Work with mutually interlinked entities of at least **3 different types** (e.g. lines, flights and tickets)
		* Insert data about at least **15 particular entities** (e.g. 3 lines, 4 flights, 8 tickets)
	* Create expressions for exactly **2 different XPath queries** (i.e. not more, not less)
	* Use each of the following constructs at least once
		* Axes: descendant or descendant-or-self or // abbreviation
		* Predicates (all of the following): path expression (existence test), position testing, value comparison, general comparison
	* Create expressions for exactly **3 different XQuery queries** (that cannot be expressed solely using XPath)
	* Use each of the following constructs at least once
		* Direct or computed constructor
		* FLWOR expression (with at least one FOR clause)
		* Conditional expression
		* Existential or universal quantifier
* Requirements:
	* Both XML document and queries must be **well-formed** (i.e. syntactically correct)
	* Put each XPath / XQuery expression into a standalone file (e.g. xpath1.xp)
	* Always add a comment describing the intended **query meaning in natural language** via (: comment :)
	* Each query expression must be evaluated to a **non-empty sequence**
* Submission:
	* **data.xml**: XML document with your data to be queried
	* **xpath1.xp** and **xpath2.xp**: files with XPath expressions
	* **xquery1.xq**, **xquery2.xq**, and **xquery3.xq**: files with XQuery expressions
* Execution:
	* Execute the following shell command to evaluate each individual XPath or XQuery query expression
		* saxonb-xquery -s $DataFile $QueryFile
		* $DataFile is the input XML document to be queried, i.e. data.xml
		* $QueryFile is a file with query expression to be evaluated, e.g. xquery1.xq

## Useful links
* [XML Editor](https://codebeautify.org/xmlvalidator)
* [JSON Editor](https://codebeautify.org/jsonvalidator)
* [RDF Editor](http://ttl.summerofcode.be/)
* [XPath and XQuery Processor](http://videlibri.sourceforge.net/cgi-bin/xidelcgi)
* [SPARQL endpoint](https://nosql.opendata.cz/sparql)

## Recommended Literature
* [Holubová, Irena - Kosek, Jiří - Minařík, Karel - Novák, David: Big Data a NoSQL databáze.](https://www.mff.cuni.cz/cs/fakulta/organizacni-struktura/katedra?code=204)
* [NoSQL Distilled](https://martinfowler.com/books/nosql.html)
* [Advanced Data Management: For SQL, NoSQL, Cloud and Distributed Databases.](https://www.degruyter.com/viewbooktoc/product/460529)
* [Handbook of Big Data Technologies.](https://www.springer.com/gp/book/9783319493398)