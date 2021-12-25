library(RSQLite)
data("mtcars")
mtcars$car_names <- rownames(mtcars)
rownames(mtcars) <- c()
head(mtcars)
conn <- dbConnect(RSQLite::SQLite(), "carshello.db")
dbWriteTable(conn, "cars_data", mtcars )
dbListTables(conn)
dbListFields(conn, "cars_data")
dbReadTable(conn, "cars_data")
rdd <- dbReadTable(conn, "cars_data")
dbGetQuery(conn, "SELECT * FROM cars_data LIMIT 10")
dbGetQuery(conn, "SELECT car_names, hp, cyl, WHERE cyl=8")
dbGetQuery(conn, "SELECT car_names, hp, cyl FROM cars_data WHERE cyl=8")
dbGetQuery(conn, "SELECT car_names, hp, cyl FROM cars_data
                  WHERE car_names LIKE 'M%' AND cyl IN (6,8)")

mpg <- 18
cyl <- 4
dbGetQuery(conn, "SELECT car_names, hp, cyl FROM cars_data
                  WHERE mpg >= ? AND cyl == ? ",
           params = c(mpg,cyl))
