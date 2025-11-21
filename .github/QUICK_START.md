# 🚀 GitHub Actions 快速开始

## 一键配置清单

### ✅ 已完成
- [x] GitHub Actions 工作流配置
- [x] Dependabot 自动更新
- [x] Issue 和 PR 模板
- [x] CI/CD 文档

### 📋 待办事项

#### 1️⃣ 推送代码 (必需)
```bash
git push origin fix/improve-device-list-clickable-area
```

#### 2️⃣ 配置签名 Secrets (可选，用于 Release)
在 GitHub 仓库设置中添加：
- `SIGNING_KEY` - Base64 编码的 keystore
- `SIGNING_KEY_ALIAS` - 密钥别名
- `SIGNING_KEY_PASSWORD` - 密钥密码
- `SIGNING_STORE_PASSWORD` - Keystore 密码

生成 SIGNING_KEY:
```bash
base64 -w 0 app/store.jks > keystore.base64.txt
```

#### 3️⃣ 测试工作流
```bash
# 触发 CI
git push origin your-branch

# 触发 Release
git tag v1.0.0
git push origin v1.0.0
```

## 🎯 工作流一览

| 工作流 | 触发条件 | 用途 |
|--------|---------|------|
| **Android CI** | 推送/PR | 构建测试 |
| **Android Release** | 标签/手动 | 发布 APK |
| **PR Check** | Pull Request | 代码检查 |

## 📱 常用命令

```bash
# 创建并推送标签
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0

# 查看工作流状态
gh run list  # 需要 GitHub CLI

# 下载 APK
gh run download  # 需要 GitHub CLI
```

## 📊 徽章

添加到 README.md:
```markdown
![CI](https://github.com/mx0c/Android-BLE-Monitor/workflows/Android%20CI/badge.svg)
![Release](https://github.com/mx0c/Android-BLE-Monitor/workflows/Android%20Release/badge.svg)
```

## 💡 提示

- ⚡ Gradle 依赖会被缓存，第二次构建更快
- 🔒 Release 需要配置签名 Secrets
- 🧪 模拟器测试在 CI 工作流中运行
- 📦 所有构建产物保留 7-30 天

## 🆘 需要帮助？

详细文档: `.github/CI_CD_README.md`
