# Machine Learning-Based Process Monitoring

## Overview

This repository presents a machine learning-based statistical process monitoring framework developed as part of my M.Sc. research in Statistics at Ege University.

The proposed framework integrates traditional Statistical Process Control (SPC) statistics with modern machine learning algorithms to enhance process monitoring performance.

The study combines control chart-based feature engineering with supervised machine learning models and evaluates their performance under both simulated and real-world scenarios.

## Implemented Methods

### SPC Statistics

* Shewhart 
* Exponentially Weighted Moving Average (EWMA)
* Cumulative Sum Control Chart (CUSUM)

### Machine Learning Models

* Logistic Regression
* Random Forest
* Support Vector Machine (SVM)
* Extreme Gradient Boosting (XGBoost)

## Methodology

1. Generate in-control and out-of-control process observations.
2. Extract SPC-based features.
3. Train machine learning classifiers.
4. Calibrate control limits using Average Run Length (ARL) criteria.
5. Evaluate detection performance through Monte Carlo simulations and real-world anomaly datasets.

## Evaluation Metrics

* Average Run Length (ARL)
* Standard Deviation of Run Length (SDRL)
* Accuracy
* ROC-AUC
* Detection Delay
* False Alarm Rate

## Datasets

The proposed framework was evaluated using both simulated datasets and publicly available benchmark anomaly detection datasets.

## Note

This repository provides an overview and illustrative implementation of the proposed methodology. Full implementation details are reserved for future academic publication.
