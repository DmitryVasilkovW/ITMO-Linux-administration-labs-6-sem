FROM python:3.9-slim

RUN useradd -m appuser && mkdir /app && chown appuser:appuser /app
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
USER appuser

ENV STUDENT_NAME="Vasilkov Dmitry"
EXPOSE 5000
CMD ["python", "app.py"]
