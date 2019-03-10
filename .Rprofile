options("digits.secs"=3)            # show sub-second time stamps
options(max.print=1000)             # don't kill emacs by printing big data.frames

local({r <- getOption("repos");r["CRAN"] <- "https://cloud.r-project.org";options(repos = r)})

exit <- function() { q("no") }

##http://jeromyanglim.tumblr.com/post/33825729070/function-to-view-r-data-frame-in-spreadsheet
view <- function(data, autofilter=TRUE, open_command='xdg-open') {
    # data: data frame
    # autofilter: whether to apply a filter to make sorting and filtering easier
    # open_command: command used to open xlsx file
    #     on Ubuntu this `xdg-open` works
    #     on other platforms, perhaps `open`
    #     or the command name for the spreadsheet softare might work
    ##require(XLConnect)
    temp_file <- paste0(tempfile(), '.csv')
    ##wb <- loadWorkbook(temp_file, create = TRUE)
    ##createSheet(wb, name = "temp")
    ##writeWorksheet(wb, data, sheet = "temp", startRow = 1, startCol = 1)
    ##if (autofilter) setAutoFilter(wb, 'temp', aref('A1', dim(data)))
    ##saveWorkbook(wb, )
    write.csv(data, temp_file, row.names = FALSE)
    system(paste(open_command, temp_file))
}

#http://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session
# improved list of objects
.ls.objects <- function (pos = 1, pattern, order.by,
                        decreasing=FALSE, head=FALSE, n=5) {
    napply <- function(names, fn) sapply(names, function(x)
                                         fn(get(x, pos = pos)))
    names <- ls(pos = pos, pattern = pattern)
    obj.class <- napply(names, function(x) as.character(class(x))[1])
    obj.mode <- napply(names, mode)
    obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
    obj.size <- napply(names, object.size)
    obj.dim <- t(napply(names, function(x)
                        as.numeric(dim(x))[1:2]))
    vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
    obj.dim[vec, 1] <- napply(names, length)[vec]
    out <- data.frame(obj.type, obj.size, obj.dim)
    names(out) <- c("Type", "Size", "Rows", "Columns")
    if (!missing(order.by))
        out <- out[order(out[[order.by]], decreasing=decreasing), ]
    if (head)
        out <- head(out, n)
    out
}
# shorthand
lsos <- function(..., n=10) {
    .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}

r.autoyas.esc <- function(str) {
  str <- gsub("$", "\\$", str, fixed=TRUE)
  str <- gsub("`", "\\`", str, fixed=TRUE)
  return(str)
}

r.autoyas.create <- function(funname) {
  if (!existsFunction(funname)) return(" ")
  formals <- formals(funname)
  nr <- 0
  closebrackets <- 0
  str <- NULL
  for (field in names(formals)) {
    type <- typeof(formals[[field]])
    if (type=="symbol" & field!="...") {
      nr <- nr+1
      str <- append(str, paste(", ${",nr,":",field,"}", sep=""))
    } else if (type=="symbol" & field=="...") {
      nr <- nr+2
      str <- append(str, paste("${",nr-1,":, ${",nr,":",field,"}}", sep=""))
    } else if (type=="character") {
      nr <- nr+2
      str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":\"",gsub("\"", "\\\"", r.autoyas.esc(encodeString(formals[[field]])), fixed=TRUE),"\"}}", sep=""))
    } else if (type=="logical") {
      nr <- nr+2
      str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":",as.character(formals[[field]]),"}}", sep=""))
    } else if (type=="double") {
      nr <- nr+2
      str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":",as.character(formals[[field]]),"}}", sep=""))
    } else if (type=="NULL") {
      nr <- nr+2
      str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":NULL}}", sep=""))
    } else if (type=="language") {
      nr <- nr+2
      str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":",r.autoyas.esc(deparse(formals[[field]])),"}}", sep=""))
    }
  }
  str <- paste(str, sep="", collapse="")
  if (grepl(", ", str, fixed=TRUE)) str <- sub(", ", "", str) # remove 1st ', ' (from 1st field)
  str <- paste("(",str,")", sep="")
  return(str)
}

.backup_packages <- function(filename = "~/backup/packages/installed_packages.rda"){
  packages <- installed.packages()[, "Package"]
  save(packages, file = filename)
}

.restore_packages <- function(filename = "~/backup/packages/installed_packages.rda"){
  load(filename)
  installed <- packages %in% installed.packages()[, "Package"]
  if (length(packages[!installed]) >= 1){
    install.packages(packages[!installed])
  }
}

#if (interactive()) {
#  suppressMessages(require(usethis))
#}

options(
  devtools.name = "Diego Valle-Jones",
  devtools.desc.author = 'person("Diego", "Valle-Jones", email = "diego@diegovalle.net", role = c("aut", "cre"))',
  devtools.desc.license = "MIT + file LICENSE"
)


.libPaths("/home/diego/R/rpackages")
#message("Using library: ", .libPaths()[1])

