# The FastLLM Dockerfile is used to construct FastLLM image that can be directly used
# to run the offline batch inference.

#################### BatchLLM dependency IMAGE ####################
# image with dependency installed
FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04 AS batchllm
WORKDIR /workspace

RUN apt-get update -y \
    && apt-get install -y python3-pip git vim wget

RUN --mount=type=cache,target=/root/.cache/pip \
     pip install -i http://yum.tbsite.net/aliyun-pypi/simple/ --trusted-host=yum.tbsite.net --extra-index-url https://mirrors.aliyun.com/pypi/simple/ pyodps-int

COPY requirements.txt requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt

COPY entrypoint.sh entrypoint.sh
ENTRYPOINT ["bash", "entrypoint.sh"]
#################### BatchLLM dependency IMAGE ####################
