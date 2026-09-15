# client
from socket import *

clientsock = socket(AF_INET, SOCK_STREAM)
clientsock.connect(('192.168.0.21', 7788))
clientsock.send("안녕 반가워".encode())
print('수신자료 : ', clientsock.recv(1024).decode())


clientsock.close()

# server 실행 중 - client 실행 - server가 메세지 수신 후 종료