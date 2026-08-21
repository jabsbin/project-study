# function : 여러 개의 수행문을 하나의 이름으로 묶은 실행 단위
# 함수 고유의 공간을 갖는다.
# 자원의 재활용 가능
# 내장함수: 일부 체험
print(sum([1,2,3]))
print(8, bin(8)) # bin은 2진수로 출력함
print(eval('4 + 5')) # 연산식이 있고 eval함수 이용시 연산 수행
print(round(1.2), round(1.6)) # round는 반올림 되어 출력(끝이 5일 때 가까운 짝수로 출력)
import math
print(math.ceil(1.2), ' ', math.ceil(1.6)) #올림
print(math.floor(1.2), ' ', math.floor(1.6)) #내림

b_list = [True, 1, False]
print(all(b_list)) # False
print(any(b_list)) # True

data1 = [10, 20, 30]
data2 = ['a', 'b']
for i in zip(data1, data2):
    print(i)
# (10, 'a')
# (20, 'b')

import builtins  # 자동 로딩되기 때문에 import 필요 없음
builtins.print("자동 로딩")
builtins.print(builtins.sum([2,5]))
# print = 7
# print("안녕")
