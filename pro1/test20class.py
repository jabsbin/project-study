class Car:
    handle = 1
    speed = 0

    def __init__(self, name, speed):
        self.name = name  # 현재 객체의 name에게 name(지역변수) 인자값 치환
        self.speed = speed

    def showData(self):
        km = "킬로미터"
        msg = "속도 :" + str(self.speed) + km
        return msg

    def printHandle(self):
        return self.handle

print(Car.handle)  # 원형(prototype) 클래스의 멤버 호출
# Car.하면 Car클래스 멤버 중에 handle을 호출.
print()

car1 = Car('tom', 10) # 생성자 호출을 통해 객체 생성(인스턴스화)
#  name, speed 는 지역 변수
# 원형 타입이 아닌 새로운 객체에 입력 되는 것
print('car1 객체 주소 : ', car1)
print('car1 : ', car1.name, ' ', car1.speed, ' ', car1.handle)
# 새 객체에 멤버가 없을 경우에 원형 클래스에서 멤버 찾아서 호출
car1.color = '파랑'
print('car.color : ', car1.color)

car2 = Car('oscar', 20) # 생성자 호출
print('car2 객체 주소 : ', car2)
print('car2 : ', car2.name, ' ', car2.speed, ' ', car2.handle)
# print('car2.color : ', car2.color) # AttributeError: 'Car' object has no attribute 'color'

print(Car, car1, car2)
print(id(Car), id(car1), id(car2))
# 1806829162288 1806827015872 1806826933776
print()
# 각 객체의 멤버 확인
print(car1.__dict__) # {'name': 'tom', 'speed': 10, 'color': '파랑'}
print(car2.__dict__) # {'name': 'oscar', 'speed': 20}

print('---메소드--------------')
print('car1 speed : ', car1.showData()) # car1 speed :  속도 :10킬로미터
print('car2 speed : ', car2.showData()) # car2 speed :  속도 :20킬로미터

car1.speed = 60
car2.speed = 110
print('car1 speed : ', car1.showData()) # car1 speed :  속도 :60킬로미터
print('car2 speed : ', car2.showData()) # car2 speed :  속도 :110킬로미터

print()
print('car1 handle : ', car1.printHandle())
print('car2 handle : ', car2.printHandle())
# 둘 다 각 개체에 멤버가 없어서 원형 클래스에서 찾음
Car.handle = 2  #원형(원본) 클래스의 멤버 변수 값 수정 
print('car1 handle : ', car1.printHandle())
print('car2 handle : ', car2.printHandle())

# 참고: 자바와 달리 접근 지정자가 없다. 메소드 오버로딩 없다.