[![Build Status](https://travis-ci.org/DBCDK/recomole.svg?branch=master)](https://travis-ci.org/DBCDK/recomole)
[![Maintainability](https://api.codeclimate.com/v1/badges/04ad2e6e98561fafb864/maintainability)](https://codeclimate.com/github/DBCDK/recomole/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/04ad2e6e98561fafb864/test_coverage)](https://codeclimate.com/github/DBCDK/recomole/test_coverage)

# recomole #

recommender service based on loans
This. recommender is is a cosimilarity model based on loans

## Requests
The service provides one post method that takes a json structure, with the following keys:

* **like**: List of pids to base recommendation on
* **dislike**: List of pids to base recommendation on (not used at the moment)
* **start**: Paging. first row to return (defaults to 0)
* **rows**: Paging. Number of rows to return
* **ignore**: List of pids to ignore (pids from the work they belong to will not be returned in recommendation list)
* **filters**: object containing filters to apply to recommendations
* **boosters**: object containing boosters to apply to recommendations (not implemented yet)

### Filters
Filters are used to filter unwanted recommendations from the result.

Supported filters:

* **authorFlood**: The maximum number of recommendations from a single author in the result
* **subject**: List of subjects. Only materials with one of these subjects are returned
* **matType**: List of material types. Only materials with one of these subjects are returned
* **language**: List of languages. Only materials with one of these subjects are returned

### Boosters
Boost recommendations and change the ranking of resultset (not implemented yet).

### examples

simple example:
```json
{"like":["870970-basis:28511663"]}
```

paging example:
```json
{"like":["870970-basis:28511663"],
 "rows": 4,
 "start": 2}
```

ignore example:
```json
{"like": ["870970-basis:28511663"],
 "ignore": ["870970-basis:27925715"]}
```
 
AuthorFlood example:
```json
{"like":["870970-basis:28511663"],
 "maxresults": 2,
 "filters": {"authorFlood": 2}}
```

mutiple filters example:
```json
{"like":["870970-basis:28511663"],
 "maxresults": 2,
 "filters": {"authorFlood": 2,
             "language": ["dan", "eng"]}}
```

## response
Each *response* item consists of a recommended pid and some additional info.
The info object consists of the following keys:

* **pid**: pid in recommended work with highest loancount
* **val**: Similarity value
* **loancount**: Number of loans of recommended pid
* **from**: recommendations based in this item
* **debug-creator**: Creator of recommended work (should only be used for debugging)
* **debug-title**: Title of recommended work (should only be used for debugging)
* **debug-work**: Recommmended work (should only be used for debugging)
    
The *responseHeader* consists timings and other forms of metadata..</br></br>

### Endpoints

The service provides three endpoints:

* **loan-cosim** The recommender endpoint
* **loan-cosim/status** service status
* **loan-cosim/help** description and example client
