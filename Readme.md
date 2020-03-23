Workplan
--------

Overview Scoring Rules
----------------------

### Bias

should be around 0.5 (between -1 and 1 according to Gunnar, but that
seems just wrong)

### Sharpness

Median Absolute Deviation, i.e., the (lo-/hi-) median of the absolute
deviations from the median. Smaller is better.

### CRPS

generalisation of Brier score to continuous variables. Smaller is
better.

### LogS

**Advantage**: logarithmic Score penalises underestimating uncertainty
heavily. I feel this is what we want.

**Drawback**: In contrast to the CRPS, the computation of LogS requires
a predictive density. An estimatorcan be obtained with classical
nonparametric kernel density estimation (KDE, e.g. Silverman1986).
However, this estimator is valid only under stringent theoretical
assumptions and canbe fragile in practice: If the outcome falls into the
tails of the simulated forecast distribution,the estimated score may be
highly sensitive to the choice of the bandwidth tuning parameter.In an
MCMC context, a mixture-of-parameters estimator that utilizes a
simulated sampleof parameter draws rather than draws from the posterior
predictive distribution is a better

–&gt; especially problematic I think if we work with traces and only
small sample sizes?

**Question** do we now the posterior distribution of our draws?

### DSS

proper scoring rule that only depends on the first two moments. Smaller
is better.

![Correlation between different
metrics](results/plots/correlation_metrics_different_horizons.png)

Predictions over time horizons
------------------------------

### 1 day ahead

![1 day ahead
prediction](results/plots/forecasts_1_ahead_all_regions.png)

### 3 days ahead

![3 day ahead
prediction](results/plots/forecasts_3_ahead_all_regions.png)

### 7 days ahead

![7 day ahead
prediction](results/plots/forecasts_7_ahead_all_regions.png)

### 14 days ahead

![14 day ahead
prediction](results/plots/forecasts_14_ahead_all_regions.png)

### 21 days ahead

![21 day ahead
prediction](results/plots/forecasts_21_ahead_all_regions.png)

Scoring by metrics
------------------

### Bias

![median Bias across
time](results/plots/bias_median_across_regions_all_horizons.png)

![Bias across different time
horizons](results/plots/biasacross_regions_all_horizons.png)

![Bias across different time
horizons](results/plots/biasBias_violin_across_regions_different_horizons.png)

### CRPS

![median CRPS across
time](results/plots/crps_median_across_regions_all_horizons.png)

![CRPS across different time
horizons](results/plots/crpsacross_regions_all_horizons.png)

### logS

![median LogS across
time](results/plots/logs_median_across_regions_all_horizons.png)

![LogS across different time
horizons](results/plots/logsacross_regions_all_horizons.png)

### DSS

![median DSS across
time](results/plots/dss_median_across_regions_all_horizons.png)

![DSS across different time
horizons](results/plots/dssacross_regions_all_horizons.png)

### Sharpness

![median Sharpness across
time](results/plots/sharpness_median_across_regions_all_horizons.png)

![Sharpness across different time
horizons](results/plots/sharpnessacross_regions_all_horizons.png)

Scoring by days
---------------

### 1 day ahead

##### **Conclusion**

Across the bench, Sparse AR seems the most reasonable (little bias, ok
DSS and LogS)

AR1 seems to be very unconfident (and therefore performs well on LogS)
AR1 seems to be downward biased.

![Bias across models 1 day
ahead](results/plots/bias_across_regions_1_day_ahead_forecasts.png)

![CRPS across models 1 day
ahead](results/plots/crps_across_regions_1_day_ahead_forecasts.png)

![LogS across models 1 day
ahead](results/plots/logs_across_regions_1_day_ahead_forecasts.png)

![DSS across models 1 day
ahead](results/plots/dss_across_regions_1_day_ahead_forecasts.png)

