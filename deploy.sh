docker build -t chaudhary1993/multi-client:latest -t chaudhary1993/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chaudhary1993/multi-server:latest -t chaudhary1993/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chaudhary1993/multi-worker:latest  -t chaudhary1993/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push chaudhary1993/multi-client:latest
docker push chaudhary1993/multi-server:latest
docker push chaudhary1993/multi-worker:latest
docker push chaudhary1993/multi-client:$SHA 
docker push chaudhary1993/multi-server:$SHA 
docker push chaudhary1993/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chaudhary1993/multi-server:$SHA
kubectl set image deployments/client-deployment client=chaudhary1993/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chaudhary1993/multi-worker:$SHA