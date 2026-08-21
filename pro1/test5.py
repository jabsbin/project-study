# 조건 판단문 if
var = 1

if var >= 3: # 조건문은 True False 나와야 하니까 비교연산자 사용
    print('크네') 
    print('흠 크쿤') # 조건이 참이면 블럭 안의 문장을 수행

print('끝')

print()

if var >= 3:
    print('크구나')
else:
    print('작구나')
print('끝')

print()
money = 700
age = 55

if money >= 500:
    item = "사과"
    if age <= 30:
        msg = '참 참'
    else:
        msg = "참 거짓"
else:
    item = "복숭아"
    if age >= 20:
        msg = "거짓 참"
    else:
        msg = "거짓 거짓"

print(f"중복 if 수행 후 결과 : {item} {msg}")

print("끝")

print()
# data = input('점수입력 :') # 키보드로 숫자 입력해서 문자열로 입력한걸로 됨.
# print(int(data), type(int(data))) # 위 말 때문에 int로 형변환 해줌
# print(int(data) + 5)

jumsu = int(input('점수 입력:'))
print(jumsu)
if jumsu >= 90:
    print('우수')
elif jumsu >= 80: #else  와 if 합쳐서 elif 가능
        print('보통')
else:
    print('저조')

jum = 80
if 90 <= jum <= 100:
    print('A')
elif 70 <= jum < 90:
    print('B')
else:
    print('C')

print('---------')
names = ['홍길동', '신기해', '이기자']
if '홍길동' in names:
    print('친구 이름이야')
else:
    print('누구야')

if (count := len(names)) >= 3:
    print(f'인원수가 {count}명 이므로 단체 할인 적용') #count 매핑
else:
    print('ㅠㅠ')

scores = [95, 88, 76, 92, 81]
if(avg := sum(scores) / len(scores)) >= 80:
    print(f'우수반 평균점수 : {avg}')

print('삼항연산')
a = 'kbs'
# if a == 'kbs':
#     b = 9
# else:
#     b = 11
b = 9 if a == 'kbs' else 11 # 위 주석처리한걸 줄인 것.
print('b : ', b)

a = 11
b = 'mbc' if a == 9 else 'kbs'
print('b : ', b)

a = 3
print(0 if a<5 else 1 if a<10 else 2) # 권장 X 너무 복잡해짐.

print("끝")
