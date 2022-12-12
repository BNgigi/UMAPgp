


#' @title UMAPgp package
#' @description Computes Uniform Manifold Approximation and Projection (UMAP) while preserving global structures.
#' @details
#' Create, modify, and delete columns
#' `mutate()` adds new variables and preserves the existing ones
#' `rename()` renames columns
#' Subset columns using their names and types
#' `select()` picks variable basedon their names
#' `where()`selection helper that selects the variables for which a function returns TRUE
#' Assign row names
#' `column_to_rownames()` assigns row names to the dataframe
#' Scaling columns of a matrix
#' `scale()`centers and scales the columns of a numeric matrix
#' Mutating joins
#' `inner_join()`An inner join is a merge operation between two data frame which seeks to only return the
#' records which matched between the two data frames
#' Data visualization
#' `ggplot()`used to declare the input data frame for a graphic and to specify the set of plot aesthetics
#' intended to be common throughout all subsequent layers unless specifically overridden
#' @param data The dataset to be used; it should be a dataframe with no rownames.
#' @param var A variable of interest from the dataset; it should be categorical.
#' @param path path to filename
#' @import ggplot2 dplyr umap datasets  devtools  tibble magrittr tidyverse readr
#' @return  object of class umap, containing atleast a component with an embedding and a component with configuration settings
#' @examples umapgp(var="Species",data=iris)
#' @references Robert E Tarjan and Mihalis Yannakis.(1984). Simple Linear-time algorithms to test chordality of graphs, test acyclicity
#' of hypergraphs.
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