![Sharpness across models 1 day
ahead](results/plots/sharpness_across_regions_1_day_ahead_forecasts.png)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">horizon</th>
<th style="text-align: left;">score</th>
<th style="text-align: left;">model</th>
<th style="text-align: right;">bottom</th>
<th style="text-align: right;">lower</th>
<th style="text-align: right;">median</th>
<th style="text-align: right;">mean</th>
<th style="text-align: right;">upper</th>
<th style="text-align: right;">top</th>
<th style="text-align: right;">sd</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0080000</td>
<td style="text-align: right;">0.1860000</td>
<td style="text-align: right;">0.3905000</td>
<td style="text-align: right;">0.4197689</td>
<td style="text-align: right;">0.6250000</td>
<td style="text-align: right;">0.9595000</td>
<td style="text-align: right;">0.2772750</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0120000</td>
<td style="text-align: right;">0.2722500</td>
<td style="text-align: right;">0.4800000</td>
<td style="text-align: right;">0.4836653</td>
<td style="text-align: right;">0.6907500</td>
<td style="text-align: right;">0.9934750</td>
<td style="text-align: right;">0.2745576</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0140500</td>
<td style="text-align: right;">0.2732500</td>
<td style="text-align: right;">0.4415000</td>
<td style="text-align: right;">0.4432570</td>
<td style="text-align: right;">0.6007500</td>
<td style="text-align: right;">0.9489500</td>
<td style="text-align: right;">0.2455554</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0120000</td>
<td style="text-align: right;">0.2452500</td>
<td style="text-align: right;">0.4660000</td>
<td style="text-align: right;">0.4862390</td>
<td style="text-align: right;">0.7400000</td>
<td style="text-align: right;">0.9889500</td>
<td style="text-align: right;">0.2895952</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0101867</td>
<td style="text-align: right;">0.0292209</td>
<td style="text-align: right;">0.0496502</td>
<td style="text-align: right;">0.0804964</td>
<td style="text-align: right;">0.0908336</td>
<td style="text-align: right;">0.3520052</td>
<td style="text-align: right;">0.0970162</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0092356</td>
<td style="text-align: right;">0.0186063</td>
<td style="text-align: right;">0.0307310</td>
<td style="text-align: right;">0.0589323</td>
<td style="text-align: right;">0.0637748</td>
<td style="text-align: right;">0.2901038</td>
<td style="text-align: right;">0.0791821</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0103291</td>
<td style="text-align: right;">0.0246476</td>
<td style="text-align: right;">0.0372596</td>
<td style="text-align: right;">0.0660410</td>
<td style="text-align: right;">0.0766843</td>
<td style="text-align: right;">0.3237791</td>
<td style="text-align: right;">0.0816737</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0077607</td>
<td style="text-align: right;">0.0161175</td>
<td style="text-align: right;">0.0285822</td>
<td style="text-align: right;">0.0581726</td>
<td style="text-align: right;">0.0657830</td>
<td style="text-align: right;">0.2963876</td>
<td style="text-align: right;">0.0783066</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-6.4081542</td>
<td style="text-align: right;">-4.3556485</td>
<td style="text-align: right;">-3.1301046</td>
<td style="text-align: right;">-2.8061977</td>
<td style="text-align: right;">-2.0187648</td>
<td style="text-align: right;">2.4022130</td>
<td style="text-align: right;">3.5155217</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-6.6064909</td>
<td style="text-align: right;">-5.4001019</td>
<td style="text-align: right;">-4.4365827</td>
<td style="text-align: right;">-3.4039877</td>
<td style="text-align: right;">-3.0640898</td>
<td style="text-align: right;">5.6251181</td>
<td style="text-align: right;">5.5025561</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-6.3403357</td>
<td style="text-align: right;">-4.6895059</td>
<td style="text-align: right;">-3.9733682</td>
<td style="text-align: right;">-3.2789461</td>
<td style="text-align: right;">-2.3513212</td>
<td style="text-align: right;">2.0815847</td>
<td style="text-align: right;">3.5105402</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-6.7544456</td>
<td style="text-align: right;">-5.4803737</td>
<td style="text-align: right;">-4.4320114</td>
<td style="text-align: right;">-3.3146278</td>
<td style="text-align: right;">-2.8404630</td>
<td style="text-align: right;">4.7867443</td>
<td style="text-align: right;">5.9490699</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-2.3516078</td>
<td style="text-align: right;">-1.3373002</td>
<td style="text-align: right;">-0.8712790</td>
<td style="text-align: right;">-0.5973268</td>
<td style="text-align: right;">-0.2245719</td>
<td style="text-align: right;">2.6490532</td>
<td style="text-align: right;">1.8376894</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-2.4011705</td>
<td style="text-align: right;">-1.7499162</td>
<td style="text-align: right;">-1.3185821</td>
<td style="text-align: right;">-0.0632782</td>
<td style="text-align: right;">-0.5770308</td>
<td style="text-align: right;">2.6046985</td>
<td style="text-align: right;">10.6262543</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-2.2742154</td>
<td style="text-align: right;">-1.4547978</td>
<td style="text-align: right;">-1.0760557</td>
<td style="text-align: right;">-0.4869469</td>
<td style="text-align: right;">-0.3510247</td>
<td style="text-align: right;">2.1962172</td>
<td style="text-align: right;">6.6138710</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-2.5637118</td>
<td style="text-align: right;">-1.9861798</td>
<td style="text-align: right;">-1.4052472</td>
<td style="text-align: right;">-0.0809180</td>
<td style="text-align: right;">-0.5353133</td>
<td style="text-align: right;">3.1767137</td>
<td style="text-align: right;">11.1970500</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0270395</td>
<td style="text-align: right;">0.0730474</td>
<td style="text-align: right;">0.1076575</td>
<td style="text-align: right;">0.1362156</td>
<td style="text-align: right;">0.1715399</td>
<td style="text-align: right;">0.4037328</td>
<td style="text-align: right;">0.0989903</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0292870</td>
<td style="text-align: right;">0.0438936</td>
<td style="text-align: right;">0.0759519</td>
<td style="text-align: right;">0.1035307</td>
<td style="text-align: right;">0.1164945</td>
<td style="text-align: right;">0.3782497</td>
<td style="text-align: right;">0.0914737</td>
</tr>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0281568</td>
<td style="text-align: right;">0.0612873</td>
<td style="text-align: right;">0.1052844</td>
<td style="text-align: right;">0.1394959</td>
<td style="text-align: right;">0.1584550</td>
<td style="text-align: right;">0.4441418</td>
<td style="text-align: right;">0.1273435</td>
</tr>
<tr class="even">
<td style="text-align: right;">1</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0222886</td>
<td style="text-align: right;">0.0380191</td>
<td style="text-align: right;">0.0557680</td>
<td style="text-align: right;">0.0917445</td>
<td style="text-align: right;">0.1073016</td>
<td style="text-align: right;">0.3563071</td>
<td style="text-align: right;">0.0863139</td>
</tr>
</tbody>
</table>

