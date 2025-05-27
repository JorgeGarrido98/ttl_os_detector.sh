# 🕵️‍♂️ TTL OS Detector

This Bash script uses the TTL (Time-To-Live) value in a `ping` response to **estimate the operating system** (OS) of a remote host. It also checks for basic **network connectivity**.

---

## 📌 What does this script do?

1. Prompts the user to enter an IP address.
2. Sends a single `ping` to the target.
3. If the host is reachable, extracts the `TTL` value from the response.
4. Based on the TTL value, **infers the likely operating system**:
   - TTL ≈ 64 → **Linux**
   - TTL ≈ 128 → **Windows**
5. Displays color-coded results in the terminal.


## ⚙️ Requirements

- Linux with Bash
- `ping` command available (included in most distros)


## 🚀 How to Use

1. Make the script executable:
   ```bash
   chmod +x ttl_os_detector.sh
   ```
2. Run it:
   ```bash
   ./ttl_os_detector.sh
   ```
3. Enter an IP address when prompted:
   ```bash
   Enter the IP address: 192.168.1.10
   ```

## 👤 Author
- Jorge Garrido
- Version: 1.0
- Last updated: 2025-05-27
