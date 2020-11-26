library(parsnip)
library(recipes)
library(magrittr)
library(rsample)


# choosing 75% of the data to be the training data
splitCars <- initial_split(mtcars, prop = .70)
# extracting training data and test data as two seperate dataframes
trainingCars <- training(splitCars)
testingCars  <- testing(splitCars)

carModel <- linear_reg() %>%
              set_engine("lm")

carWorkflow <- workflow() %>%
                add_model(carModel)

carRecipe <- recipe(mpg ~ cyl + disp, trainingCars) %>%
              step_log(disp)


workflow <- add_recipe(carWorkflow, carRecipe)

fit_workflow <- fit(workflow, trainingCars)


predict(fit_workflow, testingCars)
