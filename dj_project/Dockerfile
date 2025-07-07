FROM python:3.12

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /code

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY ./backend /code

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000