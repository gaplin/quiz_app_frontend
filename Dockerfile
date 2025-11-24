# syntax=docker/dockerfile:1.12-labs

FROM debian:latest AS build

# Install flutter dependencies
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN apt-get clean

# Download flutter sdk
RUN curl -fL -o "/usr/flutter.tar.xz" https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.38.3-stable.tar.xz
RUN tar -xf /usr/flutter.tar.xz -C /usr/local
RUN git config --global --add safe.directory /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter precache --web
RUN flutter config --enable-web

# build
WORKDIR /app
COPY --exclude=nginx.conf . .
RUN flutter clean
RUN flutter pub get
RUN flutter build web --release --dart-define-from-file=appsettings.release.json

FROM nginx:alpine
RUN apk update && apk upgrade

RUN chown -R nginx:nginx /usr/share/nginx/html && chmod -R 755 /usr/share/nginx/html && \
       chown -R nginx:nginx /var/cache/nginx && \
       chown -R nginx:nginx /var/log/nginx && \
       chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
       chown -R nginx:nginx /var/run/nginx.pid


USER nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose server port from nginx.conf
EXPOSE 8888

CMD ["nginx", "-g", "daemon off;"]
