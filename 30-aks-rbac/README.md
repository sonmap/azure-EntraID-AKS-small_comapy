# 30-aks-rbac

CSV 기반으로 Kubernetes Namespace, Role, RoleBinding을 생성합니다.

## 선행 조건
```bash
az aks get-credentials -g rg-ai-aks-krc -n aks-ai-dev-krc --overwrite-existing
kubectl config current-context
```

## CSV
- `namespaces.csv`
- `roles.csv`
- `rolebindings.csv`

## 실행
```bash
terraform init
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

주의: AKS Entra ID 그룹 클레임은 일반적으로 Object ID 기준으로 매핑합니다. 그래서 `sonmap.auto.tfvars`에 그룹 Object ID를 넣습니다.
