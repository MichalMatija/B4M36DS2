#!/bin/bash

#-------------------------------------------------------------------------------

curl -v http://localhost:10011/ping
curl -v http://localhost:10012/ping
curl -v http://localhost:10013/ping

riak ping
riak-admin test
riak-admin status
riak-admin status | grep ring_members

#-------------------------------------------------------------------------------

curl -i -X PUT \
    -H 'Content-Type: text/plain' \
    -d 'Ivan Trojan, 1964' \
    http://localhost:10011/buckets/login_actors/keys/trojan

curl -i -X GET http://localhost:10011/buckets/login_actors/keys/trojan

#-------------------------------------------------------------------------------

curl -i -X GET http://localhost:10011/buckets?buckets=true

curl -i -X GET http://localhost:10011/buckets/login_actors/keys?keys=true

#-------------------------------------------------------------------------------

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name" : "Ivan Trojan", "year" : 1964 }' \
    http://localhost:10011/buckets/login_actors/keys/trojan

curl -i -X DELETE http://localhost:10011/buckets/login_actors/keys/trojan

#-------------------------------------------------------------------------------

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name" : "Ivan Trojan", "year" : 1964 }' \
    http://localhost:10011/buckets/login_actors/keys/trojan

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name" : "Jiøí Macháèek", "year" : 1966 }' \
    http://localhost:10011/buckets/login_actors/keys/machacek

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name" : "Jitka Schneiderová", "year" : 1973 }' \
    http://localhost:10011/buckets/login_actors/keys/schneiderova

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name" : "Zdenìk Svìrák", "year" : 1936 }' \
    http://localhost:10011/buckets/login_actors/keys/sverak


curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "title" : "Vratné lahve", "year" : 2006, "actors" : [ "Zdenìk Svìrák", "Jiøí Macháèek" ] }' \
    http://localhost:10011/buckets/login_movies/keys/vratnelahve

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "title" : "Samotáøi", "year" : 2000, "actors" : [ "Jitka Schneiderová", "Ivan Trojan", "Jiøí Macháèek" ] }' \
    http://localhost:10011/buckets/login_movies/keys/samotari

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "title" : "Medvídek", "year" : 2007, "actors" : [ "Jiøí Macháèek", "Ivan Trojan" ] }' \
    http://localhost:10011/buckets/login_movies/keys/medvidek

#-------------------------------------------------------------------------------

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -H 'Link: </buckets/login_movies/keys/samotari>; riaktag="tmovie"' \
    -H 'Link: </buckets/login_movies/keys/medvidek>; riaktag="tmovie"' \
    -d '{ "name" : "Ivan Trojan", "year" : 1964 }' \
    http://localhost:10011/buckets/login_actors/keys/trojan

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -H 'Link: </buckets/login_movies/keys/vratnelahve>; riaktag="tmovie"' \
    -H 'Link: </buckets/login_movies/keys/samotari>; riaktag="tmovie"' \
    -H 'Link: </buckets/login_movies/keys/medvidek>; riaktag="tmovie"' \
    -d '{ "name" : "Jiøí Macháèek", "year" : 1966 }' \
    http://localhost:10011/buckets/login_actors/keys/machacek

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -H 'Link: </buckets/login_movies/keys/samotari>; riaktag="tmovie"' \
    -d '{ "name" : "Jitka Schneiderová", "year" : 1973 }' \
    http://localhost:10011/buckets/login_actors/keys/schneiderova

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -H 'Link: </buckets/login_movies/keys/vratnelahve>; riaktag="tmovie"' \
    -d '{ "name" : "Zdenìk Svìrák", "year" : 1936 }' \
    http://localhost:10011/buckets/login_actors/keys/sverak

#-------------------------------------------------------------------------------

curl -i -X GET http://localhost:10011/buckets/login_actors/keys/trojan/login_movies,tmovie,1

#-------------------------------------------------------------------------------

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -H 'Link: </buckets/login_actors/keys/sverak>; riaktag="tactor"' \
    -H 'Link: </buckets/login_actors/keys/machacek>; riaktag="tactor"' \
    -d '{ "title" : "Vratné lahve", "year" : 2006, "actors" : [ "Zdenìk Svìrák", "Jiøí Macháèek" ] }' \
    http://localhost:10011/buckets/login_movies/keys/vratnelahve

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -H 'Link: </buckets/login_actors/keys/schneiderova>; riaktag="tactor"' \
    -H 'Link: </buckets/login_actors/keys/trojan>; riaktag="tactor"' \
    -H 'Link: </buckets/login_actors/keys/machacek>; riaktag="tactor"' \
    -d '{ "title" : "Samotáøi", "year" : 2000, "actors" : [ "Jitka Schneiderová", "Ivan Trojan", "Jiøí Macháèek" ] }' \
    http://localhost:10011/buckets/login_movies/keys/samotari

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -H 'Link: </buckets/login_actors/keys/machacek>; riaktag="tactor"' \
    -H 'Link: </buckets/login_actors/keys/trojan>; riaktag="tactor"' \
    -d '{ "title" : "Medvídek", "year" : 2007, "actors" : [ "Jiøí Macháèek", "Ivan Trojan" ] }' \
    http://localhost:10011/buckets/login_movies/keys/medvidek

#-------------------------------------------------------------------------------

curl -i -X GET http://localhost:10011/buckets/login_actors/keys/trojan/login_movies,tmovie,0/login_actors,tactor,1

#-------------------------------------------------------------------------------

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "schema" : "_yz_default" }' \
    http://localhost:10011/search/index/login_iactors

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "props" : { "search_index" : "login_iactors" } }' \
    http://localhost:10011/buckets/login_actors/props

curl -i -X GET http://localhost:10011/buckets/login_actors/props

#-------------------------------------------------------------------------------

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name_s" : "Ivan Trojan", "year_i" : 1964 }' \
    http://localhost:10011/buckets/login_actors/keys/trojan

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name_s" : "Jiri Machacek", "year_i" : 1966 }' \
    http://localhost:10011/buckets/login_actors/keys/machacek

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name_s" : "Jitka Schneiderova", "year_i" : 1973 }' \
    http://localhost:10011/buckets/login_actors/keys/schneiderova

curl -i -X PUT \
    -H 'Content-Type: application/json' \
    -d '{ "name_s" : "Zdenek Sverak", "year_i" : 1936 }' \
    http://localhost:10011/buckets/login_actors/keys/sverak

#-------------------------------------------------------------------------------

curl -i -X GET 'http://localhost:10011/search/query/login_iactors?wt=json&omitHeader=true&q=year_i:1964'

curl -i -X GET 'http://localhost:10011/search/query/login_iactors?wt=json&omitHeader=true&rows=10&q=(year_i:\[1960%20TO%20*\])AND(name_s:*de*)'

#-------------------------------------------------------------------------------

curl -i -X DELETE http://localhost:10011/buckets/login_actors/keys/trojan
curl -i -X DELETE http://localhost:10011/buckets/login_actors/keys/machacek
curl -i -X DELETE http://localhost:10011/buckets/login_actors/keys/schneiderova
curl -i -X DELETE http://localhost:10011/buckets/login_actors/keys/sverak

curl -i -X DELETE http://localhost:10011/buckets/login_movies/keys/vratnelahve
curl -i -X DELETE http://localhost:10011/buckets/login_movies/keys/samotari
curl -i -X DELETE http://localhost:10011/buckets/login_movies/keys/medvidek

#-------------------------------------------------------------------------------
