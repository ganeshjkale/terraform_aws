#!/bin/bash
kubectl apply -f metric_components.yaml
kubectl apply -f 01_redis/
kubectl apply -f 02_webapp/
kubectl apply -f user_role/
