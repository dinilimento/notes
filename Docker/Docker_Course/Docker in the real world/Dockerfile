FROM python:2.7-alpine

RUN mkdir /app

WORKDIR /app

RUN mkdir /public

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

VOLUME [ "/app/public" ]

LABEL maintainer="Cas van Niel <cas.van.niel@nn.nl" \
      version="1.0"

CMD flask run --host=0.0.0.0 --port=5000
