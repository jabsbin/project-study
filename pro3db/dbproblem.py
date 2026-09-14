# 문1) 직원번호와 직원명을 입력(로그인)하여 성공하면 아래의 내용 출력

 

# 직원번호 입력 : _______

# 직원명 입력 : _______

# 직원번호 직원명 부서명 부서전화 직급 성별

#     1         홍길동 총무부 111-1111 이사 남           <== 홍길동으로 로그인한 경우

# # 1번
# import MySQLdb
# import json

# from dotenv import load_dotenv
# import os

# load_dotenv()

# config = {
#     'host':os.getenv('DB_HOST'),
#     'user':os.getenv('DB_USER'),
#     'password':os.getenv('DB_PASSWORD'),
#     'database':os.getenv('DB_NAME'),
#     'port': int(os.getenv('DB_PORT')),  # port는 숫자 처리
#     'charset':os.getenv('DB_CHARSET')
# }


# def LoginFunc():
#     try:
#         conn = None
#         conn = MySQLdb.connect(**config)
#         cursor = conn.cursor()
#         jikwon_no = input("직원번호 : ")
#         jikwon_name = input("직원명 : ")
#         if jikwon_no == "" or jikwon_name == "":
#             print("로그인 정보를 입력하세요")
#             return
#         sql = """
#                     select j.jikwonno as 직원번호, j.jikwonname as 직원명,
#                     b.busername as 부서명, b.busertel as 부서전화, j.jikwonjik as 직급, j.jikwongen as 성별
#                     from jikwon j
#                     left outer join buser b on j.busernum = b.buserno
#                     where jikwonno=%s and jikwonname=%s
#                 """

#         # sql 실행
#         cursor.execute(sql, (jikwon_no,jikwon_name))

#         # 로그인 성공 직원 정보 출력 (한명)
#         data = cursor.fetchone()

#         if data:
#             print("직원번호", "직원명", "부서명", "부서전화", "직급", "성별")
#             print(data[0], data[1], data[2], data[3], data[4], data[5])
            
#         else:
#             print("로그인 실패 : 입력자료 확인하세요")


        
#     except Exception as e:
#         print('에러 : ', e)
#     finally:
#         if conn:
#             conn.close()

# if __name__== "__main__":
#     LoginFunc()



# 문1-1) 직원번호와 직원명을 입력(로그인)하여 성공하면 아래의 내용 출력

# 해당 직원이 근무하는 부서 내의 직원 전부를 직급별 오름차순우로 출력. 직급이 같으면 이름별 오름차순한다.

 

# 직원번호 입력 : _______

# 직원명 입력 : _______

# 직원번호 직원명 부서명 부서전화 직급 성별

# 1 홍길동 총무부 111-1111 이사 남

# ...

# 직원 수 :

 

# 이어서 로그인한 해당 직원이 관리하는 고객 자료도 출력한다.

# 고객번호 고객명 고객전화 나이

# 1 사오정 555-5555 34

# 관리 고객 수 :

# 1-1번

# MariaDB : jikwon, buser, gogek table
# import MySQLdb
# import json
# from dotenv import load_dotenv
# import os

# load_dotenv()

# config = {
#     'host': os.getenv('DB_HOST'),
#     'user': os.getenv('DB_USER'),
#     'password': os.getenv('DB_PASSWORD'),
#     'database': os.getenv('DB_NAME'),
#     'port': int(os.getenv('DB_PORT')),  # port는 숫자 처리
#     'charset': os.getenv('DB_CHARSET')
# }


# def LoginFunc():
#     conn = None
#     try:
#         conn = MySQLdb.connect(**config)
#         cursor = conn.cursor()
        
#         jikwon_no = input("직원번호 입력 : ")
#         jikwon_name = input("직원명 입력 : ")
        
#         if jikwon_no == "" or jikwon_name == "":
#             print("로그인 정보를 입력하세요")
#             return

#         # 1. 로그인 쿼리
#         sql = """
#                     select j.jikwonno as 직원번호, j.jikwonname as 직원명,
#                     b.busername as 부서명, b.busertel as 부서전화, j.jikwonjik as 직급, j.jikwongen as 성별,
#                     j.busernum
#                     from jikwon j
#                     left outer join buser b on j.busernum = b.buserno
#                     where jikwonno=%s and jikwonname=%s
#                 """

#         # sql 실행
#         cursor.execute(sql, (jikwon_no, jikwon_name))

#         # 로그인 성공 직원 정보 출력 (한명)
#         data = cursor.fetchone()

#         if data:
#             buser_no = data[6]
            
#             # 2. 같은 부서 직원 목록 조회 쿼리 (직급별 오름차순, 직급 같으면 이름별 오름차순)
#             sub_sql = """
#                 select jikwonno, jikwonname, busername, busertel, jikwonjik, jikwongen
#                 from jikwon
#                 left outer join buser on busernum = buserno
#                 where busernum = %s
#                 order by jikwonjik asc, jikwonname asc
#             """
#             cursor.execute(sub_sql, (buser_no,))
#             buser_members = cursor.fetchall()

