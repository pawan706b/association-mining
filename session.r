install.packages("arules") 
install.packages("tidyverse") 
library("arules")
library("tidyverse")

file_path = "C:/Users/pawan/OneDrive/Desktop/MCDA/sem2/data mining/Assignment 3/sessionDistinctMilestoneDec15.csv"
data <- read.csv(file_path, header = TRUE)  # Replace "your_data.csv" with the actual file path
data

# Transpose data using id and date
transposed_data <- data %>%
  group_by(user_id, date) %>%
  summarise(milestones = list(milestone_name)) %>%
  ungroup()

# Remove the id column
transposed_data$user_id <- NULL

# Convert to transactions
tr <- as(transposed_data$milestones, "transactions")

# Perform association rule mining
rules <- apriori(tr, parameter = list(supp = 0.2, conf = 0.6))

# Print the rules
inspect(rules)

itemsets=unique(generatingItemsets(rules))
write(itemsets)

# Create item frequency plot
itemFrequencyPlot(tr, topN=10, type="absolute", main="Item Frequency")