### 3 day ahead

#### Scoring

##### **Conclusion**

AR1 seems very bad in terms of bias and everything.

Sparse AR is the best in terms of crps, AR1 the worst. Sparse AR also
best with dss

–&gt; take Sparse AR

All models have a tendency to be downwards biased, the local and
semilocal ones tend to do a bit better.

![Bias across models 3 day
ahead](results/plots/bias_across_regions_3_day_ahead_forecasts.png)

![CRPS across models 3 day
ahead](results/plots/crps_across_regions_3_day_ahead_forecasts.png)

![LogS across models 3 day
ahead](results/plots/logs_across_regions_3_day_ahead_forecasts.png)

![DSS across models 3 day
ahead](results/plots/dss_across_regions_3_day_ahead_forecasts.png)

![Sharpness across models 3 day
ahead](results/plots/sharpness_across_regions_3_day_ahead_forecasts.png)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">horizon</th>
<th style="text-align: left;">score</th>
<th style="text-align: left;">model</th>
<th style="text-align: right;">bottom</th>
<th style="text-align: right;">lower</th>
<th style="text-align: right;">median</th>
<th style="text-align: right;">mean</th>
<th style="text-align: right;">upper</th>
<th style="text-align: right;">top</th>
<th style="text-align: right;">sd</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0735000</td>
<td style="text-align: right;">0.3410000</td>
<td style="text-align: right;">0.3902982</td>
<td style="text-align: right;">0.6562500</td>
<td style="text-align: right;">0.9860000</td>
<td style="text-align: right;">0.3231420</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0050000</td>
<td style="text-align: right;">0.2125000</td>
<td style="text-align: right;">0.4555000</td>
<td style="text-align: right;">0.4798136</td>
<td style="text-align: right;">0.7817500</td>
<td style="text-align: right;">0.9986250</td>
<td style="text-align: right;">0.3220311</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.1577500</td>
<td style="text-align: right;">0.3955000</td>
<td style="text-align: right;">0.4237785</td>
<td style="text-align: right;">0.6425000</td>
<td style="text-align: right;">0.9832500</td>
<td style="text-align: right;">0.2995765</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0033750</td>
<td style="text-align: right;">0.1910000</td>
<td style="text-align: right;">0.4380000</td>
<td style="text-align: right;">0.4856228</td>
<td style="text-align: right;">0.7867500</td>
<td style="text-align: right;">0.9982500</td>
<td style="text-align: right;">0.3287758</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0164429</td>
<td style="text-align: right;">0.0632751</td>
<td style="text-align: right;">0.1111931</td>
<td style="text-align: right;">0.1816778</td>
<td style="text-align: right;">0.2183764</td>
<td style="text-align: right;">0.8391543</td>
<td style="text-align: right;">0.2042630</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0199180</td>
<td style="text-align: right;">0.0476855</td>
<td style="text-align: right;">0.0903064</td>
<td style="text-align: right;">0.1616771</td>
<td style="text-align: right;">0.1824046</td>
<td style="text-align: right;">0.7707849</td>
<td style="text-align: right;">0.2079662</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0190907</td>
<td style="text-align: right;">0.0489743</td>
<td style="text-align: right;">0.0953043</td>
<td style="text-align: right;">0.1535442</td>
<td style="text-align: right;">0.1807402</td>
<td style="text-align: right;">0.7460374</td>
<td style="text-align: right;">0.1856064</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0168029</td>
<td style="text-align: right;">0.0490093</td>
<td style="text-align: right;">0.0861813</td>
<td style="text-align: right;">0.1692337</td>
<td style="text-align: right;">0.2037845</td>
<td style="text-align: right;">0.9086105</td>
<td style="text-align: right;">0.2278852</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-5.7523054</td>
<td style="text-align: right;">-2.9788105</td>
<td style="text-align: right;">-1.7181326</td>
<td style="text-align: right;">0.0659997</td>
<td style="text-align: right;">-0.3214171</td>
<td style="text-align: right;">15.9102891</td>
<td style="text-align: right;">10.1308226</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-5.0696145</td>
<td style="text-align: right;">-3.4282586</td>
<td style="text-align: right;">-2.3150460</td>
<td style="text-align: right;">0.2284952</td>
<td style="text-align: right;">-0.6315108</td>
<td style="text-align: right;">18.8387007</td>
<td style="text-align: right;">15.1851117</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-5.0893487</td>
<td style="text-align: right;">-3.4022191</td>
<td style="text-align: right;">-2.2443317</td>
<td style="text-align: right;">-0.9142318</td>
<td style="text-align: right;">-0.6633021</td>
<td style="text-align: right;">16.0607899</td>
<td style="text-align: right;">5.6334128</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-5.1049417</td>
<td style="text-align: right;">-3.2627570</td>
<td style="text-align: right;">-2.1765028</td>
<td style="text-align: right;">-0.0712919</td>
<td style="text-align: right;">-0.6249551</td>
<td style="text-align: right;">15.8084657</td>
<td style="text-align: right;">10.8358287</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-1.9576532</td>
<td style="text-align: right;">-0.6315737</td>
<td style="text-align: right;">-0.0286593</td>
<td style="text-align: right;">2.9121943</td>
<td style="text-align: right;">0.9444399</td>
<td style="text-align: right;">8.3190947</td>
<td style="text-align: right;">22.8390010</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-1.6304220</td>
<td style="text-align: right;">-0.7493319</td>
<td style="text-align: right;">-0.2138140</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">0.6412694</td>
<td style="text-align: right;">15.0739556</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-1.6879827</td>
<td style="text-align: right;">-0.7530458</td>
<td style="text-align: right;">-0.1899264</td>
<td style="text-align: right;">1.1110839</td>
<td style="text-align: right;">0.5448895</td>
<td style="text-align: right;">5.5963112</td>
<td style="text-align: right;">9.3162127</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-1.8682007</td>
<td style="text-align: right;">-0.8397704</td>
<td style="text-align: right;">-0.2895923</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">0.8173786</td>
<td style="text-align: right;">5.5636130</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0310117</td>
<td style="text-align: right;">0.1197644</td>
<td style="text-align: right;">0.1712382</td>
<td style="text-align: right;">0.2185140</td>
<td style="text-align: right;">0.2919571</td>
<td style="text-align: right;">0.6146275</td>
<td style="text-align: right;">0.1596005</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0448152</td>
<td style="text-align: right;">0.1040028</td>
<td style="text-align: right;">0.1698169</td>
<td style="text-align: right;">0.1982319</td>
<td style="text-align: right;">0.2466923</td>
<td style="text-align: right;">0.7182105</td>
<td style="text-align: right;">0.1536501</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0393702</td>
<td style="text-align: right;">0.1299643</td>
<td style="text-align: right;">0.1694644</td>
<td style="text-align: right;">0.2235151</td>
<td style="text-align: right;">0.2729458</td>
<td style="text-align: right;">0.6719199</td>
<td style="text-align: right;">0.1711399</td>
</tr>
<tr class="even">
<td style="text-align: right;">3</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0343422</td>
<td style="text-align: right;">0.0914051</td>
<td style="text-align: right;">0.1411028</td>
<td style="text-align: right;">0.1886089</td>
<td style="text-align: right;">0.2398148</td>
<td style="text-align: right;">0.7732401</td>
<td style="text-align: right;">0.1695911</td>
</tr>
</tbody>
</table>

