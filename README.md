<div align="center">
  <image src="/assets/miner.png" alt="Aminer" height="200px"></image>
  <h3><a href="https://github.com/cornjosh/Aminer">Aminer</a></h3>
  <em>Mining with Android devices</em>
</div>

<p align="center">
<img src="https://img.shields.io/github/stars/cornjosh/Aminer?style=flat-square" alt="GitHub Stars"/>
<img src="https://img.shields.io/github/forks/cornjosh/Aminer?style=flat-square" alt="GitHub Forks"/>
<img src="https://img.shields.io/github/issues/cornjosh/Aminer?style=flat-square" alt="GitHub Issues"/>
<img src="https://img.shields.io/github/last-commit/cornjosh/Aminer?style=flat-square" alt="GitHub last commit"/>
<img src="https://img.shields.io/github/license/cornjosh/Aminer?style=flat-square" alt="GitHub License"/>
<img src="https://img.shields.io/github/size/cornjosh/Aminer/aminer.sh?style=flat-square" alt="Script Size"/>
</p>

<h5 align="center">Aminer is an open source script that makes it easy to deploy XMRig on Android devices to mine cryptocurrencies, primarily Monero (XMR). Perfect for utilizing spare Android devices for lightweight cryptocurrency mining.</h5>

> ⚠️ **Security Notice**: Cryptocurrency mining may drain your device's battery and generate heat. Use at your own risk and ensure proper ventilation. Only use trusted mining pools and be aware of electricity costs.

---

[简体中文版](/README_CN.md)

---

## Screenshots ✨

<div align="center">
    <image src="/assets/screen.gif" alt="screen" height="500px"></image>
</div>

## Earnings 💰

**⚠️ Important Disclaimer: These figures are for reference only and represent the situation at the time of publication. Actual earnings may vary significantly based on:**

- Current network difficulty
- Market prices
- Pool fees
- Device performance
- Electricity costs

**Historical Reference Data:**
- Snapdragon 865 in c3-pool: ~1.5KH/s hash rate, estimated ￥0.8 per 24h
- Snapdragon 625 in c3-pool: ~1KH/s hash rate, estimated ￥0.5 per 24h

> 💡 **Performance Note**: Mining performance varies greatly between devices. Consider your electricity costs and device wear before mining.

## Compatibility 📱

**System Requirements:**
- Android 4.4+ (API level 19+)
- 64-bit architecture (arm64, x86-64)
- At least 2GB RAM recommended
- Stable internet connection
- Termux app installed

**Termux Version Compatibility:**
- **Android 7+**: Use latest Termux from F-Droid or GitHub
- **Android 6 and below**: Use Termux v0.73

✅ **Tested Devices:**
| Device | Android Version | Termux Version | Status |
|--------|----------------|----------------|---------|
| Redmi Note 2 | 5.0 | 0.73 | ✅ Working |
| Redmi 5 Plus | 7.0 | 0.108 | ✅ Working |
| Redmi K30 Pro | 11 | 0.108 | ✅ Working |

> 📝 **Note**: Feel free to open an issue to report compatibility with your device!

## Quick Start 🚀

### Prerequisites

