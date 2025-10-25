# 🔌 COMPLETE NIGHTSCOUT PLUGINS REFERENCE
## All Features and Configuration

**📦 GitHub Repository:** https://github.com/reservebtc/nightscout-professional-server

═══════════════════════════════════════════════════════════════════
## 📊 CORE MONITORING PLUGINS

### 1. **CAREPORTAL** 🏥
**What it does:** Allows you to log treatment events (boluses, carbs, site changes)

**Enable:**
```yaml
ENABLE: "careportal"
```

**Usage:**
- Via web interface: "+" (plus) button
- You can log: boluses, carbs, sensor/site changes, measurements

**Integration with your app:**
Data from Loop automatically appears in Care Portal

---

### 2. **IOB (Insulin On Board)** 💉
**What it does:** Shows active insulin in your body

**Enable:**
```yaml
ENABLE: "iob"
```

**Profile settings:**
```yaml
DIA: "5"      # Duration of Insulin Action (3-6 hours)
ISF: "50"     # Insulin Sensitivity Factor (mg/dl per 1 unit)
```

**What it shows:**
- How much insulin is still active
- BG prediction graph considering IOB
- Used by other plugins (BWP, OpenAPS)

**In your app:**
- Displayed on iPhone main screen
- Syncs with Loop

---

### 3. **COB (Carbs On Board)** 🍞
**What it does:** Shows unabsorbed carbohydrates

**Enable:**
```yaml
ENABLE: "cob"
```

**Configuration:**
```yaml
CARBS_HR: "30"      # Absorption rate (g/hour)
IC: "10"            # Insulin to Carb ratio (g per 1 unit)
```

**What it shows:**
- How many carbs are still being absorbed
- Impact on BG
- Time to full absorption

---

### 4. **BWP (Bolus Wizard Preview)** 🎯
**What it does:** Bolus calculation assistant (NOT a replacement for medical advice!)

**Enable:**
```yaml
ENABLE: "bwp"
```

**Settings:**
```yaml
BWP_WARN: "0.50"       # Warning if bolus needed >0.5U
BWP_URGENT: "1.00"     # Critical alert >1U
BWP_SNOOZE_MINS: "10"  # Snooze for 10 min if enough IOB
BWP_SNOOZE: "0.10"     # IOB threshold for snooze
```

**IMPORTANT:** This is only a suggestion! You make the decisions!

---

### 5. **RAWBG (Raw Blood Glucose)** 📈
**What it does:** Shows raw CGM data (before calibration)

**Enable:**
```yaml
ENABLE: "rawbg"
SHOW_RAWBG: "always"   # Always show
```

**Why needed:**
- See sensor noise
- Evaluate calibration accuracy
- Debug CGM issues

---

### 6. **DELTA** 📊
**What it does:** Shows BG change over the last 5 minutes

**Enable:**
```yaml
ENABLE: "delta"
```

**What it shows:**
- ▲ +15 - rapid rise
- ▼ -8 - rapid fall
- Helps assess trends

---

### 7. **DIRECTION** ➡️
**What it does:** Arrow indicating BG change direction

**Enable:**
```yaml
ENABLE: "direction"
```

**Arrows:**
- ⇈ DoubleUp - very rapid rise
- ↑ SingleUp - rapid rise
- ↗ FortyFiveUp - slow rise
- → Flat - stable
- ↘ FortyFiveDown - slow fall
- ↓ SingleDown - rapid fall
- ⇊ DoubleDown - very rapid fall

═══════════════════════════════════════════════════════════════════
## 🔄 CLOSED LOOP PLUGINS

### 8. **LOOP** 🔁
**What it does:** Closed loop monitoring (Loop, iAPS)

**Enable:**
```yaml
ENABLE: "loop"
LOOP_ENABLE_ALERTS: "true"
LOOP_WARN: "30"       # Warning if loop inactive for 30 min
LOOP_URGENT: "60"     # Critical alert after 60 min
```

**What it shows:**
- Loop status (running/stopped)
- Reason for stopping
- Last cycle
- Loop recommendations

**Notifications:**
- 🟢 Loop running
- 🟡 Loop stopped >30 min
- 🔴 Loop stopped >60 min

---

