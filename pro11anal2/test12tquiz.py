from scipy import stats
import pandas as pd
import numpy as np

midterm = np.array([80, 75, 85, 50, 60, 75, 45, 70, 90, 95, 85, 80])
final = np.array([90, 70, 90, 65, 80, 85, 65, 75, 80, 90, 95, 95])

# 귀무 : 중간고사와 기말고사 성적의 차이가 없다.
# 대립 : 중간고사와 기말고사 성적의 차이가 있다.

# 정규성 검정
diff = final - midterm
shapiro_test = stats.shapiro(diff)
print(f"차이값의 정규성 검정 p-value: {shapiro_test.pvalue:.4f}")
# p 0.3011 > 0.05 정규성 만족

t_stat, p_val = stats.ttest_rel(midterm, final)

print(f"t-통계량: {t_stat:.4f}")
print(f"p-value: {p_val:.4f}")  # p-value: 0.0235

# 결론: p-value가 alpha(0.05)보다 작으므로 귀무가설을 기각
# 즉, 이 학급의 중간고사와 기말고사 성적 사이에는 유의한 차이가 있으며
# 기말고사 평균 성적이 중간고사보다 높다.