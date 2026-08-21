#2번
def inputfunc():
    datas = [
        "새우깡,15",
        "감자깡,20",
        "양파깡,10",
        "새우깡,30",
        "감자깡,25",
        "양파깡,40",
        "새우깡,40",
        "감자깡,10",
        "양파깡,35",
        "새우깡,50",
        "감자깡,60",
        "양파깡,20",
    ]
    return datas

def processfunc(datas):
    print(f'출력 형태:')
    print(f'\n상품명 수량 단가 금액')
    print('-----------------------------------')

    saewu , saewutot = 0, 0
    gamja , gamjatot = 0, 0
    onion , oniontot = 0, 0

    for gang in datas:
        name, count = gang.split(",")
        count = int(count)

        if name == "새우깡":
            price = 450
            tot = count * price
            saewu += count
            saewutot += tot

        elif name == "감자깡":
            price = 300
            tot = count * price
            gamja += count
            gamjatot += tot

        elif name == "양파깡":
            price = 350
            tot = count * price
            onion += count
            oniontot += tot

        print(f'{name} {count} {price} {tot}')

    totcount = saewu + gamja + onion
    totprice = saewutot + gamjatot + oniontot

    print('\n소계')
    print(f'새우깡 : {saewu}건  소계액:{saewutot}')
    print(f'감자깡 : {gamja}건  소계액:{gamjatot}')
    print(f'양파깡 : {onion}건  소계액:{oniontot}')

    print('\n총계')
    print(f'총 건수 :{totcount}')
    print(f'총 액 : {totprice}')

datas = inputfunc()
processfunc(datas)
