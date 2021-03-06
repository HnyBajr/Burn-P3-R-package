#' Wind Ninja ASCII to TIF Converter
#'
#' A quick converter for ASCII wind ninja grids to GeoTiff for smaller storage and faster loading.
#'
#' @importFrom raster writeRaster raster
#'
#' @param directory directory of wind ninja grids. The directory that contains the direction and velocity folders.
#' @export
#'
#'
wn_converter <- function(directory){
  if (length(grep("dir|speed|spd|ang|vel",list.dirs(directory,recursive = F))) > 0) {

    direction <- list.dirs(directory,
                           recursive = F)[grep("dir|ang",
                                               list.dirs(directory,
                                                         recursive = F)
                                               )
                                          ]
    speed <- list.dirs(directory,
                       recursive = F)[grep("speed|spd|vel",
                                           list.dirs(directory,
                                                     recursive = F)
                                           )
                                      ]

    lapply(c(direction,speed), function(i){
      lapply(list.files(i,
                        full.names = T,
                        pattern = ".asc"),
             function(x){
        writeRaster(raster(x),
                    gsub(".asc",".tif",x),
                    format = "GTiff",
                    NAflag = -9999,
                    datatype = "INT2S",
                    overwrite = T)
      }
      )
    }
    )
  } else {
    lapply(list.files(directory,
                      full.names = T,
                      pattern = ".asc"),
           function(x){
      writeRaster(raster(x),
                  gsub(".asc",".tif",x),
                  format = "GTiff",
                  NAflag = -9999,
                  datatype = "INT2S",
                  overwrite = T)
    }
    )
  }
}
