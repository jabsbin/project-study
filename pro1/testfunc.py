# 1번
def inputfunc():
    datas = [
        [1, "강나루", 1500000, 2010],
        [2, "이바다", 2200000, 2018],
        [3, "박하늘", 3200000, 2005],
    ]
    return datas

def processfunc(datas):
    print('사번\t 이름\t 기본급 근무년수 근속수당 공제액 수령액')
    print('-------------------------------------------------------------------------------')

    # 년도를 자동으로 받는거 참고하기.

    for data in datas:
        sabun = data[0]
        name = data[1]
        basics = data[2]
        years = data[3]

        workyears = 2026 - years
        if workyears >= 9:
            sudang = 1000000
        elif workyears >= 4:
            sudang = 450000
        else:
            sudang = 150000

        money = basics + sudang

        if money >= 3000000:
            gong = money * 0.5
        elif money >= 2000000:
            gong = money * 0.3
        else:
            gong = money * 0.15

        finalpay = money - gong
        print(f'{sabun}\t{name}\t{basics}\t{workyears}\t{sudang}\t{int(gong)}\t{int(finalpay)}')
    print(f'처리 건수 : {len(datas)}건')

datas = inputfunc()
processfunc(datas)