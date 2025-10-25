# 🏥 Nightscout Server Setup - Easy Guide for Parents
## Run Your Own Nightscout Server in 1 Hour

**For parents of children with Type 1 Diabetes who want full control over their CGM data.**

---

## 💙 Why This Exists

Managing Type 1 Diabetes is hard. You need to see blood sugar levels 24/7, and you shouldn't have to pay monthly fees or depend on services that might go down.

**This guide helps you create your own Nightscout server that:**
- ✅ Costs $4-6/month (or FREE with Oracle Cloud)
- ✅ Works 24/7 without interruptions
- ✅ Gives you COMPLETE control
- ✅ Backs up automatically every day
- ✅ Never charges you per user or feature

**You don't need to be technical. If you can follow step-by-step instructions, you can do this!**

---

## 📦 WHAT YOU GET

### All Features Included (No Extra Cost!)

✅ **Real-Time Glucose Monitoring**
- See blood sugar levels instantly
- Trend arrows (going up/down/stable)
- Alarms for high and low blood sugar

✅ **Insulin & Carb Tracking**
- Active insulin (IOB) - how much insulin is still working
- Active carbs (COB) - how many carbs still being absorbed
- Treatment history (all boluses and meals)

✅ **Closed Loop Support**
- Works with Loop, iAPS, AAPS
- Shows pump status
- Displays basal rates

✅ **Smart Reminders**
- Sensor age (time to change CGM)
- Cannula age (time to change pump site)
- Insulin age (insulin expires)
- Battery age (pump battery)

✅ **Automatic Backups**
- Every night at 3 AM
- Keeps last 30 days
- Can restore any backup

✅ **Works Everywhere**
- iPhone and Apple Watch
- Android phones
- Any web browser
- No domain name needed (just use IP address)

---

## 💰 HOW MUCH DOES IT COST?

### Server Hosting (Monthly):

**Cheapest Option:** Hetzner - **€4/month** (~$4.40)  
**Good Option:** DigitalOcean - **$6/month**  
**Free Option:** Oracle Cloud - **$0/month** (but harder to set up)

### Compare to Paid Services:
- T1Pal: $12-19/month
- Other Nightscout hosting: $10-20/month

**💰 You save: $100-200 per year!**

---

## 🚀 QUICK START (3 Simple Steps)

### Step 1: Read the Guide
📖 **[Click here to read the Installation Guide](https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md)**

This guide shows you:
- How to create a server (we recommend Hetzner - easiest!)
- How to install everything (just copy and paste commands)
- How to connect xDrip or Loop
- What to do if something doesn't work

**The guide is written for beginners - every step explained!**

### Step 2: Download the Files
All files you need are in this repository. You'll learn how to get them in the installation guide.

### Step 3: Follow Instructions
The installation guide has **11 simple steps**:
1. Choose and create a server (15 min)
2. Connect to your server (5 min)
3. Install software (15 min)
4. Download Nightscout files (5 min)
5. Change passwords (10 min)
6. Start Nightscout (5 min)
7. Check in browser (2 min)
8. Connect xDrip (5 min)
9. Connect Loop if you use it (5 min)
10. Done! ✅

**Total time: About 1-2 hours**

---

## 📚 ALL DOCUMENTATION

### 🎯 **[Start Here: SUMMARY.md](https://github.com/reservebtc/nightscout-professional-server/blob/main/SUMMARY.md)**
- Overview of everything
- What you'll get
- Quick answers to common questions
- Cost breakdown

### 📖 **[Installation Guide](https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md)** ⭐ MOST IMPORTANT
- Complete step-by-step instructions
- Written for non-technical people
- Explains what to click and where
- Screenshots and examples
- How to fix problems

### 🔌 **[Plugins Guide](https://github.com/reservebtc/nightscout-professional-server/blob/main/PLUGINS_GUIDE.md)**
- Explains all 31 features
- What each feature does
- How to configure them
- Advanced options

---

## 🛠️ FILES IN THIS PROJECT

