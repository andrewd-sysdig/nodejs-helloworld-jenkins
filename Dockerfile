# FROM node:17-slim
# This is node:17-slim at 17/3/22
FROM node@sha256:c5725a63cb29b78a2ccfffbc70c0e7bc938c925633dbb39a96acbec57c792994

# Create app directory
WORKDIR /usr/src/app

# Upgrade libssl1.1 to fix SCV2022-0778
RUN apt update && apt upgrade libssl1.1 -y

# Bundle app source
COPY app.js .

EXPOSE 3000
CMD [ "node", "app.js" ]
