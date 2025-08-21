<div align="center">
  <image src="/assets/miner.png" alt="Aminer" height="200px"></image>
  <h3><a href="https://github.com/cornjosh/Aminer">Aminer</a></h3>
  <em>使用 Android 设备来挖矿</em>
</div>

<p align="center">
<img src="https://img.shields.io/github/stars/cornjosh/Aminer?style=flat-square" alt="GitHub Stars"/>
<img src="https://img.shields.io/github/forks/cornjosh/Aminer?style=flat-square" alt="GitHub Forks"/>
<img src="https://img.shields.io/github/issues/cornjosh/Aminer?style=flat-square" alt="GitHub Issues"/>
<img src="https://img.shields.io/github/last-commit/cornjosh/Aminer?style=flat-square" alt="GitHub last commit"/>
<img src="https://img.shields.io/github/license/cornjosh/Aminer?style=flat-square" alt="GitHub License"/>
<img src="https://img.shields.io/github/size/cornjosh/Aminer/aminer.sh?style=flat-square" alt="Script Size"/>
</p>

<h5 align="center">Aminer 是一个开源脚本，可以方便的在 Android 设备上部署 XMRig，用来挖取以 <strong>门罗币 (XMR)</strong> 为主的多种加密货币。非常适合利用闲置的 Android 设备进行轻量级加密货币挖矿。</h5>

> ⚠️ **安全提示**: 加密货币挖矿可能会消耗设备电池并产生热量。使用风险自负，请确保设备通风良好。仅使用可信的矿池，并注意电费成本。

---

[English Version](README.md)

---

## 演示 ✨

<div align="center">
    <image src="/assets/screen.gif" alt="screen" height="500px"></image>
</div>

## 收益 💰

**⚠️ 重要免责声明：以下数据仅供参考，代表发布时的情况。实际收益可能因以下因素而显著变化：**

- 当前网络难度
- 市场价格波动
- 矿池手续费
- 设备性能表现
- 电费成本

**历史参考数据：**
- 骁龙 865 在 c3-pool：约 1.5KH/s 算力，预估每 24h 收益 ￥0.8
- 骁龙 625 在 c3-pool：约 1KH/s 算力，预估每 24h 收益 ￥0.5

> 💡 **性能提示**：不同设备的挖矿性能差异很大。挖矿前请考虑电费成本和设备损耗。

## 兼容性 📱

**系统要求：**
- Android 4.4+ (API level 19+)
- 64 位架构 (arm64, x86-64)
- 建议至少 2GB 内存
- 稳定的网络连接
- 已安装 Termux 应用

**Termux 版本兼容性：**
- **Android 7+**：使用 F-Droid 或 GitHub 的最新版本
- **Android 6 及以下**：使用 Termux v0.73

✅ **已测试设备：**
| 设备型号 | Android 版本 | Termux 版本 | 状态 |
|---------|-------------|-------------|------|
| Redmi Note 2 | 5.0 | 0.73 | ✅ 正常工作 |
| Redmi 5 Plus | 7.0 | 0.108 | ✅ 正常工作 |
| Redmi K30 Pro | 11 | 0.108 | ✅ 正常工作 |

> 📝 **说明**：欢迎提交 issue 报告您设备的兼容性情况！

## 快速开始 🚀

### 前置条件