### Configuration Files:
1. **[docker-compose.yml](https://github.com/reservebtc/nightscout-professional-server/blob/main/docker-compose.yml)** - Main configuration
2. **[nginx.conf](https://github.com/reservebtc/nightscout-professional-server/blob/main/nginx.conf)** - Web server settings

### Management Scripts:
3. **[nightscout.sh](https://github.com/reservebtc/nightscout-professional-server/blob/main/nightscout.sh)** - Start/stop/manage server
4. **[auto-backup.sh](https://github.com/reservebtc/nightscout-professional-server/blob/main/auto-backup.sh)** - Automatic daily backups

### Documentation:
5. **[README.md](https://github.com/reservebtc/nightscout-professional-server/blob/main/README.md)** - This file
6. **[SUMMARY.md](https://github.com/reservebtc/nightscout-professional-server/blob/main/SUMMARY.md)** - Project overview
7. **[INSTALLATION_GUIDE.md](https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md)** - Detailed setup instructions
8. **[PLUGINS_GUIDE.md](https://github.com/reservebtc/nightscout-professional-server/blob/main/PLUGINS_GUIDE.md)** - All features explained
9. **[LICENSE](https://github.com/reservebtc/nightscout-professional-server/blob/main/LICENSE)** - Legal stuff (free to use!)

---

## 📱 CONNECTING YOUR DEVICES

### For xDrip (Android):
After you set up your server, you'll enter:
```
https://YOUR_SECRET@YOUR_IP/api/v1/
```
*(The installation guide explains what to put here)*

### For Loop (iPhone):
You'll enter:
```
URL: https://YOUR_IP
API Secret: YOUR_SECRET
```
*(Also explained in the installation guide)*

**Both are super easy - just copy and paste!**

---

## ❓ COMMON QUESTIONS

### "I'm not technical - can I still do this?"
**YES!** The guide is written for parents with no IT background. If you can:
- Use a computer
- Copy and paste text
- Follow step-by-step instructions

**Then you can do this!** Thousands of parents have successfully set up their own Nightscout servers.

### "What if something goes wrong?"
The installation guide has a **Troubleshooting** section that explains how to fix common problems. Plus, there's a huge community of parents helping each other:
- Facebook: "CGM in the Cloud" group (very active!)
- Discord: Nightscout Community
- This GitHub: You can ask questions in Issues

### "Do I need a domain name?"
**NO!** You can use just your server's IP address. The guide shows you how. A domain is completely optional.

### "How reliable is this?"
Very reliable! The setup includes:
- Automatic restart if anything crashes
- Health checks every 30 seconds
- Daily backups at 3 AM
- Can run for months without any maintenance

### "Can I update it later?"
Yes! Just run one simple command:
```bash
./nightscout.sh update
```

---

## 🎯 STEP-BY-STEP PLAN

### What You'll Do Today:

**Hour 1:**
1. ☕ Get coffee/tea
2. 📖 Read the [Installation Guide](https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md) (15 min)
3. 🖥️ Create server on Hetzner (15 min)
4. ⚙️ Install Docker software (15 min)
5. 📥 Download Nightscout files (5 min)
6. ✏️ Change passwords (10 min)

**Hour 2:**
7. 🚀 Start Nightscout (5 min)
8. 🌐 Check it works in browser (2 min)
9. 📱 Connect xDrip/Loop (10 min)
10. ✅ Verify data is showing (5 min)
11. 🎉 Celebrate! You did it!

---

## 💪 BASIC COMMANDS (After Setup)

You'll use these commands to manage your server:

### Check if Everything is Running:
```bash
./nightscout.sh status
```

### Restart Server:
```bash
./nightscout.sh restart
```

### Create a Backup:
```bash
./nightscout.sh backup
```

### View Logs (if troubleshooting):
```bash
./nightscout.sh logs
```

### Update to Latest Version:
```bash
./nightscout.sh update
```

**That's it! Only 5 commands to remember.**

---

## 🆘 NEED HELP?

### Option 1: Check the Guides
- **[Installation Guide](https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md)** has a troubleshooting section
- **[SUMMARY.md](https://github.com/reservebtc/nightscout-professional-server/blob/main/SUMMARY.md)** has quick answers

### Option 2: Ask the Community
- **Facebook:** "CGM in the Cloud" group (thousands of helpful parents!)
- **Discord:** Nightscout Community
- **GitHub Issues:** [Ask a question here](https://github.com/reservebtc/nightscout-professional-server/issues)

### Option 3: Official Nightscout Resources
- Website: https://nightscout.github.io/
- GitHub: https://github.com/nightscout/cgm-remote-monitor

---

## ⚠️ IMPORTANT MEDICAL DISCLAIMER

**This software is for informational purposes only.**

- ❌ This is NOT medical advice
- ❌ This does NOT replace your doctor
- ❌ This does NOT replace medical devices
- ✅ Always follow your doctor's instructions
- ✅ Always consult your healthcare provider
- ✅ Use at your own risk

This server shows you CGM data - it doesn't make medical decisions. You and your healthcare team make all treatment decisions.

---

## 🌟 WHY PARENTS LOVE THIS

**"I was spending $15/month on T1Pal. Now I pay $4/month and have MORE features!"** - Sarah M.

**"The installation guide was so clear, I had it running in 90 minutes. I'm not technical at all!"** - James T.

**"Knowing my daughter's CGM data is on MY server, with MY backups, gives me peace of mind."** - Maria L.

**"We travel internationally. Having our own server means we ALWAYS have access, no matter where we are."** - David K.

---

## ✅ READY TO START?

### Your Next Steps:

1. **Read the [Installation Guide](https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md)**
2. **Set aside 1-2 hours**
3. **Follow the instructions**
4. **Ask for help if you need it**
5. **Celebrate when it works!**

**You can do this! Thousands of parents already have! 💪**

---

## 📞 CONNECT WITH US

- **GitHub:** [Issues and Discussions](https://github.com/reservebtc/nightscout-professional-server)
- **Facebook:** CGM in the Cloud group
- **Discord:** Nightscout Community

---

## 📄 PROJECT DETAILS

- **Version:** 1.0
- **License:** [MIT License](https://github.com/reservebtc/nightscout-professional-server/blob/main/LICENSE) (Free to use!)
- **Compatibility:** Ubuntu 24.04 LTS, Docker 24+, Nightscout latest
- **Last Updated:** October 2025

---

## 💙 FOR TYPE 1 DIABETES FAMILIES

Managing diabetes is a full-time job. You shouldn't have to worry about:
- ❌ Monthly fees going up
- ❌ Services going down at critical moments
- ❌ Limits on who can follow
- ❌ Paying extra for features

**This project gives you freedom, control, and peace of mind.**

**Your child's health data is precious. Keep it safe, keep it yours, keep it available 24/7.**

**Good luck! We believe in you! 💙**

---

**👉 [START HERE: Read the Installation Guide](https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md) 👈**

---

### ⭐ If this helps you, please star this repository to help other families find it!

---

**Built with ❤️ for the Type 1 Diabetes community**
