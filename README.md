
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cuttingshapes

<!-- badges: start -->

<!-- badges: end -->

The goal of cuttingshapes is to make it easier to cut shapes out of
images.

## Installation

You can install the development version of cuttingshapes from
[github](https://github.com/annafergusson/cuttingshapes) with:

``` r
devtools:install_github("annafergusson/cuttingshapes")
```

## Example

This is a quick example of cutting a cat shape out of an image of
pumpkins. Because it’s Halloween\!

``` r
library(cuttingshapes)
## basic example code
cut_shape(image = "https://cdn.pixabay.com/photo/2019/09/08/19/01/pumpkin-4461665_1280.jpg",
          shape = "https://imageog.flaticon.com/icons/png/512/30/30209.png?size=1200x630f&pad=10,10,10,10&ext=png&bg=FFFFFFFF")
```

<img src="man/figures/README-example-1.png" width="100%" />
