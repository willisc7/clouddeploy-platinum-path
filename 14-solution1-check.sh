#!/bin/bash

function _fatal() {
    echo "$*" >&1
    exit 42
}
function _after_allgood_post_script() {
    echo "[$0] All good on $(date)"
    CLEANED_UP_DOLL0="$(basename $0)"
    touch .executed_ok."$CLEANED_UP_DOLL0".touch
}

# Created with codelabba.rb v.1.7a
source .env.sh || _fatal 'Couldnt source this'
set -e

########################
# Add your code here
########################
#  We're going to use  - "sol1-__APPNAME__.example.io"    # kept for easy curl/documented static commands :)
DEFAULT_APP="app01"                       # app01 / app02
APP_NAME="${1:-$DEFAULT_APP}"
URL="sol1-$APP_NAME.example.io"

#bin/kubectl-canary apply -f "$GKE_SOLUTION1_XLB_PODSCALING_SETUP_DIR/out/"
#bin/kubectl-prod   apply -f "$GKE_SOLUTION1_XLB_PODSCALING_SETUP_DIR/out/"

#set -x
yellow "Watch in awe this:"
bin/kubectl-triune get gateways | egrep "NAME|sol1"

yellow "Warning, IP address is currently hard-coded :/"
#LB_NAME="http-svc9010-lb"
SOL1_LB_NAME_FOR_MY_APP="sol1-$APP_NAME-$DEFAULT_SHORT_REGION-gke-l7-gxlb"
#ENDPOINT_IP="34.160.173.24:80"	# https://console.cloud.google.com/net-services/loadbalancing/details/httpAdvanced/http-svc9010-lb?project=cicd-platinum-test001
ENDPOINT_IP='1.2.3.4'



yellow "TODO check for a LB called SOL1_LB_NAME_FOR_MY_APP=$SOL1_LB_NAME_FOR_MY_APP. Once you do, youre done and you can subsitute it to this static IP."
curl -H "host: $URL" "$ENDPOINT_IP/canary" 2>/dev/null
curl -H "host: $URL" "$ENDPOINT_IP/prod" 2>/dev/null


########################
# End of your code here
########################
#green 'Everything is ok. To use this amazing script, please download it from https://github.com/palladius/sakura'
_after_allgood_post_script
echo 'Everything is ok'
