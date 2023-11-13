# test
# treatment_cols <- function(column){
#   if (str_detect(column, ".DMSO")){
#     str_replace_all(column, ".DMSO", "_untreated")
#   } else if (str_detect(column, ".G007.LK")){
#     str_replace_all(column, ".GOO7.LK", "_treated")
#   }
# }


#maybe a function for transform our uploading datasets
#but needs improvement
#file_tr <- function(origin,filename){
# x<-vroom::vroom("../_raw/origin",
#              show_col_types = FALSE)
#  write.table(x,
#          file = "../data/filename.tsv",
#         sep = "\t",
#        row.names = FALSE, 
#       quote = FALSE)

#filename<- vroom::vroom("../data/filename.tsv", 
#                       show_col_types = FALSE)

#}