docker build -t dennis7/multi-client:latest -t dennis7/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t dennis7/multi-server:latest -t dennis7/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t dennis7/multi-worker:latest -t dennis7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dennis7/multi-client:latest
docker push dennis7/multi-server:latest
docker push dennis7/multi-worker:latest

docker push dennis7/multi-client:$SHA
docker push dennis7/multi-server:$SHA
docker push dennis7/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/client-deplyment client=dennis7/multi-client:$SHA 
kubectl set image deployments/server-deplyment server=dennis7/multi-server:$SHA 
kubectl set image deployments/worker-deplyment worker=dennis7/multi-worker:$SHA 


