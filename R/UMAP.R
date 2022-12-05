


#' @title UMAPgp package
#' @description Computes Uniform Manifold Approximation and Projection (UMAP).
#' @param data The dataset to be used should be a dataframe with no rownames.
#' @param var A variable of interest from the dataframe should be categorical.
#' @import ggplot2 dplyr umap datasets  devtools  tibble
#' @return  object of class umap, containing atleast a component with an embedding and a component with configuration settings
#' @examples umapgp(var="Species",data=iris)
#' @export

# Defining  the function and parameters to be passed
umapgp<-function(var,data){

# Preprocessing data for umap
  data <- data %>%
    mutate(ID=row_number())

# Creating a dataframe with all categorical variables with the unique row ID
  data_meta <- data %>%
    select(ID, var)


# Performing UMAP
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
    mutate(ID=row_number())%>%
    inner_join(data_meta, by="ID")
  umap_df$var<- data[, var]

# UMAP Plot
  umapplot<-umap_df %>%
    ggplot(aes(x = UMAP1,
               y = UMAP2,
               color = var))+
    geom_point()+
    labs(x = "UMAP1",
         y = "UMAP2",
         subtitle = "UMAP plot")
  return(umapplot)
}
