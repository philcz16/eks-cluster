#!/usr/bin/env bash

# This script does a graceful rolling upgrade of an EKS cluster using https://github.com/hellofresh/eks-rolling-update
# It's needed when worker node groups have changes (AMI version, userdata, etc.)

set -euo pipefail

# export KUBECONFIG="./kubeconfig_ara-prod-use1"
export K8S_CONTEXT=" arn:aws:eks:us-east-1:077794698366:cluster/philcz-lab-ChaQvs8R "
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ACCESS_KEY_ID="AKIAREHHM4R7IHWRMZVW"
export AWS_SECRET_ACCESS_KEY="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"
export K8S_AUTOSCALER_ENABLED="True"
export K8S_AUTOSCALER_NAMESPACE="cluster-autoscaler"
export K8S_AUTOSCALER_DEPLOYMENT="cluster-autoscaler-aws-cluster-autoscaler"
# Forcing drain is required because nodes may have pods not managed by any replication controller and therefor fail normal draining
export EXTRA_DRAIN_ARGS="--force=true"
# Wait 30s between node deletion and taking down the next one in ASG just in case something didn't finish replication in time
export BETWEEN_NODES_WAIT="30"
# Retry operations a bunch of times as things may roll slowly on large clusters
export GLOBAL_MAX_RETRY="30"
export DRY_RUN="true"
export ASG_NAMES="philcz-lab-ChaQvs8R-worker-group-120230420130327830200000017"

eks_rolling_update.py --cluster_name philcz-lab-ChaQvs8R 
