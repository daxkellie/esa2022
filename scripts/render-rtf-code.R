library(galah)
library(withr)
library(reprex)


withr::with_options(
  new = c(
    reprex.highlight.hl_style  = "earendel",
    reprex.highlight.font      = "Fira Code Regular",
    reprex.highlight.font_size = 70
  ),
  reprex::reprex({
    library(galah)
    
    galah_config(email = "dax.kellie@csiro.au", verbose = FALSE)
    
    galah_call() |>
      galah_identify("ceyx pusillus") |>
      galah_filter(multimedia == "Image") |>
      atlas_media() |> 
      collect_media(type = "thumbnail",
                    path = tempdir()) |> 
      dplyr::select(scientificName,  
                    multimedia, license, size_in_bytes, recordID) |> print(n = 5) 
  }, 
                 venue = "rtf"))


## Counts
library(galah)

galah_call() |>
  galah_identify("litoria") |>
  galah_group_by(species) |>
  galah_apply_profile("ALA") |> # data quality filters
  atlas_counts() |> print(n = 5)

## Occurrences
library(galah)

galah_config(email = "dax.kellie@csiro.au", verbose = FALSE)

galah_call() |>
  galah_identify("eolophus") |>
  galah_filter(year == 2022) |>
  galah_select(scientificName, decimalLongitude, 
               decimalLatitude, eventDate) |>
  atlas_occurrences() |> print(n = 5)

## Species lists

galah_call() |>
  galah_identify("Orchidaceae") |>
  galah_filter(year > 2020) |>
  atlas_species() |> print(n = 5)

## Images & media
galah_config(email = "dax.kellie@csiro.au", verbose = FALSE)

galah_call() |>
  galah_identify("ceyx pusillus") |>
  galah_filter(multimedia == "Image") |>
  galah_select(scientificName, eventDate, recordID, multimedia, size_in_bytes, license)
  atlas_media() |> 
  collect_media(type = "thumbnail",
                path = tempdir()) |> print(n = 5) 
