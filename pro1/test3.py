# 기본 자료형 : int, float, bool, complex
# 묶음 자료형 : str, tuple, list, dict, set

# str : 문자열 저장 단위, 순서 O, 수정 X
s = "sequence"
print("길이(크기)", len(s)) # len 함수
print("포함 횟수 : ", s.count('e'))
print('검색 위치 : ', s.find('e'), s.find('e', 3), s.rfind('e')) #rfind : rightfind(오른 쪽 인덱스부터 왼쪽으로 e위치 찾아 알려줌)
print('첫글자 유무 : ', s.startswith('s'), s.startswith('a'))

print()
ss = "mbc"
print(ss, id(ss))
ss = "abc"
print(ss, id(ss))
# ss에 mbc의 주소를 기억하고 있다가 abc라는 새로운 객체를 따로 또 저장하여 해당하는 주소를 가져와 출력.

print('인덱싱 / 슬라이싱')
print(s[0], s[5], s[-1]) # s n e  <== 인덱싱
print(s[0:4], s[:4], s[-4:-1]) # sequ sequ enc <== 슬라이싱
print(s[::2], s[0:8:3], s[0:len(s):1])

print("*" *10)
# List : 다양한 종류의 자료 묶음형. 순서 o, 중복 o, 수정 o
a = [1, 2, 3] # [다양한 종류의 데이터가 들어올 수 있음]
print(a, a[0], a[0:2])
b = [10, a, 10, 20.5, True, '문자열']
print(b, b[0], b[1], b[1][1]) #b[1][1], b[1]에서의 첫 번째 인덱스 값 의미
print()

family = ['엄마', '아빠', '나', '여동생']
print(family, id(family))
family.append('남동생')
print(family, id(family))
# 리스트는 수정이 가능해서 남동생을 추가해도 주소가 똑같다.
family.remove('나') #삭제
print(family)
family.insert(0, '할머니') # 0 번 째에 할머니 삽입
print(family)
family.extend(['삼촌','고모','조카'])
print(family)
family += ['이모'] # 추가
print(family)

family.remove('아빠') #값에 의한 삭제
del family[2] #순서에 의한 삭제
print(family)

print()
kbs = ['123', '34', '234'] # 문자열
kbs.sort() #문자열 정렬
print(kbs) # ['123', '234', '34']

mbc = [123, 34, 234] # 숫자
mbc.sort() # 오름차순(ascending)
mbc.sort(reverse=True)  #내림차순(descending)
print(mbc) #[234, 123, 34]

sbs = [123, 34, 234]
ytn = sorted(sbs) # sorted 한 다음에 sbs하면 원본은 유지되고 값이 바뀐걸 ytn에 전달.
print(ytn)
print(sbs)

print("*" * 10)
# tuple : 리스트와 유사. 읽기 전용 - 수정X
t = (1, 2, 3, 4) #(다양한 종류의 데이터)
t = 1, 2, 3, 4 # 위와 동일
print(t, type(t)) #(1, 2, 3, 4) <class 'tuple'>

k = (1,) # 데이터 값이 하나일 경우 튜플로 되려면 콤마 필수
print(k, type(k))

print(t[0], t[1:3])
#t[0] = 9 #튜플은 치환 불가 수정이 안되기 때문에, 그래서 중요한 데이터는 튜플로 저장하면 보호 가능하다.

# 튜플 값 수정시 리스트로 형변환 가능
imsi = list(t) # type 형변환
print(type(imsi))
imsi[0] = 9
t = tuple(imsi)
print(t, type(t))

print("--" * 10)
# set : 순서 X, 중복 X, 수정 O
ss = {1, 2, 3, 2}
print(ss, type(ss)) #{1, 2, 3} <class 'set'>
# set은 중복 데이터를 지울 때 사용하면 좋음
ss2 = {3, 4}
print(ss.union(ss2)) #합집합 {1, 2, 3, 4}
print(ss.intersection(ss2)) # 교집합 {3}
print(ss - ss2, ss | ss2, ss & ss2) # 차, 합 ,교집합 {1, 2} {1, 2, 3, 4} {3}

ss.update({6,7})
print(ss)
ss.discard(7) # 값 삭제
ss.discard(7) # 값 삭제: 해당 값 없으면 통과
ss.remove(6) # 값 삭제
#ss.remove(6) # 값 삭제 시 해당 값 없으면 에러

li = ['aa', 'aa', 'bb', 'cc', 'aa']
print(li)
imsi = set(li)
li = list(imsi)
print(li) # ['cc', 'aa', 'bb']

print("--" * 10)
#dict : 사전 자료형 {'키':값} 형태
#방법 1
mydic = dict(k1 = 1, k2 = 'ok', k3 = 1234)
print(mydic, type(mydic)) #{'k1': 1, 'k2': 'ok', 'k3': 1234} <class 'dict'>

# 방법 2
dic = {'파이썬':'뱀', '자바':'커피', '번호':123}
print(dic, type(dic))
print(len(dic))
print(dic['자바']) #키로 값을 검색
print(dic.get('자바')) #get 메소드 이용
#print(dic[0]) # 딕셔너리는 인덱싱 불가 왜냐하면 순서가 없기 때문에

dic['금요일'] = 'wow' # 추가
print(dic)

del dic['번호'] #삭제
print(dic.keys()) #dict_keys(['파이썬', '자바', '금요일'])
print(dic.values()) #dict_values(['뱀', '커피', 'wow'])

