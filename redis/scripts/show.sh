# Port forward redisinsight service
kubectl port-forward -n redis svc/redisinsight-service 8002:80