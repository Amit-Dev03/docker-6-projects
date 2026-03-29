# Jenkins RBAC Lockout Recovery Guide

## 🧠 Problem Summary

You encountered a **Jenkins lockout issue** while using **Role-Based Authorization Strategy (RBAC)**.

### Root Cause

* RBAC was enabled
* ❌ No role was assigned to your admin user
* Result:

  * No permissions (not even `Overall/Read`)
  * Access Denied errors
  * Logging ID errors

> ⚠️ In RBAC: **No role assigned = No access**

---

## 💥 What Went Wrong Internally

* Jenkins requires permissions to render UI
* Without roles → authorization fails
* Manual edits in `config.xml` introduced invalid configuration
* Jenkins failed to load → system errors appeared

---

## ✅ How Recovery Was Done

### Step 1: Disable Security => sudo nano /var/lib/jenkins/config.xml

Edit:

```xml
<useSecurity>false</useSecurity>
```

➡️ This disables authentication → Jenkins becomes accessible

---

### Step 2: Remove Broken RBAC Config

Delete this block completely:

```xml
<authorizationStrategy class="...">
   ...
</authorizationStrategy>
```

➡️ Prevents Jenkins from loading invalid authorization settings

---

### Step 3: Restart Jenkins

```bash
sudo systemctl restart jenkins
```

➡️ Jenkins starts in clean (unsecured) state

---

### Step 4: Re-enable Security via UI

Go to:

```
Manage Jenkins → Security
```

* Enable Security
* Select **Jenkins’ own user database**
* Select **Role-Based Strategy**

---

### Step 5: Create and Assign Role (CRITICAL)

Go to:

```
Manage Jenkins → Manage and Assign Roles
```

#### Create Role:

* Name: `admin`
* Permission: ✔ Overall/Administer

#### Assign Role:

* Assign `admin` role to your user

---

## 🔐 Golden Rule

> In RBAC:
>
> * Create role ✅
> * Assign role ✅
> * Otherwise → LOCKOUT ❌

---

## 💾 Backup Strategy

### Backup config.xml

```bash
cp /var/lib/jenkins/config.xml /var/lib/jenkins/config_backup.xml
```

---

### Full Jenkins Backup

```bash
tar -czvf jenkins_backup.tar.gz /var/lib/jenkins
```

Includes:

* Jobs
* Plugins
* Users
* Configurations

---

### Smart Backup Naming

```bash
cp config.xml config_$(date +%F).xml
```

---

## ✂️ Editing config.xml Safely

### Open file:

```bash
sudo nano /var/lib/jenkins/config.xml
```

---

### Disable Security:

```xml
<useSecurity>false</useSecurity>
```

---

### Remove RBAC Block:

Delete everything from:

```xml
<authorizationStrategy ...>
```

to:

```xml
</authorizationStrategy>
```

---

### Apply Changes:

```bash
sudo systemctl restart jenkins
```

---

## ⚠️ What NOT to Do

* ❌ Enable RBAC without assigning roles
* ❌ Edit `<authorizationStrategy>` manually (unless necessary)
* ❌ Restart Jenkins with broken config
* ❌ Forget backups before changes

---

## 🚀 Safe Recovery Flow (Reusable)

1. Backup config
   (i) cp /var/lib/jenkins/config.xml /var/lib/jenkins/config_backup.xml
   (ii) full jenkins backup => tar -czvf jenkins_backup.tar.gz /var/lib/jenkins
3. Disable security
4. Remove RBAC block
5. Restart Jenkins
6. Fix via UI
7. Re-enable security
8. Assign admin role

---



**End of Guide**
