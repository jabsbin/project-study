# li = [1, 2, 2, 2, 3, 4, 5, 5, 5, 2, 2]
# im = set(li)
# li = list(im)
# print(li)

# count = 0
# count_sum = 0

# for i in range(1, 101):
#     if (i % 3 == 0 or i % 4 == 0) and i % 7 != 0:
#         print(i, end=" ")
#         count += 1
#         count_sum += i

# print(f'\n건수 :', count)
# print(f'총합 :', count_sum)

# print(5 / 3)
# print(5 // 3)
# print(5 % 4)

# a = 1.5; b = 2; c = 3;
# def kbs:

# a = 20
# b = 30
# def mbc():
#     global c
#     nonlocal b
#     print(‘mbc 내의 a:{}, b:{}, c:{}’.format(a, b, c))
#     c = 40
#     b = 50
#     mbc()
# kbs()

# def Hap(m, n):
#   return m + n * 5

# Hap = lambda x,y: x + y * 5

# i = 10
# while i > 0 :
#     print(' '* (10-i) + ('*' * i))
#     i -= 1

# i = 0
# while True:
#     if i % 10 != 3: 
#         i += 1
#         continue
    
#     if i > 100: break
#     print(i, end=' ')
#     i += 1


# class Gugudan:
#     def print_dan(self):

#         i=3

#         while i <= 9:
#             j = 1
#             if i % 2 != 0:

#                 while j < 10:
#                     print(f"{i}x{j}={i*j} ", end="")
#                     j += 1
#                 print()
#             i += 1

# gugu = Gugudan()
# gugu.print_dan()

class Bicycle:
    def __init__(self, name, wheel, price):
        self.name = name
        self.wheel = wheel
        self.price = price

    def display(self):
        tot_price = self.wheel * self.price
        print(f'{self.name}님 자전거 바퀴 가격 총액은 {tot_price}원 입니다')

gildong = Bicycle('길동', 2, 50000)
gildong.display()



            


    
        

