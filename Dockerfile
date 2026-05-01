FROM python:3.13-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY app /app/app

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --retries=5 CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000')"

CMD ["python", "/app/app/server.py"]