normal: R(x <- rnorm(n = 100,mean = 0,sd = 1))
    # dollar sign on left-hand side is an assignment
    # dollar sign on RHS is an input
    $data: x
    $true_mean: 0

mean: R(y <- mean(x))
    x: $data
    $mean: y

DSC:
  define:
    simulate: normal
    analyze: mean
  run: simulate * analyze