using **Ubuntu inside WSL**, here’s the **exact minimal way to launch your Jenkins agent (no confusion)**.

# ✅ **What’s happening in your setup**

* Jenkins → running on Windows (`localhost:8080`)
* WSL Ubuntu → acts as **agent machine**

# 🚀 **Launch Agent (Clean Steps)**

## 🔹 **Step 1: Create folder in WSL**

```bash
mkdir -p ~/agent
cd ~/agent
```

---

## 🔹 **Step 2: Install Java (if not already)**

```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
```

---

## 🔹 **Step 3: Download agent.jar**

```bash
curl -O http://localhost:8080/jnlpJars/agent.jar
```

---

## 🔹 **Step 4: Run agent (MOST IMPORTANT)**

👉 Go to Jenkins:

* Node → `wsl-agent`
* Copy the command (it contains **secret**)

It will look like:

```bash
java -jar agent.jar \
-url http://localhost:8080/ \
-secret YOUR_SECRET \
-name "wsl-agent" \
-webSocket \
-workDir ~/agent
```

👉 Run it in WSL

---

# ✅ **Expected Output**

```text
INFO: Connected
```

👉 Jenkins UI → Node → **ONLINE ✅**

---

# ⚠️ **Common Mistakes (You already hit these)**

| Mistake                      | Fix                       |
| ---------------------------- | ------------------------- |
| Using `/home/jenkins`        | ❌ use `~/agent`           |
| Running curl + java together | ❌ separate commands       |
| Using sudo                   | ❌ don’t                   |
| Wrong secret                 | ❌ copy fresh from Jenkins |

---

# 🔥 **Quick Test**

After agent is online, run:

```groovy
pipeline {
    agent { label 'wsl' }

    stages {
        stage('Check') {
            steps {
                sh 'whoami'
            }
        }
    }
}
```

👉 Output should show your WSL user

---

# 🧠 **What you just built (important)**

You now have:

* Controller → Jenkins (Windows)
* Agent → Ubuntu (WSL)

👉 This is **real DevOps architecture**

---

# 🎯 **One-line takeaway**

👉 **Run `agent.jar` inside WSL using your home directory (`~/agent`) and your agent will connect instantly.**

---

