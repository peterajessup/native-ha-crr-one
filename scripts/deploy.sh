#!/bin/bash

set +e

# --------For the Live site-------------
set +e
oc project mq

oc delete QueueManager sydqm 
oc delete route sydroute 
oc delete secret mqkey sydkey tls-mel
oc delete configMap mq1-mqsc

set -e
oc apply -f sydRoute.yaml

oc create secret tls mqkey --cert=./tls/tls.crt --key=./tls/tls.key

# Key and cert for CRR
oc create secret tls sydkey --cert=./tls/tls.crt --key=./tls/tls.key
oc create secret generic tls-mel --from-file ./tls/tls.crt 
oc create -f mqsc/mqscsyd.yaml


oc apply -f sydCrr.yaml

