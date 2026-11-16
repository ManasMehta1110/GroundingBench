FROM python:3.11.9-slim-bookworm

# Run as non-root — create user early
RUN useradd -m -u 1000 appuser

WORKDIR /app

# Install dependencies first for layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY . .

# Default port
ENV PORT=7860

# Switch to non-root
USER appuser

EXPOSE 7860

CMD ["python", "-m", "server.app"]