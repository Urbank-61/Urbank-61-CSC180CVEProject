# Urbank-61-CSC180CVEProject
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
