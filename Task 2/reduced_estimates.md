| S No | Change | Impact |
| --- | --- | --- |
| 1 | Change web server and app server instance size from t3.small to t3 micro. | This will result in reduced performance of web servers . However, as we have kept autoscaling it will absorb the impact of this to a certain extent. Besides this, we have kept the peak duration as 8 hours instead of 12 hours for intial cost estimate. |
| 2 | Change RDS db instance size from m5.4xlarge to m5.2xlarge | This will result in reduced performance of database servers so during peak times users may experience degraded performance. |
| 3 | Developer support instead of business support. | This will impact the support response time. However, the team should be able to work with a response time of less than 12 hours for system issues. |
