# cyclistic-bike-share-case-study
Cyclistic Bike-Share Case Study: Analyzing Rider Behavior to Maximize Annual Memberships

As a junior data analyst on Cyclistic's marketing analytics team, I investigated how annual members and casual riders use bike-share services differently. By processing and analyzing over 3.8 million historical trip records from 2019 using BigQuery SQL, I uncovered distinct behavioral patterns: annual members predominantly utilize the system for weekday commuting with shorter, consistent ride durations, whereas casual riders favor longer leisure rides heavily concentrated on weekends. To translate these insights into business value, I built interactive data visualizations in Looker Studio and formulated three data-backed marketing strategies aimed at converting high-value casual riders into loyal annual members.

## 📁 Project Structure
* `README.md`: Overview of the business problem, methodology, analysis, and recommendations.
* `cyclistic_analysis.sql`: Contains the complete BigQuery SQL code used for data merging, cleaning, and aggregate analysis.

---

## 1. Ask (Business Task)
* **Objective:** Design marketing strategies aimed at converting casual bike-share riders into annual members.
* **Key Stakeholder:** Lily Moreno (Director of Marketing) and the Cyclistic executive team.
* **Core Question:** How do annual members and casual riders use Cyclistic bikes differently?

---

## 2. Prepare (Data Sources)
* **Data Used:** Historical trip data from Cyclistic (Divvy / Motivate) covering the four quarters of 2019.
* **Storage & Management:** Uploaded and managed via Google Cloud Storage (GCS) and queried using Google BigQuery due to file size limits.
* **Credibility:** This is first-party public data provided by Motivate International Inc., allowing us to analyze actual user behavior securely while protecting user privacy (no personally identifiable information is included).

---

## 3. Process (Data Cleaning & Manipulation)
* **Tool:** Google BigQuery (SQL).
* **Steps Taken:**
  * Imported all 4 quarterly CSV files into separate tables.
  * Standardized disparate schemas by mapping Q2's verbose header names to match the clean naming conventions of Q1, Q3, and Q4.
  * Used `UNION ALL` to combine all four quarters into a single master table (`master_2019_trips`).
  * Performed feature engineering by calculating `ride_length_minutes` via `TIMESTAMP_DIFF()` and extracting `day_of_week` using `EXTRACT()`.
  * Cleaned the data by filtering out negative or erroneous ride durations (where ride length was $\le 0$).

---

## 4. Analyze (Descriptive Statistics)
* **Key Metrics Analyzed:** Total ride counts, average ride lengths, maximum ride lengths, and weekly riding patterns.
* **Initial Findings:**
  * **Annual Members (Subscribers):** Account for the vast majority of total trips (~2.93 million), with short, consistent average ride lengths (~13.8 minutes) peaking during standard weekday commuting hours.
  * **Casual Riders (Customers):** Account for fewer total trips (~880k) but take significantly longer average trips (~56.5 minutes) that heavily peak on weekends for leisure.

---

## 5. Share (Visualizations)
* **Tool:** Looker Studio.
* **Visual Highlights:**
  * *Chart 1:* Total rides and average duration compared side-by-side between customer types.
  * *Chart 2:* Weekly breakdown showing member volume flatlining across weekdays versus casual volume spiking heavily on Saturdays and Sundays.
  * <img width="854" height="638" alt="image" src="https://github.com/user-attachments/assets/f0729efb-1a74-4620-89c3-940388eb2a35" />
  * <img width="762" height="601" alt="image" src="https://github.com/user-attachments/assets/5ca855a6-2b22-4f12-81df-38def4c212b0" />


---

## 6. Act (Recommendations)
Based on these insights, the marketing team should pursue the following three strategies:
1. **Launch Weekend-to-Weekday Membership Perks:** Introduce specialized promotions or discounts for casual riders who choose to ride during off-peak weekdays, easing them into regular commuting habits.
2. **Targeted Digital Ads at Leisure Hotspots:** Run geo-targeted ad campaigns near popular weekend trails and tourist spots illustrating the cumulative long-term cost savings of an annual membership compared to frequent single-day passes.
3. **Flexible/Seasonal Membership Tiers:** Offer a warm-weather seasonal membership tailored to casual riders who only use the service heavily during spring and summer, providing an attractive middle-ground stepping stone to a full annual commitment.
