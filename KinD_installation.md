# 🚀 kind (Kubernetes IN Docker) — Quick Setup Guide

## 📌 Goal

Set up a **local Kubernetes cluster quickly** using kind (best for DevOps practice).

---

# ⚡ FASTEST METHOD — PowerShell (Recommended)

## ✅ Step 1: Open PowerShell (Admin)

---

## ✅ Step 2: Install kind

```powershell
choco install kind -y
```

---

## ✅ Step 3: Verify Setup

```powershell
kind --version
kubectl version --client
docker version
```

---

## ⚠️ IMPORTANT: Start Docker Desktop

Before creating cluster:

* Open **Docker Desktop**
* Wait until:

```
Docker is running
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

# 🚨 COMMON MISTAKES (VERY IMPORTANT)

## ❌ 1. Running Markdown in PowerShell

### Example Mistakes:

````
```powershell
# Heading
---
* bullet points
````

### Problem:

PowerShell tries to execute them → errors like:

```
not recognized as command
```

### ✅ Rule:

👉 Only run actual commands (kind, kubectl, docker)
👉 Do NOT paste documentation into terminal

---

## ❌ 2. Docker Not Running

### Error:

```
failed to connect to docker API
```

### Fix:

* Start Docker Desktop manually

---

## ❌ 3. kind Not Recognized

### Error:

```
kind : not recognized
```

### Fix:

```powershell
choco install kind -y --force
```

Then restart PowerShell

---

## ❌ 4. kubectl Authentication Error

### Error:

```
Authentication required (HTML response)
```

### Cause:

kubectl pointing to wrong cluster

### Fix:

After creating kind cluster:

```powershell
kubectl config use-context kind-kind
```

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

# ⚡ Advanced (Optional)

## Multi-node cluster

Create `cluster.yaml`:

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

* Use **PowerShell (best + stable)**
* Always start Docker first
* Never paste Markdown into terminal
* Use `kind` + `kubectl` commands only
* Perfect for DevOps practice

---
