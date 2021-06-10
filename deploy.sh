docker build -t mseerah/multi-client:latest -t mseerah/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t mseerah/multi-server:latest -t mseerah/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t mseerah/multi-worker:latest -t mseerah/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push mseerah/multi-client:latest
docker push mseerah/multi-client:SHA
docker push mseerah/multi-server:latest
docker push mseerah/multi-server:SHA
docker push mseerah/multi-worker:latest
docker push mseerah/multi-worker:SHA


kubectl apply -f k8s

Kubectl set image deployments/client-deployment client=mseerah/multi-client:$SHA
Kubectl set image deployments/server-deployment server=mseerah/multi-server:$SHA
Kubectl set image deployments/worker-deployment worker=mseerah/multi-worker:$SHA