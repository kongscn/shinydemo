..fixpath <- function(APP_DIR)
{
  if(!file.exists("ui.R")){
    setwd(file.path(getwd(), APP_DIR))
  }
}
