NAMESPACE=$1
if [[ ! -z "$NAMESPACE" ]]; then
  NAMESPACE='--namespace='$NAMESPACE
else
  echo "usage: stack_up.sh <namespace>"
  exit
fi
kubectl create -f liferegistry_secret.yaml $NAMESPACE 
kubectl create -f zookeeper.yaml $NAMESPACE 
while [ $(kubectl get po $NAMESPACE -o=wide | grep zk | grep Run | wc -l) -ne 3 ] ; do sleep 3; echo "Zookeper cluster not ready. Will try again after 3 sec..." ;done
kubectl create -f clickhouse.yaml $NAMESPACE 

