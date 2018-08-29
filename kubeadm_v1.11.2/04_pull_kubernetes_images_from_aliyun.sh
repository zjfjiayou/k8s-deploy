#!/bin/bash

set -e

# Check version in https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
# Search "Running kubeadm without an internet connection"
# For running kubeadm without an internet connection you have to pre-pull the required master images for the version of choice:
KUBE_VERSION=v1.11.2
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.2.18
DNS_VERSION=1.1.3
username=anjia0532


# When test v1.11.0, I found Kubernetes depends on both pause-amd64:3.1 and pause:3.1 

images=(
google-containers.kube-proxy-amd64:${KUBE_VERSION}
google-containers.kube-scheduler-amd64:${KUBE_VERSION}
google-containers.kube-controller-manager-amd64:${KUBE_VERSION}
google-containers.kube-apiserver-amd64:${KUBE_VERSION}
pause:${KUBE_PAUSE_VERSION}
etcd-amd64:${ETCD_VERSION}
coredns:${DNS_VERSION}
)


for image in ${images[@]}
do
  docker pull ${username}/${image}
  tmp=${image/google-containers./}
  docker tag ${username}/${image} k8s.gcr.io/${tmp}
  docker rmi ${username}/${image}
done

unset ARCH version images username



