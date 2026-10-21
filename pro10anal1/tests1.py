import MySQLdb
import pandas as pd
import numpy as np
import sys

def main():
    CONFIG = {"host": "127.0.0.1", "user": "root", "passwd": "123", "db": "test", "port": 3306, "charset": "utf8" }

    sql = """
        SELECT jikwonno, jikwonpay 
        FROM jikwon 
        WHERE jikwonno NOT IN (SELECT DISTINCT gogekdamsano FROM gogek WHERE gogekdamsano IS NOT NULL)
    """

    try:
        db = MySQLdb.connect(**CONFIG)
        cursor = db.cursor()
        cursor.execute(sql)
        result = cursor.fetchall()
        df = pd.DataFrame(result, columns=['jikwonno', 'jikwonpay'])
    except Exception as e:
        print("err:", e)
        return
    finally:
        db.close()

    count = len(df)
    mean_pay = df['jikwonpay'].mean()
    std_pay = df['jikwonpay'].std()

    print(f"담당 고객이 없는 직원의 수: {count}")
    print(f"연봉 평균: {mean_pay}")
    print(f"표준편차: {std_pay}")

if __name__ == "__main__":
    main()