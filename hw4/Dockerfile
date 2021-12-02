FROM ubuntu

WORKDIR /sample

ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Устанавливаем cmake
RUN apt-get update && \
    apt-get install -y cmake g++ python3 python3-pip

# Копируем cmake-with-flask в наш image
ADD ./task6/cmake-with-flask /app/src

# Устанавливаем директорию для сборки проекта
WORKDIR /app/build

# Собираем проект
RUN cmake ../src && \
    cmake --build .

# Создаем пользователя techproguser
RUN useradd techproguser

# Flask
RUN pip install flask

# Порт
EXPOSE 5000

# Установим точку входа
ENTRYPOINT FLASK_APP=/app/src/app.py flask run --port=5000 --host=172.17.0.2

