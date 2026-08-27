#1번
# i = 1
# sum = 0
# while i <= 100:
#     if i % 3 != 0 and i % 2 != 0:
#         print(i)
#     sum = sum + i
# else:
#     print(sum)

#2번
# a = 2
# while a <= 5:
#     b = 1
#     while b <= 9:
#         print(f'{a} x {b} :', a*b)
#         b = b + 1
#     a = a + 1

#3번
# i = 1
# h = 0
# while i <= 100:
#     if i % 2 == 0:
#         h = h + i
#     else:
#         h = h - i
#     i += 1
# print(h)

#4번
# i = 1
# s = -1
# total = 0

# while i <= 99:
#     value = s * i
#     total += value

#     s *= -1
#     i += 2
# print(total)

# 5번
sum = 0  # 총합을 저장할 변수
sign = -1  # 부호를 번갈아 바꾸기 위한 변수 (-1부터 시작)

# 1부터 99까지 2씩 증가하며 반복 (1, 3, 5, 7, ..., 99)
for i in range(1, 100, 2):
    # 숫자와 현재 부호를 곱해서 더함
    value = i * sign
    sum += value

    # 다음 숫자를 위해 부호를 반전 (-1 -> 1 -> -1 -> 1 ...)
    sign *= -1

# 최종 결과 출력
print(f"수열의 총합: {sum}")





        
