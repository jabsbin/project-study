# 추상 클래스(abstract class)
# 추상 메소드를 가진 클래스를 추상 클래스라고 하며
# 얘는 인스턴스 할 수 없다(객체 생성 불가)
# 부모 클래스로만 사용
# 추상 클래스는 "직접 객체를 만들려고 존재하는 클래스가 아니라,
# 자식 클래스들이 반드시 지켜야 할 공통 규칙을 정하는 클래스" 이다.
# 추상 클래스 = 자식 클래스에게 규칙을 강제(메서드 오버라이딩)하는 부모 클래스

# 클래스는 속성과 행위를 입력, self를 이용, 생성자는 생성하거나 초기화 작업을 할 때 이용하고 많은 작업 금지,
# 생성자는 선언만 하는 장소, 틀을 만드는게 원형 메소드

from abc import *


class AbstractClass(metaclass = ABCMeta):  # 추상 클래스 (metaclass = ABCMeta)중요
    @abstractmethod  # 강제로 오버라이딩하게 하는 방법 (추상 메소드 선언)
    def abcMethond(self): # 추상 메소드 : 자식 클래스에서 오버라이딩 강요
        pass
# 메소드 내용 없으니 부모 클래스 인 것을 알 수 있음.

    def normalMethod(self):
        print('추상 클래스 내의 일반 메소드 : 자식 클래스에서 오버라이딩 선택')

# parent = AbstractClass() # TypeError: Can't instantiate abstract class

class Child1(AbstractClass):
    name = '난 Child1'
    def abcMethond(self):
        print('부모가 가진 추상 메소드 재정의 - 강요를 당함 ^^')
# c1 = Child1() # 추상 메소드 오버라이딩 안했을 시 -> TypeError: Can't instantiate abstract class Child1
ch1 = Child1()
print('name : ', ch1.name)
ch1.abcMethond()
ch1.normalMethod()

print()
class Child2(AbstractClass):
    def abcMethond(self):   # 오버라이딩 강요 당함
        print('오버라이딩 함 : Child2에서 수행 할 로직 작성')

    def normalMethod(self):  # 오버라이딩 자의적 선택함
        print('부모의 일반 메소드를 내 맘대로 내용 변경해서 사용')

    def show(self):
        print('Child2 고유 메소드')

ch2 = Child2()
ch2.abcMethond()
ch2.normalMethod()
ch2.show()

print('----------')
hapyy = ch1
hapyy.abcMethond()
print()
happy = ch2
happy.abcMethond()
