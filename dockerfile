# Dockerfile de test simple
FROM python:3.11-alpine

WORKDIR /app

# Crée une page de test
RUN echo '<!doctype html><meta charset="utf-8"><h1>Test Docker</h1><p>Image créée pour test.</p>' > /app/index.html

EXPOSE 8080

# Démarre un serveur HTTP simple servant /app
CMD ["python", "-m", "http.server", "8080", "--directory", "/app"]