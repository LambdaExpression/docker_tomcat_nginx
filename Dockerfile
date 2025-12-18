FROM tomcat:8.0.36-jre8-alpine

# 安装nginx和依赖
RUN apk add --no-cache nginx && \
    # 创建必要的目录
    mkdir -p /run/nginx && \
    mkdir -p /var/log/nginx && \
    # 清理apk缓存
    rm -rf /var/cache/apk/*

# 复制nginx配置文件（如果需要自定义配置）
# COPY nginx.conf /etc/nginx/nginx.conf

# 复制启动脚本
RUN echo '#!/bin/sh' > /start.sh && \
    echo 'nginx' >> /start.sh && \
    echo 'exec catalina.sh run' >> /start.sh && \
    chmod +x /start.sh

# 暴露端口
EXPOSE 80 8080

# 启动nginx和tomcat
CMD ["/start.sh"]