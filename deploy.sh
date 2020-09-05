docker build -t perikala/multi-client:latest -t perikala/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t perikala/multi-server:latest -t perikala/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t perikala/multi-worker:latest -t perikala/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push perikala/multi-client:latest
docker push perikala/multi-server:latest
docker push perikala/multi-worker:latest

docker push perikala/multi-client:$SHA
docker push perikala/multi-server:$SHA
docker push perikala/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=perikala/multi-client:$SHA
kubectl set image deployment/server-deployment server=perikala/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=perikala/multi-worker:$SHA