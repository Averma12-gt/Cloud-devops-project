#!/bin/bash

docker buildx build --platform linux/amd64 -t akash-cloud-app . --load
docker tag akash-cloud-app:latest 590183758261.dkr.ecr.ap-south-1.amazonaws.com/akash-cloud-app:latest
docker push 590183758261.dkr.ecr.ap-south-1.amazonaws.com/akash-cloud-app:latest

aws ecs update-service \
  --cluster akash-cluster \
  --service akash-service \
  --force-new-deployment

