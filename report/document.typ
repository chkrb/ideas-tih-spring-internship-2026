#set document(title: [Time-Series Analysis of COVID-19 Data])
#set heading(numbering: "1.")
#set page(margin: 1.1in)
#set par(leading: 0.55em, spacing: 0.9em)

#align(center + horizon)[
  #title()
  #v(20%)

  *Kaustabh Chakraborty* \
  St. Xavier's College (Autonomous), Kolkata \
  B.Sc. Computer Science (Year 2)
  #v(20%)

  Period of Internship: 21#super[st] January 2026 – 17#super[th] February 2026

  _This report is submitted to IDEAS – Institute of Data Engineering,
  Analytics, and Science Foundation, Indian Statistical Institute, Kolkata_
]
#pagebreak()

= Abstract

The rapid spread of COVID-19 from 2020 led to the World Health Organization
(WHO) in declaring a pandemic. The impacts of the pandemic especially in
economic and social circles was quite significant and never seen before by an
entire generation. This analytical project searches deep into the numbers, and
tries to identify trends in the growth and spread of the virus around the world.

= Introduction

The project is a part of the internship programme graciously provided by
Institute of Data Engineering, Analytics, and Science Foundation (IDEAS) of
Indian Statistical Institute (ISI). The Python programming language is chosen in
order to clean and observe the data, as it enjoys a high popularity among data
scientists, and boasts a huge suite of libraries for including – but not limited
to – data analytics and artificial intelligence. Adequate training programs were
provided to consider the analytical aspect of this project, which includes:

- Basics in Python programming – data structures, conditionals, iterations,
  functions
- Objected-oriented programming in Python
- Data Science in Python – NumPy, Pandas
- Machine Learning Techniques – Regression, Classification
- Fundamental Concepts of Large Language Models (LLMs)

Required tasks were carried out in a Jupyter Notebook, and the assignments were
provided by the Institute. A link to the complete Notebook (among other things)
is pushed to a GitHub repository @project-github.

This project relies hugely upon the `pandas` @pandas library of Python, a
mature library used for data analysis and manipulation purposes.

= Objectives

Some prime objectives for the satisfactory fulfillment of this project are:

- To be familiar with the provided dataset; and to clean and restructure said
  dataset for analysis.
- To identify the number of reported cases in various countries and region.
- To calculate the number of reported cases and its cumulative in various time
  groups.
- To perform methods such as aggregation and pivoting on the existing dataset
  to simplify the interpretation of information directly from views.
- To identify applications of the dataset and its operations in the real world,

= Methodology

== Data Description

The provided dataset has about 500,000 records of COVID-19 cases reported by
countries, and is a subset of WHO's dataset @who-covid-datasets. The records
have the following fields:

- *Date Reported* in `YYYY-MM-DD` format.
- *Country Code* as per the ISO 3166-1 @iso3166-1 standard.
- *Country Name* in English known colloquially.
- *Region Code* as per WHO @who-regions.
- *New Cases* and *Cumulative Cases* of COVID-19 reported in a certain date.
- *New Deaths* and *Cumulative Deaths* due to COVID-19 reported in a certain
  date.

== Data Manipulation

The dataset, in CSV format, was loaded in a ```py pandas.DataFrame``` object,
using ```py pandas.read_csv(...)```. A subset of the dataset was taken with
important attributes, to decrease fetch load when working with said data. It
contains all records of March to August of 2023.

The limitation with the CSV format is that there is no explicit type
declaration. Hence, ```py pandas.DataFrame``` heuristically detects the data
type of the value. For instance, if a certain data contains strictly numeric
values, the loader implicitly converts to a numeric data type.

This poses a problem with dates. There may be infinite possibilities to
represent date in a field (with varying formatting techniques), so the
conversion must be done explicitly. This may be done with the
```py pandas.to_datetime(...)``` function.

= Analysis and Results

/*
 * TODO: The outputs have been manually ported over from the Jupyter Notebook.
 * However, there exists a package named `callisto`, which has tight Notebook
 * integration. It would've been ideal to use that instead.
 *
 * https://typst.app/universe/package/callisto/
 *
 * However, from my limited amount of research there's no known library to
 * render the HTML tables in Notebook output cells.
 */

== Total Cases in Countries

#grid(
  columns: (auto, 1fr),
  inset: (5pt, 5pt),
  table(
    columns: range(2).map(_ => auto),
    align: (left, right),
    table.header(
      [*`country`*], [*`max(cumulative_cases)`*],
    ),
    [United States], [103436829],
    [China], [99381761],
    [India], [45055954],
    [France], [39042805],
    [Germany], [38437875],
  ),
  [
    The data is grouped by `Country`, and the `Cumulative Cases` column is
    extracted. It is then viewed in non-increasing order, with the first five
    records.

    United States has had the most cases of COVID-19 as per the data, with over
    103 million cases.
  ],
)

== Daily Global Cases

