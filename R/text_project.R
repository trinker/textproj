#' Text Project Template
#'
#' Create a template directory of subdirectories and files for a text project.
#'
#' @param path The path (including project name) for the project.
#' @param open logical. If \code{TRUE} the project will be opened in RStudio.
#' The default is to test if new_project is being used in the global environment,
#' if it is then the project directory will be opened.
#' @keywords project
#' @rdname text_project
#' @export
#' @examples
#' \dontrun{
#' text_project()
#' }
text_project <- function (path = "new", open = is.global(2)){

    path <- gsub("\\s+", "_", path)
    if (path == Sys.getenv("R_HOME")) stop("path can not be `R_HOME`")
    if (file.exists(path)) {
        message(paste0("\"", path, "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("project aborted")
        } else {
             unlink(path, recursive = TRUE, force = FALSE)
        }
    }
    suppressWarnings(invisible(dir.create(path, recursive = TRUE)))

    invisible(lapply(file.path(path, dirs), function(x){
        suppressWarnings(invisible(dir.create(x, recursive = TRUE)))
    }))


    cat(paste(rproj, collapse = "\n"), file = file.path(path, ".Rproj"))

    cat(paste(dat_clean, collapse = "\n"), file = file.path(path, "scripts", "01_data_cleaning.R"))
    cat(paste(analysis, collapse = "\n"), file = file.path(path, "scripts", "02_initial_analysis.R"))

    verify <- all(c(dirs, ".Rproj") %in% dir(path, all.files = TRUE)) &&
        all(file.exists(file.path(path, "scripts", c("01_data_cleaning.R", "02_initial_analysis.R"))))

    if(isTRUE(verify)) {
        message("Looks like everything went according to plan...")
    } else {
        message("Major bummer :-\\ \nLooks like some components of the project template are missing...")
    }
    if (isTRUE(open)){
        open_rstudio(file.path(path, ".Rproj"))
    }

}

#' @param n The number of generations to go back. If used as a function argument
#' \code{n} should be set to 2.
#' @export
#' @rdname text_project
is.global <- function (n = 1) {
    identical(parent.frame(n = n), globalenv())
}


dirs <- c("data", "output", "plots", "reports", "scripts")

categories <- c("## time: %s", "list(", "    cat_1 = c(),",
    "    cat_2 = c()", ")")

rproj <- c("Version: 1.0", "", "RestoreWorkspace: Default", "SaveWorkspace: Default",
    "AlwaysSaveHistory: Default", "", "EnableCodeIndexing: Yes",
    "UseSpacesForTab: No", "NumSpacesForTab: 4", "Encoding: UTF-8",
    "", "RnwWeave: knitr", "LaTeX: pdfLaTeX")

open_rstudio <- function (Rproj.loc) {
    action <- paste(wheresRstudio(), Rproj.loc)
    message("Preparing to open project!")
    try(system(action, wait = FALSE, ignore.stderr = TRUE))
}


wheresRstudio <- function () {
    myPaths <- c("rstudio", "~/.cabal/bin/rstudio", "~/Library/Haskell/bin/rstudio",
        "C:\\PROGRA~1\\RStudio\\bin\\rstudio.exe", "C:\\RStudio\\bin\\rstudio.exe",
        "/Applications/RStudio.app/Contents/MacOS/RStudio")
    panloc <- Sys.which(myPaths)
    temp <- panloc[panloc != ""]
    if (identical(names(temp), character(0))) {
        ans <- readline("RStudio not installed in one of the typical locations.\n \n            Do you know where RStudio is installed? (y/n) ")
        if (ans == "y") {
            temp <- readline("Enter the (unquoted) path to RStudio: ")
        }
        else {
            if (ans == "n") {
                stop("RStudio not installed or not found.")
            }
        }
    }
    short.path <- which.min(unlist(lapply(gregexpr("RStudio",
        temp), "[[", 1)))
    temp[short.path]
}

dat_clean <- c("if (!require(\"pacman\")) install.packages(\"pacman\"); library(pacman)",
    "p_load_gh(\"trinker/rnltk\")", "p_load(dplyr, tidyr, readr)",
    "", "", "dat <- readr::read_csv(\"data/\")", "")

analysis <- c("if (!require(\"pacman\")) install.packages(\"pacman\"); library(pacman)",
    "p_load_gh(\"trinker/rnltk\")", "p_load(dplyr, tidyr, readr, ggplot2)",
    "", "", "dat <- readr::read_csv(\"data/\")", "")
