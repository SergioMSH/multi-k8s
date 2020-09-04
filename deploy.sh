docker build -t smshss/multi-client:latest -t smshss/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smshss/multi-server:latest -t smshss/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t smshss/multi-worker:latest -t smshss/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push smshss/multi-client:latest
docker push smshss/multi-server:latest
docker push smshss/multi-worker:latest

docker push smshss/multi-client:$SHA
docker push smshss/multi-server:$SHA
docker push smshss/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=smshss/multi-server:$SHA
kubectl set image deployments/client-deployment client=smshss/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=smshss/multi-worker:$SHA