1. **安装 Termux：**
   - **Android 7+**：从 [F-Droid](https://f-droid.org/en/packages/com.termux/) 或 [GitHub Releases](https://github.com/termux/termux-app/releases) 下载
   - **Android 6 及以下**：安装 Termux v0.73（旧版本）

2. **准备 Termux 环境：**
   ```bash
   # 对于较旧的 Android 版本，请先更新软件包列表
   pkg update -y && pkg install curl -y
   ```

### 安装过程

在 Termux 终端中运行以下命令：

```bash
bash <(curl -fsSL git.io/aminer) -u 你的钱包地址
```

**示例：**
```bash
bash <(curl -fsSL git.io/aminer) -u 45xh7ksV8w4...你的门罗币地址
```

### 安装过程中会发生什么

1. ⬇️ 下载并安装 Ubuntu 容器
2. 🔧 安装构建依赖项（git、cmake、gcc 等）
3. 📦 从源码编译 XMRig
4. ⚙️ 配置挖矿参数
5. 🎯 设置守护进程以实现自动重启

**安装时间**：约 20 分钟（取决于网络速度）

**成功标志**：您将看到蓝色消息：
```
##### Please restart Termux to run XMRIG #####
```

### 开始挖矿

1. **关闭并重新打开 Termux** - 挖矿将自动开始
2. **监控进度** - 查看矿池仪表板获取统计信息
3. **查看日志** - 挖矿输出将在终端中显示

> ⚠️ **重要提示**：确保设备通风良好，并考虑对电池寿命的影响。

## 使用方法 ⌨️

### 基本用法

```bash
bash <(curl -fsSL git.io/aminer) [选项...] <参数>
```

### 命令行选项

| 选项 | 说明 | 示例 |
|------|------|------|
| `-y` | 自动模式（跳过风险警告） | `-y` |
| `-u` | 矿池用户名/钱包地址 | `-u 45xh7ks...` |
| `-p` | 矿池密码 | `-p worker_name` |
| `-o` | 矿池 URL 和端口 | `-o mine.pool.com:1234` |
| `-d` | 向 XMRig 开发者的捐赠级别 | `-d 1` |
| `-g` | 使用 GitHub 用户名设置 SSH | `-g your_github_user` |

### 使用示例

**使用自定义钱包地址挖矿：**
```bash
bash <(curl -fsSL git.io/aminer) -u 你的门罗币钱包地址
```

**自定义矿池和设置：**
```bash
bash <(curl -fsSL git.io/aminer) -u 钱包地址 -p worker1 -o pool.example.com:4444 -d 0
```

**自动安装并设置 SSH：**
```bash
bash <(curl -fsSL git.io/aminer) -y -u 钱包地址 -g github_用户名
```

### 安装后命令

**检查挖矿状态：**
```bash
./ubuntu.sh
ps aux | grep xmrig
```

**停止挖矿：**
```bash
./ubuntu.sh
pkill xmrig
```

**重启挖矿：**
```bash
./ubuntu.sh
./service.sh
```

## 功能特性 👍

### ⚡ 挖矿管理
- [x] **守护进程** - 意外退出时自动重启
- [x] **自动启动** - 打开 Termux 应用时开始挖矿
- [ ] **开机自启** - 设备启动时开始挖矿 *（开发中）*

### 🎯 矿池配置
- [x] **自定义矿池** - 不再局限于 c3-pool
- [x] **自动设备检测** - 自动获取设备名称用于矿池识别
- [x] **灵活的矿池设置** - 支持任何兼容门罗币的矿池

### 🏗️ 系统功能
- [x] **Ubuntu 容器** - 使用国内镜像源（中科大源，下载更快）
- [x] **SSH 服务器设置** - 使用 P3TERX 脚本一键配置 SSH
- [ ] **Termux 镜像源** - 国内软件源 *（清华镜像兼容性问题）*
- [ ] **Ubuntu 软件镜像** - 额外的速度优化 *（计划中）*

### 🔧 高级选项
- [x] **可配置捐赠** - 调整 XMRig 开发者捐赠百分比
- [x] **自定义工作名称** - 个性化工作标识
- [x] **自动依赖项** - 自动安装所有必需的软件包
- [x] **错误恢复** - 强大的错误处理和恢复机制

### 📊 监控与日志
- [x] **实时输出** - 在终端中查看挖矿进度
- [x] **进程监控** - 自动检测挖矿状态
- [x] **资源管理** - 针对移动设备优化


## 贡献指南 🤝

我们欢迎为改进 Aminer 做出贡献！以下是您可以帮助的方式：

### 🐛 错误报告
- 提交 issue 描述问题
- 包含设备型号、Android 版本和 Termux 版本
- 提供日志和重现步骤

### 💡 功能请求
- 建议新功能或改进
- 解释用例和好处

### 📝 文档
- 帮助改进 README 翻译
- 添加设备兼容性信息
- 编写教程和指南

### 💻 代码贡献
- Fork 仓库
- 创建功能分支
- 提交带有清晰说明的拉取请求

## 故障排除 🔧

### 常见问题

**安装失败：**
- 确保网络连接稳定
- 如果在网络限制地区，尝试使用 VPN
- 检查可用存储空间（需要约 500MB）

**挖矿无法启动：**
- 完全重启 Termux
- 检查 XMRig 二进制文件是否存在：`ls ~/ubuntu-in-termux/ubuntu-fs/root/xmrig`
- 检查安装日志中的错误

**算力较低：**
- 关闭其他应用以释放 CPU 资源
- 确保设备没有过热限频
- 检查矿池连接状态

**需要帮助？**
- 📧 在 GitHub 上提交 issue
- 🔍 查看已有 issue 寻找解决方案
- 📱 验证您的设备是否满足最低要求

## 致谢 💐

本项目基于以下优秀项目的工作：

- [**SSH Key Installer**](https://github.com/P3TERX/SSH_Key_Installer) - 自动化 SSH 密钥部署
- [**ubuntu-in-termux**](https://github.com/MFDGaming/ubuntu-in-termux) - Ubuntu 容器实现
- [**XMRig**](https://github.com/xmrig/xmrig) - 高性能门罗币挖矿软件
- **Termux 团队** - 让 Android 上运行 Linux 成为可能

特别感谢所有帮助改进这个项目的贡献者和测试者！🙏



---

🏵 **Aminer** ©Josh Zeng. Released under the BSD-3-Clause License.

Authored and maintained by Josh Zeng.

[@Blog](https://linkyou.top/) · [@GitHub](https://github.com/cornjosh)