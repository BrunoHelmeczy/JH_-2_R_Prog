##Factors

x <- factor(c("yes","yes","no","yes","no"))
x
table(x)
unclass(x)
attr(x,"levels")
x <- factor(c("yes", "yes", "no", "yes", "no"),
            levels = c("yes", "no"))

y <- data.frame(foo = 1:4, bar = c(T,T,F,F))

 

