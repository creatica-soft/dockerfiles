#!/usr/bin/bash
if [[ $# < 1 || $# > 1 ]]; then 
  echo -e "This script re-deploys rstudio-server k8s objects for all users\nIt re-applies rstudio-remote_user.yaml template.\nAttention! Users will be logged out rstudio server\nusage: ./re-deploy.sh all"
  exit 
fi
if [[ "$1" == "-h" || "$1" == "-?" || "$1" == "--help" || "$1" == "help" ]]; then 
  echo -e "This script re-deploys all rstudio-server k8s objects for all users\nIt re-applies rstudio-remote_user.yaml template.\nAttention! Users will be logged out rstudio server\nusage: ./re-deploy.sh all"
  exit
fi
if [[ "$1" == "all" ]]; then 
  for d in `kubectl get pod -l "soft=rstudio" --no-headers=true|cut -f2 -d"-"`; do 
    if [[ "$d" != "bi" ]]; then 
#    ./deploy.sh $d -n
      kubectl delete deployment rstudio-$d
      export remote_user=$d
      envsubst < rstudio-remote_user.yaml |kubectl apply -f -
      unset remote_user
    fi
  done
fi

