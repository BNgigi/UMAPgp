


#' @title UMAPgp package
#' @description Computes a manifold approximation and projection
#' @param data The dataset to be used for analysis, it should be a dataframe.
#' @param var A variable of interest from the dataframe.
#' @import ggplot2
#' @import dplyr
#' @import umap
#' @import datasets
#' @import devtools
#' @return  object of class umap, containing atleast a component with an embedding and a component with configuration settings
#' @examples umapgp(var=Species,data=iris)
#' @export


umapgp<-function(var,data){
  data <- data %>%
    mutate(ID=row_number())
  data_meta <- data %>%
    select(ID, var)
  set.seed(142)
  umap_fit <- data %>%
    select(where(is.numeric)) %>%
    column_to_rownames("ID") %>%
    scale() %>%
    umap(n_neighbors=70,min_dist=0.3)
  umap_df <- umap_fit$layout %>%
    as.data.frame()%>%
    rename(UMAP1="V1",
           UMAP2="V2") %>%
    mutate(x=row_number())%>%
    inner_join(data_meta, by="ID")

  umapplot<-umap_df %>%
    ggplot2(aes(x = UMAP1,
                y = UMAP2,
                color = var()))+
    geom_point()+
    labs(x = "UMAP1",
         y = "UMAP2",
         subtitle = "UMAP plot")
  return(umapplot)
}
