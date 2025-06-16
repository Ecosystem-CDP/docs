# OpenSource Data Platform (ODP) Stack Installation on Ubuntu 22.04 via Clemlab

> **Important:**  
> The authentication session for accessing Clemlab repositories is short-lived.  
> **You must perform the installation steps immediately after authenticating on the Clemlab platform**—otherwise, repository access will be denied (HTTP 403 Forbidden).

## Prerequisites

- Ubuntu 22.04 system with root or sudo privileges
- Active and recent authentication on the [Clemlab platform](https://www.opensourcedataplatform.com)[^2]
- Internet connection

---

## Step 1: Import the Clemlab GPG Key

Download and install the Clemlab GPG key in the correct binary format:

```

wget -O - https://archive.clemlab.com/RPM-GPG-KEY-Jenkins | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/odp.gpg > /dev/null

```

---

## Step 2: Add the ODP APT Repository

Download the repository list file and place it in the appropriate directory:

```

wget -O /etc/apt/sources.list.d/ambari.list https://archive.clemlab.com/ubuntu22/odp-release/1.2.4.0-108/ambari.list

```

---

## Step 3: Update APT Cache

Update your package lists to include the new repository:

```

sudo apt update

```

> **Note:**  
> If you receive a `403 Forbidden` error at this step, your authentication session with Clemlab may have expired.  
> Return to the Clemlab platform, log in again, and immediately retry the steps above.

---

## Step 4: Install Ambari Components (if not already installed)

If you do **not** have Ambari Server and Agent installed, run:

```

sudo apt install ambari-server ambari-agent

```

If you already have these components installed, you can skip this step.

---

## Step 5: Enable and Start Ambari Services

Enable the services to start automatically on boot, then start them:

```

sudo systemctl enable ambari-server
sudo systemctl start ambari-server

sudo systemctl enable ambari-agent
sudo systemctl start ambari-agent

```

---

## Step 6: Access the Ambari Web Interface

Open your browser and go to:

```

http://<YOUR_SERVER_IP>:8080

```

- Default username: `admin`
- Default password: `admin`

---

## Step 7: Register the ODP Stack in Ambari

1. In the Ambari web UI, go to:  
   `Admin > Stack and Versions`
2. Click **Manage Versions** and then **Register Version**.
3. For **Version Definition File URL**, enter:

```

https://archive.clemlab.com/ubuntu22/odp-release/1.2.4.0-108/ODP-VDF.xml

```

4. Complete the wizard to register the stack.

---

## Step 8: Install ODP Services via Ambari

- Use the Ambari wizard to add hosts and install the desired ODP components (Hadoop, Hive, Spark, etc.).
- Follow all on-screen instructions to complete the cluster setup.

---

## Troubleshooting

- **403 Forbidden when updating APT:**  
This usually means your authentication on Clemlab has expired.  
Log in again on the Clemlab platform and retry the steps immediately.

- **Service not starting:**  
Check logs in `/var/log/ambari-server/` and `/var/log/ambari-agent/` for troubleshooting.

---

## References

- [Open Source Data Platform - Clemlab][^2]


Replace `<YOUR_SERVER_IP>` with your server's actual IP address.
You can further customize this documentation for your team's needs!

<div style="text-align: center">⁂</div>

[^1]: https://askubuntu.com/questions/1291732/cant-close-authentication-required-window-after-login

[^2]: https://www.opensourcedataplatform.com

[^3]: https://forum.image.sc/t/new-ubuntu-22-04-installation-server-and-web/93716

[^4]: https://community.passbolt.com/t/problem-finishing-install-on-ubuntu-22-04-2-lts/7022

[^5]: https://hostman.com/tutorials/installing-lamp-stack-on-ubuntu/

[^6]: https://computingforgeeks.com/openstack-deployment-on-ubuntu-with-devstack/

[^7]: https://www.youtube.com/watch?v=6I1Xg843sTI

[^8]: https://github.com/thorstenb/odpdown

[^9]: https://docs.openstack.org/horizon/latest/install/install-ubuntu.html

[^10]: https://stackoverflow.com/questions/73338845/how-to-install-openstack-on-ubuntu-in-2022

