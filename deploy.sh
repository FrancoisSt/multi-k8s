docker build -t nawu/multi-client:latest -t nawu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nawu/multi-server:latest -t nawu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nawu/multi-worker:latest -t nawu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nawu/multi-client:latest
docker push nawu/multi-client:$SHA
docker push nawu/multi-server:latest
docker push nawu/multi-server:$SHA
docker push nawu/multi-worker:latest
docker push nawu/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=nawu/multi-client:$SHA
kubectl set image deployments/server-deployment server=nawu/multi-server:$SHA
kubectl set image deployments/worker-deployment server=nawu/multi-worker:$SHA