### 7 days ahead

![Bias across model
forecasts](results/plots/bias_across_regions_7_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/crps_across_regions_7_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/logs_across_regions_7_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/dss_across_regions_7_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/sharpness_across_regions_7_day_ahead_forecasts.png)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">horizon</th>
<th style="text-align: left;">score</th>
<th style="text-align: left;">model</th>
<th style="text-align: right;">bottom</th>
<th style="text-align: right;">lower</th>
<th style="text-align: right;">median</th>
<th style="text-align: right;">mean</th>
<th style="text-align: right;">upper</th>
<th style="text-align: right;">top</th>
<th style="text-align: right;">sd</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0305000</td>
<td style="text-align: right;">0.2340000</td>
<td style="text-align: right;">0.3406351</td>
<td style="text-align: right;">0.5777500</td>
<td style="text-align: right;">0.9977750</td>
<td style="text-align: right;">0.3207735</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0010000</td>
<td style="text-align: right;">0.1245000</td>
<td style="text-align: right;">0.4555000</td>
<td style="text-align: right;">0.4629514</td>
<td style="text-align: right;">0.7827500</td>
<td style="text-align: right;">0.9980000</td>
<td style="text-align: right;">0.3453798</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0720000</td>
<td style="text-align: right;">0.3675000</td>
<td style="text-align: right;">0.3906459</td>
<td style="text-align: right;">0.6615000</td>
<td style="text-align: right;">0.9945500</td>
<td style="text-align: right;">0.3217249</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0034500</td>
<td style="text-align: right;">0.1492500</td>
<td style="text-align: right;">0.4610000</td>
<td style="text-align: right;">0.4791946</td>
<td style="text-align: right;">0.7980000</td>
<td style="text-align: right;">0.9987750</td>
<td style="text-align: right;">0.3405127</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0237678</td>
<td style="text-align: right;">0.0960116</td>
<td style="text-align: right;">0.1857228</td>
<td style="text-align: right;">0.2955098</td>
<td style="text-align: right;">0.3946808</td>
<td style="text-align: right;">1.1168065</td>
<td style="text-align: right;">0.3121035</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0399012</td>
<td style="text-align: right;">0.1090727</td>
<td style="text-align: right;">0.1981111</td>
<td style="text-align: right;">0.3140519</td>
<td style="text-align: right;">0.4360475</td>
<td style="text-align: right;">1.1921736</td>
<td style="text-align: right;">0.3001370</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0432188</td>
<td style="text-align: right;">0.0844265</td>
<td style="text-align: right;">0.1635945</td>
<td style="text-align: right;">0.2610888</td>
<td style="text-align: right;">0.3281690</td>
<td style="text-align: right;">0.9150013</td>
<td style="text-align: right;">0.2852256</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0319151</td>
<td style="text-align: right;">0.1285761</td>
<td style="text-align: right;">0.2182245</td>
<td style="text-align: right;">0.3465975</td>
<td style="text-align: right;">0.4452252</td>
<td style="text-align: right;">1.3017779</td>
<td style="text-align: right;">0.3641722</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-5.0529295</td>
<td style="text-align: right;">-2.1116999</td>
<td style="text-align: right;">-0.9486481</td>
<td style="text-align: right;">7.8874438</td>
<td style="text-align: right;">1.6099643</td>
<td style="text-align: right;">75.1686650</td>
<td style="text-align: right;">53.2973291</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-3.4492815</td>
<td style="text-align: right;">-1.8213095</td>
<td style="text-align: right;">-0.8431559</td>
<td style="text-align: right;">5.7522375</td>
<td style="text-align: right;">1.0772263</td>
<td style="text-align: right;">29.4807890</td>
<td style="text-align: right;">57.5437701</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-3.7290359</td>
<td style="text-align: right;">-2.4864360</td>
<td style="text-align: right;">-1.2975935</td>
<td style="text-align: right;">2.1013875</td>
<td style="text-align: right;">0.8160169</td>
<td style="text-align: right;">33.7009999</td>
<td style="text-align: right;">11.4105880</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-3.1526853</td>
<td style="text-align: right;">-1.5676692</td>
<td style="text-align: right;">-0.5059338</td>
<td style="text-align: right;">2.3143832</td>
<td style="text-align: right;">1.2395309</td>
<td style="text-align: right;">26.9223396</td>
<td style="text-align: right;">17.4728669</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-1.6469611</td>
<td style="text-align: right;">-0.1862844</td>
<td style="text-align: right;">0.4575571</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">2.0977521</td>
<td style="text-align: right;">133.8684222</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-0.8702571</td>
<td style="text-align: right;">0.0531860</td>
<td style="text-align: right;">0.6150591</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">1.5742947</td>
<td style="text-align: right;">64.6989266</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-0.9441767</td>
<td style="text-align: right;">-0.2999462</td>
<td style="text-align: right;">0.2810207</td>
<td style="text-align: right;">4.6497351</td>
<td style="text-align: right;">1.3725644</td>
<td style="text-align: right;">20.9503585</td>
<td style="text-align: right;">27.0332360</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-1.1839989</td>
<td style="text-align: right;">0.1761904</td>
<td style="text-align: right;">0.6842636</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">1.6256690</td>
<td style="text-align: right;">273.9563772</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0349965</td>
<td style="text-align: right;">0.1691771</td>
<td style="text-align: right;">0.2460824</td>
<td style="text-align: right;">0.3057967</td>
<td style="text-align: right;">0.4133362</td>
<td style="text-align: right;">0.9203690</td>
<td style="text-align: right;">0.2316235</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.1697449</td>
<td style="text-align: right;">0.3092458</td>
<td style="text-align: right;">0.3373103</td>
<td style="text-align: right;">0.4295277</td>
<td style="text-align: right;">0.8052232</td>
<td style="text-align: right;">0.2336642</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0537510</td>
<td style="text-align: right;">0.1769637</td>
<td style="text-align: right;">0.2431955</td>
<td style="text-align: right;">0.2990138</td>
<td style="text-align: right;">0.3303729</td>
<td style="text-align: right;">0.7902818</td>
<td style="text-align: right;">0.2042039</td>
</tr>
<tr class="even">
<td style="text-align: right;">7</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.1720308</td>
<td style="text-align: right;">0.3345330</td>
<td style="text-align: right;">0.3777638</td>
<td style="text-align: right;">0.4916669</td>
<td style="text-align: right;">1.0344513</td>
<td style="text-align: right;">0.3343831</td>
</tr>
</tbody>
</table>

