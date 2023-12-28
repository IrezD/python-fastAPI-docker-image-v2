FROM python:3.9

WORKDIR /app/

COPY main.py /app/

EXPOSE 5000

RUN pip install fastapi && \
    pip install "uvicorn[standard]"

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000" ]