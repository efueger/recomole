# recomole

recommender service based on loans
This. recommender is is a cosimilarity model based on loans

### Requests
The service provides one post method that takes a json structure, with the following keys:

* **like**: List of pids to base recommendation on
* **maxresult**: Maximum number of returned results
* **creatormax**: Maximum number works by a single creator

### response
Each *response* item consists of a recommended pid and some additional info.
The info object consists of the following keys:

* **pid**: pid in recommended work with highest loancount
* **work**: Recommmended work
* **val**: Similarity value
* **debug-creator**: Creator of recommended work (should only be used for debugging)
* **debug-title**: Title of recommended work (should only be used for debugging)
* **loancount**: Number of loans of recommended pid
* **from**: recommendations based in this item
    
   The *responseHeader* consists timings and other forms of metadata..</br></br>

### Endpoints

The service provides three endpoints:

* **loan-cosim** The recommender endpoint
* **loan-cosim/status** service status
* **loan-cosim/help** description and example client
