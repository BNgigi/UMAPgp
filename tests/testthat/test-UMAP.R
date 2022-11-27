
test_that("mutate", {
  df <- data.frame(
    studentname = c("Student1", "Student2", "Student3", "Student4"),
    Math = c(75, 58, 93, 66),
    Eng= c(44, 89, 89, NA))
  df1<-data.frame(
    studentname = c("Student1", "Student2", "Student3", "Student4"),
    Math = c(75, 58, 93, 66),
    Eng= c(44, 89, 89, NA),
    totalMarks=c(119,147,182,NA)

  )
  expect_equal(mutate(df, totalMarks = Math + Eng),df1)
})

test_that("select", {
  df <- data.frame(
    studentname = c("Student1", "Student2", "Student3", "Student4"),
    Math = c(75, 58, 93, 66),
    Eng= c(44, 89, 89, NA))
  df1<-data.frame(
    Math = c(75, 58, 93, 66),
    Eng= c(44,89,89,NA)
    )
  expect_equal(select(df,Math,Eng),df1)

})

test_that("column_to_rownames",{
  data <- data.frame(x1 = LETTERS[1:5],
                     x2 = 5:9)
  data1<-column_to_rownames(data,"x1")
  expect_equal(column_to_rownames(data,"x1"),data1)

})
test_that("inner_join",{
  df1 = data.frame(team=c("A", "B", "C", "D", "E", "F", "G", "H"),
                   points=c(18, 22, 19, 14, 14, 11, 20, 28))
  df2 = data.frame(team=c("A", "B", "C", "D", "G", "H"),
                   assists=c(4, 9, 14, 13, 10, 8))
  df3<-data.frame(team=c("A", "B", "C", "D", "G", "H"),
                  points=c(18, 22, 19, 14, 20, 28),
                  assists=c(4, 9, 14, 13, 10, 8)
                  )
  expect_equal(inner_join(df1, df2, by='team'),df3)

})

test_that("rename",{
  df <- data.frame(col1 = 1:3, col2 = 4:6, col3 = 7:9)
  df1<-data.frame(c1=1:3, col2=4:6, col3=7:9)
  expect_equal(rename(df,"c1"="col1"),df1)

})

test_that("scale",{
  mat <- matrix(1:9, ncol = 3)
  mat1<-scale(mat)

  expect_equal(scale(mat),mat1)
})

test_that("umap",{
  df1<-force(iris)
  df2<-df1%>%select(where(is.numeric))
  df3<-scale(df2)
  df4<-umap(df3)
  expect_equal(umap(df3),df4)

})

test_that("ggplot",{
  df<-force(iris)
  df1<-ggplot(df, aes(x = Petal.Length, y = Petal.Width))+
    xlab("Petal Length")+
    ylab("Petal Width") +
    geom_point(aes(color = Species,shape=Species))+
    geom_smooth(method='lm')+
    ggtitle("Iris Petal Length vs Width")
  expect_equal(ggplot(df, aes(x = Petal.Length, y = Petal.Width))+
                        xlab("Petal Length")+
                        ylab("Petal Width") +
                        geom_point(aes(color = Species,shape=Species))+
                        geom_smooth(method='lm')+
                        ggtitle("Iris Petal Length vs Width"),df1)

})

