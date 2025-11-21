# GitHub Actions CI/CD

本项目使用 GitHub Actions 进行持续集成和持续部署。

## 工作流说明

### 1. Android CI (`android-ci.yml`)

**触发条件：**
- 推送到 `master`、`develop` 分支
- 推送到 `fix/**`、`feature/**` 分支
- 对 `master`、`develop` 的 Pull Request

**功能：**
- ✅ 代码检查 (Lint)
- ✅ 单元测试
- ✅ 构建 Debug APK
- ✅ 模拟器运行 Instrumentation 测试
- 📦 上传构建产物和测试报告

### 2. Android Release (`android-release.yml`)

**触发条件：**
- 推送 `v*` 标签 (例如 `v1.0.0`)
- 手动触发

**功能：**
- 🔐 使用密钥库签名
- 📦 构建 Release APK
- 🚀 创建 GitHub Release
- 📝 自动生成 Release Notes

### 3. Pull Request Check (`pr-check.yml`)

**触发条件：**
- Pull Request 打开、同步或重新打开

**功能：**
- ✅ 代码质量检查
- 🤖 自动在 PR 中评论构建状态
- 📦 上传 PR 预览 APK

## 配置 GitHub Secrets

为了使 Release 工作流正常工作，需要在 GitHub 仓库中配置以下 Secrets：

### 签名密钥配置

1. **SIGNING_KEY** - Base64 编码的密钥库文件
   ```bash
   base64 -w 0 app/store.jks > keystore.base64.txt
   # 将 keystore.base64.txt 的内容复制到 GitHub Secret
   ```

2. **SIGNING_KEY_ALIAS** - 密钥别名
   - 值: `store` (或你的密钥别名)

3. **SIGNING_KEY_PASSWORD** - 密钥密码
   - 值: 你的密钥密码

4. **SIGNING_STORE_PASSWORD** - 密钥库密码
   - 值: 你的密钥库密码

### 配置步骤

1. 进入 GitHub 仓库
2. 点击 **Settings** → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. 添加上述四个 Secrets

## 使用说明

### 创建 Release

1. **使用 Git 标签：**
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. **手动触发：**
   - 进入 GitHub Actions 页面
   - 选择 "Android Release" 工作流
   - 点击 "Run workflow"

### 查看构建结果

- 进入仓库的 **Actions** 标签
- 选择对应的工作流运行
- 下载构建产物 (APK 文件)

### 本地测试工作流

使用 [act](https://github.com/nektos/act) 在本地测试 GitHub Actions：

```bash
# 安装 act
# macOS
brew install act

# Linux
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# 运行特定工作流
act -W .github/workflows/android-ci.yml
```

## 工作流徽章

添加以下徽章到你的 README.md：

```markdown
![Android CI](https://github.com/mx0c/Android-BLE-Monitor/workflows/Android%20CI/badge.svg)
![Android Release](https://github.com/mx0c/Android-BLE-Monitor/workflows/Android%20Release/badge.svg)
```

## 注意事项

1. **NDK 版本：** 工作流使用 NDK 25.2.9519653，确保与本地开发环境一致
2. **Java 版本：** 使用 JDK 11，与项目配置一致
3. **缓存：** Gradle 依赖会被缓存以加速构建
4. **超时：** 默认超时时间为 360 分钟，可根据需要调整
5. **16 KB 页面支持：** 构建的 APK 已支持 16 KB 页面大小，符合 Google Play 要求

## 故障排除

### 构建失败
- 检查 Actions 日志查看详细错误信息
- 确保所有依赖版本与本地环境一致

### 签名失败
- 验证所有 Secrets 配置正确
- 确保密钥库文件 Base64 编码正确

### NDK 问题
- 确认 NDK 版本与项目要求匹配
- 检查 `ANDROID_NDK_HOME` 环境变量设置

## 自定义配置

可以根据项目需要修改工作流文件：

- **分支策略：** 修改 `on.push.branches` 和 `on.pull_request.branches`
- **测试超时：** 添加 `timeout-minutes` 配置
- **通知：** 集成 Slack、Discord 等通知服务
- **代码覆盖率：** 添加 JaCoCo 等覆盖率工具

## 参考文档

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Android Gradle 插件](https://developer.android.com/studio/build)
- [签名配置](https://developer.android.com/studio/publish/app-signing)
