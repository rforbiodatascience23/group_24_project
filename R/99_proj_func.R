download_csv <- function(file_url, file_name) {
  raw_dir <- "../data/_raw/"
  data_dir <- "../data/"
  # Downloads file if it doesn't exist
  if (!file.exists(str_c(raw_dir, file_name, ".csv"))) {
    download.file(url = file_url, destfile = str_c(raw_dir, file_name, ".csv"))
  }
  # Reads data into a data frame
  df <- read_csv(file = str_c(raw_dir, file_name, ".csv"),
                 na = c("", "NA", "N/A","na"))
  
  # Writes data to a TSV file
  write_tsv(x = df, file = str_c(data_dir, file_name, ".tsv.gz"))
  
  # Reads data from TSV
  df <- read_tsv(file = str_c(data_dir, file_name, ".tsv.gz"))
}


###############################################################################
  
download_txt <- function(file_url, file_name) {
  raw_dir <- "../data/_raw/"
  data_dir <- "../data/"
  # Download file if it doesn't exist
  if (!file.exists(str_c(raw_dir, file_name, ".txt"))) {
    download.file(url = file_url, destfile = str_c(raw_dir, file_name, ".txt"))
  }
  # Read data into a data frame
  df <- read_delim(file = str_c(raw_dir, file_name, ".txt"),
                  delim = "\t",
                  na = c("", "NA", "N/A","na"))
                
  # Write data to a TSV file
  write_tsv(x = df, file = str_c(data_dir, file_name, ".tsv.gz"))
  
  # Read data from TSV
  df <- read_tsv(file = str_c(data_dir, file_name, ".tsv.gz"))
}


###############################################################################

generate_dir <- function(){
  data_dir <- "../data/"
  if( !dir.exists(data_dir) ){
    dir.create(path = data_dir)
  }
  
  raw_dir <- "../data/_raw/"
  if( !dir.exists(raw_dir) ){
    dir.create(path = raw_dir)
  }
}


###############################################################################

head_all <- function(alist){
  purrr::map(.x = alist,
      .f = ~head(.x)) 
}


###############################################################################

summary_all <- function(alist){
  purrr::map(.x = alist,
             .f = ~summary(.x)) 
}


###############################################################################

nas_present <- function(alist){
  if (any(is.na(alist))) {
    cat("There are NA values in the data frame.\n")
  } else {
    cat("There are no NA values in the data frame.\n")
  }
}

