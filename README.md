<div align="center">
  <image src="/assets/miner.png" alt="Aminer" height="200px"></image>
  <h3><a href="https://github.com/cornjosh/Aminer">Aminer</a></h3>
  <em>Mining with Android devices</em>
</div>

<p align="center">
<img src="https://img.shields.io/github/last-commit/cornjosh/Aminer" alt="GitHub last commit"/>
<img src="https://visitor-badge.glitch.me/badge?page_id=cornjosh.Aminer" alt="visitor badge"/>
<img src="https://img.shields.io/github/size/cornjosh/Aminer/aminer.sh" alt="GitHub file size in bytes"/>
<img src="https://img.shields.io/github/license/cornjosh/Aminer" alt="GitHub"/>
</p>

<h5 align="center">Aminer is an open source script that makes it easy to deploy XMRig on Android devices to mine a variety of cryptocurrencies, mainly Monroe Coin.</h5>

---

[简体中文版](/README_CN.md)

---

## Screenshots ✨

<div align="center">
    <image src="/assets/screen.gif" alt="screen" height="500px"></image>
</div>

## Earnings 💰

**For reference only and represents only the situation at the time of publication**

- Snapdragon 865 in c3-pool, converted hash speed is 1.5KH/s, gain is about ￥0.8 per 24h

- Snapdragon 625 in c3-pool, converted hash rate is 1KH/s, gain is about ￥0.5 per 24h

## Compatibility 📱

Theoretical support for 64-bit devices with Android 4.4+ (arm64, x86-x64)

✔️ **The following are the tested devices, welcome issue to add**

- Redmi note 2 (Android 5.0/Termux 0.73)
- Redmi 5 plus (Android 7.0/Termux 0.108)
- Redmi k30 pro (Android 11/Termux 0.108)

## Quick Start 🚀

### Install Termux

- For Android 7 and above devices, please install the latest version of Termux

- For Android 6 and below, please install Termux version v0.73

### Installing and compiling software

Run the script in Termux terminal

```bash
bash <(curl -fsSL git.io/aminer) -u username
```

**For Android 6 and below devices you may also need to run** `pkg update -y && pkg install curl -y`

Default is to use the c3-pool, donate 1% to XMRig software developers (not me), you can adjust it according to the instructions

All required dependencies will be installed automatically, please make sure you have a good network connection, your confirmation may be required when installing some dependencies

Installation takes about 20 minutes (depending on your network)

Once the installation is complete, you will see the blue tips `##### Please restart Termux to run XMRIG #####`

At this point, restart the Termux software to start mining automatically

## Usage ⌨️

```bash
bash <(curl -fsSL git.io/aminer) [options...] <arg>
```

- -y  Auto mode, ignore risks warning
- -u  Pool's user, the arguments like `username`
- -p  Pool's password, the arguments like `password`
- -o  Pool's url, the arguments like `mine.pool.example:1234`
- -d  Donate level to XMRIG's developers (not me),the arguments like `1`
- -g  Setup sshd with Github name, the arguments like `githubUsername`

## Feature 👍

- [x] daemon (automatic restart for unexpected exit)
- [x] Autostart (open APP to start itself)
- [ ] Boot self-start (no clue yet)



- [x] Customize mining pool (not limited to c3-pool anymore)
- [x] Auto-get device name (for Android, c3-pool)



- [x] Ubuntu container domestic mirror (USTC source)
- [ ] Termux software source domestic mirror (Tsinghua source does not seem to support older versions)
- [ ] Ubuntu software source domestic mirror (lazy)



- [x] One-click setup SSH server (use P3TERX's script)


## Thanks 💐

The following items are referenced or cited：

- [SSH Key Installer](https://github.com/P3TERX/SSH_Key_Installer)

- [ubuntu-in-termux](https://github.com/MFDGaming/ubuntu-in-termux)



---

🏵 **Aminer** ©Josh Zeng. Released under the BSD-3-Clause License.

Authored and maintained by Josh Zeng.

[@Blog](https://linkyou.top/) · [@GitHub](https://github.com/cornjosh)