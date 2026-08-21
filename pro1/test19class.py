# oop : 객체지향(중심)적인 프로그래밍 가능. 상속, 포함, 다형성 등의 기법 구사 가능
# class : 맴버 변수(필드), 멤버 메소드로 구성
# 인스턴스에 의해 새로운 이름 공간을 갖는다.

import math

a = 2
print(a)

def func():
    print('ok')

class TestClass:  # class의 이름 만큼은 대문자로 시작하도록 하자 (aa=5 는 상수, AA 는 변수이다)
    aa = 1 # 멤버 변수

    def __init__(self): # 특별 메소드. Method의 첫 인자는 반드시 self 이다.
        print('생성자 : 객체 생성시 가장 먼저 1회만 호출 - 초기화 담당')

    def __del__(self): # 특별 메소드
        print('소멸자 : 프로그램 종료시 자동실행. 마무리 작업')

    def showMessage(self): # 일반 메소드
        name = '한국인'  # 지역변수: showMessage에서만 유효
        print(name)
        print(self.aa) # print(aa)하면 showMessage에서 찾아서 self. 붙여줘야한다.

print(TestClass)

test = (TestClass)  # <class '__main__.TestClass'>
# TestClass() 는 __init__ 실행하는 의미 ??
print('클래스 멤버 a : ', TestClass.aa) # 클래스 멤버 a :  1
# TestClass.showMessage() # TypeError: ...  (실행시킬 때 나는 오류 : 런타임 오류가 일어남/ 문법 오류는 신택스오류)

# 클래스 생성자를 이용해 객체 생성 후 해당 객체의 주소를 객체변수에 치환.
test = TestClass() # 생성자 호출. instanse를 함.  -> object(객체, 개체)이 생성
print('클래스 멤버 a : ', test.aa)
# 1. Bound Method call
test.showMessage() # 자동으로 객체변수 test가 ()안에 메서드의 인수로 담겨 showMessage(test)로 호출됨.

# 2. UnBound Method call
TestClass.showMessage(test) # 전 줄에 객체 변수를 호출 했기 때문에 가능해졌다.

print()
print(type(1)) # <class 'int'>
print(type(1.0))
print(type('ok'))
print(type(test)) # <class '__main__.TestClass'>

print(id(test)) # 2757185654464
print(id(TestClass)) # 2757187805072
test2 = TestClass() # 객체 한 개 더 생성
print(id(test2)) # 1825659293200