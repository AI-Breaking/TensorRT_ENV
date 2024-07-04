# Base image 설정
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

# 비대화형 모드로 설정
ENV DEBIAN_FRONTEND=noninteractive

# 필요한 시스템 패키지 설치
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# pip 명령어를 python3-pip으로 대체
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN rm -f /usr/bin/pip && ln -s /usr/bin/pip3 /usr/bin/pip

# 작업 디렉토리 설정
WORKDIR /app

# 필요한 패키지 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# pip 업그레이드
RUN pip install --upgrade pip

# Jupyter Notebook 설치
RUN pip install notebook
