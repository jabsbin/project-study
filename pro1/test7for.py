# 반복문 for
# for target in object:
#     statement....

# for i in [1,2,3,4,5]: # 0번 째 부터 i 값을 순서대로 찍음.
# for i in (1,2,3,4,5):
# for i in {1,2,3,4,5,5,5,5,5,5}: # 중복 값은 하나만 출력
aa = {1,2,3,4,5,5,5,5,5,5}
for i in aa:
    #pass # pass 이용시 아무것도 수행안함
    print(i, end = ' ')

# 편차 제곱합의 평균 : 분산 / 분산에 루트 씌워주면 표준편차
print('분산/표준편차 ---')
numbers = [1,3,5,7,9] #합은 25, 평균은 5.0
# numbers = [3,4,5,6,7] #합은 25, 평균은 5.0
# numbers = [-3,4,5,7,12] #합은 25, 평균은 5.0

tot = 0
for a in numbers:
    tot += a

print(f"합은 {tot}, 평균은 {tot/ len(numbers)}")

avg = tot / len(numbers)

#편차의 합 
hap = 0
for i in numbers:
    hap += (i - avg) ** 2
print(f"편차 제곱의 합 : {hap}")
vari = hap / len(numbers)
print(f'분산은 {vari}')
print(f'표준편차는 {vari ** 0.5}')

print()
colors = ['빨강', '초록', '파랑']
for v in colors:
    print(v, end = " ")

print()
print('iter() : 반복 가능한 객체를 하나씩 꺼낼 수 있는 상태로 만들어 주는 함수')
iterator = iter(colors)
for v in iterator:
    print(v, end = ' ')

print()
for idx, d in enumerate(colors, start=0): # enumerate는 인덱스와 값을 반환해줌
    print(idx, ' ', d)

print('\n사전형 ---')
datas = {'python' : '만능언어', 'java':'웹용언어','mariadb':'RDBMS'}
print(datas.items()) # [('python', '만능언어'), ... ] (리스트, 튜플은 순서가 있다.)
for i in datas.items():
    # print(i[0]) # 키 값만 나온다.
    print(i[0], '~~~', i[1]) #python ~~~ 만능언어 ...

for k, v in datas.items():
    print(k, '~~', v)

for k in datas.keys():
    print(k, end = ' ') # python java mariadb

print()
for v in datas.values():
    print(v, end = ' ') # 만능언어 웹용언어 RDBMS 
print()

print('\n다중 for -----')
for n in [2, 3]:
    print(f'{n}단 ~~~ ')
    for su in [1,2,3,4,5,6,7,8,9]:
        print(f'{n} * {su} = {n * su}')

print('\nfor : continue, break -----')
nums = [1,2,3,4,5]
for i in nums:
    if i == 2: continue # 2 경우엔 루트로 이동.
    if i == 4: break # 4 경우엔 탈출.
    print(i, end = ' ')
else:
    print('정상종료 :')

print('\n\n정규표현식 + for문 연습 ---')
message = """
17일(현지시간) 트럼프 대통령은 백악관에서 취재진과 만나 최근 이 대통령과 통화한 사실을 공개 abc & * $ # @
"""

import re
message2 = re.sub(r'[^가-힣\s]', '', message)  # 페턴과 일치하는 문자열을 다른 문자열로 치환
print(message2)
message3 = message2.split(' ') # 공백 기준 문자열 분리
print(message3, ' ', len(message3)) 
# 단어별 빈도수 출력 : dict 사용
cou = {}
for i in message3:
    if i in cou:
        cou[i] += 1 #같은 단어가 있으면 누적
    else:
        cou[i] = 1 # 최초 단어일 경우 '단어': 1

print(cou) #{'\n일현지시간': 1, '트럼프': 1, '대통령은': 1, '백악관에서': 1, '취재진과': 1, '만나': 1, '최근': 1, '이': 1, '대통령과': 1, '통화한': 1, '사실을': 1, '공개': 1, '': 5, '\n': 1}

print('정규 표현식 좀 더 ...')
for imsi in ['111-1234','일이삼-일이삼사','222-1234','333&1234']:
    if re.match(r'^\d{3}-\d{4}$', imsi): # \d = [0-9]+ 의미와 같음./ ^ : 시작 / $ : 끝 의미
        print(imsi, '전화번호 맞네')
    else:
        print(imsi, '전화번호 아니야')

print('\ncomprehension : 반복문 + 조건문 + 값 생성을 한 줄로 표현')
a = [1,2,3,4,5,6,7,8,9,10]
li = []
for i in a:
    if i % 2 == 0:
        li.append(i)
print(li)  # [2, 4, 6, 8, 10]

print(list(i for i in a if i % 2 == 0)) # [2, 4, 6, 8, 10]
# i를 a에서 뽑고 i가 짝수 일 경우 리스트로 출력

print()
datas = [1, 2, 'a', True, 3.0]
li2 = [i for i in datas if type(i) == int] # i를 datas에서 뽑고 정수일 경우 리스트로 출력
print(li2)

print()
id_name = {1:'tom', 2:'james'}
name_id = { val:key for key, val in id_name.items()} # dict는 중괄호
print(name_id) # {'tom': 1, 'james': 2}

print()
aa = [(1,2),(3,4),(5,6)]
for a, b in aa:
    print(a + b)

#print([a + b for a, b in aa]) #[3, 7, 11]
print(*[a + b for a, b in aa], sep='\n') # 앞에 *을 붙이면 unpack이 된다.

print('\n수열 생성 : range(start, stop, step)')
print(list(range(1, 6))) # [1, 2, 3, 4, 5]
print(list(range(1, 6, 1)))
print(list(range(1, 6, 2))) # [1, 3, 5]
print(tuple(range(1, 6, 2))) # (1, 3, 5)
print(set(range(1, 6, 2))) # {1, 3, 5}
print(set(range(6))) #{0, 1, 2, 3, 4, 5}
print(list(range(-10, -100, -20)))
print()

for i in range(6):
    print(i, end = ", ")

print()
for _ in range(6):
    print('반복')

print('1 ~ 10까지 정수 합')
tot = 0
for i in range(1, 11):
    tot += i

print('tot : ', tot, ' ', sum(range(1, 11))) #sum() 내장함수

for i in range(1, 10):
    print(f'2 * {i} = {2 * i}')

print('2 ~ 9 구구단 출력 (단은 행단위 출력)')
for i in range(2, 10):
    for j in range(1, 10):
        print(f'{i}*{j} = {i * j}', end=' ')
    print()

print('주사위를 두 번 던져 나온 숫자들의 합이 4의 배수가 되는 경우만 출력')
for i in range(6):
    n1 = i + 1
    for j in range(6):
        n2 = j + 1
        n = n1 + n2
        if n % 4 == 0:
            print(n1, n2)

print()
for i in range(1, 7, 1):
    for j in range(1, 7):
        hap = i + j
        if hap % 4 == 0:
            print(i, j)