1. **Install Termux:**
   - **Android 7+**: Download from [F-Droid](https://f-droid.org/en/packages/com.termux/) or [GitHub Releases](https://github.com/termux/termux-app/releases)
   - **Android 6 and below**: Install Termux v0.73 (legacy version)

2. **Prepare Termux Environment:**
   ```bash
   # For older Android versions, update package lists first
   pkg update -y && pkg install curl -y
   ```

### Installation

Run the following command in your Termux terminal:

```bash
bash <(curl -fsSL git.io/aminer) -u your_wallet_address
```

**Example:**
```bash
bash <(curl -fsSL git.io/aminer) -u 45xh7ksV8w4...your_monero_address
```

### What Happens During Installation

1. ⬇️ Downloads and installs Ubuntu container
2. 🔧 Installs build dependencies (git, cmake, gcc, etc.)
3. 📦 Compiles XMRig from source
4. ⚙️ Configures mining parameters
5. 🎯 Sets up daemon for automatic restart

**Installation Time**: ~20 minutes (depends on your internet speed)

**Success Indicator**: You'll see the blue message:
```
##### Please restart Termux to run XMRIG #####
```

### Start Mining

1. **Close and reopen Termux** - Mining will start automatically
2. **Monitor Progress** - Check your pool dashboard for statistics
3. **View Logs** - Mining output will be displayed in the terminal

> ⚠️ **Important**: Make sure your device has good ventilation and consider the impact on battery life.

## Usage ⌨️

### Basic Usage

```bash
bash <(curl -fsSL git.io/aminer) [options...] <arguments>
```

### Command Line Options

| Option | Description | Example |
|--------|-------------|---------|
| `-y` | Auto mode (skip risk warnings) | `-y` |
| `-u` | Mining pool username/wallet | `-u 45xh7ks...` |
| `-p` | Mining pool password | `-p worker_name` |
| `-o` | Mining pool URL and port | `-o mine.pool.com:1234` |
| `-d` | Donation level to XMRig developers | `-d 1` |
| `-g` | Setup SSH with GitHub username | `-g your_github_user` |

### Examples

**Basic mining with custom wallet:**
```bash
bash <(curl -fsSL git.io/aminer) -u your_monero_wallet_address
```

**Custom pool and settings:**
```bash
bash <(curl -fsSL git.io/aminer) -u wallet -p worker1 -o pool.example.com:4444 -d 0
```

**Auto-install with SSH setup:**
```bash
bash <(curl -fsSL git.io/aminer) -y -u wallet -g github_username
```

### Post-Installation Commands

**Check mining status:**
```bash
./ubuntu.sh
ps aux | grep xmrig
```

**Stop mining:**
```bash
./ubuntu.sh
pkill xmrig
```

**Restart mining:**
```bash
./ubuntu.sh
./service.sh
```

## Features 👍

### ⚡ Mining Management
- [x] **Daemon Process** - Automatic restart on unexpected exit
- [x] **Auto-start** - Mining begins when Termux app opens
- [ ] **Boot Auto-start** - Start mining on device boot *(work in progress)*

### 🎯 Pool Configuration
- [x] **Custom Mining Pools** - Not limited to c3-pool anymore
- [x] **Auto Device Detection** - Automatically gets device name for pool identification
- [x] **Flexible Pool Settings** - Support for any Monero-compatible pool

### 🏗️ System Features
- [x] **Ubuntu Container** - Uses domestic mirrors (USTC source for faster downloads)
- [x] **SSH Server Setup** - One-click SSH configuration using P3TERX's script
- [ ] **Termux Mirror** - Domestic software sources *(Tsinghua mirror compatibility issues)*
- [ ] **Ubuntu Software Mirror** - Additional speed optimizations *(planned)*

### 🔧 Advanced Options
- [x] **Configurable Donation** - Adjust XMRig developer donation percentage
- [x] **Custom Worker Names** - Personalized worker identification
- [x] **Automatic Dependencies** - All required packages installed automatically
- [x] **Error Recovery** - Robust error handling and recovery mechanisms

### 📊 Monitoring & Logs
- [x] **Real-time Output** - View mining progress in terminal
- [x] **Process Monitoring** - Automatic detection of mining status
- [x] **Resource Management** - Optimized for mobile devices


## Contributing 🤝

We welcome contributions to improve Aminer! Here's how you can help:

### 🐛 Bug Reports
- Open an issue describing the problem
- Include device model, Android version, and Termux version
- Provide logs and steps to reproduce

### 💡 Feature Requests
- Suggest new features or improvements
- Explain the use case and benefits

### 📝 Documentation
- Help improve README translations
- Add device compatibility information
- Write tutorials and guides

### 💻 Code Contributions
- Fork the repository
- Create a feature branch
- Submit a pull request with clear description

## Troubleshooting 🔧

### Common Issues

**Installation fails:**
- Ensure stable internet connection
- Try using a VPN if in regions with network restrictions
- Check available storage space (needs ~500MB)

**Mining doesn't start:**
- Restart Termux completely
- Check if XMRig binary exists: `ls ~/ubuntu-in-termux/ubuntu-fs/root/xmrig`
- Review installation logs for errors

**Low hash rate:**
- Close other apps to free up CPU resources
- Ensure device isn't thermal throttling
- Check pool connection status

**Need Help?**
- 📧 Open an issue on GitHub
- 🔍 Check existing issues for solutions
- 📱 Verify your device meets minimum requirements

## Thanks 💐

This project builds upon the excellent work of:

- [**SSH Key Installer**](https://github.com/P3TERX/SSH_Key_Installer) - Automated SSH key deployment
- [**ubuntu-in-termux**](https://github.com/MFDGaming/ubuntu-in-termux) - Ubuntu container implementation
- [**XMRig**](https://github.com/xmrig/xmrig) - High-performance Monero miner
- **The Termux Team** - Making Linux on Android possible

Special thanks to all contributors and testers who help improve this project! 🙏



---

🏵 **Aminer** ©Josh Zeng. Released under the BSD-3-Clause License.

Authored and maintained by Josh Zeng.

[@Blog](https://linkyou.top/) · [@GitHub](https://github.com/cornjosh)