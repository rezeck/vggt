FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

WORKDIR /app

# System deps for OpenCV video IO and git-based installs
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements_demo.txt ./
RUN pip install --no-cache-dir -r requirements.txt -r requirements_demo.txt

COPY . .

EXPOSE 8031

# Bind to all interfaces and use the requested port for Gradio
ENV GRADIO_SERVER_NAME=0.0.0.0 \
    GRADIO_SERVER_PORT=8031

CMD ["python", "demo_gradio.py"]

