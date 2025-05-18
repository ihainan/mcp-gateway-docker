FROM node:20-alpine

# 安装 Python 和 pip
RUN apk add --no-cache python3 py3-pip curl

# 安装 UV 并确保它在系统路径中可用
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mv /root/.local/bin/uv /usr/local/bin/ && \
    mv /root/.local/bin/uvx /usr/local/bin/ && \
    chmod +x /usr/local/bin/uv && \
    chmod +x /usr/local/bin/uvx

WORKDIR /app

# 复制 package.json 和 package-lock.json（如果存在）
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制源代码
COPY . .

# 创建配置文件目录
RUN mkdir -p /app/config

# 暴露默认端口（根据 README 中的示例）
EXPOSE 3000

# 设置启动命令
CMD ["npm", "start"] 