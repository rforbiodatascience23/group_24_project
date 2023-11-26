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


###############################################################################

generate_lm_genes <- function(df, treatm){
  df |> 
  filter(treatment == 'DMSO' | treatment == treatm) |>    # Filter for control
  mutate(Treated = ifelse(treatment == treatm,1,0))|>     #create binary indicator of treatment
  pivot_longer(cols = -c(treatment,replicate,Treated), 
               names_to = 'Gene', 
               values_to = 'rel_log2_expr_level') |>      #pivot longer for gene expressions
  group_by(Gene) |>                                       
  nest() |> 
  mutate(model_object = 
           map(.x = data, 
               .f = ~lm(formula = rel_log2_expr_level ~ Treated, 
                        data = .x))) |>                  # do the lm for each gene
  mutate(model_object_tidy = map(model_object, tidy, conf.int = TRUE)) |>    # extract the nested lm df for each gene
  unnest(model_object_tidy) |>     #unnest it
  filter(term == 'Treated') |>   
  ungroup() |> 
  mutate(q.value = p.adjust(p.value, method = "bonferroni"),
         signif = q.value < 0.05)    # benferroni adjust the p-values
}

###############################################################################
signif_genes_error_bars <- function(df, gene_title){
  p <- df |> 
  filter(signif==TRUE) |>  #filter by onfly signififcantly up or down regulated
  arrange(estimate) |>    #sort by estimate of treatment effect on expression
    mutate(Gene = factor(Gene, levels = unique(Gene))) |> 
    ggplot(aes(x=estimate,y = Gene)) +
    geom_point() +
    geom_errorbar(aes(xmin = conf.low, 
                      xmax = conf.high),
                  width = 0.2) +
    labs(title=paste0('Genes Associated with Treatment of ', 
                      paste(gene_title),
                      ' in mouse'), 
         xlab='Estimate (95% CIs)', 
         ylab='Gene')+
    theme(axis.text.y = element_text(size=6),
          panel.background = element_rect(fill = "white"),
          panel.grid.major = element_line(color = "grey", size = 0.1),
          panel.grid.minor = element_line(color = "lightgrey", size = 0.1),
          plot.title = element_text(size = 11))+
    geom_vline(aes(xintercept=0), linetype="solid", color="black")    #plot estimate and error bars of signif genes
  print(p)
  
  filename <- "../results/05_key_plot_2.png"
  if (gene_title == 'GK007LK') {
    # Save the key plot
    ggsave(filename, 
           plot = p, 
           path = getwd(), 
           width = 10, 
           height = 8, 
           units = "in", 
           bg = "white", 
           device = "png")
    }
  }

###############################################################################
volcano_plot <- function(df, gene_title) {
  p <- df |> 
    mutate(neglog10p = -log10(p.value)) |> 
    arrange(estimate) |>   #sort by estimate of treatment effect on expression
    mutate(Gene = factor(Gene, levels = unique(Gene))) |> 
    ggplot(aes(x = estimate, y = neglog10p, color = signif, label = Gene)) +
    geom_point(alpha = 0.15) +
    labs(title=paste0('Genes Plotted by log2fold Change and q-value from Treatment of ', 
                      paste(gene_title),
                      ' in mouse'),
         xlab = 'Log2 Fold Change',
         ylab = '-log10(p-value)') +
    scale_color_manual(values = c(`FALSE` = "blue", `TRUE` = "red")) +
    theme_minimal() +
    theme(plot.title = element_text(size = 11))
  print(p)
  

  filename <- paste0('../results/05_key_plot_1.png')
  if (gene_title == 'GL007LK') {
    # Save the key plot
    ggsave(filename, 
           plot = p, 
           path = getwd(), 
           width = 10, 
           height = 8, 
           units = "in", 
           bg = "white", 
           device = "png")
  }
  
}
###########

zero_replacement <- function(zeroes_removed_df, cols_to_join){
# Replace the zero values in the dataset with a calculated minimum-non-zero value per observation multiplied by 0.65. Thus we ensure that the 0 values that cannot undergo log transformation are replaced by a small non-zero value.
zeroes_replaced_df <- zeroes_removed_df |>
  rowwise() |>
  mutate(min_non_zero = min(c_across
                            (where
                              (is.numeric))[c_across(where
                                                     (is.numeric)) != 0], na.rm = TRUE)) |>
  ungroup() |>
  mutate(across
         (where
           (is.numeric), ~ ifelse(. == 0, 
                                  0.65 * min_non_zero,
                                  .))) |>
  select(-min_non_zero)

#This part calculated the sum across all genes for every observation in the dataset with the replaced zeroes
zeroes_replaced_sums_df <- zeroes_replaced_df |>
  rowwise() |>
  mutate(total_sum = sum(c_across
                         (everything()),
                         na.rm = TRUE))

n = 1000000 # the data are normalized in TPM that is why we selected 1 million as n

#Data normalization. This part ensures that different experiments with varying total expression levels are brought to consistant scale
scaled_data_df <- zeroes_replaced_sums_df |>
  mutate(scaling_factor = n / total_sum) |>
  rowwise() |>
  mutate(across(-c(total_sum, scaling_factor), ~ . * scaling_factor)) |>
  select(-total_sum, -scaling_factor)

scaled_data_df |>
  rowwise() |>
  mutate(row_sums = sum(c_across
                        (everything()), 
                        na.rm = TRUE))

#This part of the code binds the normalized and scaled expression data with the first columns from the original df data.
joined_df <- bind_cols(cols_to_join,
                          scaled_data_df)
print(joined_df)
}

