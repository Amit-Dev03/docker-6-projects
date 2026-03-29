# 📧 Jenkins Email Setup Guide (Freestyle + Pipeline)

---

# 📊 Which Approach is Most Used?

## ✅ Pipeline (Jenkinsfile) — Industry Standard

* ✔ Code-based CI/CD
* ✔ Version controlled (Git)
* ✔ Scalable and reusable
* ✔ Used in DevOps + SDET workflows

## ⚠️ Freestyle Project — Limited Usage

* ✔ UI-based (easy for beginners)
* ❌ Not scalable
* ❌ Hard to maintain in teams

> 🎯 **Conclusion:**
> Use **Pipeline** for real-world projects. Freestyle is mainly for learning/debugging.

---

# 📧 PART 1: Email Setup in Freestyle Project

## 🧠 Definition

Email configuration using UI via **Email Extension Plugin**

---

## ⚙️ Step 1: Install Plugin

👉 Manage Jenkins → Plugins → Available
✔ Install: **Email Extension Plugin**

---

## ⚙️ Step 2: Configure SMTP (Global)

👉 Manage Jenkins → System → **Extended E-mail Notification**

| Field          | Value                                               |
| -------------- | --------------------------------------------------- |
| SMTP Server    | smtp.gmail.com                                      |
| Port           | 587                                                 |
| Authentication | Enabled                                             |
| Username       | [your-email@gmail.com](mailto:your-email@gmail.com) |
| Password       | App Password                                        |
| TLS            | Enabled                                             |

✔ Click **Test Configuration** → must succeed

---

## ⚙️ Step 3: Configure Job

👉 Job → Configure → **Post-build Actions**

Add:

👉 **Editable Email Notification**

---

## ⚙️ Step 4: Configure Fields

### 📩 Project Recipient List

```
your-email@gmail.com
```

---

### 🔔 Triggers

Select:

* ✔ Failure
* ✔ Success
* ✔ Always (for testing)

---

## 🧪 Execution Flow

Build runs → Trigger matches → Email sent

---

## ⚠️ Common Mistakes

* ❌ Using “E-mail Notification” instead of “Editable Email Notification”
* ❌ SMTP not configured globally
* ❌ No trigger selected

---

# 📧 PART 2: Email Setup in Pipeline (Jenkinsfile)

## 🧠 Definition

Email configured using code via `post {}` block

---

## ⚙️ Basic Structure

```groovy
pipeline {
    agent any

    stages {
        // build stages
    }

    post {
        // email logic here
    }
}
```

---

## 📧 Basic Email Example

```groovy
post {
    always {
        emailext(
            to: 'your-email@gmail.com',
            subject: "Build #${BUILD_NUMBER} - ${currentBuild.currentResult}",
            body: "Check: ${env.BUILD_URL}"
        )
    }
}
```

---

## 🎯 Trigger Types

| Block   | Description            |
| ------- | ---------------------- |
| always  | Runs after every build |
| success | Runs only on success   |
| failure | Runs only on failure   |

---

## 🔥 Failure Email Example

```groovy
post {
    failure {
        emailext(
            to: 'your-email@gmail.com',
            subject: "FAILED: ${env.JOB_NAME}",
            body: "Check: ${env.BUILD_URL}"
        )
    }
}
```

---

## 🚀 Advanced: Attach Logs

```groovy
emailext(
    to: 'your-email@gmail.com',
    subject: "Build Result",
    body: "Check: ${env.BUILD_URL}",
    attachLog: true
)
```

---

## 🧪 Execution Flow

Pipeline runs → `post` executes → Email sent

---

## ⚠️ Common Mistakes

* ❌ Placing `post` inside `stages`
* ❌ Plugin not installed
* ❌ SMTP not configured
* ❌ Using `mail` instead of `emailext`

---

# 📊 Freestyle vs Pipeline (Quick Comparison)

| Feature         | Freestyle          | Pipeline   |
| --------------- | ------------------ | ---------- |
| Setup           | UI-based           | Code-based |
| Email Config    | Post-build Actions | `post {}`  |
| Scalability     | ❌ Low              | ✅ High     |
| Industry Use    | ❌ Low              | ✅ High     |
| Version Control | ❌ No               | ✅ Yes      |

---

# 🎯 Final Concept (Must Remember)

> Jenkins Email =
> **SMTP Configuration (Global) + Trigger (Job/Pipeline)**

---

## 🧠 Memory Trick

* Freestyle → UI → Post-build Actions
* Pipeline → Code → `post {}`

---

# 🚀 Next Steps (Recommended for SDET)

* ✔ Send test reports via email
* ✔ Attach Playwright reports
* ✔ Trigger emails only on failure
* ✔ Integrate Slack + Email notifications

---

**End of File**
