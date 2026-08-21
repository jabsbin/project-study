# 모듈은 파이썬 파일 하나에 정의된 함수, 클래스, 변수 등을 모아둔 것
# 즉, 관련된 코드들을 하나의 파일로 정리한 것이 모듈이다.
# 패키지 사용시에는 __init__.py 이 파일을 추가해 패키지라는 것을 알려줌.(예전 버전은 써줘야함)
# module : 소스 코드의 재사용을 가능하게 하며, 
# 소스 코드를 하나의 이름 공간으로 구분하고 관리.
# 하나의 파일은 하나의 모듈이 된다.
# 모듈의 멤버로 모듈, 함수, 클래스, 변수, 실행문이 있다.
# 표준 모듈, 사용자 작성 모듈, 제3자 모듈(third party)로 구분 할 수 있다.

print(print.__module__) # builtins 

print('뭔 작업을 하다가... 외부 모듈 사용하기')
import sys
print(sys.path)  # 현재 모듈의 경로 확인

q = 'n'
if q == 'y':
    sys.exit() # 실행되는 프로그램 종료시 exit 사용 /
#exit () 괄호가 있기 때문에 함수이다. (sys.path) 경우에는 함수 아님.

# 수학 관련 모듈 읽기
import math
print(math.pi)
print(math.sin(math.radians(30))) # sin30도 값 출력

# 달력 출력
import calendar
print(calendar.JULY)
calendar.setfirstweekday(6) # 0 ~ 6 순서대로 월~ 일 의미/ 한 주의 시작을 일요일로 설정한 것
calendar.prmonth(2026, 8)
del calendar

# import time
# print('3초 휴식')
# time.sleep(3)
# print('계속')

# 난수 출력
import random # 모듈명만 씀
print(random.random()) # 0 ~ 1 사이 숫자 난수 출력
print(random.randrange(1, 10)) # 1 ~ 10 사이 숫자의 난수 출력

from random import random # 이렇게 사용하면 위 print 처럼 안써도됨./ (from 모듈명 import 멤버의 이름)
print(random())

from random import randint, randrange, choice # 일부 멤버만 로딩
print(randrange(1, 5))
print(randint(1, 5))
#방법 : 모듈명만 쓰거나 모듈명에 멤버 쓰는 방법 2가지 중 하나 이용.
from random import * # 전체 멤버 로딩 (비권장) / 필요한 것만 불러다 쓰는게 좋음.
print('종료')