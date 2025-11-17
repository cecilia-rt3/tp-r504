#!/bin/bash
docker stop nginx-lb  2>/dev/null || true 
docker stop nginx1  2>/dev/null || true 
docker stop nginx2  2>/dev/null || true 

docker network rm tplb  2>/dev/null || true 
