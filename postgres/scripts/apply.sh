# Apply Postgres resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

kubectl apply -f $BASE_PATH/postgres-namespace.yaml

kubectl apply -n postgres -f $BASE_PATH/postgres-sealed-secret.yaml
kubectl apply -n postgres -f $BASE_PATH/pgpool-sealed-secret.yaml
kubectl apply -n postgres -f $BASE_PATH/pgadmin-sealed-secret.yaml

helm install postgres oci://registry-1.docker.io/bitnamicharts/postgresql-ha -f $BASE_PATH/postgres-values.yaml

kubectl apply -n postgres -f $BASE_PATH/pgadmin-deployment.yaml