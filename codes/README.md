# 🚤 USV Cross-Platform Dashboard

A **Flutter application** for displaying and monitoring data from an **USV (Unmanned Surface Vehicle)** — including real-time operational metrics and water quality indicators.

---

## ⚙️ System Features

| **Feature** | **Description** | **Data Details** |
|--------------|----------------|------------------|
| **USV Status** | Displays the vehicle’s core operational indicators. | Battery (%), Speed (km/h), Heading direction. |
| **Water Quality** | Monitors important environmental parameters. | pH, DO (Dissolved Oxygen), COD (Chemical Oxygen Demand), TSS (Total Suspended Solids). |
| **History Chart** | Visualizes historical data over time. | Line Chart for tracking the trends of water quality indicators. |
| **Error Handling** | Integrated `try-catch` mechanism to show connection/data errors and a **Retry** button. | Prevents application crashes caused by asynchronous errors. |

---

## 🧩 3. Installation & Run Guide

### 🧰 3.1. Prerequisites

- **Flutter SDK:** Ensure that Flutter is installed and environment variables are properly set.  
  Check with the command:
  ```bash
  flutter doctor
  ```
-  SDK: (Included with Flutter)
- IDE: Visual Studio Code or Android Studio.

### 3.2. Environment Setup

Clone the repository:
```bash
git clone https://github.com/thanhtra3105/USV-Cross-platform.git
cd USV-Cross-platform
```

Install dependencies:
```bash
flutter pub get
```
### 3.3. Run the Application

This app is designed to run cross-platform (Mobile, Web, and Desktop).

Open IDE: Open the USV-Cross-platform folder in your IDE.

Select Device: Choose an emulator/simulator or a real device.

Run the app:
```bash
  flutter run
```

The dashboard interface will launch and display live data.

Note: The app simulates data fetching (including delay and random errors) to test the stability of FutureBuilder and asynchronous logic.

#4. Cấu trúc Dự án Chính
```plaintext
lib/
├── pages/
│   ├── dashboardPage.dart     # Main Dashboard page (displaying overall data)
│   ├── missionPage.dart       # Mission selection page for USV
│   ├── overviewPage.dart      # System overview page
│   └── streamPage.dart        # Video streaming page
├── widgets/
│   ├── batteryCard.dart       # Card displaying battery status
│   ├── dashboardCard.dart     # General dashboard information card
│   ├── historyChart.dart      # Historical Line Chart
│   └── speedCard.dart         # Card showing current speed
└── main.dart                  # Application entry point

```
# License
...

# ©️ Copyright

© 2025 thanhtra3105
All rights reserved.
Copyright belongs to thanhtra3105 & Mojinnn

## Authors: thanhtra3105 & Mojinnn
### Version: 1.0.0

