# Delete RabbitMQ resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

helm uninstall rabbits

kubectl delete -n rabbits -f $BASE_PATH/rabbits-sealed-secret.yaml