# 재귀함수 : 함수가 자기 자신을 호출 - 반복 처리 가능

def countDown(n):
    if n == 0:
        print('완료')
        return
    else:
        print(n, end=' ')
        countDown(n - 1) # 재귀(recursion)

countDown(5)

print('\n--- 1부터 n까지의 정수의 합 구하기 ---')
def totFunc(n):
    if n == 1:
            print('완료')
            return 1

    return n + totFunc(n - 1) # 재귀
# 5에서 1 될 때 까지 연산하지 않고 호출만 하고 다 호출 한 후에 함수 실행한다.
# tot(1) = 1, tot(2) = 2 + 1, tot(3) = 3 + 3, tot(4) = 6 + 4, tot(5) = 10 + 5/ 결과는 15 나옴.
result = totFunc(5)
print('result : ', result)

print('\n--- (factorial, 계승)은 1부터 어떤 자연수 n까지의 모든')
def factFunc(a):
     if a == 1:return 1
     print(a)
     return a * factFunc(a - 1)

result2 = factFunc(5)
print('result2 : ', result2)

