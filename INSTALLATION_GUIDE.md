# 🏥 NIGHTSCOUT SERVER SETUP GUIDE
## Step-by-Step Instructions for Parents and Beginners

**⚠️ IMPORTANT: This guide is written for people with NO technical background.**  
**If you can use a computer and follow instructions, you can do this! 💪**

**📦 GitHub Repository:** https://github.com/reservebtc/nightscout-professional-server

═══════════════════════════════════════════════════════════════════
## 🎯 WHAT YOU'LL GET

✅ Your own Nightscout server - complete control over your data  
✅ ALL plugins enabled (IOB, COB, Loop, OpenAPS, Pump, etc.)  
✅ Automatic daily backups  
✅ HTTPS with SSL certificates  
✅ Works 24/7 without interruptions  
✅ Connect xDrip and Loop using just IP address (no domain needed!)  

**Cost: $4-6/month** (or FREE with Oracle Cloud!)

═══════════════════════════════════════════════════════════════════
## 📖 TABLE OF CONTENTS

1. [**CHOOSE SERVER**](#step-1) - Pick where to host (5 minutes)
2. [**CREATE SERVER**](#step-2) - Sign up and create (10 minutes)
3. [**CONNECT TO SERVER**](#step-3) - Use terminal/SSH (5 minutes)
4. [**INSTALL SOFTWARE**](#step-4) - Copy/paste commands (15 minutes)
5. [**DOWNLOAD FILES**](#step-5) - Get Nightscout files (5 minutes)
6. [**CONFIGURE**](#step-6) - Change passwords (10 minutes)
7. [**START NIGHTSCOUT**](#step-7) - Launch everything (5 minutes)
8. [**CONNECT xDRIP**](#step-8) - Link your CGM (5 minutes)
9. [**CONNECT LOOP**](#step-9) - Link your pump (5 minutes)
10. [**DONE!**](#step-10) - You're all set! ✅

**Total time: ~60 minutes**

═══════════════════════════════════════════════════════════════════
## 💻 STEP 1: CHOOSE YOUR SERVER PROVIDER {#step-1}

You need a "server" - a computer that runs 24/7 in the cloud. Don't worry, you don't need to buy actual hardware!

### 🌟 **RECOMMENDED FOR BEGINNERS: Hetzner**

**Why Hetzner?**
- ✅ Cheapest: €4/month (~$4.40)
- ✅ EASIEST to set up
- ✅ Very fast servers
- ✅ Located in Germany (good for Europe)
- ✅ No credit card required initially

**Alternative options:**
- **DigitalOcean** - $6/month (good for beginners, US-based)
- **Oracle Cloud** - FREE forever (but harder to set up)
- **Linode** - $5/month (also good)

**👉 We'll use Hetzner in this guide because it's the simplest!**

═══════════════════════════════════════════════════════════════════
## 🚀 STEP 2: CREATE YOUR HETZNER SERVER {#step-2}

### 2.1. Sign Up

1. Go to: **https://www.hetzner.com/cloud**
2. Click **"Sign Up"** (top right)
3. Enter your email and create password
4. Check your email and confirm

### 2.2. Add Payment Method

1. Log in to Hetzner Cloud Console
2. Click your name (top right) → **Billing**
3. Add credit card or PayPal
   - Don't worry - they only charge you at the end of the month!
   - First month is often discounted or has free credit

### 2.3. Create a New Project

1. Click **"New Project"**
2. Name it: **"Nightscout"**
3. Click **Create**

### 2.4. Create a Server (Droplet)

Now the important part - follow EXACTLY:

1. Click **"Add Server"**

2. **Location:** Choose closest to you
   - Europe: **Falkenstein** or **Helsinki**
   - US: **Ashburn**
   - Asia: **Singapore**

3. **Image:** 
   - Click **"Linux"**
   - Select **"Ubuntu"**
   - Choose **"24.04"** (the newest version)

4. **Type:**
   - Select **"Shared vCPU"**
   - Choose **"CX11"** (1 vCPU, 2GB RAM) - €4.15/month
   - This is perfect for Nightscout!

5. **SSH Keys:**
   - Skip this for now (we'll use password)
   - We'll make it secure later

6. **Volumes, Firewalls, Backups:**
   - Leave everything unchecked
   - We don't need these yet

7. **Name:**
   - Name your server: **"nightscout-server"**

8. **Click "Create & Buy Now"**

### 2.5. Wait for Server Creation

- It takes 1-2 minutes
- You'll see a loading spinner
- When done, you'll see your server with a **green dot** ✅

### 2.6. GET YOUR SERVER DETAILS

**VERY IMPORTANT - SAVE THESE!**

You'll see:
- **IP Address:** Something like `123.45.67.89` - COPY THIS!
- **Root Password:** Click the eye icon 👁️ to reveal - COPY THIS!

**📝 Write these down or save in a password manager!**

═══════════════════════════════════════════════════════════════════
## 🔌 STEP 3: CONNECT TO YOUR SERVER {#step-3}

Now we need to connect to your server. It's like remote controlling a computer.

### For Windows Users:

#### 3.1. Download PuTTY
1. Go to: https://www.putty.org/
2. Download **putty.exe** (64-bit)
3. Run it (no installation needed)

#### 3.2. Connect
1. In **"Host Name"** field, paste your IP address: `123.45.67.89`
2. **Port:** Leave as `22`
3. Click **"Open"**
4. Security warning appears → Click **"Yes"**
5. Login as: Type `root` and press Enter
6. Password: Paste the root password (right-click to paste)
   - **You won't see the password as you paste - this is normal!**
7. Press Enter

**✅ You're in!** You should see a welcome message.

### For Mac/Linux Users:

#### 3.1. Open Terminal
- **Mac:** Press `Cmd + Space`, type "Terminal", press Enter
- **Linux:** Press `Ctrl + Alt + T`

#### 3.2. Connect
Type this command (replace with YOUR IP):
```bash
ssh root@123.45.67.89
```

Press Enter, then:
1. Type `yes` and press Enter (if asked about fingerprint)
2. Paste your password (won't see it - normal!)
3. Press Enter

**✅ You're in!**

═══════════════════════════════════════════════════════════════════
## ⚙️ STEP 4: INSTALL REQUIRED SOFTWARE {#step-4}

Now we'll install Docker - the software that runs Nightscout.

**IMPORTANT: Just copy and paste each command, press Enter, and wait!**

### 4.1. Update System

Copy this entire block, paste it, press Enter:

```bash
apt update && apt upgrade -y
```

⏳ **Wait 2-3 minutes** - it will install updates.

### 4.2. Install Basic Tools

```bash
apt install -y curl wget git nano ufw
```

⏳ **Wait 1 minute**

### 4.3. Setup Firewall (Security!)

**This is VERY important for security!**

```bash
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable
```

When asked **"Command may disrupt existing ssh connections. Proceed with operation (y|n)?"**
- Type: `y`
- Press Enter

### 4.4. Install Docker

This is the main software. Copy and paste:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

⏳ **Wait 2-3 minutes** - lots of text will scroll by. That's normal!

### 4.5. Install Docker Compose

```bash
apt install docker-compose-plugin -y
```

⏳ **Wait 1 minute**

### 4.6. Verify Installation

Let's check if everything installed correctly:

```bash
docker --version
docker compose version
```

You should see version numbers. ✅ Good!

═══════════════════════════════════════════════════════════════════
## 📦 STEP 5: DOWNLOAD NIGHTSCOUT FILES {#step-5}

### 5.1. Create a Folder

```bash
mkdir nightscout
cd nightscout
```

### 5.2. Download Files from GitHub

```bash
wget https://raw.githubusercontent.com/reservebtc/nightscout-professional-server/main/docker-compose.yml

wget https://raw.githubusercontent.com/reservebtc/nightscout-professional-server/main/nginx.conf

wget https://raw.githubusercontent.com/reservebtc/nightscout-professional-server/main/nightscout.sh

wget https://raw.githubusercontent.com/reservebtc/nightscout-professional-server/main/auto-backup.sh
```

### 5.3. Make Scripts Executable

```bash
chmod +x nightscout.sh auto-backup.sh
```

### 5.4. Check Files

```bash
ls -l
```

You should see 4 files. ✅

═══════════════════════════════════════════════════════════════════
## 🔧 STEP 6: CONFIGURE YOUR PASSWORDS {#step-6}

**THIS IS THE MOST IMPORTANT STEP!**

You must change passwords from the default values.

### 6.1. Open Configuration File

```bash
nano docker-compose.yml
```

You'll see a text file. Use arrow keys to move around.

### 6.2. CHANGE THESE VALUES:

**Look for these lines and change them:**

#### A) MongoDB Password (appears 3 times!)

Find this line:
```yaml
MONGO_INITDB_ROOT_PASSWORD: YOUR_STRONG_PASSWORD_HERE
```

Change `YOUR_STRONG_PASSWORD_HERE` to a strong password.
**Example:** `MySecret2025MongoDB!Pass`

**⚠️ IMPORTANT:** You need to change this in **3 places**:
1. Line ~22: `MONGO_INITDB_ROOT_PASSWORD:`
2. Line ~60: Inside `MONGO_CONNECTION:`
3. Line ~314: `ME_CONFIG_MONGODB_ADMINPASSWORD:`

**Use THE SAME password in all 3 places!**

#### B) API Secret

Find this line:
```yaml
API_SECRET: "YOUR_API_SECRET_MIN_12_CHARS"
```

Change to a secret key (minimum 12 characters).
**Example:** `MyNightscout2025Secret`

**📝 WRITE THIS DOWN - you'll need it for xDrip/Loop!**

#### C) Your Server IP

Find this line:
```yaml
BASE_URL: "https://YOUR_IP_OR_DOMAIN"
```

Replace `YOUR_IP_OR_DOMAIN` with your actual IP address.
**Example:** `https://123.45.67.89`

#### D) Mongo Express Password

Find this line:
```yaml
ME_CONFIG_BASICAUTH_PASSWORD: YOUR_DIFFERENT_PASSWORD_HERE
```

Change to another password (different from MongoDB password).
**Example:** `WebUI2025Pass`

### 6.3. Customize Blood Glucose Targets (Optional)

Find these lines and change to YOUR target values:

```yaml
BG_TARGET_BOTTOM: "70"    # Your low target
BG_TARGET_TOP: "180"      # Your high target
BG_LOW: "70"              # Low alarm
BG_HIGH: "180"            # High alarm
```

### 6.4. Customize Therapy Profile (IMPORTANT for IOB/COB!)

Find these lines:
```yaml
DIA: "5"          # Duration of Insulin Action (hours)
ISF: "50"         # Insulin Sensitivity Factor
IC: "10"          # Insulin to Carb ratio
CARBS_HR: "30"    # Carb absorption (grams/hour)
```

**Change these to YOUR values from your doctor!**

### 6.5. Save and Exit

- Press: `Ctrl + O` (letter O, not zero)
- Press: `Enter`
- Press: `Ctrl + X`

✅ **File saved!**

═══════════════════════════════════════════════════════════════════
## 🚀 STEP 7: START NIGHTSCOUT! {#step-7}

Almost done! Now we start everything.

### 7.1. Initial Setup

```bash
./nightscout.sh setup
```

This creates:
- Data folders
- SSL certificate
- Checks your configuration

If you see an error about passwords, go back to Step 6!

### 7.2. Start Server

```bash
./nightscout.sh start
```

⏳ **Wait 1-2 minutes** while everything starts up.

You'll see lots of messages. That's normal!

### 7.3. Check Status

```bash
./nightscout.sh status
```

You should see:
```
✓ Nightscout: OK
✓ MongoDB: OK
```

**✅ IF YOU SEE THIS - NIGHTSCOUT IS RUNNING!**

### 7.4. Get Your IP Address

```bash
./nightscout.sh ip
```

You'll see your server IP. Write it down!

═══════════════════════════════════════════════════════════════════
## 🌐 STEP 8: OPEN NIGHTSCOUT IN BROWSER {#step-8}

### 8.1. Open Your Browser

Open any web browser (Chrome, Firefox, Safari, Edge)

### 8.2. Go to Your IP

Type in the address bar:
```
https://YOUR_IP
```

**Example:** `https://123.45.67.89`

### 8.3. Security Warning

**⚠️ Your browser will show a warning - THIS IS NORMAL!**

The warning says something like:
- "Your connection is not private"
- "NET::ERR_CERT_AUTHORITY_INVALID"

**This is OK because you're using a self-signed certificate.**

**What to do:**
- **Chrome/Edge:** Click "Advanced" → "Proceed to... (unsafe)"
- **Firefox:** Click "Advanced" → "Accept the Risk and Continue"
- **Safari:** Click "Show Details" → "visit this website"

### 8.4. What You Should See

**✅ Success looks like:**
- Black screen with clock in the center
- "No data yet" or "Nightscout" logo
- Time displayed

**❌ If you see an error:**
- Go back to Step 7 and check status
- Check that you used `https://` (not `http://`)

═══════════════════════════════════════════════════════════════════
## 📱 STEP 9: CONNECT xDRIP (Android) {#step-9}

Now let's connect your CGM data!

### 9.1. Open xDrip Settings

1. Open xDrip app
2. Tap **hamburger menu** (☰) top left
3. Tap **Settings**
4. Scroll down to **Cloud Upload**
5. Tap **Nightscout Sync (REST-API)**

### 9.2. Enable Upload

☑️ **Enable Nightscout Sync** - Turn this ON

### 9.3. Enter Your URL

**⚠️ VERY IMPORTANT - FORMAT MATTERS!**

In **Base URL** field, enter:
```
https://YOUR_API_SECRET@YOUR_IP/api/v1/
```

**Replace with YOUR details:**
- `YOUR_API_SECRET` - the API secret from Step 6
- `YOUR_IP` - your server IP address

**Full Example:**
```
https://MyNightscout2025Secret@123.45.67.89/api/v1/
```

**IMPORTANT NOTES:**
- ✅ Use `https://` (not `http://`)
- ✅ Put the API secret BEFORE the `@` symbol
- ✅ End with `/api/v1/` (don't forget the slashes!)

### 9.4. Test Connection

1. Scroll down in xDrip
2. Tap **Test** button
3. You should see: ✅ **"Success!"**

**If you get an error:**
- Check the URL format (copy it exactly!)
- Make sure your API secret matches exactly
- Verify your server is running: `./nightscout.sh status`

### 9.5. Start Uploading

xDrip will now automatically upload your CGM data to Nightscout!

**Wait 5 minutes, then refresh your Nightscout page** - you should see your glucose data! 🎉

═══════════════════════════════════════════════════════════════════
## 🔄 STEP 10: CONNECT LOOP (iOS) {#step-10}

If you use Loop, here's how to connect it:

### 10.1. Open Loop Settings

1. Open Loop app
2. Tap **Settings** (gear icon)
3. Tap **Services**
4. Tap **Nightscout**

### 10.2. Enter Your Details

- **Site URL:** `https://YOUR_IP`
  - Example: `https://123.45.67.89`
  - **NOTE:** Do NOT include `/api/v1/` for Loop!
  
- **API Secret:** Your API secret from Step 6
  - Example: `MyNightscout2025Secret`

### 10.3. Enable Upload

Toggle **Upload Enabled** to ON ✅

### 10.4. Save

Tap **Done** or **Save**

Loop will now upload pump data to Nightscout!

═══════════════════════════════════════════════════════════════════
## 🎉 STEP 11: YOU'RE DONE! {#step-11}

### Congratulations! 🎊

You now have:
✅ Your own professional Nightscout server  
✅ Running 24/7 with all features  
✅ Connected to your CGM  
✅ Automatic daily backups  
✅ Complete control over your data  

### What Happens Now?

- xDrip uploads glucose data every 5 minutes
- Nightscout displays it on the web
- You can access it from anywhere: `https://YOUR_IP`
- Data is backed up automatically every night at 3 AM

### Quick Reference

**Your Nightscout URL:**
```
https://YOUR_IP
```

**Your API Secret:**
```
(the one you chose in Step 6)
```

**For xDrip URL:**
```
https://YOUR_API_SECRET@YOUR_IP/api/v1/
```

═══════════════════════════════════════════════════════════════════
## 🔧 USEFUL COMMANDS

Save these for later - you might need them!

### Check if Everything is Running

```bash
./nightscout.sh status
```

### Restart Nightscout

If something isn't working:
```bash
./nightscout.sh restart
```

### View Logs

To see what's happening:
```bash
./nightscout.sh logs nightscout
```

### Create Manual Backup

```bash
./nightscout.sh backup
```

### Update to Latest Version

```bash
./nightscout.sh update
```

### Get Your IP Address

```bash
./nightscout.sh ip
```

═══════════════════════════════════════════════════════════════════
## ❓ TROUBLESHOOTING

### Problem: Can't Connect to Server

**Solution:**
1. Check your server is running on Hetzner website
2. Check you're using the correct IP address
3. Try restarting server: `./nightscout.sh restart`

### Problem: xDrip Won't Upload

**Check these:**
1. ✅ URL format: `https://SECRET@IP/api/v1/`
2. ✅ API Secret matches exactly
3. ✅ Internet connection on phone
4. ✅ Nightscout is running: `./nightscout.sh status`

### Problem: Browser Shows "Connection Not Private"

**This is NORMAL with self-signed certificate!**

Click "Advanced" → "Proceed anyway"

**Want to fix it?** Set up a domain with Let's Encrypt (advanced - see end of this guide)

### Problem: No Data Showing

**Wait 5-10 minutes** for first data to appear.

Check:
1. xDrip is uploading (green cloud icon)
2. Check Nightscout logs: `./nightscout.sh logs nightscout`
3. Test API: Open in browser: `https://YOUR_IP/api/v1/status`

### Problem: Forgot Password

If you forgot your API secret:
```bash
cd nightscout
nano docker-compose.yml
```

Look for the `API_SECRET` line

═══════════════════════════════════════════════════════════════════
## 🆘 NEED HELP?

### Get Server Logs

```bash
./nightscout.sh logs nightscout
```

Press `Ctrl + C` to stop viewing logs

### Check Everything

```bash
./nightscout.sh status
docker ps
```

### Test Connection

```bash
curl -k https://localhost/api/v1/status
```

### Join Community

- **Facebook:** "CGM in the Cloud" group
- **Discord:** Nightscout Discord server
- **GitHub:** nightscout/cgm-remote-monitor

═══════════════════════════════════════════════════════════════════
## 💰 MONTHLY COSTS

Your Nightscout will cost approximately:

- **Hetzner CX11:** €4.15/month (~$4.40)
- **DigitalOcean:** $6/month
- **Oracle Cloud:** FREE forever (but harder setup)

**Compared to paid Nightscout services: $12-20/month**

**You save: $90-180 per year!** 💰

═══════════════════════════════════════════════════════════════════
## 🔒 AUTOMATIC BACKUPS

Your database is automatically backed up every night at 3:00 AM!

### Setup Automatic Backups

```bash
cd ~/nightscout
crontab -e
```

If asked to choose editor, select `1` (nano)

Add this line at the bottom:
```
0 3 * * * /root/nightscout/auto-backup.sh
```

Save: `Ctrl + O`, Enter, `Ctrl + X`

### View Backups

```bash
ls -lh ~/nightscout/mongo-backup/
```

Backups are kept for 30 days.

═══════════════════════════════════════════════════════════════════
## 🌐 OPTIONAL: GET A DOMAIN NAME (Advanced)

Using IP address works great, but if you want a pretty URL like `sugar.yourdomain.com`:

### Option 1: Free Domain (DuckDNS)

1. Go to: https://www.duckdns.org/
2. Sign in with Google/GitHub
3. Create domain: `yourname.duckdns.org`
4. Follow DuckDNS instructions to keep IP updated

### Option 2: Buy Domain + Let's Encrypt

1. Buy domain from Namecheap, Google Domains, etc. (~$10/year)
2. Point domain to your server IP
3. Install Certbot for SSL certificate
4. Update `docker-compose.yml` with your domain

**This is advanced - only do it if you're comfortable!**

═══════════════════════════════════════════════════════════════════
## ✅ FINAL CHECKLIST

After setup, verify:

- [ ] Nightscout opens in browser: `https://YOUR_IP`
- [ ] xDrip connected (green cloud icon)
- [ ] Data appears in Nightscout (wait 5-10 min)
- [ ] Loop connected (if using)
- [ ] Automatic backups set up (cron)
- [ ] Server status OK: `./nightscout.sh status`

═══════════════════════════════════════════════════════════════════
## 📚 ADDITIONAL RESOURCES

**Official Nightscout:**
- Website: https://nightscout.github.io/
- GitHub: https://github.com/nightscout/cgm-remote-monitor

**Community:**
- Facebook: "CGM in the Cloud"
- Discord: Nightscout Community

**This GitHub Repository:**
- **Main Page:** https://github.com/reservebtc/nightscout-professional-server
- **README:** https://github.com/reservebtc/nightscout-professional-server/blob/main/README.md
- **SUMMARY:** https://github.com/reservebtc/nightscout-professional-server/blob/main/SUMMARY.md
- **Plugins Guide:** https://github.com/reservebtc/nightscout-professional-server/blob/main/PLUGINS_GUIDE.md
- **Ask Questions:** https://github.com/reservebtc/nightscout-professional-server/issues

═══════════════════════════════════════════════════════════════════

## 💙 FOR PARENTS

**You did it!** 

Managing Type 1 Diabetes is hard enough. Having control over your own data and not depending on paid services is empowering.

Your child's health data is now in YOUR hands, running on YOUR server, backing up automatically, available 24/7.

**You are amazing! 💪**

═══════════════════════════════════════════════════════════════════

**Remember:**
- Your Nightscout URL: `https://YOUR_IP`
- Your API Secret: (the one you created)
- Server runs 24/7 automatically
- Backups happen every night
- Cost: ~$4-6/month

**Stay healthy! 💙**
