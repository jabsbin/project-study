# 빵을 기름에 튀길 때 네 가지 기름의 종류에 따라 빵에 흡수된 기름의 양을 측정하였다.
# 기름의 종류에 따라 흡수하는 기름의 평균에 차이가 존재하는지를 분산분석을 통해 알아보자.
# 조건 : NaN이 들어 있는 행은 해당 칼럼의 평균값으로 대체하여 사용한다.
# 수집된 자료 :  
# kind quantity
# 1 64
# 2 72
# 3 68
# 4 77
# 2 56
# 1 NaN
# 3 95
# 4 78
# 2 55
# 1 91
# 2 63
# 3 49
# 4 70
# 1 80
# 2 90
# 1 33
# 1 44
# 3 55
# 4 66
# 2 77

# 귀무가설: 네 가지 기름의 평균 흡수량은 모두 같다.
# 대립가설: 적어도 한 종류의 기름은 평균 흡수량이 다르다.
# 유의수준: 0.05

import numpy as np
import pandas as pd
from scipy import stats
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm


data = pd.DataFrame({
    'kind': [1, 2, 3, 4, 2, 1, 3, 4, 2, 1,
            2, 3, 4, 1, 2, 1, 1, 3, 4, 2],
    'quantity': [64, 72, 68, 77, 56, np.nan, 95, 78, 55, 91,
                63, 49, 70, 80, 90, 33, 44, 55, 66, 77]
})

# 1. 결측값 처리: quantity 칼럼 전체 평균으로 대체 (그룹별 평균 아님)
print('대체 전 결측값 수:\n', data.isnull().sum())
quantity_mean = data['quantity'].mean()  # NaN을 제외한 평균
data['quantity'] = data['quantity'].fillna(quantity_mean)
print(f'결측값 대체 평균: {quantity_mean:.6f}')  # 67.526316
print(data)

# 2. 기름 종류별 자료 분리 및 평균 확인
gr1 = data.loc[data['kind'] == 1, 'quantity']
gr2 = data.loc[data['kind'] == 2, 'quantity']
gr3 = data.loc[data['kind'] == 3, 'quantity']
gr4 = data.loc[data['kind'] == 4, 'quantity']

print('\n기름 종류별 표본 수와 평균')
print(data.groupby('kind')['quantity'].agg(['count', 'mean']))

# 3. 정규성 확인: 각 그룹의 정규성 귀무가설을 검정
print('\n정규성 검정 (Shapiro-Wilk)')
print('기름 1 p-value:', stats.shapiro(gr1).pvalue)
print('기름 2 p-value:', stats.shapiro(gr2).pvalue)
print('기름 3 p-value:', stats.shapiro(gr3).pvalue)
print('기름 4 p-value:', stats.shapiro(gr4).pvalue)
# 모두 p > 0.05: 정규성 귀무가설을 기각하지 못함 (표본이 작음에 유의)

# 4. 등분산성 확인
print('\n등분산성 검정 (Levene)')
print('p-value:', stats.levene(gr1, gr2, gr3, gr4).pvalue)
# p = 0.326897 > 0.05: 등분산성 귀무가설을 기각하지 못함
# 관측값의 독립성은 실험 설계에서 확인해야 한다.

# 5. 일원분산분석 방법 1: f_oneway()
f_stat, p_value = stats.f_oneway(gr1, gr2, gr3, gr4)
print('\n일원분산분석 결과')
print(f'F 통계량: {f_stat:.6f}')  # 0.266935
print(f'p-value: {p_value:.6f}')  # 0.848244

# 일원분산분석 방법 2: OLS 모형으로 분산분석표 출력
# kind는 숫자로 표시된 범주형 변수이므로 C(kind)로 지정한다.
model = ols('quantity ~ C(kind)', data=data).fit()
print('\n분산분석표')
print(anova_lm(model, typ=1))

# 6. 결과 해석
alpha = 0.05
if p_value < alpha:
    print('\n귀무가설 기각: 기름 종류에 따라 평균 흡수량에 유의한 차이가 있다.')
else:
    print('\n귀무가설을 기각하지 못한다.')
    print('기름 종류에 따라 평균 흡수량이 다르다고 할 통계적 근거가 부족하다.')

# p = 0.848244 > 0.05이므로 유의한 평균 차이를 확인하지 못했다.
# 이는 네 종류의 평균이 같음을 증명한 것은 아니다.
# 평균 대체는 문제 조건에 따른 처리이며 자료의 변동성에 영향을 줄 수 있다.


