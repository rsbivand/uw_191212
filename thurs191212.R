library(osmdata)
library(sf)
bbox <- opq(bbox = 'warszawa polska')
bbox
af <- available_features()
af
qu <- add_osm_feature(bbox, key = 'railway', value = 'station')
qu
res <- osmdata_sf(qu)
pts <- res$osm_points
pls <- res$osm_polygons
library(mapview)
st_crs(pls)
mapview(pls)
mapview(pts)
which(pts$network %in% "Warsaw Metro")
metro <- pts[which(pts$network %in% "Warsaw Metro"),]
mapview(metro)

library(spDataLarge)
data(pol_pres15)
st_crs(pol_pres15)
metro_proj <- st_transform(metro, st_crs(pol_pres15)$proj4string)
metro_buf <- st_buffer(metro_proj, dist=250)
mapview(metro_buf)

pol_pres15 <- st_buffer(pol_pres15, dist=0)
library(tmap)
tmap_mode("plot")
o <- tm_shape(pol_pres15) + tm_facets(free.scales=FALSE) + tm_borders(lwd=0.5, alpha=0.4) + tm_layout(panel.labels=c("Duda", "Komorowski"))
o + tm_fill(c("I_Duda_share", "I_Komorowski_share"), n=6, style="pretty", title="I round\nshare of votes")
o + tm_fill(c("II_Duda_share", "II_Komorowski_share"), n=6, style="pretty", title="II round\nshare of votes")
tmap_mode("view")
o + tm_fill(c("II_Duda_share", "II_Komorowski_share"), n=6, style="pretty", title="II round\nshare of votes")
tmap_mode("plot")