### 9. **OPENAPS** 🤖
**What it does:** OpenAPS/AndroidAPS support

**Enable:**
```yaml
ENABLE: "openaps"
OPENAPS_ENABLE_ALERTS: "true"
OPENAPS_WARN: "30"
OPENAPS_URGENT: "60"
OPENAPS_FIELDS: "status-symbol status-label iob meal-assist rssi"
```

**Fields:**
- `status-symbol` - status icon
- `status-label` - text status
- `iob` - insulin on board
- `meal-assist` - meal assistance
- `rssi` - signal quality

---

### 10. **PUMP** ⚙️
**What it does:** Insulin pump monitoring

**Enable:**
```yaml
ENABLE: "pump"
PUMP_ENABLE_ALERTS: "true"
```

**Alarm thresholds:**
```yaml
PUMP_WARN_CLOCK: "30"      # Pump offline 30 min
PUMP_URGENT_CLOCK: "60"    # Critical: 60 min

PUMP_WARN_RES: "50"        # Warning: 50 units remaining
PUMP_URGENT_RES: "10"      # Critical: 10 units

PUMP_WARN_BATT_P: "30"     # Battery 30%
PUMP_URGENT_BATT_P: "20"   # Battery 20%
```

**What it shows:**
- Connection status
- Insulin remaining
- Battery charge
- Last contact

═══════════════════════════════════════════════════════════════════
## ⏰ REMINDER PLUGINS

### 11. **SAGE (Sensor Age)** 🎯
**What it does:** Tracks CGM sensor age

**Enable:**
```yaml
ENABLE: "sage"
SAGE_ENABLE_ALERTS: "true"
```

**Settings:**
```yaml
SAGE_INFO: "144"      # Info: 6 days (144 hours)
SAGE_WARN: "168"      # Warning: 7 days
SAGE_URGENT: "192"    # Urgent: 8 days (time to change!)
```

**How it works:**
- Counts from "Sensor Start" event in Care Portal
- Shows how many days/hours sensor has been active
- Notifies when it's time to change

---

### 12. **CAGE (Cannula Age)** 💉
**What it does:** Catheter/cannula age

**Enable:**
```yaml
ENABLE: "cage"
CAGE_ENABLE_ALERTS: "true"
```

**Settings:**
```yaml
CAGE_INFO: "48"       # Info: 2 days
CAGE_WARN: "72"       # Warning: 3 days
CAGE_URGENT: "96"     # Urgent: 4 days (time to change!)
```

**Care Portal event:**
- "Site Change" - catheter replacement

---

### 13. **IAGE (Insulin Age)** 🧪
**What it does:** Age of insulin in pump

**Enable:**
```yaml
ENABLE: "iage"
IAGE_ENABLE_ALERTS: "true"
```

**Settings:**
```yaml
IAGE_INFO: "168"      # Info: 7 days
IAGE_WARN: "336"      # Warning: 14 days
IAGE_URGENT: "504"    # Urgent: 21 days
```

**IMPORTANT:** Insulin degrades! Change on time!

---

### 14. **BAGE (Battery Age)** 🔋
**What it does:** Pump battery age

**Enable:**
```yaml
ENABLE: "bage"
BAGE_ENABLE_ALERTS: "true"
```

**Settings:**
```yaml
BAGE_INFO: "168"      # Info: 7 days
BAGE_WARN: "336"      # Warning: 14 days
BAGE_URGENT: "504"    # Urgent: 21 days
```

═══════════════════════════════════════════════════════════════════
## 🍔 ADDITIONAL PLUGINS

### 15. **FOOD** 🍽️
**What it does:** Food database

**Enable:**
```yaml
ENABLE: "food"
```

**Usage:**
1. Open in browser: `https://YOUR_URL/food`
2. Add foods with carb counts
3. Use in Care Portal when logging meals

**Example entry:**
- Name: "Medium Apple"
- Carbs: 15g
- Category: "Fruits"

---

### 16. **PROFILE** 👤
**What it does:** Therapy profile (treatment settings)

**Enable:**
```yaml
ENABLE: "profile"
```

**What it stores:**
- DIA (Duration of Insulin Action)
- IC (Insulin to Carb ratio)
- ISF (Insulin Sensitivity Factor)
- BG target values
- Basal profiles (if using)

