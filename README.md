
# Open-WebUI
Only supports Huggingface deployment  
[Open WebUI On Huggingface](https://huggingface.co/spaces/xzygreen1/fkhdgduthserykgysssbhjvxg) This is an example – do not duplicate this Space.  

```
Environment variables:
WEBDAV_URL https://alist.com/dav WebDAV address
WEBDAV_USERNAME WebDAV username
WEBDAV_PASSWORD WebDAV password
```

> This project is a community-driven fork of the open-source AI platform [Open WebUI](https://github.com/open-webui/open-webui). This version is not associated with or maintained by the official Open WebUI team.  

## Extended Configurations  
### HTTP Client Read Buffer Size  
Adjust this value when encountering `Chunk too big` errors:  
```
# Default is 64KB
AIOHTTP_CLIENT_READ_BUFFER_SIZE=65536
```

### Registration Email Verification  
Enable email verification in the admin panel, configure the WebUI URL, and set these environment variables:  
```
# Cache
REDIS_URL=redis://:<password>@<host>:6379/0
# Email settings
SMTP_HOST=smtp.email.qq.com
SMTP_PORT=465
SMTP_USERNAME=example@qq.com
SMTP_PASSWORD=password
```
