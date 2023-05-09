docker build -t eikkon/multi-client-k8s:latest -t eikkon/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t eikkon/multi-server-k8s-pgfix:latest -t eikkon/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t eikkon/multi-worker-k8s:latest -t eikkon/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push eikkon/multi-client-k8s:latest
docker push eikkon/multi-server-k8s-pgfix:latest
docker push eikkon/multi-worker-k8s:latest

docker push eikkon/multi-client-k8s:$SHA
docker push eikkon/multi-server-k8s-pgfix:$SHA
docker push eikkon/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eikkon/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=eikkon/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=eikkon/multi-worker-k8s:$SHA