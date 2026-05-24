FROM python:3.12-slim

WORKDIR /app
COPY suites/ /app/suites
COPY libraries/ /app/libraries

COPY requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

CMD ["robot", "--outputdir", "/app/results", "-v", "PORT:/dev/ttyACM0", "/app/suites"]