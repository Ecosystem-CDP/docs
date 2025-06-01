# Apache Ambari + ODP Cluster — Ubuntu 22.04

This repository provides a step-by-step guide for installing, configuring, and validating a cluster with **Apache Ambari** and the **OpenSource Data Platform (ODP)** using **Ubuntu 22.04** virtual machines on **Oracle Cloud Infrastructure (OCI)**.

---

## Objective

Provide a clear and reproducible guide for building a secure, scalable, and efficient data lake using open-source tools, tailored for small and medium-sized public or private organizations in Brazil.

---

## Technologies and Tools

| Component        | Version        |
|------------------|----------------|
| Ubuntu           | 22.04 LTS      |
| Apache Ambari    | 2.7.11         |
| OpenSource Data Platform (ODP) | 1.2.4.0 |
| Hadoop           | 3.x (via ODP)  |
| Oracle Cloud     | Always Free    |

---

## Documentation Structure

All detailed guides are located in the [`docs/`](docs/) folder:

| Step | Document | Description |
|------|----------|-------------|
| 01 | [`00-requirements.md`](docs/00-requirements.md) | System and software requirements |
| 02 | [`01-vms-setup.md`](docs/01-vms-setup.md) | VM creation and basic setup |
| 03 | [`02-ssh-setup.md`](docs/02-ssh-setup.md) | Passwordless SSH between nodes |
| 04 | [`03-hosts-config.md`](docs/03-hosts-config.md) | `/etc/hosts` configuration |
| 05 | [`04-install-ambari.md`](docs/04-install-ambari.md) | Apache Ambari installation |
| 06 | [`05-odp-configuration.md`](docs/05-odp-configuration.md) | Cluster setup via Ambari |
| 07 | [`06-cluster-validation.md`](docs/06-cluster-validation.md) | Tests and validation |
| 08 | [`07-common-errors.md`](docs/07-common-errors.md) | Common issues and solutions |

---

## Minimum Requirements

- Oracle Cloud account (VMs in the same AD/FD)
- 1 main VM (Ambari Server) with **≥ 8 GB RAM**
- Up to 3 auxiliary VMs (worker nodes)
- SSH access with public key authentication
- All VMs running Ubuntu 22.04 LTS

---

## Project Status

- [x] Documentation structure
- [x] Ambari Server installation and testing
- [x] SSH key exchange and hosts config
- [ ] Full ODP integration via Ambari
- [ ] Production-grade validation

---

## Tested With

- Ubuntu Server 22.04 (Oracle Cloud — Always Free + Flexible shapes)
- Ambari + ODP from Clemlab repositories
- 1 master + 3 worker nodes cluster

---

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests with fixes, improvements, or suggestions.

---

## Contact

For questions or collaboration:

- GitHub: [@joaopfduarte](https://github.com/joaopfduarte)
- Email: joao.duarte@aluno.cefetmg.br
