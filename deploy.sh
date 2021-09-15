docker build -t indranilatcal/multi-client:latest -t indranilatcal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t indranilatcal/multi-server:latest -t indranilatcal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t indranilatcal/multi-worker:latest -t indranilatcal/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push indranilatcal/multi-client:latest
docker push indranilatcal/multi-server:latest
docker push indranilatcal/multi-worker:latest

docker push indranilatcal/multi-client:$SHA
docker push indranilatcal/multi-server:$SHA
docker push indranilatcal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=indranilatcal/multi-client:$SHA
kubectl set image deployments/server-deployment server=indranilatcal/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=indranilatcal/multi-worker:$SHA