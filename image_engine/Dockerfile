FROM elenaalexandrovna/opencv-python3

COPY . /home/deploy/app
WORKDIR /home/deploy/app

RUN apt-get update
RUN apt-get install -y python3-pip
RUN apt-get install -y python-numpy
RUN pip3 install flask
RUN pip3 install numpy

#EXPOSE 5000

CMD ["python3","app.py"]
