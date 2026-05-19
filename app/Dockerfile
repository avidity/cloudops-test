FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends curl

COPY server.py .

EXPOSE 8000

CMD ["python", "server.py"]
