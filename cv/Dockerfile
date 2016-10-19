FROM elenaalexandrovna/opencv-python3

RUN apt-get update && \
		apt-get install -y python3-pip && \
		pip3 install flask

COPY . /home/deploy/app
WORKDIR /home/deploy/app

EXPOSE 5000

CMD ["python3","app.py"]
