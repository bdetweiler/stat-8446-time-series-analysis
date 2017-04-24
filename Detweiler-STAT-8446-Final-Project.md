Traffic Camera Violations in Chicago
========================================================
author: Brian Detweiler
date: April 24, 2017
autosize: true

The Data
========================================================





Interactive map: <http://bdetweiler.github.io/projects/chicago-traffic-cameras.html>

- City of Chicago traffic camera data: <https://data.cityofchicago.org/Transportation/Speed-Camera-Violations/hhkd-xvj4/>
- 150 cameras in the dataset
- Data range from 2014-07-01 to 2017-03-11


|     ADDRESS     | CAMERA.ID | VIOLATION.DATE | VIOLATIONS |
|:---------------:|:---------:|:--------------:|:----------:|
| 7738 S WESTERN  |  CHI065   |   2014-07-08   |     65     |
| 1111 N HUMBOLDT |  CHI010   |   2014-07-16   |     56     |
| 5520 S WESTERN  |  CHI069   |   2014-07-08   |     10     |
| 1111 N HUMBOLDT |  CHI010   |   2014-07-26   |    101     |
| 1111 N HUMBOLDT |  CHI010   |   2014-07-27   |     92     |
***
<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" style="display: block; margin: auto;" />

City-Level Data
========================================================

- Aggregate violations by date
- High level summary view of all violations in Chicago as Time Series

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Stationarity of First Difference
========================================================

- $\nabla Y_t$ results in constant mean over time
- Variance still quite large, and heteroskedastic in some places



- Augmented Dickey-Fuller test p-value $< 0.01$

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

ACF and PACF of First Difference
========================================================
<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />
- ACF is problematic, and appears to have some seasonal influences at $7t$

***

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />
- PACF is also problematic
- Difficult to pick a model based on these


arma.subsets()
========================================================

Suggests an ARIMA(7, 1, 10) given by the equation
$$
\begin{split}
  W_t &= \nabla Y_t = Y_t - Y_{t - 1} \\
  W_t &= \phi_1 W_{t - 1} + \phi_7 W_{t - 7} + e_t - \theta_{1} e_{1} - \theta_6 e_{t - 6} - \theta_7 e_{t - 7} - \theta_8 e_{t - 8} - \theta_{10} e_{t - 10} \\
\end{split}
$$

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />



Model Diagnostics
========================================================

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />
<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />

- AIC: 15246.82

***

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-13-1.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" style="display: block; margin: auto;" /><img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-13-2.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" style="display: block; margin: auto;" />

- Shapiro-Wilk test p-value  << 0.001
- Ljung-Box test p-value > 0.95 
  - Indepenent


Forecast
========================================================
<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" style="display: block; margin: auto;" />

auto.arima()
========================================================

Suggests an ARIMA(1, 1, 3) given by the equation
$$
\begin{split}
  W_t &= \nabla Y_t = Y_t - Y_{t - 1} \\
  W_t &= \phi_1 W_{t - 1} + e_t - \theta_{1} e_{1} - \theta_2 e_{t - 2} - \theta_3 e_{t - 3} \\
\end{split}
$$

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" style="display: block; margin: auto;" />


Model Diagnostics
========================================================

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-16-1.png" title="plot of chunk unnamed-chunk-16" alt="plot of chunk unnamed-chunk-16" style="display: block; margin: auto;" />

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-17-1.png" title="plot of chunk unnamed-chunk-17" alt="plot of chunk unnamed-chunk-17" style="display: block; margin: auto;" />

- AIC: 15331.86

***

<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-18-1.png" title="plot of chunk unnamed-chunk-18" alt="plot of chunk unnamed-chunk-18" style="display: block; margin: auto;" /><img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-18-2.png" title="plot of chunk unnamed-chunk-18" alt="plot of chunk unnamed-chunk-18" style="display: block; margin: auto;" />

- Shapiro-Wilk test p-value  << 0.001
- Ljung-Box test p-value > 0.95 
  - Indepenent


Forecast
========================================================
<img src="Detweiler-STAT-8446-Final-Project-figure/unnamed-chunk-19-1.png" title="plot of chunk unnamed-chunk-19" alt="plot of chunk unnamed-chunk-19" style="display: block; margin: auto;" />


Conclusion
========================================================

- Data difficult to fit due to high day-to-day variance
- Addative Outliers present possibly due to weather (snow)
- Both models have i.i.d. normal residuals - Model 2 contains autocorrelation
- Model 1 has lower AIC
- Model 2 has more realistic prediction limits
