FROM node:18-bookworm

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python-is-python3 \
    ffmpeg \
    curl \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir -U yt-dlp --break-system-packages
RUN pip3 install --no-cache-dir bgutil-ytdlp-pot-provider --break-system-packages

WORKDIR /app

COPY package*.json ./
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

COPY . .

EXPOSE 8000
CMD ["node", "index.js"]
