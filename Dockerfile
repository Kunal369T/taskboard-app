# ---- Stage 1: build dependencies ----
FROM python:3.12-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---- Stage 2: runtime image ----
FROM python:3.12-slim
RUN useradd --create-home --uid 10001 appuser
WORKDIR /home/appuser
COPY --from=builder /install /usr/local
COPY app ./app
USER 10001
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
