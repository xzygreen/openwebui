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

## 拓展配置

### HTTP Client Read Buffer Size

当有遇到 `Chunk too big` 报错时，可以适当调节这里的大小

```
# 默认是 64KB
AIOHTTP_CLIENT_READ_BUFFER_SIZE=65536
```

### 注册邮箱验证


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
