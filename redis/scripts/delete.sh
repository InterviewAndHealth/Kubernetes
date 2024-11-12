# Delete redis resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

helm uninstall redis

kubectl delete -n redis -f $BASE_PATH/redisinsight-deployment.yaml