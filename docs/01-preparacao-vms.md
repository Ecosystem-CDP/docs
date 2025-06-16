
# \# Cluster System Preparation - Apache Ambari + ODP

This document describes the initial preparation steps for configuring a cluster environment using Apache Ambari and Open Data Platform (ODP) on Ubuntu 22.04 virtual machines provisioned on Oracle Cloud Infrastructure (OCI).

## Cluster Nodes

The cluster consists of the following virtual machines, by example:


| Role | Public IP | SSH Access Command |
| :-- | :-- | :-- |
| master | 136.248.89.210 | `ssh -i "ssh-key-2025-05-20.key" ubuntu@136.248.89.210` |
| node1 | 137.131.159.126 | `ssh -i "ssh-key-2025-05-20.key" ubuntu@137.131.159.126` |
| node2 | 136.248.64.191 | `ssh -i "ssh-key-2025-05-20.key" ubuntu@136.248.64.191` |
| node3 | 164.152.61.106 | `ssh -i "ssh-key-2025-05-20.key" ubuntu@164.152.61.106` |

Each of these VMs should be updated and configured equally during this preparation phase.

---

## Step 1: Update System Packages

SSH into each virtual machine and run the following commands:

```bash
sudo apt update && sudo apt upgrade -y
```

During the upgrade process, a kernel update prompt may appear:

pgsql
Copy
Edit
Pending kernel upgrade

Newer kernel available

The currently running kernel version is 6.8.0-1025-oracle
which is not the expected kernel version 6.8.0-1026-oracle.

Restarting the system to load the new kernel will not be handled automatically, so you should consider rebooting.
In this case:

Press <Enter> to continue.

Manually reboot the instance using:

bash
Copy
Edit
sudo reboot
After rebooting, verify that the new kernel is in use:

bash
Copy
Edit
uname -r
# Expected output: 6.8.0-1026-oracle or later
Repeat this process for all four virtual machines.

Step 2: Install Required Dependencies
After ensuring all machines are up-to-date and running the new kernel, install the essential packages using the following command:

bash
Copy
Edit
sudo apt install -y curl unzip tar wget sed gcc openssl libssl-dev \
python2 python2-dev openjdk-8-jdk libsnappy-dev libsnappy1v5 \
openssh-server openssh-client sssd-krb5
Note: The scp command is already provided by the openssh-client package and does not require separate installation.


me envie o markdown propriadamente formatado do texto acima, quando copiei parte quebrou. Me envie num bloco de código markodwon apenas,


