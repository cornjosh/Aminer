<div align="center">
  <image src="/assets/miner.png" alt="Aminer" height="200px"></image>
  <h3><a href="https://github.com/cornjosh/Aminer">Aminer</a></h3>
  <em>使用 Android 设备来挖矿</em>
</div>

<p align="center">
<img src="https://img.shields.io/github/last-commit/cornjosh/Aminer" alt="GitHub last commit"/>
<img src="https://visitor-badge.glitch.me/badge?page_id=cornjosh.Aminer" alt="visitor badge"/>
<img src="https://img.shields.io/github/size/cornjosh/Aminer/aminer.sh" alt="GitHub file size in bytes"/>
<img src="https://img.shields.io/github/license/cornjosh/Aminer" alt="GitHub"/>
</p>

<h5 align="center">Aminer 是一个开源脚本，可以方便的在 Android 设备上部署 XMRIG，用来挖取以 <strong>门罗币</strong> 为主的多种加密货币。</h5>

---

[English Version](README.md)

---

## 演示 ✨

<div align="center">
    <image src="/assets/screen.gif" alt="screen" height="500px"></image>
</div>

## 收益 💰

**仅供参考，仅代表发布时的情况**

- 骁龙 865 在 c3-pool 中，换算哈希速度为 1.5KH/s，每 24h 收益约 ￥0.8

- 骁龙 625 在 c3-pool 中，换算哈希速度为 1KH/s，每 24h 收益约 ￥0.5

## 兼容性 📱

理论支持 Android 4.4 + 的 64 位设备（arm64、x86
-x64）

✔️ **以下为经过测试的设备，欢迎提 issue 添加**

- Redmi note 2 (Android 5.0/Termux 0.73)
- Redmi 5 plus (Android 7.0/Termux 0.108)
- Redmi k30 pro (Android 11/Termux 0.108)

## 快速开始 🚀

### 安装 Termux

- Android 7 及以上的设备请安装最新版本的 Termux

- Android 6 及以下的设备请安装 v0.73 版本的 Termux

### 安装、编译软件

在 Termux 终端窗口中输入

```bash
bash <(curl -fsSL git.io/aminer) -u username
```

**对于 Android 6 及以下的设备可能还需要先运行** `pkg update -y && pkg install curl -y`

默认使用 c3-pool 矿池, 捐赠 1% 给 XMRIG 软件开发者 ( 不是我 ), 可以参考使用说明进行调整

所有需要的依赖程序将会被自动安装，请确保网络畅通，在安装一些依赖时可能需要您的确认

安装需要约 20 分钟(取决于您的网络)

安装完成后，将会看到蓝色的 `##### Please restart Termux to run XMRIG #####`

此时重启 Termux 软件即可自动开始挖矿

## 使用 ⌨️

```bash
bash <(curl -fsSL git.io/aminer) [选项...] <参数>
```

- -y  自动模式, 跳过风险提示
- -u  矿池的用户名, 参数如同 `username`
- -p  矿池的密码, 参数如同 `password`
- -o  矿池的 URL, 参数如同 `mine.pool.example:1234`
- -d  捐赠给 XMRIG 开发者的算力百分比(不是给我的), 参数如同 `1`
- -g  安装 SSH 服务并使用 Github 上的公钥, 参数如同 `githubUsername`

## 功能 👍

- [x] 守护程序（意外退出自动重启）
- [x] 自动启动（打开 APP 自启）
- [ ] 开机自启（暂无头绪）



- [x] 自定义矿池（不局限于猫池啦）
- [x] 自动获取设备名（适用于 Android、猫池）



- [x] Ubuntu 容器国内镜像（中科大源）
- [ ] Termux 软件源国内镜像（清华源似乎不支持老版本）
- [ ] Ubuntu 软件源国内镜像（懒得）



- [x] 一键设置 SSH 服务器（调用大佬脚本）


## 致谢 💐

参考或引用了以下项目：

- [SSH Key Installer](https://github.com/P3TERX/SSH_Key_Installer)

- [ubuntu-in-termux](https://github.com/MFDGaming/ubuntu-in-termux)



---

🏵 **Aminer** ©Josh Zeng. Released under the BSD-3-Clause License.

Authored and maintained by Josh Zeng.

[@Blog](https://linkyou.top/) · [@GitHub](https://github.com/cornjosh)