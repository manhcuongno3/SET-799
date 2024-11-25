# Sử dụng Node.js phiên bản LTS
FROM node:18

# Tạo thư mục làm việc trong container
WORKDIR /app

# Sao chép các file package.json và package-lock.json
COPY app/package*.json ./

# Cài đặt các dependencies
RUN npm install

# Sao chép toàn bộ mã nguồn ứng dụng
COPY app/ .

# Expose cổng 3000
EXPOSE 3000

# Chạy ứng dụng
CMD ["npm", "start"]
