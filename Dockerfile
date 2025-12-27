FROM node:22-alpine
RUN apk add --no-cache netcat-openbsd
WORKDIR /app
# Copy both package files to ensure the lockfile is respected
COPY package.json package-lock.json* ./
# Force a fresh install of the specific requirements
RUN npm install --legacy-peer-deps
COPY . .
# This step validates the system structure before finishing the build
RUN npx hardhat compile
EXPOSE 8545
CMD ["sh", "./docker/entrypoint.sh"]