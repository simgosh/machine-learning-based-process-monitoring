# SAMPLE IMPLEMENTATION:
# Machine Learning-Based Process Monitoring Framework
#
# DISCLAIMER
#
# This repository contains a simplified implementation
# illustrating the proposed methodology.
#
# Full simulation framework, calibration procedures,
# and experimental settings are reserved for future
# academic publication.



library(dplyr)
library(pROC)

# 1) DATA GENERATION
set.seed(123)
generate_data <- function(n = 1000, delta = 0) {
  data.frame(x = rnorm(n, mean = delta, sd = 1))
}

# Generate in-control and out-of-control observations

df_ic <- generate_data(n = 1000, delta = 0)
df_oc <- generate_data(n = 1000, delta = 1)


# 2) FEATURE ENGINEERING

feature_engineering <- function(df,
                                lambda = 0.1,
                                k = 0.5) {

  x <- df$x
  n <- length(x)

  z  <- numeric(n)
  cp <- numeric(n)

  z[1]  <- 0
  cp[1] <- 0

  for (i in 2:n) {

    z[i] <- lambda * x[i] +
      (1 - lambda) * z[i - 1]

    cp[i] <- max(
      0,
      x[i] - k + cp[i - 1]
    )
  }

  data.frame(
    x      = x,
    dEWMA  = c(0, diff(z)),
    dCPos  = c(0, diff(cp))
  )
}

# Apply feature extraction

feat_ic <- feature_engineering(df_ic)
feat_oc <- feature_engineering(df_oc)

# 3) PREPARE DATASET

X <- rbind(feat_ic, feat_oc)

y <- c(
  rep(0, nrow(feat_ic)),
  rep(1, nrow(feat_oc))
)

dataset <- data.frame(X, y)

# ============================================================
# 4) TRAIN / TEST SPLIT
# ============================================================

set.seed(123)

train_index <- sample(
  1:nrow(dataset),
  0.7 * nrow(dataset)
)

train_data <- dataset[train_index, ]
test_data  <- dataset[-train_index, ]

# 5) LOGISTIC REGRESSION MODEL

model <- glm(
  y ~ .,
  data = train_data,
  family = "binomial"
)

# 6) MODEL EVALUATION

test_scores <- predict(
  model,
  newdata = test_data,
  type = "response"
)

test_pred <- ifelse(
  test_scores >= 0.5,
  1,
  0
)

accuracy <- mean(
  test_pred == test_data$y
)

cat(
  "\nClassification Accuracy:",
  round(accuracy, 4),
  "\n"
)

# 7) ROC-AUC

roc_obj <- roc(
  test_data$y,
  test_scores
)

auc_value <- auc(roc_obj)

cat(
  "ROC-AUC:",
  round(auc_value, 4),
  "\n"
)

plot(
  roc_obj,
  main = "ROC Curve"
)

# END OF SAMPLE IMPLEMENTATION
