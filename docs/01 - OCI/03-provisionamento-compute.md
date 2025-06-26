## Provisionamento das Máquinas Virtuais

Serão criadas **4 instâncias**:

| Função  | Shape sugerido | Sistema Operacional |
|---------|----------------|---------------------|
| master  | VM.Standard.E4.Flex (4 OCPU, 16 GB) | Ubuntu 22.04 |
| node1  | VM.Standard.E4.Flex (2 OCPU, 8 GB)  | Ubuntu 22.04 |
| node2  | VM.Standard.E4.Flex (2 OCPU, 8 GB)  | Ubuntu 22.04 |
| node3  | VM.Standard.E4.Flex (2 OCPU, 8 GB)  | Ubuntu 22.04 |

### Terraform

