FROM node:20-alpine

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