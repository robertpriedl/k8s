# QUick and dirty config for k8s and vra - dont use it in production!

# certificate for vRA is under /etc/kubernetes/admin.conf under: certificate-authority-data:

# token will be shown with: kubectl get secret default-token -o jsonpath='{.data.token}' | base64 --decode
# perhaps try without pipe

# to allow default to manage cluster make clusterrole binding.
# create for this a yaml file with:

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: fabric8-rbac
subjects:
  - kind: ServiceAccount
     # Reference to upper's `metadata.name`
    name: default
       # Reference to upper's `metadata.namespace`
    namespace: default
roleRef:
  kind: ClusterRole
  name: cluster-admin
  apiGroup: rbac.authorization.k8s.io
  
  # and apply it iwth: kubectl apply -f xxxx.yaml
