# Apply RabbitMQ resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

kubectl apply -f $BASE_PATH/rabbits-namespace.yaml

kubectl apply -n rabbits -f $BASE_PATH/rabbits-sealed-secret.yaml

helm install rabbits oci://registry-1.docker.io/bitnamicharts/rabbitmq -f $BASE_PATH/rabbits-values.yaml
