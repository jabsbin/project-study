# 반복문 while 조건: 조건이 참인 동안 블럭 수행
a = 1
while a <= 5:# 조건
    print(a, end = ' ')
    a += 1 # 조건에 1씩 증가
else: # 선택적 : 조건에 따른 종료시 수행.
    print('수행 성공')

print()
i = 1
while i <= 3:
    j = 1
    while j <= 4:
        # print('i =' + str(i) + ', j=' + str(j))
        print(f'i={i}, j={j}') # 위 주석 코드랑 같은 코드
        j = j + 1
    i = i + 1

print('1 ~ 100 사이의 정수 중 3의 배수의 합은?')
su = 1
hap = 0
while su <= 100:
    #print(su, end = ' ') #end 이용은 옆으로 값 나옴
    if su % 3 == 0:
        # print(su, end = " ")
        hap += su
    su += 1

print('합 :', hap)

print()
colors = ["r", "g", "b"]

num = 0
while num < len(colors):
    print(colors[num])
    num += 1

print('if 블럭 내에 while 블럭 사용')
import time
# print('a')
# time.sleep(2)
# print("b")

"""
sw = input('폭탄 스위치를 누를까요?[y/n]')

if sw == 'Y' or sw == 'y':
    #pass # 수행 할 내용이 없을 때 pass꼭 적기.
    count = 5
    while i <= count:
        print('%d초 남았어요'%count)
        # print(f'{count}초 남았어요')
        time.sleep(1)
        count -= 1
    print('폭발')
elif sw == 'N' or sw == 'n':
    print('작업 취소')
else:
    print('y 또는 n을 누르시오')
"""

print('\ncontinue / break')
a = 0
while a < 10:
    a += 1
    if a == 7: break #반복문(무한루프) 무조건 탈출
    if a == 5: continue # 아래 문을 무시하고 while로 이동해서 값이 안나옴.
    print(a)
# else: # 선택적 : 조건에 따른 종료시 수행. ( while 문이 잘 되는지 확인하고 싶은면 else문 이용)
#     print('수행 성공')

print('\n키보드로 정수를 입력 받아 홀수, 짝수 출력(무한 반복)')
while True: # 가독성 떨어지니까 True 사용
    mysu = int(input('확인할 정수 입력(예:5)'))
    if mysu == 0:
        print('프로그램 종료')
        break
    elif mysu % 2 == 0:
        print(f'{mysu} : 짝수')
        continue # continue 로 인해 while 문으로 이동
    elif mysu % 2 == 1:
        print(f'{mysu} : 홀수')

print('끝')