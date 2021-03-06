## You can use kubectl drain to safely evict all of your pods from a node before you perform maintenance on the node
# kubectl drain node-1
## To mark a Node unschedulable, run:
# kubectl cordon node-1
## afterwards to tell Kubernetes that it can resume scheduling new pods onto the node.

# kubectl uncordon node-1
# kubectl drain node01 --ignore-daemonsets
# upgrade cluster
apt update
apt install kubeadm=1.20.0-00
kubeadm upgrade apply v1.20.0
apt install kubelet=1.20.0-00
systemctl restart kubelet
# etcd
kubectl describe pod etcd-controlplane -n kube-system
ETCDCTL_API=3 etcdctl --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --endpoints=https://[127.0.0.1]:2379 snapshot save /opt/snapshot-pre-boot.db

ETCDCTL_API=3 etcdctl  --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db
Next, update the /etc/kubernetes/manifests/etcd.yaml:

  volumes:
  - hostPath:
      path: /var/lib/etcd-from-backup
      type: DirectoryOrCreate
    name: etcd-data

    kubectl delete pod -n kube-system etcd-controlplane
