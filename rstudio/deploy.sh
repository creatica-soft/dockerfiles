#!/usr/bin/bash
if [[ $# < 1 || $# > 2 ]]; then echo -e "deploy.sh <username> [-n]\n -n - disable group membership check"; exit; fi
if [[ $1 == "-h" || $1 == "-?" || $1 == "--help" || $1 == "help" ]]; then echo -e "deploy.sh <username> [-n]\n -n - disable group membership check"; exit; fi
if [[ $# == 1 || $2 != "-n" ]]; then
 if [[ -f ~/.ldaprc || -f ~/ldaprc ]]; then
  echo "When prompted, please provide your AD account password to check if $1 has Unix attributes and correct group membership"
  ldapsearch -x -W sAMAccountName=$1 uidNumber memberOf > /tmp/ldapsearchres
  UID_NUMBER=`cat /tmp/ldapsearchres|grep uidNumber:|cut -f2 -d" "`
  if [[ $UID_NUMBER == '' ]]; then
    echo "User $1 does not have Unix attributes enabled. Please contact MS Windows team for the support"
    exit
  fi
#  ldapsearch -x -W sAMAccountName=$1 memberOf|grep memberOf:|cut -f2 -d"="|cut -f1 -d","|grep QAS|tr -s " " "_" > /tmp/grps
  cat /tmp/ldapsearchres|grep memberOf:|cut -f2 -d"="|cut -f1 -d","|grep QAS|tr -s " " "_" > /tmp/grps
  kubectl describe configmaps etc-pam-d-rstudio-server-allowed-groups|grep ^QAS|tr -s " " "_" > /tmp/allowed_grps
  MATCH=false
  for g in `cat /tmp/grps`; do
   grep ^$g$ /tmp/allowed_grps > /dev/null;
   if (($? != 0)); then continue;
   else MATCH=true; break;
   fi
  done
  if [[ $MATCH == "false" ]]; then echo "User account is not a member of required kazootek AD QAS groups"; exit; fi
 else echo "missing ~/.ldaprc file with BINDDN '<your AD account DN>' line in it"; exit; fi
fi
kubectl get deployment rstudio-$1
if (( $? == 0 )); then
  read -p "Rstudio deployment for the user $1 already exists. Would you like to delete it and create a new one? [y/N]"
  if [[ "${REPLY}" == "y" ]]; then
    kubectl delete deployment rstudio-$1
  else
    echo "Leaving the current rstudio-$1 deployment intact"
    exit 1
  fi
fi
export remote_user=$1
envsubst < rstudio-remote_user.yaml |kubectl apply -f -
unset remote_user
sleep 5
kubectl get pods -o wide -w|grep rstudio-$1
