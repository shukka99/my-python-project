FROM python:3.8-slim

RUN groupadd -r pyapp && useradd --no-log-init -r -g pyapp pyapp

WORKDIR /home/pyapp

COPY requirements.txt .
COPY app.py .

RUN pip install --no-cache-dir -r requirements.txt \

 && chown -R pyapp:pyapp .
USER pyapp

HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1

ENTRYPOINT ["python3", "app.py"]
EXPOSE 8080
