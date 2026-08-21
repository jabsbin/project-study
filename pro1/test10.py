# 매개변수 유형
# 위치 매개변수 : 인수와 순서대로 대응
# 기본값 매개변수 : 매개변수에 입력값이 없으면 기본값 사용
# 키워드 매개변수 : 실인수와 가인수 간 동일 이름으로 대응
# 가변 매개변수 : 인수의 갯수가 동적인 경우

def showGugu(start, end=5):
    for dan in range(start, end + 1, 1):
        print(str(dan) + '단 출력')
        for i in range(1, 10):
            print(f'{dan} * {i} = {dan * i}', end = ' ')
        print()

showGugu(2, 3) # start와 end에 매핑. (위치 매개변수)
print()
showGugu(2) # end는 기본값 매개변수 적용
print()
showGugu(start=7, end=9) # 키워드 매개변수
print()
showGugu(start=9, end=7) # 순서가 아닌 이름에 의한 매핑
print()
showGugu(7, end=9)
#showGugu(start=7, 9) #SyntaxError: positional argument follows keyword argument
#showGugu(end=9, 7) #SyntaxError: positional argument follows keyword argument
# 위치 인자는 항상 키워드 인자 보다 앞에 와야한다. 

print('가변 매개변수 ---')
def func1(*ar):   #def func1(ar): 를 * 추가해 바꿔줌으로 여러 개의 인자를 tulpe로 묶어서 받겠다는 의미
    print(ar)
    for i in ar:
        print('밥 : ' + i)


func1('김밥') #밥 : 김밥
func1('김밥', '비빔밥') # 하나만 받는다고 했는데 두 개 받아서 오류인데 *ar로 문제해결.

print()
def func2(a, *ar):
# def func2(*ar, a): #TypeError: func2() missing 1 required keyword-only argument: 'a'
    print(a)
    print(ar)

func2('김밥')
func2('김밥', '비빔밥', '공기밥', '주먹밥') # 김밥은 a로 출력 나머지는 튜플로 ar에 출력됨

print()
def func3(w, h, **other): # (**을 쓰면 dict를 의미한다.)
    print(f'몸무게:{w}, 키:{h}')
    print(f'기타: {other}')

func3(80, 180, irum='신기해', nai=33)
# 몸무게:80, 키:180
# 기타: {'irum': '신기해', 'nai': 33}

# func3(80, 180, 'irum'='신기해', 'nai'=33) # err

print()
def func4(a, b,*c, **d):
    print(a, b)
    print(c)
    print(d)

func4(1, 2)
func4(1, 2, 3, 4, 5)
func4(1, 2, 3, 4, 5, kbs=9, mbc=11)

print()
# type hint : 함수의 인자와 반환 값에 type을 적어 가독성 향상
# type에 대한 강제성을 없다.
def typeFunc(num:int, data:list[str]): # -> dict[str, int]:
    # num은 정수로 data는 리스트로 리스트는 스트링으로 (권장).
    print(num)
    print(data)
    result = {}
    for idx, item in enumerate(data, start=1):
        print(f'idx:{idx}, item:{item}')
        result[item] = idx

    return result

rdata = typeFunc(1, ['일', '이', '삼'])
print(rdata)
print()
rdata = typeFunc('한계', ['일', '이', '삼'])
print(rdata)