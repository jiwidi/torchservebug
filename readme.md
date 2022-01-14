# To run locally
From the root folder run

```
$ sh test.sh
```
This runs succesfully
# Run with docker
From the root folder run

```
$ docker build . -t debug:v1

$ docker run debug:v1
```

This doesnt run, torchserve cant load the model
