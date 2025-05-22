FROM python:3.10

RUN pip install --no-cache-dir uv

RUN uv python pin 3.10

WORKDIR /lift

COPY pyproject.toml /lift

RUN uv sync

# No extra file copied, volume mounted in docker-compose

ENV PYTHONPATH=/lift

CMD ["uv", "run", "python", "src/prices.py"]