#grid(
  columns: (auto, 1fr),
  inset: (5pt, 5pt),
  table(
    columns: range(2).map(_ => auto),
    align: (right, right),
    table.header(
      [*`date_reported`*], [*`sum(new_cases)`*],
    ),
    [2023-03-01], [99346.0],
    [2023-03-02], [100280.0],
    [2023-03-03], [101783.0],
    [2023-03-04], [306407.0],
    [2023-03-05], [239791.0],
    [...], [...],
    [2023-04-09], [352663.0],
    [...], [...],
  ),
  [
    The data is grouped by `Date Reported`, followed by calculating the sum of
    the `New Cases` column.

    Some records are shown in chronological order of `Date Reported`. With the
    limited view of the data, it is observed that total cases were on an
    increasing trend during the first 5 days of March 2023.

    352663 cases were reported in 9#super[th] April, 2023. This is the highest
    number of new reported cases in this data subset.
  ],
)

== Quarterly Aggregation

#grid(
  columns: (auto, 1fr),
  inset: (5pt, 5pt),
  table(
    columns: range(3).map(_ => auto),
    align: (left, right, right),
    table.header(
      [*`quarter`*], [*`sum(new_cases)`*], [*`sum(new_deaths)`*],
    ),
    [2023Q1], [3822277.0], [24641.0],
    [2023Q2], [6227606.0], [49113.0],
    [2023Q3], [2737820.0], [12443.0],
  ),
  [
    Dates are cast to annual quarter periods and inserted into a new column
    called `Quarter`. The table is grouped by it and then aggregated, adding all
    `New Cases` and `New Deaths`.
  ],
)

== New Cases in WHO Regions

#grid(
  columns: (auto, 1fr),
  inset: (5pt, 5pt),
  table(
    columns: range(2).map(_ => auto),
    align: (left, right),
    table.header(
      [*`who_region`*], [*`sum(new_cases)`*],
    ),
    [WPR], [6208917.0],
    [EUR], [3599235.0],
    [AMR], [2442555.0],
    [SEAR], [357858.0],
    [EMR], [130110.0],
    [AFR], [49028.0],
    [OTHER], [0.0],
  ),
  [
    The data is grouped by `WHO Region`, followed by calculating the sum of the
    `New Cases` column.

    The West Pacific Region (WPR) has the most number of infections, at over 6
    million cases, followed by the European Region (EUR), American Region (AMR),
    South-East Asian Region (SEAR), the East Mediterranean Region (EMR), and the
    African Region (AFR) has the lowest, at about 50 thousand cases.
  ],
)

== Pivot Table for Regional Monthly Cases

#grid(
  rows: (auto, auto), /* content can't be nicely fit in column layout */
  inset: (5pt, 5pt),
  table(
    columns: range(7).map(_ => auto),
    align: (left, right, right, right, right, right, right),
    [], [*2023-03*], [*2023-04*], [*2023-05*], [*2023-06*], [*2023-07*], [*2023-08*],
    [*AFR*], [17495.0], [7220.0], [9422.0], [8235.0], [3754.0], [2902.0],
    [*AMR*], [1190913.0], [905239.0], [308556.0], [15369.0], [9302.0], [13176.0],
    [*EMR*], [46659.0], [49659.0], [23597.0], [4967.0], [1530.0], [3698.0],
    [*EUR*], [1570836.0], [1062206.0], [487679.0], [218868.0], [87476.0], [172170.0],
    [*OTHER*], [0.0], [0.0], [0.0], [0.0], [0.0], [0.0],
    [*SEAR*], [30709.0], [236649.0], [60895.0], [18158.0], [7602.0], [3845.0],
    [*WPR*], [965665.0], [989257.0], [1174357.0], [647273.0], [1191725.0], [1240640.0],
  ),
  [
    Dates are cast to year-month pairs and inserted into a new column called
    `Month Year`. A pivot table is prepared, with `WHO Region` being the row
    indices, `Month Year` in column indices, and the cell values being the
    aggregated sum of `New Cases`.

    The resulting view gives a complete summary of the number of registered
    cases in all WHO Regions in multiple months.
  ],
)

= Conclusion

From the massive assortment of data points, organizing them in meaningful ways
provides insight in various hidden trends. It was seen that United States has
had the most amount of COVID-19 cases, closely followed by China, and India,
France, and Germany being a distant third, fourth, and fifth most affected
respectively.

Although the cases of the virus were first reported from China
@wsj-patient-zero, Western regions seem to be affected the most, including WHO's
West Pacific, European, and American regions. The other eastern regions seems to
have a drastically lower number of cases. There is a clear correlation between
the countries of the minority world (developed nations) and the majority world
(developing nations).

The regional monthly pivot table provides the best insight; a sudden increase in
the number of new cases is seen in the aforementioned WHO regions, including the
Eastern Mediterranean region, while the cases in South-East Asian and African
regions seem to drop consistently across the time period.

These observations, along with several social and biological parameters, can be
extrapolated and used to predict the severity of it in various regions and
nations. Data from other similar outbreaks can also aid this research.

= References

#bibliography("refs.yaml", title: none, style: "iso-690-numeric")
