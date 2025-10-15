# ---
# title: "Scraping Data from ArcGIS StoryMaps"
# author: "Jeff Jacobs"
# date: 2025-10-01
# format:
#   html:
#     df-print: kable
# ---

import json
from esridump.dumper import EsriDumper

layer_num = 11

# d = EsriDumper('http://example.com/arcgis/rest/services/Layer/MapServer/1')

k1835_endpoint = 'https://services.arcgis.com/3xOwF6p0r7IHIjfn/arcgis/rest/services/KurdPop1835/FeatureServer/0'

principalities_1835_endpoint = 'https://services.arcgis.com/3xOwF6p0r7IHIjfn/arcgis/rest/services/Kurd1835/FeatureServer/9'

sevres_endpoint = 'https://services.arcgis.com/3xOwF6p0r7IHIjfn/arcgis/rest/services/Treaty_of_Sevres/FeatureServer/11/'

k47_endpoint = 'https://services.arcgis.com/3xOwF6p0r7IHIjfn/ArcGIS/rest/services/Kurdistan1947Boundaries/FeatureServer/10'

cur_endpoint = 'https://services.arcgis.com/3xOwF6p0r7IHIjfn/arcgis/rest/services/Kurdistan_Current_Boundary_Estimates/FeatureServer/15'

ed_object = EsriDumper(k47_endpoint)

krd_features = list(ed_object)

# len(krd_features)

krd_feature = krd_features[0]
# len(krd_feature)

with open('krd_47.geojson', 'w') as infile:
  json.dump(krd_feature, infile)

#| label: scraped-esri-data
print("ESRI Type:", krd_feature['type'])
print("ESRI Properties:", krd_feature['properties'])
print("Geometry Type:", krd_feature['geometry']['type'])
print("First Coordinate:",krd_feature['geometry']['coordinates'][0][0])

print(krd_feature.keys())

print(krd_feature['type'])

print(krd_feature['properties'])

krd_geom = krd_feature['geometry']
print(type(krd_geom))

print(krd_geom.keys())

print(krd_geom['type'])

krd_coords = krd_geom['coordinates']
print(krd_coords)
