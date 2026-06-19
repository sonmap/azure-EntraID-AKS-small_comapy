# 10-network

CSV 기반으로 AKS 네트워크를 생성합니다.

## CSV
- `resource_groups.csv`
- `vnets.csv`
- `subnets.csv`
- `nsgs.csv`
- `nsg_rules.csv`

## 실행
```bash
terraform init
terraform validate
terraform plan -out tfplan
terraform apply tfplan
```

## 다음 단계
```bash
terraform output next_step_20_aks_network_reference
```
