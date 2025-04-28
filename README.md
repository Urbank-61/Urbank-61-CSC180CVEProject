# Urbank-61-CSC180CVEProject
# 🚨 CVE-2025-21497: MySQL RCE via Privilege Misconfiguration

This lab simulates **Remote Code Execution (RCE)** in MySQL caused by insecure privilege configurations. It's a hands-on, Docker-based demo that helps security learners understand the risks of misconfigurations in production environments.

---

## 📂 Folder Structure

cve-2025-21497-lab/ ├── docker-compose.yml ├── Dockerfile ├── install.sh ├── requirements.txt └── malicious_pkg/ └── setup.py


---

## 🧪 Vulnerability Summary

- **CVE**: 2025-21497  
- **Type**: Remote Code Execution (RCE)  
- **Affected Software**: MySQL < 8.0.40  
- **Exploit Vector**: Remote connection with misconfigured privileges  
- **Impact**: Full code execution, data corruption, unauthorized access  
- **Fixed In**: MySQL 8.0.40 and later  

---

## 🎯 Learning Objectives

- Understand how misconfigured privileges in MySQL can lead to RCE.
- Simulate an attack using a malicious Python package.
- Learn how to mitigate such vulnerabilities in real-world setups.

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

2️⃣ requirements.txt

mysql-backdoor-pkg

3️⃣ install.sh

#!/bin/bash
echo "[*] Starting MySQL RCE simulation..."

pip install --no-cache-dir --find-links=file:///local_pypi -r requirements.txt

echo "[*] Simulation complete."
ls /tmp/mysql_rce_success.txt && cat /tmp/mysql_rce_success.txt || echo "[!] Exploit file not found."

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

5️⃣ docker-compose.yml

version: "3.9"
services:
  mysql-rce-lab:
    build: .
    container_name: mysql-rce-lab

✅ Running the Lab

In your terminal, from the root of the lab folder:

docker-compose build
docker-compose up

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


