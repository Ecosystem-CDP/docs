# Cluster Requirements – Oracle Cloud Infrastructure + ODP Stack
*(docs/odp/00-requirements.md)*

This document lists all baseline requirements to deploy the OpenSource Data
Platform (ODP 1.2.4) with Apache Ambari on Oracle Cloud Infrastructure (OCI).
Meeting these prerequisites avoids installation failures and ensures every
service in the Big-Data stack has enough resources to start and operate.

---

## 1  Host Roles & Minimum Specs

| Role     | vCPU (OCPU) | RAM (GiB) | Root Disk | Extra Disk* | Purpose                            |
|----------|-------------|-----------|-----------|-------------|------------------------------------|
| master   | ≥ 4         | ≥ 24      | ≥ 100 GB  | optional    | Ambari Server, NameNode, Hive Metastore |
| worker   | ≥ 2         | ≥ 16      | ≥ 100 GB  | optional    | DataNode, NodeManager, other engines |

\*Attach block volumes for HDFS / YARN scratch space or object-store caching
when running heavy workloads.

---

## 2  Operating System

- Ubuntu 22.04 LTS 64-bit, fully updated
  `sudo apt update && sudo apt upgrade -y`
- Locale: `en_US.UTF-8` (or another UTF-8 locale)
- Time synchronisation enabled (systemd-timesyncd or chrony)

---

## 3  Software Prerequisites

| Package / Component          | Version / Notes                               |
|------------------------------|-----------------------------------------------|
| Java Runtime                 | OpenJDK 8 (u272 or newer) **Do not** use 8u40, 8u45, 8u60 or 8u242 – they break Ambari agents |
| Python 2                     | Required by Ambari agents (`python2`, `python2-dev`) |
| Build & utility tools        | `gcc`, `make`, `tar`, `sed`, `unzip`, `wget`, `curl` |
| SSL libraries                | `openssl`, `libssl-dev`                      |
| Compression library          | `libsnappy-dev`, `libsnappy1v5`              |
| OpenSSH                      | `openssh-server`, `openssh-client`           |
| Kerberos client libs         | `sssd-krb5`                                  |

Install in one shot:


sudo apt install -y curl wget unzip tar sed gcc make openssl libssl-dev \
     python2 python2-dev openjdk-8-jdk libsnappy-dev libsnappy1v5 \
     openssh-server openssh-client sssd-krb5


---

## 4  Network & Firewall

| Port | Direction | Used by                 | Comment                                   |
|------|-----------|-------------------------|-------------------------------------------|
| 22   | In/Out    | SSH                     | Required for administration               |
| 8080 | In        | Ambari Web UI           | Open to admin workstation / Jump host     |
| 8440 | In        | Ambari Agent ➡ Server   | Agents initiate heartbeat RPC             |
| 8441 | In        | Ambari Agent ➡ Server   | TLS heartbeat (optional, same as 8440)    |
| 1022 | In        | (Oracle serial console) | OCI default – may keep for break-glass    |

OCI Security List (or Network Security Group) must include the entries above
between the master and every worker (`10.0.0.0/24` in the examples).
On each VM, either disable UFW/firewalld or allow the same ports:

# for UFW (Ubuntu default)
sudo ufw allow 8080/tcp
sudo ufw allow 8440,8441/tcp
sudo ufw enable           # if not enabled yet


---

## 5  DNS & Hostname Policy

- Every node must resolve its own FQDN (`hostname -f`) and those of all other
  nodes.
- Typical approach in small labs: manage `/etc/hosts` on each VM:


10.0.2.207 master.clemlab.local master
10.0.2.11  node1.clemlab.local  node1
10.0.2.12  node2.clemlab.local  node2
10.0.2.13  node3.clemlab.local  node3


---

## 6  OCI Resource Checklist

| OCI Item                | Recommendation                               |
|-------------------------|----------------------------------------------|
| Compartment             | One per environment (dev / prod)            |
| VCN CIDR                | `/16` or `/24` private range (no overlap)   |
| Subnet type             | Private subnet + NAT Gateway (preferred)    |
| Object Storage          | 100 GB bucket for logs / backups            |
| Block Volumes           | 500 GB @ Balanced for HDFS, attach as needed|
| IAM Policy              | Least privilege; create group *bigdata-ops* |

---

## 7  Authentication Token Window (Clemlab)

Clemlab repository URLs are gated by a short-lived session cookie.
Authenticate in the Clemlab portal **immediately** before:


# 1 – import GPG key in binary form
wget -O - https://archive.clemlab.com/RPM-GPG-KEY-Jenkins | \
    gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/odp.gpg > /dev/null

# 2 – add repo list
wget -O /etc/apt/sources.list.d/ambari.list \
    https://archive.clemlab.com/ubuntu22/odp-release/1.2.4.0-108/ambari.list

# 3 – refresh cache
sudo apt update


If `apt update` returns **403 Forbidden**, the token has expired—log in again
and repeat the three commands above.

---

## 8  Quick Validation Commands


# Java version
java -version     # should print 1.8.0_xx

# Python 2
python2 -V        # should print 2.7.x

# Hostname/FQDN
hostname -f

# Open TCP ports (master only)
sudo ss -ltnp | grep -E '8080|8440|8441'

All checks passing means the host is ready to install **ambari-server** or
**ambari-agent** and to join the cluster.

---

*Last updated: 2025-06-24*


[1] https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/73168941/83257260-933e-4793-934f-00f6faa6ae41/como-checar-no-ubuntu-22.04-se-o-ambari-server-est.md
[2] https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/73168941/908e146c-ed6b-4879-a6c1-90c46e51f033/plano-pibic.pdf
[3] https://github-wiki-see.page/m/acceldata-io/odpdocumentation/wiki/3-ODP-User-Guide
[4] https://gist.github.com/AlessandroAnnini/4f5276167e5770aa76a034ddb4d8dcc2
[5] https://layers.openembedded.org/layerindex/recipe/122613/
[6] https://pypi.org/project/cddp/
[7] https://docs.oracle.com/en/database/oracle/oracle-data-access-components/19.3/odpnt/data-provider-net-developers-guide.pdf
[8] https://www.acceldata.io/open-data-platform
[9] https://hackmd.io/@francescovarrato/HkhBW0uDB
[10] https://docs.acceldata.io/odp/documentation/ODP-introduction
[11] https://www.npmjs.com/package/odp-sdk
[12] https://help.sap.com/doc/saphelp_nw75/7.5.5/en-US/11/853413cf124dde91925284133c007d/content.htm?no_cache=true
[13] https://github.com/osrmt/osrmt
[14] https://github.com/boozallen/opendataplatform
[15] https://www.instaclustr.com/education/open-source-ai/open-source-data-platform-architecture-and-top-10-tools-to-know/
[16] https://academic.oup.com/gigascience/article/doi/10.1093/gigascience/giaf038/8119128
[17] https://opencode.md/en/about/requirements/
[18] https://github.com/the-robot/open-data-platform
[19] https://dev.to/longbuivan/your-open-source-data-platform-starter-kit-57j9
[20] https://www.opendatacube.org