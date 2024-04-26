'%>%' <- magrittr::`%>%`
utils::globalVariables(c(".","width","height"))

#' Cut some shapes!
#'
#' If you can make or find a shape as an image, you can use it cut out shapes from other images.
#'
#' @param image
#' The image from which the shape will be cut
#' @param shape
#' The image that contains the shape to cut out
#' @param color
#' The color, as a hex code (e.g. #000000), that identifies the shape in the image
#' This is black by default
#' @param fuzz
#' The fuzz factor to identify the points that match the color specified.
#' Increase to get a smoother outline for the cut shape.
#'
#' @return
#' An external pointer of class 'magick-image'
#' @export
#'
#' @examples
#' cut_shape(image = "https://cdn.pixabay.com/photo/2019/09/08/19/01/pumpkin-4461665_1280.jpg",
#' shape = "https://cdn.pixabay.com/photo/2016/02/07/19/44/cat-1185453_960_720.png")

cut_shape <- function(image, shape, color = "#000000", fuzz = 10){
  # read the images if they are not already
  if(!typeof(image) == "externalptr"){
    image %>% magick::image_read() -> image
  }

  if(!typeof(shape) == "externalptr"){
    shape %>% magick::image_read() -> shape
  }

  # make the specified color transparent
  # add white background in case shape image has transparent background
  shape %>%
    magick::image_background(color = "#FFFFFF") %>%
    magick::image_transparent(color = color, fuzz = fuzz) -> shape
  shape_width <- shape %>% magick::image_info() %>% dplyr::pull(width)
  shape_height <- shape %>% magick::image_info() %>% dplyr::pull(height)

  # resize the image to be cut from to match the shape
  image_width <- image %>% magick::image_info() %>% dplyr::pull(width)
  image_height <- image %>% magick::image_info() %>% dplyr::pull(height)
  scale_factor <- max(shape_width/image_width, shape_height/image_height)
  # for now, take the crop from the middle of the image
  image %>% magick::image_scale(scale_factor * image_width) %>%
    magick::image_crop(
      paste0(shape_width,"x",shape_height,
             "+",
             (magick::image_info(.)$width - shape_width)/2,
             "+",
             (magick::image_info(.)$height - shape_height)/2)) -> image

  # make the cut!
  magick::image_flatten(c(image, shape)) %>%
    magick::image_trim()
}
