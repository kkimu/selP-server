FROM elenaalexandrovna/opencv-python3

RUN apt-get update
RUN apt-get install -y python3-pip
RUN apt-get install -y python-numpy
RUN pip3 install flask
RUN pip3 install numpy

COPY . /home/deploy/app
WORKDIR /home/deploy/app

EXPOSE 5000

CMD ["python3","app.py"]