### 14 days ahead

![Bias across model
forecasts](results/plots/bias_across_regions_14_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/crps_across_regions_14_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/logs_across_regions_14_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/dss_across_regions_14_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/sharpness_across_regions_14_day_ahead_forecasts.png)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">horizon</th>
<th style="text-align: left;">score</th>
<th style="text-align: left;">model</th>
<th style="text-align: right;">bottom</th>
<th style="text-align: right;">lower</th>
<th style="text-align: right;">median</th>
<th style="text-align: right;">mean</th>
<th style="text-align: right;">upper</th>
<th style="text-align: right;">top</th>
<th style="text-align: right;">sd</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0135000</td>
<td style="text-align: right;">0.2220000</td>
<td style="text-align: right;">0.3116846</td>
<td style="text-align: right;">0.5030000</td>
<td style="text-align: right;">1.000000</td>
<td style="text-align: right;">0.3200756</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0020000</td>
<td style="text-align: right;">0.0885000</td>
<td style="text-align: right;">0.3350000</td>
<td style="text-align: right;">0.4174659</td>
<td style="text-align: right;">0.7575000</td>
<td style="text-align: right;">0.990050</td>
<td style="text-align: right;">0.3465923</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0125000</td>
<td style="text-align: right;">0.2950000</td>
<td style="text-align: right;">0.3531685</td>
<td style="text-align: right;">0.6295000</td>
<td style="text-align: right;">0.957500</td>
<td style="text-align: right;">0.3234279</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0139000</td>
<td style="text-align: right;">0.1320000</td>
<td style="text-align: right;">0.3990000</td>
<td style="text-align: right;">0.4484301</td>
<td style="text-align: right;">0.7430000</td>
<td style="text-align: right;">0.985100</td>
<td style="text-align: right;">0.3289778</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0335856</td>
<td style="text-align: right;">0.1375773</td>
<td style="text-align: right;">0.2462624</td>
<td style="text-align: right;">0.4147992</td>
<td style="text-align: right;">0.5281402</td>
<td style="text-align: right;">1.856200</td>
<td style="text-align: right;">0.4455997</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0793567</td>
<td style="text-align: right;">0.1919530</td>
<td style="text-align: right;">0.3146997</td>
<td style="text-align: right;">0.5050492</td>
<td style="text-align: right;">0.6477006</td>
<td style="text-align: right;">1.798096</td>
<td style="text-align: right;">0.5020982</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0606336</td>
<td style="text-align: right;">0.1168247</td>
<td style="text-align: right;">0.2136598</td>
<td style="text-align: right;">0.3936231</td>
<td style="text-align: right;">0.4891568</td>
<td style="text-align: right;">1.869009</td>
<td style="text-align: right;">0.4469477</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0788096</td>
<td style="text-align: right;">0.2201375</td>
<td style="text-align: right;">0.3961209</td>
<td style="text-align: right;">0.5867447</td>
<td style="text-align: right;">0.7345232</td>
<td style="text-align: right;">1.984991</td>
<td style="text-align: right;">0.6112888</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-4.2580235</td>
<td style="text-align: right;">-1.4838933</td>
<td style="text-align: right;">-0.3875600</td>
<td style="text-align: right;">53.1288720</td>
<td style="text-align: right;">3.7123344</td>
<td style="text-align: right;">473.335952</td>
<td style="text-align: right;">355.8044540</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-2.5452295</td>
<td style="text-align: right;">-0.9568288</td>
<td style="text-align: right;">-0.0362917</td>
<td style="text-align: right;">9.9814570</td>
<td style="text-align: right;">2.2139444</td>
<td style="text-align: right;">65.350047</td>
<td style="text-align: right;">90.5184714</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-3.2051358</td>
<td style="text-align: right;">-1.7379334</td>
<td style="text-align: right;">-0.7522603</td>
<td style="text-align: right;">7.2520291</td>
<td style="text-align: right;">2.7236760</td>
<td style="text-align: right;">75.087795</td>
<td style="text-align: right;">26.9582388</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-1.9943268</td>
<td style="text-align: right;">-0.4764472</td>
<td style="text-align: right;">0.6081701</td>
<td style="text-align: right;">5.6446427</td>
<td style="text-align: right;">1.9254041</td>
<td style="text-align: right;">13.013435</td>
<td style="text-align: right;">63.5809658</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-1.2078627</td>
<td style="text-align: right;">0.2458156</td>
<td style="text-align: right;">0.8472780</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">3.2302493</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-0.3101312</td>
<td style="text-align: right;">0.5834656</td>
<td style="text-align: right;">1.1589241</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">2.2983405</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-0.6660663</td>
<td style="text-align: right;">0.0654051</td>
<td style="text-align: right;">0.5824193</td>
<td style="text-align: right;">14.0855857</td>
<td style="text-align: right;">2.1425211</td>
<td style="text-align: right;">173.874522</td>
<td style="text-align: right;">61.2007764</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-0.4708208</td>
<td style="text-align: right;">0.8439186</td>
<td style="text-align: right;">1.4452099</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">2.1914378</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0329083</td>
<td style="text-align: right;">0.1993808</td>
<td style="text-align: right;">0.3296000</td>
<td style="text-align: right;">0.3637842</td>
<td style="text-align: right;">0.4719614</td>
<td style="text-align: right;">1.086160</td>
<td style="text-align: right;">0.2522039</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.2300625</td>
<td style="text-align: right;">0.3947365</td>
<td style="text-align: right;">0.4972462</td>
<td style="text-align: right;">0.7065726</td>
<td style="text-align: right;">1.502997</td>
<td style="text-align: right;">0.4054781</td>
</tr>
<tr class="odd">
<td style="text-align: right;">14</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0835340</td>
<td style="text-align: right;">0.1994929</td>
<td style="text-align: right;">0.3027100</td>
<td style="text-align: right;">0.3513953</td>
<td style="text-align: right;">0.3877486</td>
<td style="text-align: right;">1.095796</td>
<td style="text-align: right;">0.2491342</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.1670901</td>
<td style="text-align: right;">0.4814912</td>
<td style="text-align: right;">0.6085576</td>
<td style="text-align: right;">0.9148659</td>
<td style="text-align: right;">2.055006</td>
<td style="text-align: right;">0.5593290</td>
</tr>
</tbody>
</table>

