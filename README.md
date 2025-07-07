# Open-WebUI
仅支持huggingface部署
🤗Space Open WebUI automatic update template
# Environment variable
G_NAME	xxx/openwebui	您的 GitHub 仓库名称，可选
G_TOKEN	*************	您的 GitHub 访问令牌，可选
WEBDAV_URL	https://alist.com/dav	WebDAV 的地址
WEBDAV_USERNAME	webdav用户名	WebDAV 的用户名
WEBDAV_PASSWORD	webdav密码	WebDAV 的密码

> 该项目是社区驱动的开源 AI 平台 [Open WebUI](https://github.com/open-webui/open-webui) 的定制分支。此版本与 Open WebUI 官方团队没有任何关联，亦非由其维护。

# Open WebUI 👋

官方文档: [Open WebUI Documentation](https://docs.openwebui.com/).  
官方更新日志: [CHANGELOG.md](./CHANGELOG.md)



## 拓展特性

完整特性请看更新日志 [CHANGELOG_EXTRA.md](./CHANGELOG_EXTRA.md)

### 积分报表

![usage panel](./docs/usage_panel.png)

### 全局积分设置

![credit config](./docs/credit_config.png)

### 用户积分管理与充值

![user credit](./docs/user_credit.png)

### 按照 Token 或请求次数计费，并在对话 Usage 中显示扣费详情

![usage](./docs/usage.png)

### 支持注册邮箱验证

![email](./docs/sign_verify_user.png)

## 拓展配置

### HTTP Client Read Buffer Size

当有遇到 `Chunk too big` 报错时，可以适当调节这里的大小

```
# 默认是 64KB
AIOHTTP_CLIENT_READ_BUFFER_SIZE=65536
```

### 注册邮箱验证

![verify email](./docs/signup_verify.png)

请在管理端打开注册邮箱验证，配置 WebUI URL，同时配置如下环境变量

```
# 缓存
REDIS_URL=redis://:<password>@<host>:6379/0

# 邮件相关
SMTP_HOST=smtp.email.qq.com
SMTP_PORT=465
SMTP_USERNAME=example@qq.com
SMTP_PASSWORD=password
```

### 品牌/LOGO定制能力说明

本项目尊重并遵守 [Open WebUI License](https://docs.openwebui.com/license) 的品牌保护条款；我们鼓励社区用户尽量保留原有 Open WebUI 品牌，支持开源生态！

如需自定义品牌标识（如 LOGO、名称等）：

- 请务必确保您的实际部署满足 License 所要求的用户规模、授权条件等（详见 [官方说明#9](https://docs.openwebui.com/license#9-what-about-forks-can-i-start-one-and-remove-all-open-webui-mentions)）。
- 未经授权的商用或大规模去除品牌属于违规，由使用者自行承担法律风险。
- 具体自定义方法见 [docs/BRANDING.md](./docs/BRANDING.md)。
