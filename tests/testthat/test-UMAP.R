
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
