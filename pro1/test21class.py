kor = 100   # 모듈의 멤버 : 전역 변수

def abc():
    kor = 0  # 함수 내의 지역변수
    print('모듈의 멤버 함수')

class My:
    kor = 80   # My 클래스 멤버 변수(My type 객체의 공유 자원)

    # def __init__(self):  # 초기화 작업이 없는 경우 생성자는 생략 가능
    #     pass

    def abc(self):
        print('My 클래스 멤버 메소드')

    def show(self):
        #kor = 77   # 메소드 내의 지역 변수
        print(kor) # 값이 이 객체에 지역변수에 없을 경우 전역 변수 값 적용.
        print(self.kor)
        abc()
        self.abc()

myObj = My()  # 생성자 호출
myObj.show()  # myobj 객체에 kor 없으니까  위에 kor값 80 받아옴.
print('-------')

myObj2 = My()
print(myObj.kor)
myObj2.kor = 99
print(myObj2.kor)

print('~~~~~')
myObj3 = My()
print(myObj3.kor)