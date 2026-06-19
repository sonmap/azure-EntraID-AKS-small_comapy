# 00-entra-org

이 스택은 CSV 기반으로 Microsoft Entra ID 조직 구성을 생성합니다.

## 포함
- `data/users.csv`: 30명 사용자
- `data/groups.csv`: 보안 그룹
- `data/group_memberships.csv`: 사용자-그룹 매핑
- `data/azure_rbac.csv`: Azure RBAC 권한
- `data/aks_rbac.csv`: AKS 권한 설계 매핑

## 실행
```bash
terraform init
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

## 다음 단계
```bash
terraform output aks_tfvars_object_ids
```

출력된 그룹 Object ID를 `20-aks/sonmap.auto.tfvars`, `30-aks-rbac/sonmap.auto.tfvars`에 넣습니다.
