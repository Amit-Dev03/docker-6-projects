# 🚀 kind (Kubernetes IN Docker) — Quick Setup Guide

## 📌 Goal

Set up a **local Kubernetes cluster quickly** using kind (recommended approach for DevOps practice).

---

# ⚡ FASTEST METHOD (Recommended) — PowerShell

## ✅ Step 1: Open PowerShell (Admin)

---

## ✅ Step 2: Install kind

### Option A: Using Chocolatey

```powershell
choco install kind
```

### If Chocolatey not installed:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Then:

```powershell
choco install kind
```

---

### Option B: Manual Install

```powershell
curl -Lo kind.exe https://kind.sigs.k8s.io/dl/latest/kind-windows-amd64
move kind.exe C:\Windows\System32\
```

---

## ✅ Step 3: Verify Setup

```powershell
kind --version
kubectl version --client
docker version
```

---

## ✅ Step 4: Create Cluster

```powershell
kind create cluster
```

---

## ✅ Step 5: Verify Cluster

```powershell
kubectl get nodes
```

Expected:

```
kind-control-plane   Ready    control-plane
```

---

## 🧹 Reset (if needed)

```powershell
kind delete cluster
kind create cluster
```

---

# ⚠️ MUST CHECK

* Docker Desktop is **running**
* kubectl is installed
* No WSL dependency needed

---

# 📦 Test Deployment

```powershell
kubectl create deployment nginx --image=nginx
kubectl get pods
```

---

# 🧠 DevOps Flow (Your Context)

1. Build Docker image
2. Load into kind
3. Deploy:

```powershell
kubectl apply -f deployment.yaml
```

---

# 🐧 OPTIONAL (WSL Setup — Only if needed)

## ❌ Common Error

```
kubelet not healthy
required cgroups disabled
```

## 📌 Cause

WSL lacks proper **cgroups/systemd support**

---

## ✅ Fix

### Enable systemd

```bash
sudo nano /etc/wsl.conf
```

Add:

```ini
[boot]
systemd=true
```

---

### Restart WSL

```powershell
wsl --shutdown
```

---

### Verify

```bash
ps -p 1 -o comm=
stat -fc %T /sys/fs/cgroup/
```

Expected:

```
systemd
cgroup2fs
```

---

## ⚡ Recommendation

👉 Prefer **PowerShell over WSL** for kind (more stable)

---

# ⚡ Advanced (Optional)

## Multi-node cluster

```yaml
kind: Cluster
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

Run:

```powershell
kind create cluster --config cluster.yaml
```

---

## Load local image

```powershell
kind load docker-image my-app:latest
```

---

# 📌 Summary (Quick Recall)

* Use **PowerShell → Best method**
* kind runs K8s inside Docker
* Avoid WSL issues unless configured deeply
* Perfect for DevOps practice

---
