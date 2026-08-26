
try:
    with open('sales.txt', mode='r', encoding='utf-8') as reads:
        print(reads.read())

        print(f'날짜')



except Exception as e:
    print("error : ", e)