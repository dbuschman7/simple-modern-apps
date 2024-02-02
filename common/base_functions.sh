export DOCKER_HUB_USER="timeflies"

function microk8sRunning() {
  local running=$(microk8s status | grep -c "is running" | wc -l)
  if [ $running -eq 1 ]; then
    export MICROK8S=true
  else
    export MICROK8S=false
  fi
}

microk8sRunning

function packageDockerImage() {
  local dockerfile=$1
  local image=$2
  local tag=$3
  
  docker build -f $dockerfile -t $image:$tag .
  
  if ( $MICROK8S ); then # push to docker hub as well
    docker tag  $image:$tag $DOCKER_HUB_USER/$image:$tag
    docker push $DOCKER_HUB_USER/$image:$tag
  fi

}