# Apply system resources

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_PATH="$(dirname "$DIR")/manifests"

# Apply Calico CNI
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/calico.yaml

# Sealed Secrets resources

KEYS_PATH="$(dirname "$DIR")/sealed-secrets-keys"
KEYS_COUNT=$(ls -1 $KEYS_PATH/*.key 2>/dev/null | wc -l)

if [ $KEYS_COUNT -eq 0 ]; then
  echo "No sealed-secrets keys found. Add keys to $KEYS_PATH and try again."
  exit 1
fi

for key in $KEYS_PATH/*.key; do
  kubectl apply -f $key
done

kubectl apply -f $BASE_PATH/sealed-secrets-controller.yaml

# Wait for Sealed Secrets controller to be ready
kubectl wait --for=condition=available --timeout=600s deployment/sealed-secrets-controller -n kube-system

# Apply remaining resources
kubectl apply -f $BASE_PATH/aws-sealed-secret.yaml

kubectl apply -k github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.36

kubectl apply -f $BASE_PATH/aws-ebs-storage-class.yaml
