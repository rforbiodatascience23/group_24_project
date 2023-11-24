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
  filter(treatment == 'DMSO' | treatment == treatm) |> 
  mutate(Treated = ifelse(treatment == treatm,1,0))|> 
  pivot_longer(cols = -c(treatment,replicate,Treated), 
               names_to = 'Gene', 
               values_to = 'rel_log2_expr_level') %>% 
  group_by(Gene) |> 
  nest() %>% 
  mutate(model_object = 
           map(.x = data, 
               .f = ~lm(formula = rel_log2_expr_level ~ Treated, 
                        data = .x))) %>% 
  mutate(model_object_tidy = map(model_object, tidy, conf.int = TRUE)) %>% 
  unnest(model_object_tidy) %>% 
  filter(term == 'Treated') |>
  ungroup() %>% 
  mutate(q.value = p.adjust(p.value, method = "bonferroni"),
         signif = q.value < 0.05)
}

###############################################################################
signif_genes_error_bars <- function(df, gene_title){
  p <- df %>% 
  filter(signif==TRUE) %>% 
  arrange(estimate) |> 
    mutate(Gene = factor(Gene, levels = unique(Gene))) |> 
    ggplot(aes(x=estimate,y = Gene)) +
    geom_point() +
    geom_errorbar(aes(xmin = conf.low, 
                      xmax = conf.high),
                  width = 0.2) +
    labs(title=paste0('Genes Associated with treatment of', 
                      paste(gene_title),
                      'in mouse'), 
         xlab='Estimate (95% CIs)', 
         ylab='Gene')+
    theme(axis.text.y = element_text(size=6),
          panel.background = element_rect(fill = "white"),
          panel.grid.major = element_line(color = "grey", size = 0.1),
          panel.grid.minor = element_line(color = "lightgrey", size = 0.1),
          plot.title = element_text(size = 11))+
    geom_vline(aes(xintercept=0), linetype="solid", color="black")
  print(p)
  
  filename <- paste0("../results/signif_genes_", gene_title, ".png")
  ggsave(filename, plot = p, path = getwd(), width = 10, height = 10, units = "in")
}

###############################################################################
volcano_plot <- function(df, gene_title) {
  p <- df %>% 
    mutate(neglog10p = -log10(p.value)) %>%
    arrange(estimate) %>%
    mutate(Gene = factor(Gene, levels = unique(Gene))) %>%
    ggplot(aes(x = estimate, y = neglog10p, color = signif, label = Gene)) +
    geom_point(alpha = 0.1) +
    labs(title=paste0('Genes plotted by lof2fold change and q-value from treatment of', 
                      paste(gene_title),
                      'in mouse'),
         xlab = 'Log2 Fold Change',
         ylab = '-log10(p-value)') +
    scale_color_manual(values = c(`FALSE` = "blue", `TRUE` = "red")) +
    theme_minimal() +
    theme(plot.title = element_text(size = 11))
  print(p)
  
  filename <- paste0("../results/volcano_", gene_title, ".png")
  ggsave(filename, plot = p, path = getwd(), width = 10, height = 10, units = "in")
}



