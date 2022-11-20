#' @title package
#' @description Computes a manifold approximation and projection
#' @param dataframe
#' @return object of class umap, containing atleast a component with an embedding and a component with configuration settings
#' @examples
#' package::UMAPgp()
#'
#' @export
umapgp<-function(data,x,variable){
  data_meta <- data %>%
    select(x, variable)
  umap_fit <- data %>%
    select(where(is.numeric)) %>%
    column_to_rownames("x") %>%
    scale() %>%
    umap(n_neighbors=70,min_dist=0.3)
  umap_df <- umap_fit$layout %>%
    as.data.frame()%>%
    rename(UMAP1="V1",
           UMAP2="V2") %>%
    mutate(ID=row_number())%>%
    inner_join(data_meta, by="x")

  umapplot<-umap_df %>%
    ggplot(aes(x = UMAP1,
               y = UMAP2,
               color = variable))+
    geom_point()+
    labs(x = "UMAP1",
         y = "UMAP2",
         subtitle = "UMAP plot")
  return(umapplot)
}
