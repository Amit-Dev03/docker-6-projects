# 🚀 kind (Kubernetes IN Docker) Installation Guide

## 📌 Overview

**kind (Kubernetes IN Docker)** allows you to run a local Kubernetes cluster using Docker containers as nodes. It is ideal for learning, testing, and CI/CD pipelines.

---

## ⚙️ Prerequisites

Ensure the following tools are installed:

* Docker
* kubectl

### Verify Installation

```bash
docker --version
kubectl version --client
```

---

## 🐧 Install kind (Linux / WSL)

### Step 1: Download kind binary

```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
```

### Step 2: Make it executable

```bash
chmod +x ./kind
```

### Step 3: Move to system path

```bash
sudo mv ./kind /usr/local/bin/kind
```

### Step 4: Verify installation

```bash
kind --version
```

---

## 🪟 Install kind (Windows - PowerShell)

### Using Chocolatey

```powershell
choco install kind
```

### Verify

```powershell
kind --version
```

---

## 🏗️ Create Kubernetes Cluster

```bash
kind create cluster
```

---

## ✅ Verify Cluster

```bash
kubectl get nodes
```

Expected output:

```
NAME                 STATUS   ROLES           AGE
kind-control-plane   Ready    control-plane   ...
```

---

## 📦 Deploy Sample Application

```bash
kubectl create deployment nginx --image=nginx
kubectl get pods
```

---

## 🧹 Delete Cluster

```bash
kind delete cluster
```

---

## ⚡ Advanced: Multi-Node Cluster

### Create config file `cluster.yaml`

```yaml
kind: Cluster
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

### Create cluster using config

```bash
kind create cluster --config cluster.yaml
```

---

## 🔄 Load Local Docker Image into kind

```bash
kind load docker-image my-app:latest
```

---

## ⚠️ Common Issues

### 1. Docker not running

* Ensure Docker Desktop is started

### 2. kubectl not configured

```bash
kubectl cluster-info
```

### 3. kind not found

* Ensure `/usr/local/bin` is in PATH

### 4. WSL Users

* Enable Docker Desktop WSL integration

---

## 🧠 Key Concept

> kind runs Kubernetes nodes as Docker containers, making it lightweight and fast for local environments.

---

## 🎯 DevOps Use Case

1. Build Docker image
2. Load into kind
3. Deploy using:

```bash
kubectl apply -f deployment.yaml
```

---

## 📌 Summary

* kind is used for local Kubernetes clusters
* Requires Docker
* Fast and lightweight
* Ideal for testing and CI/CD

---