**Editing:**
- Via web: Settings → Profile Editor
- Can create multiple profiles
- Time zone support

---

### 17. **BASAL** 💧
**What it does:** Displays basal insulin

**Enable:**
```yaml
ENABLE: "basal"
```

**What it shows:**
- Basal rate graph
- Temporary basals (temp basal)
- Changes from Loop/OpenAPS

---

### 18. **BOLUSCALC** 🧮
**What it does:** Bolus calculator

**Enable:**
```yaml
ENABLE: "boluscalc"
```

**Uses:**
- Current BG
- Target BG
- IOB
- COB
- IC, ISF from profile

**IMPORTANT:** Assistant only! Not automatic!

═══════════════════════════════════════════════════════════════════
## 🔔 NOTIFICATION PLUGINS

### 19. **PUSHOVER** 📱
**What it does:** Sends push notifications to phone

**Enable:**
```yaml
ENABLE: "pushover"
PUSHOVER_API_TOKEN: "your_token"
PUSHOVER_USER_KEY: "your_key"
```

**Getting tokens:**
1. Register at https://pushover.net/
2. Create application
3. Copy API Token and User Key

**What it sends:**
- Low/high BG alarms
- Pump notifications
- Replacement reminders

---

### 20. **TREATMENTNOTIFY** 💬
**What it does:** Notifications about logged treatments

**Enable:**
```yaml
ENABLE: "treatmentnotify"
TREATMENTNOTIFY_SNOOZE_MINS: "10"
```

