docker build -t eikkon/multi-client:latest -t eikkon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eikkon/multi-server:latest -t eikkon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eikkon/multi-worker:latest -t eikkon/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push eikkon/multi-client:latest
docker push eikkon/multi-server:latest
docker push eikkon/multi-worker:latest
docker push eikkon/multi-client:$SHA
docker push eikkon/multi-server:$SHA
docker push eikkon/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eikkon/multi-server:$SHA 
kubectl set image deployments/client-deployment client=eikkon/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=eikkon/multi-worker:$SHA 