textproj
============


[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/trinker/textproj.svg?branch=master)](https://travis-ci.org/trinker/textproj)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>
![](tools/textproj_logo/r_textproj.png)

**textproj** is a project template for text projects. The package has
one function, `text_project`. It creates the following structure of
subdirectories and files:

    template
        |
        |   .Rproj
        |   
        +---data
        +---output
        +---plots
        +---reports
        \---scripts
                01_data_cleaning.R
                02_initial_analysis.R


Table of Contents
============

-   [[Installation](#installation)](#[installation](#installation))
-   [[Contact](#contact)](#[contact](#contact))

Installation
============


To download the development version of **textproj**:

Download the [zip
ball](https://github.com/trinker/textproj/zipball/master) or [tar
ball](https://github.com/trinker/textproj/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/textproj")

Contact
=======

You are welcome to:  -   submit suggestions and bug-reports at:     <https://github.com/trinker/textproj/issues>  

-   send a pull request on: <https://github.com/trinker/textproj/>  
-   compose a friendly e-mail to: <tyler.rinker@gmail.com>