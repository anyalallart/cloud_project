# Dockerfile for the backend application
FROM python:3.11-alpine

WORKDIR /app/backend

COPY requirements.txt .
COPY *.py .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

ENTRYPOINT [ "python3" ]

CMD [ "-m", "unicorn", "main:app" ]