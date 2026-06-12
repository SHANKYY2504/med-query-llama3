# 1. Use a robust, fully-equipped Python image instead of slim
FROM python:3.10

# 2. Prevent Python from writing pyc files and enable unbuffered streaming logs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# 3. Install basic utilities cleanly
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy the project files in
COPY . .

# 5. Upgrade pip first to ensure modern wheel resolution, then install smoothly
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir .

EXPOSE 5000

CMD ["python", "app/application.py"]