docker build -t indranilatcal/multi-client-k8s:latest -t indranilatcal/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t indranilatcal/multi-server-k8s-pgfix:latest -t indranilatcal/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t indranilatcal/multi-worker-k8s:latest -t indranilatcal/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push indranilatcal/multi-client-k8s:latest
docker push indranilatcal/multi-server-k8s-pgfix:latest
docker push indranilatcal/multi-worker-k8s:latest

docker push indranilatcal/multi-client-k8s:$SHA
docker push indranilatcal/multi-server-k8s-pgfix:$SHA
docker push indranilatcal/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=indranilatcal/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=indranilatcal/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=indranilatcal/multi-worker-k8s:$SHA