### 21 days ahead

![Bias across model
forecasts](results/plots/bias_across_regions_21_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/crps_across_regions_21_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/logs_across_regions_21_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/dss_across_regions_21_day_ahead_forecasts.png)

![Bias across model
forecasts](results/plots/sharpness_across_regions_21_day_ahead_forecasts.png)

<table>
<thead>
<tr class="header">
<th style="text-align: right;">horizon</th>
<th style="text-align: left;">score</th>
<th style="text-align: left;">model</th>
<th style="text-align: right;">bottom</th>
<th style="text-align: right;">lower</th>
<th style="text-align: right;">median</th>
<th style="text-align: right;">mean</th>
<th style="text-align: right;">upper</th>
<th style="text-align: right;">top</th>
<th style="text-align: right;">sd</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0090000</td>
<td style="text-align: right;">0.1660000</td>
<td style="text-align: right;">0.3114253</td>
<td style="text-align: right;">0.5250000</td>
<td style="text-align: right;">0.999500</td>
<td style="text-align: right;">0.3367350</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0055000</td>
<td style="text-align: right;">0.0920000</td>
<td style="text-align: right;">0.3610000</td>
<td style="text-align: right;">0.4348643</td>
<td style="text-align: right;">0.7690000</td>
<td style="text-align: right;">0.985000</td>
<td style="text-align: right;">0.3465707</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0120000</td>
<td style="text-align: right;">0.3140000</td>
<td style="text-align: right;">0.3443348</td>
<td style="text-align: right;">0.6470000</td>
<td style="text-align: right;">0.921000</td>
<td style="text-align: right;">0.3273120</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">bias</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0240000</td>
<td style="text-align: right;">0.1980000</td>
<td style="text-align: right;">0.4050000</td>
<td style="text-align: right;">0.4670000</td>
<td style="text-align: right;">0.7500000</td>
<td style="text-align: right;">0.975000</td>
<td style="text-align: right;">0.3064901</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0235764</td>
<td style="text-align: right;">0.1607730</td>
<td style="text-align: right;">0.3177785</td>
<td style="text-align: right;">0.5070274</td>
<td style="text-align: right;">0.6941321</td>
<td style="text-align: right;">1.987461</td>
<td style="text-align: right;">0.4935879</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0980552</td>
<td style="text-align: right;">0.2591496</td>
<td style="text-align: right;">0.4229265</td>
<td style="text-align: right;">0.6370391</td>
<td style="text-align: right;">0.7729879</td>
<td style="text-align: right;">2.756221</td>
<td style="text-align: right;">0.6788510</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0462926</td>
<td style="text-align: right;">0.1277933</td>
<td style="text-align: right;">0.2904460</td>
<td style="text-align: right;">0.4679007</td>
<td style="text-align: right;">0.6102723</td>
<td style="text-align: right;">2.034037</td>
<td style="text-align: right;">0.4929226</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">crps</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.1085912</td>
<td style="text-align: right;">0.2731977</td>
<td style="text-align: right;">0.5074682</td>
<td style="text-align: right;">0.7785265</td>
<td style="text-align: right;">0.9108566</td>
<td style="text-align: right;">3.168600</td>
<td style="text-align: right;">0.9466353</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-4.6069415</td>
<td style="text-align: right;">-1.0815082</td>
<td style="text-align: right;">0.1624104</td>
<td style="text-align: right;">91.3327444</td>
<td style="text-align: right;">6.3480268</td>
<td style="text-align: right;">529.056224</td>
<td style="text-align: right;">591.1769803</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-2.0662364</td>
<td style="text-align: right;">-0.4916795</td>
<td style="text-align: right;">0.4901097</td>
<td style="text-align: right;">18.0294045</td>
<td style="text-align: right;">1.9068587</td>
<td style="text-align: right;">53.683590</td>
<td style="text-align: right;">179.2855097</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-3.4044389</td>
<td style="text-align: right;">-1.5845888</td>
<td style="text-align: right;">-0.2702617</td>
<td style="text-align: right;">7.4069067</td>
<td style="text-align: right;">3.3398820</td>
<td style="text-align: right;">90.777872</td>
<td style="text-align: right;">28.1997211</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">dss</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-1.6339690</td>
<td style="text-align: right;">-0.0292194</td>
<td style="text-align: right;">1.1029341</td>
<td style="text-align: right;">2.1107550</td>
<td style="text-align: right;">2.2205292</td>
<td style="text-align: right;">9.919692</td>
<td style="text-align: right;">6.2186932</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">-1.4546480</td>
<td style="text-align: right;">0.4273530</td>
<td style="text-align: right;">1.1779060</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">3.4579409</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">-0.0258806</td>
<td style="text-align: right;">0.9112704</td>
<td style="text-align: right;">1.4480704</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">2.2740219</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">-0.8044235</td>
<td style="text-align: right;">0.0710294</td>
<td style="text-align: right;">0.8436638</td>
<td style="text-align: right;">11.1228016</td>
<td style="text-align: right;">2.5644809</td>
<td style="text-align: right;">79.451618</td>
<td style="text-align: right;">56.7227038</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">logs</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">-0.0520093</td>
<td style="text-align: right;">1.1308824</td>
<td style="text-align: right;">1.6722319</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">2.3592900</td>
<td style="text-align: right;">Inf</td>
<td style="text-align: right;">Inf</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">AR 1</td>
<td style="text-align: right;">0.0238265</td>
<td style="text-align: right;">0.2243352</td>
<td style="text-align: right;">0.3728773</td>
<td style="text-align: right;">0.4033955</td>
<td style="text-align: right;">0.5296797</td>
<td style="text-align: right;">1.163644</td>
<td style="text-align: right;">0.2764973</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Semi-local linear trend</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.2018072</td>
<td style="text-align: right;">0.4735850</td>
<td style="text-align: right;">0.6459497</td>
<td style="text-align: right;">0.9680663</td>
<td style="text-align: right;">2.302249</td>
<td style="text-align: right;">0.6264441</td>
</tr>
<tr class="odd">
<td style="text-align: right;">21</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Sparse AR</td>
<td style="text-align: right;">0.0978555</td>
<td style="text-align: right;">0.2446217</td>
<td style="text-align: right;">0.3422660</td>
<td style="text-align: right;">0.4056539</td>
<td style="text-align: right;">0.4491018</td>
<td style="text-align: right;">1.267412</td>
<td style="text-align: right;">0.2737175</td>
</tr>
<tr class="even">
<td style="text-align: right;">21</td>
<td style="text-align: left;">sharpness</td>
<td style="text-align: left;">Student local linear trend</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.0000000</td>
<td style="text-align: right;">0.5287538</td>
<td style="text-align: right;">0.7701699</td>
<td style="text-align: right;">1.2390178</td>
<td style="text-align: right;">3.414396</td>
<td style="text-align: right;">0.8405296</td>
</tr>
</tbody>
</table>

