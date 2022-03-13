# Builder
ARG TAG="v1.10.6"

# Use official build as builder.
# This allows very fast build time, especially on low spec computer like armv7 board.
FROM vectorim/element-web:$TAG as builder

# App
FROM nginx:alpine

COPY --from=builder /app /app

# Insert wasm type into Nginx mime.types file so they load correctly.
RUN sed -i '3i\ \ \ \ application/wasm wasm\;' /etc/nginx/mime.types

RUN rm -rf /usr/share/nginx/html \
  && ln -s /app /usr/share/nginx/html
