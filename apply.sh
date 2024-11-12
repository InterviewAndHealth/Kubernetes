# Apply all application resources

BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# System resources
bash $BASE_PATH/system/scripts/apply.sh

if [ $? -ne 0 ]; then
  exit 1
fi

# Postgres resources
bash $BASE_PATH/postgres/scripts/apply.sh

# RabbitMQ resources
bash $BASE_PATH/rabbits/scripts/apply.sh

# Redis resources
bash $BASE_PATH/redis/scripts/apply.sh
