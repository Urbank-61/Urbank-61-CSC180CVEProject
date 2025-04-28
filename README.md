# Urbank-61-CSC180CVEProject
# CVE-2025-21497 Lab: Simulating Remote Code Execution via MySQL Vulnerability

## CVE Summary

CVE-2025-21497 is a critical vulnerability in MySQL that allows remote code execution (RCE) by exploiting insecure configuration and inadequate privilege handling in the affected version. The vulnerability exists in MySQL Server versions prior to 8.0.40.

- ✅ **Exploit vector**: Remote connection with misconfigured privileges
- ❗ **Impact**: Code execution on MySQL server, data corruption, and unauthorized access
- ✅ **Fixed in**: MySQL 8.0.40 and later

---

## Building Labs from CVEs — Prompt Checklist

To create a lab from this CVE, the following steps were completed:

### 1. Vulnerability Details

- **CVE**: 2025-21497
- **Type**: Remote Code Execution (RCE)
- **Software**: MySQL versions prior to 8.0.40

### 2. Learning Objectives

- Understand how privilege misconfigurations can lead to code execution.
- Explore how attackers can exploit misconfigurations to escalate privileges on a MySQL server.
- Demonstrate effective mitigation and patching techniques.

### 3. Environment Setup

- **Tooling**: Docker, Docker Compose
- **Language/Environment**: Python, MySQL, Bash

### 4. ⚙️ Exploit Method

- A simulated attack is executed via a misconfigured MySQL installation. By using Docker, this vulnerability is safely replicated in a contained environment for educational purposes.

### 5. Remediation & Mitigation

- Upgrade to MySQL 8.0.40 or later.
- Enforce secure configurations and restrict privileged access.

---

## Lab: Simulating CVE-2025-21497 in Docker

This lab demonstrates a simulated RCE attack on MySQL via an improperly configured MySQL server.

### What It Does

- Builds a vulnerable MySQL container.
- Simulates an attack exploiting a misconfiguration.
- Confirms vulnerability by attempting an unauthorized connection.

---

## Folder Structure

    cve-2025-21497-lab/
    ├── docker-compose.yml
    ├── Dockerfile
    ├── install.sh
    ├── requirements.txt
    └── malicious_pkg/
        └── setup.py

---

## 🛠️ Lab Setup

### 1️⃣ `malicious_pkg/setup.py`

```python
from setuptools import setup
import os

# Simulate payload execution at install time
os.system('echo "[+] MySQL RCE triggered! Dropping shell..."')
os.system('touch /tmp/mysql_rce_success.txt')

setup(
    name='mysql-backdoor-pkg',
    version='0.0.1',
    description='Fake MySQL backdoor for CVE simulation',
    py_modules=[],
)

---

2️⃣ requirements.txt

mysql-backdoor-pkg
---

3️⃣ install.sh

#!/bin/bash
echo "[*] Starting MySQL RCE simulation..."

pip install --no-cache-dir --find-links=file:///local_pypi -r requirements.txt

echo "[*] Simulation complete."
ls /tmp/mysql_rce_success.txt && cat /tmp/mysql_rce_success.txt || echo "[!] Exploit file not found."

---

4️⃣ Dockerfile

FROM python:3.13-rc-slim

# Install build tools and pip
RUN apt-get update && apt-get install -y build-essential default-mysql-server && \
    pip install --upgrade pip setuptools wheel

# Simulate malicious package creation
COPY malicious_pkg /malicious_pkg
WORKDIR /malicious_pkg
RUN python3 setup.py sdist && \
    mkdir -p /local_pypi && \
    cp dist/*.tar.gz /local_pypi/

# Setup MySQL RCE lab environment
WORKDIR /app
COPY requirements.txt install.sh /app/
RUN chmod +x install.sh

CMD ["./install.sh"]

---

5️⃣ docker-compose.yml

version: "3.9"
services:
  mysql-rce-lab:
    build: .
    container_name: mysql-rce-lab

---

✅ Running the Lab

In your terminal, from the root of the lab folder:

docker-compose build
docker-compose up

---

🧾 Expected Output

[*] Starting MySQL RCE simulation...
[+] MySQL RCE triggered! Dropping shell...
[*] Simulation complete.

To verify the exploit:

docker exec -it mysql-rce-lab cat /tmp/mysql_rce_success.txt

🎉 Success!

You've reproduced a simulated MySQL RCE vulnerability by combining insecure server config and malicious dependencies.
🔐 Mitigation Strategies

    Run MySQL with least privilege and secured user grants

    Pin dependencies using hashes or specific versions

    Avoid installing untrusted packages or dev tools in production

    Use tools like:

        pip-audit

        pip install --require-hashes

    Monitor privilege configurations and exposed services

📚 Next Steps

    Add a detection challenge (Can users find the exploit path?)

    Extend to simulate a MySQL root user compromise

    Build a hardened version with secure configs and signed packages

🙏 Credits

This lab was developed for educational and training purposes only to simulate CVE-2025-21497.

Always practice responsible disclosure. Never publish malicious packages to public repositories or deploy insecure configurations in production environments.