#             # 출력 형태 맞추기
#             print("직원번호\t직원명\t부서명\t부서전화\t직급\t성별")
#             for member in buser_members:
#                 print(f"{member[0]}\t{member[1]}\t{member[2]}\t{member[3]}\t{member[4]}\t{member[5]}")
            
#             print(f"직원 수 : {len(buser_members)}명\n")

#             # 3. 관리 고객 조회 쿼리 (str -> str_to_date 수정, 컬럼명 gogekjumin 및 오타 수정)
#             gogek_sql = """
#                             select gogekno as 고객번호, gogekname as 고객명, gogektel as 고객전화,
#                             timestampdiff(year, str_to_date(substring(gogekjumin, 1, 6), '%%y%%m%%d'), now()) as 나이
#                             from gogek where gogekdamsano = %s
#                         """   
#             cursor.execute(gogek_sql, (jikwon_no,))
#             gogek_members = cursor.fetchall()       

#             print("고객번호\t고객명\t고객전화\t나이")

#             if gogek_members:
#                 for gogek in gogek_members:
#                     print(f"{gogek[0]}\t{gogek[1]}\t{gogek[2]}\t{gogek[3]}")
#                 print(f"관리 고객 수 : {len(gogek_members)}명")
#             else:
#                 print("담당하는 고객이 없습니다.")
#                 print("관리 고객 수 : 0명")
#         else:
#             print("로그인 실패 : 입력자료 확인하세요")

#     except Exception as e:
#         print('에러 : ', e)
#     finally:
#         if conn:
#             conn.close()

# if __name__ == "__main__":
#     LoginFunc()


# 문2) 성별 직원 현황 출력 : 성별(남/여) 단위로 직원 수와 평균 급여 출력

# ​

# 성별 직원수 평균급여

# 남 3 8500

# 여 2 7800

# 2번

# import MySQLdb
# import json

# from dotenv import load_dotenv
# import os

# load_dotenv()

# config = {
#     'host':os.getenv('DB_HOST'),
#     'user':os.getenv('DB_USER'),
#     'password':os.getenv('DB_PASSWORD'),
#     'database':os.getenv('DB_NAME'),
#     'port': int(os.getenv('DB_PORT')),  # port는 숫자 처리
#     'charset':os.getenv('DB_CHARSET')
# }


# def LoginFunc():
#     try:
#         conn = None
#         conn = MySQLdb.connect(**config)
#         cursor = conn.cursor()
        
#         sql = """
#                     select jikwongen as 성별, count(*) as 직원수,
#                     avg(jikwonpay) as 평균급여
#                     from jikwon j
#                     group by jikwongen
#                 """

#         # sql 실행
#         cursor.execute(sql)

#         # 로그인 성공 직원 정보 출력 (한명)
#         data = cursor.fetchall()

#         print("성별\t직원수\t평균급여")
#         for row in data:
#             gender = row[0]       # 남 또는 여
#             count = row[1]        # 직원 수
#             avg_pay = round(row[2]) # 평균 급여 (소수점 처리 필요시 round 사용)
            
#             print(f"{gender}\t{count}\t{avg_pay}")        


        
#     except Exception as e:
#         print('에러 : ', e)
#     finally:
#         if conn:
#             conn.close()

# if __name__== "__main__":
#     LoginFunc()




# 문3) 직원별 관리 고객 수 출력 (관리 고객이 없으면 출력에서 제외)
# ​
# 직원번호 직원명 관리 고객 수
# 1 홍길동 3
# 2 한송이 1

# MariaDB : jikwon, gogek table
import MySQLdb
import json
from dotenv import load_dotenv
import os

load_dotenv()

config = {
    'host': os.getenv('DB_HOST'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'database': os.getenv('DB_NAME'),
    'port': int(os.getenv('DB_PORT', 3306)),  # port는 숫자 처리
    'charset': os.getenv('DB_CHARSET')
}

def StaffGogekCountFunc():
    conn = None
    try:
        conn = MySQLdb.connect(**config)
        cursor = conn.cursor()

        # 직원별 관리 고객 수를 구하는 SQL (관리 고객이 없는 직원은 INNER JOIN으로 자연스럽게 제외)
        sql = """
            select j.jikwonno as 직원번호, j.jikwonname as 직원명, count(g.gogekno) as 관리고객수
            from jikwon j
            inner join gogek g on j.jikwonno = g.gogekdamsano
            group by j.jikwonno, j.jikwonname
            order by j.jikwonno asc
        """
        
        cursor.execute(sql)
        data = cursor.fetchall()

        print("직원번호 직원명 관리 고객 수")
        for row in data:
            jikwon_no = row[0]
            jikwon_name = row[1]
            gogek_count = row[2]
            
            print(f"{jikwon_no} {jikwon_name} {gogek_count}")

    except Exception as e:
        print('에러 : ', e)
    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    StaffGogekCountFunc()