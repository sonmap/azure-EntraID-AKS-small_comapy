# 20-aks

CSV 기반으로 AKS, ACR, Log Analytics, Node Pool, AKS Azure RBAC를 생성합니다.

## 선행 조건
1. `10-network` 배포 완료
2. `00-entra-org` output에서 그룹 Object ID 확인
3. `sonmap.auto.tfvars`의 `<...OBJECT_ID>` 값 교체

## 실행
```bash
terraform init
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

## 다음 단계
```bash
terraform output next_step_30_aks_rbac
az aks get-credentials -g rg-ai-aks-krc -n aks-ai-dev-krc --overwrite-existing
```
