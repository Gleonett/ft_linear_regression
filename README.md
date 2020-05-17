# ft_linear_regression

It is the simple iOS application for training linear regression with gradient descent optimization algorithm. You can change parameters to see how do they affect learning.

## Tested with:
* macOS Catalina - 10.15.5 Beta
* Xcode - 11.4.1
* iPhone 8
* iOS - 13.3.1

## Get started:
```
git clone https://github.com/Gleonett/ft_linear_regression.git
cd ft_linear_regression
git submodule update --init --recursive
```
1. Drag the `Charts/Charts.xcodeproj` to your project  
2. Go to your target's settings, hit the "+" under the "Embedded Binaries" section, and select the Charts.framework
3. Build and run

## Explanation
### Main view
![Main_view](https://github.com/Gleonett/ft_linear_regression/blob/master/readme_images/main_view.jpg)
Main view contains visualization for model, dataset and buttons:
* `Parameters` - Link to Parameters view
* `Reset` - Reset already trained linear regression model's parameters
* `Train` - Train model
* `Predict` - Link to Prediction view
### Parameters view
![Parameters_view](https://github.com/Gleonett/ft_linear_regression/blob/master/readme_images/parameters_view.jpg)
`Learning rate` is a tuning parameter in an optimization algorithm that determines the step size at each iteration while moving toward a minimum of a loss function
```
learningRate = initinalLearningRate / (decay * currentEpoch + 1)
```
Model will train either until the end of `epochs` or until:
```
abs(InterceptN - InterceptN-1) < AccuracyThreshold
and
abs(BiasN - BiasN-1) < AccuracyThreshold
```
### Prediction view
![Prediction_view](https://github.com/Gleonett/ft_linear_regression/blob/master/readme_images/prediction_view.jpg)

`regressor` is the value we want to predict the dependent
