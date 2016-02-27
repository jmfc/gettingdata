# First of all open the files and stores each one in a dataframe

xtest <- read.table("./test/X_test.txt")
subjecttest <- read.table("./test/subject_test.txt")
ytest <- read.table("./test/y_test.txt")

xtrain <- read.table("./train/X_train.txt")
subjecttrain <- read.table("./train/subject_train.txt")
ytrain <- read.table("./train/y_train.txt")

# we merge in three dataframes. 

xs <- rbind(xtest, xtrain)
subjects <- rbind(subjecttest, subjecttrain)
ys <- rbind(ytest, ytrain)

# Also we erase the initial data frames to free some memory

rm(xtest, subjecttest, ytest, xtrain, subjecttrain, ytrain)

# It is time to read the variables

features <- read.table("features.txt")

# And we transform the factors to character strings 
features[,2] <- as.character(unlist(features[,2]))

# We find the positions where there are the mean or std. These will we the columns that we have to keep

position <- grep("mean\\(|std", features[,2])

# So we restrict the matrix to the values we are interested in

short <- xs[,position]

# Read the activity table

activity <- read.table("activity_labels.txt")

# And converts the ys data frame to a factor data frame

ys[,1] <- activity[ys[,1],2]

#Change the name of the columns

short <- setNames(short, features[position,2])

# delete data frames not used to free memory

rm(xs, position)

# Transform integer of subjects to factor

subjects[,1] <- as.factor(subjects[,1])

# And add a name to subjects and ys

subjects <- setNames(subjects, "subject")
ys <- setNames(ys, "Activity")

#Finally we put alltogehter in a single data frame and remove the non used data frames

final <- cbind(subjects, ys, short)

rm(subjects, activity, features, short, ys)


# To create the second table we group the table by subject and activity

groups <- group_by(final, subject, Activity, add = TRUE)

# Then we calculate the mean of each column except subject and activity

result <- summarise_each(groups, funs(mean(.,na.rm = TRUE)), -c(subject, Activity))

rm(groups)
