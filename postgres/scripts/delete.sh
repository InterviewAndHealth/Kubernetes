# Delete postgres resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

helm uninstall postgres

kubectl delete -n postgres -f $BASE_PATH/pgadmin-deployment.yaml
kubectl delete -n postgres -f $BASE_PATH/pgadmin-sealed-secret.yaml
kubectl delete -n postgres -f $BASE_PATH/pgpool-sealed-secret.yaml
kubectl delete -n postgres -f $BASE_PATH/postgres-sealed-secret.yaml
