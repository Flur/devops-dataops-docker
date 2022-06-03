# syntax=docker/dockerfile:1
FROM python:latest
WORKDIR /app
RUN groupadd -r myservices && useradd --no-log-init -r -g myservices myservices
RUN chown -R myservices:myservices /app
RUN chmod 755 /app
USER myservices:myservices
COPY . .
RUN python main.py

FROM alpine:latest
WORKDIR /root
COPY --from=0 /app/myfile.txt ./
CMD ["cat", "myfile.txt"]