**How it works:**
- When bolus logged via Care Portal → notification
- Automatically snoozes alarms for 10 min (there's IOB)

---

### 21. **MAKER (IFTTT)** 🔗
**What it does:** IFTTT integration (automation)

**Enable:**
```yaml
ENABLE: "maker"
MAKER_KEY: "your_key"
```

**Automation examples:**
- BG < 70 → turn on red light
- BG > 180 → send SMS
- Low insulin → Telegram notification

**Getting key:**
https://ifttt.com/maker_webhooks

═══════════════════════════════════════════════════════════════════
## 🌉 CONNECTION PLUGINS

### 22. **BRIDGE (Dexcom Share)** 🌉
**What it does:** Gets data from Dexcom Share

**Enable:**
```yaml
ENABLE: "bridge"
BRIDGE_USER_NAME: "your_dexcom_username"
BRIDGE_PASSWORD: "your_password"
BRIDGE_SERVER: "EU"    # or "US"
BRIDGE_MAX_COUNT: "1"
BRIDGE_MINUTES: "1440"
```

**When to use:**
- You have Dexcom G6/G7
- Want to get data directly from Dexcom cloud
- Alternative to xDrip

⚠️ **Note:** If you already have xDrip, bridge may not be needed

---

### 23. **MMCONNECT (Medtronic)** ⚙️
**What it does:** Connects to Medtronic pumps via CareLink

**Enable:**
```yaml
ENABLE: "mmconnect"
MMCONNECT_USER_NAME: "carelink_username"
MMCONNECT_PASSWORD: "password"
MMCONNECT_INTERVAL: "60000"    # 1 minute
MMCONNECT_SGV_LIMIT: "24"
```

**For pumps:**
- Medtronic 530G, 630G, 640G, 670G
- Requires CareLink account

═══════════════════════════════════════════════════════════════════
## 🛠️ UTILITY PLUGINS

### 24. **DBSIZE** 💾
**What it does:** Shows database size

**Enable:**
```yaml
ENABLE: "dbsize"
```

**Why:**
- Monitor MongoDB filling
- Warning when reaching limit
- Especially important for free accounts

---

### 25. **CORS** 🌐
**What it does:** Allows requests from other domains

**Enable:**
```yaml
ENABLE: "cors"
CORS_ALLOW_ORIGIN: "*"    # All domains
```

**Why:**
- For mobile app functionality
- For widgets
- For third-party integrations

---

### 26. **UPBAT (Uploader Battery)** 🔋
**What it does:** Shows uploader phone battery

**Enable:**
```yaml
ENABLE: "upbat"
```

**What it shows:**
- xDrip phone battery charge
- Warning on low battery

---

### 27. **TIMEAGO** ⏰
**What it does:** Shows how many minutes since last update

**Enable:**
```yaml
ENABLE: "timeago"
```

**Alarms:**
```yaml
ALARM_TIMEAGO_URGENT: "on"
ALARM_TIMEAGO_WARN: "on"
ALARM_TIMEAGO_URGENT_MINS: "15"    # Critical: 15 min
ALARM_TIMEAGO_WARN_MINS: "10"      # Warning: 10 min
```

═══════════════════════════════════════════════════════════════════
## 🎤 ADDITIONAL FEATURES

### 28. **SPEECH** 🔊
**What it does:** Voice announcements of values

**Enable:**
```yaml
ENABLE: "speech"
LANGUAGE: "en"
```

**What it announces:**
- Current BG
- Direction
- IOB
- Alarms

⚠️ **Works in browser only!**

---

### 29. **ALEXA** 🗣️
**What it does:** Amazon Alexa integration

**Enable:**
```yaml
ENABLE: "alexa"
```

**Commands:**
- "Alexa, ask Nightscout what is my blood sugar"
- "Alexa, ask Nightscout what is my blood glucose"

⚠️ **Requires Nightscout skill in Alexa**

---

### 30. **AR2 (AR2 Forecasting)** 🔮
**What it does:** BG forecasting

**Enable:**
```yaml
ENABLE: "ar2"
```

**What it does:**
- Predicts BG 30-60 minutes ahead
- Uses statistical methods
- Shows prediction line on graph

---

### 31. **SIMPLEALARMS** 🔔
**What it does:** Simple alarms (basic thresholds)

**Enable:**
```yaml
ENABLE: "simplealarms"
```

**Settings:**
```yaml
BG_LOW: "70"
BG_HIGH: "180"
ALARM_URGENT_LOW: "on"
ALARM_LOW: "on"
ALARM_HIGH: "on"
ALARM_URGENT_HIGH: "on"
```

═══════════════════════════════════════════════════════════════════
## 🎯 RECOMMENDED CONFIGURATIONS

### Minimal set (required):
```yaml
ENABLE: "careportal rawbg iob cob delta direction timeago"
```

### For Loop/OpenAPS:
```yaml
ENABLE: "careportal rawbg iob cob loop pump profile basal delta direction"
```

### MAXIMUM (everything enabled):
```yaml
ENABLE: "careportal basal dbsize rawbg iob maker bridge cob bwp cage iage sage boluscalc pushover treatmentnotify mmconnect loop pump profile food openaps bage alexa override cors delta direction timeago devicestatus upbat errorcodes ar2 simplealarms speech"
```

**💡 Tip:** Start with MAXIMUM set, then disable what you don't need.

═══════════════════════════════════════════════════════════════════
## 🔧 PLUGIN CONFIGURATION IN YOUR APP

### Integration examples:

1. **IOB/COB** - already displayed in your data manager
2. **Pump Status** - via device status endpoint
3. **Treatments** - via treatments endpoint
4. **Profile** - configured in Nightscout, used for calculations

### API endpoints for your app:

```swift
// Latest glucose entries
GET /api/v1/entries.json?count=24

// Treatments (boluses, carbs)
GET /api/v1/treatments.json

// Device status (pump)
GET /api/v1/devicestatus.json

// Profile (settings)
GET /api/v1/profile.json

// Status (connection check)
GET /api/v1/status.json
```

═══════════════════════════════════════════════════════════════════
## 📚 ADDITIONAL RESOURCES

**Official documentation:**
https://nightscout.github.io/

**GitHub:**
https://github.com/nightscout/cgm-remote-monitor

**Community:**
- Facebook: CGM in the Cloud
- Discord: Nightscout Discord

**This Repository:**
- **Main Page:** https://github.com/reservebtc/nightscout-professional-server
- **Installation Guide:** https://github.com/reservebtc/nightscout-professional-server/blob/main/INSTALLATION_GUIDE.md
- **Summary:** https://github.com/reservebtc/nightscout-professional-server/blob/main/SUMMARY.md

**Your config is already set to MAXIMUM!** 🎉
All plugins enabled in docker-compose.yml
