#!/bin/bash
cd "$(dirname "$0")"
docker build -t kangaroo .
if [ $? -eq 0 ]; then
	echo Docker Image Successfully Created
else
	echo Docker Image Creation Fail
fi
docker build -t kangaroo .
if [ $? -eq 0 ]; then
	echo Docker Container Successfully Created from Docker Image
else
	echo Docker Container Fail to Create
fi
docker run --name kangaroo -p 8880:8880 -d kangaroo

docker cp preprocessing kangaroo:/tensorflow/models/research/object_detection
docker cp kangaroo_detection.ipynb kangaroo:/tensorflow/models/research/object_detection
docker cp ./ kangaroo:/object_detection_task

python -mwebbrowser http://localhost:8880/notebooks/kangaroo_detection.ipynb
