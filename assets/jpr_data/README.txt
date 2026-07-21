This replication package is for the paper, "How do International Borders affect Conflict Processes? Evidence from the End of Mandate Palestine" published in the Journal of Peace Resarch by Richard J. McAlexander, PhD. Email: richardmcalexander@gmail.com

The R file, palestine_jpr_replication.R, loads the data, and makes the tables and plots used in the main body of the text. It also runs the regression discontinuity analysis. Please make sure all packages are installed. Note that the figures are not identical to the main text, since these were manually edited in Qgis. However, the underlying data is the same.

The shapefiles folder contains the shapefiles for making the maps.

The main data file is palestine_rep_data.rds. Here are the columns names with a brief description for that dataframe:

fell_before_ind = A binary variable indicating if this village was occupied by the Israelis/Haganah before May 15, 1948.

fell_after_ind = A binary variable indicating if this village was occupied by the Israelis/Haganah on or after May 15, 1948.

massacre = A binary variable indicating if this village experienced a massacre by Israeli/Haganah forces, as measured by the Atlas of Palestine.

any_exodus_violent = A binary variable indicating if this village was occupied by the Israelis/Haganah where the proximate cause was violence (again from the Atlas of Palestine).

un_arab_land_47 = A binary variable indicating if this village was located in land granted to the Arab state by the UN in 1947.

jew_land = The size of the land owned by the Jewish population in a village, in dunums as measured by the Atlas of Palestine.

jew_pop_45 = The size of the Jewish population in a village in 1945, as measured by the Atlas of Palestine.

jew_land_share = The share of the village land owned by the Jewish population, as measured by the Atlas of Palestine.

jew_pop_share = The share of the village population which is Jewish, as measured by the Atlas of Palestine.

distance = The distance from the village to the nearest point of the 1947 UN partition line.

distance_forcing = The forcing variable used in the RDD analysis, which is distance from the village to the nearest point of the 1947 UN partition line. It is positive if the village is in the UN Arab Land, negative if not.

Occupation Date = The date the village was occupied by the Israelis/Haganah, as measured by the Atlas of Palestine.


