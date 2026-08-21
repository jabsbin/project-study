# 정규 표현식 : 텍스트 문자를 쉽게 처리하는 방법
import re # 정규표현식 지원 모듈 로딩

ss = "1234 abc가나다abcABC_1234555실습중78입니다_6'python is fun"
print(ss)
# re.findall(패턴, 대상문자열)
print(re.findall(r'123', ss)) # ['123', '123']
print(re.findall(r'가나', ss))
print(re.findall(r'[0 1 3]', ss))
print(re.findall(r'[0-9]+', ss)) # +: 0개 이상 연속적으로 붙어있는거 
print(re.findall(r'[0-9]{2}', ss)) # 2개 이상 붙어있는거 출력
print(re.findall(r'[0-9]{2,3}', ss)) # 2개이상 3개 이하





print(re.findall(r'[ab]', ss)) # ab만 찾는 것
print(re.findall(r'[a-zA-Z]', ss))
print(re.findall(r'[a-zA-Z]+', ss))
print(re.findall(r'[가-힣]+', ss)) # ss에서 한글만 보고싶은 경우

print(re.findall(r'\d', ss))  # 모든숫자
print(re.findall(r'\d+', ss))
print(re.findall(r'\D+', ss)) # \d 반대 (숫자가 아닌 것)

print(re.findall(r'\s', ss)) # 공백, 탭 문자와 맵핑
print(re.findall(r'\s+', ss))
print(re.findall(r'\S+', ss))

#......