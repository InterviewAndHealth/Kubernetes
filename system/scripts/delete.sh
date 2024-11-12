# Delete system resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

# Sealed Secrets resources

kubectl delete -f $BASE_PATH/sealed-secrets-controller.yaml

KEYS_PATH="$(dirname "$DIR")/sealed-secrets-keys"

for key in $KEYS_PATH/*.key; do
  kubectl delete -f $key
done

# Delete remaining resources
kubectl delete -f $BASE_PATH/aws-sealed-secret.yaml

kubectl delete -k github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.36

kubectl delete -f $BASE_PATH/aws-ebs-storage-class.yaml