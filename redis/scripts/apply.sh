# Apply Redis resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

kubectl apply -f $BASE_PATH/redis-namespace.yaml

kubectl apply -n redis -f $BASE_PATH/redis-sealed-secret.yaml

helm install redis oci://registry-1.docker.io/bitnamicharts/redis -f $BASE_PATH/redis-values.yaml

kubectl apply -n redis -f $BASE_PATH/redisinsight-deployment.yaml