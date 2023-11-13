download_csv <- function(file_url, file_name) {
  # Download file if it doesn't exist
  if (!file.exists(str_c(raw_dir, file_name, ".csv"))) {
    download.file(url = file_url, destfile = str_c(raw_dir, file_name, ".csv"))
  }
  # Read data into a data frame
  df <- read_csv(file = str_c(raw_dir, file_name, ".csv"), delim = ",")
  
  # Write data to a TSV file
  write_tsv(x = df, file = str_c(data_dir, file_name, ".tsv.gz"))
  
  # Read data from TSV
  df <- read_tsv(file = str_c(data_dir, file_name, ".tsv.gz"))
}



-------------------------------------------------------------------------------
  
download_txt <- function(file_url, file_name) {
  # Download file if it doesn't exist
  if (!file.exists(str_c(raw_dir, file_name, ".txt"))) {
    download.file(url = file_url, destfile = str_c(raw_dir, file_name, ".txt"))
  }
  # Read data into a data frame
  df <- read_csv(file = str_c(raw_dir, file_name, ".txt"))
  
  # Write data to a TSV file
  write_tsv(x = df, file = str_c(data_dir, file_name, ".tsv.gz"))
  
  # Read data from TSV
  df <- read_tsv(file = str_c(data_dir, file_name, ".tsv.gz"))
}



-------------------------------------------------------------------------------