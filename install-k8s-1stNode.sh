
# create cluster
kubeadm init --pod-network-cidr=10.244.0.0/16
# export config 
export KUBECONFIG=/etc/kubernetes/admin.conf
# add network to cluster
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "now you can add other nodes.."

# install k8s dashboard:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml

echo "use command to change ports: kubectl -n kubernetes-dashboard edit svc kubernetes-dashboard"
echo "under 'targetPort: 8443' write: nodePort: 30000"
echo "change type: ClusterIp to type: NodePort"

echo "check pods: kubectl -n kubernetes-dashboard get svc"

echo "open dashboard: https://IP:30000"