Performance by countries
------------------------

### 1 day(s) ahead

![](results/plots/regions_crps_1_ahead.png)

![](results/plots/regions_logs_1_ahead.png)

![](results/plots/regions_dss_1_ahead.png)

### 3 day(s) ahead

![](results/plots/regions_crps_3_ahead.png)

![](results/plots/regions_logs_3_ahead.png)

![](results/plots/regions_dss_3_ahead.png)

### 7 day(s) ahead

![](results/plots/regions_crps_7_ahead.png)

![](results/plots/regions_logs_7_ahead.png)

![](results/plots/regions_dss_7_ahead.png)

### 14 day(s) ahead

![](results/plots/regions_crps_14_ahead.png)

![](results/plots/regions_logs_14_ahead.png)

![](results/plots/regions_dss_14_ahead.png)

### 21 day(s) ahead

![](results/plots/regions_crps_21_ahead.png)

![](results/plots/regions_logs_21_ahead.png)

![](results/plots/regions_dss_21_ahead.png)

Region performance vs metrics
-----------------------------

### australia

![](results/plots/tests/pred_1_australia_vs_scores.png)

### austria

![](results/plots/tests/pred_1_austria_vs_scores.png)

### belgium

![](results/plots/tests/pred_1_belgium_vs_scores.png)

### china

![](results/plots/tests/pred_1_china_vs_scores.png)

### china-excluding-hubei

![](results/plots/tests/pred_1_china-excluding-hubei_vs_scores.png)

### france

![](results/plots/tests/pred_1_france_vs_scores.png)

### hong-kong

![](results/plots/tests/pred_1_hong-kong_vs_scores.png)

### hubei

![](results/plots/tests/pred_1_hubei_vs_scores.png)

### iran

![](results/plots/tests/pred_1_iran_vs_scores.png)

### italy

![](results/plots/tests/pred_1_italy_vs_scores.png)

### japan

![](results/plots/tests/pred_1_japan_vs_scores.png)

### netherlands

![](results/plots/tests/pred_1_netherlands_vs_scores.png)

### singapore

![](results/plots/tests/pred_1_singapore_vs_scores.png)

### south-korea

![](results/plots/tests/pred_1_south-korea_vs_scores.png)

### spain

![](results/plots/tests/pred_1_spain_vs_scores.png)

### united-states

![](results/plots/tests/pred_1_united-states_vs_scores.png)
