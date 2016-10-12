#create one R script called run_analysis.R that does the following.

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation 
#   for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.


        # function to return a dataset using qualifer for directory and filenames
        # accomplishes 2. through 4. from above
        create.dataset <- function(dir,dsq){
        # dir - root directory of downloaded files
        # dsq - data set qualifier - used to designate sub directory or filename 
                
        ## Create test data set
        # For each record it is provided:
                

        #- A 561-feature vector with time and frequency domain variables.
        feature_labels <- 
                read.table(paste(dir,"features.txt",sep = "")
                           ,col.names = c("funcid","func"))

        # Remove - () . , from func for better readability of column names
        feature_labels$func <- gsub("-|[()]|\\.|,","",feature_labels$func)
        
        # Features data - make global for reuse
        features <<- 
                read.table(paste(dir,dsq,"\\X_",dsq,".txt",sep = "")
                           ,col.names = feature_labels$func)

        # Filter for features functions with only mean and standard deviation variables
        mean_std_columns <- grep("[Mm]ean|std",feature_labels$func)
        
        # Redefine features for filtered columns  - make global for reuse
        features <<- select(features,mean_std_columns)
        
        #- Its activity label.
        activity_labels <- 
                read.table(paste(dir,"activity_labels.txt",sep = "")
                           ,col.names = c("activityid","activityname"))
        
        # activiites with corresponding variable names
        activities <- 
                read.table(paste(dir,dsq,"\\y_",dsq,".txt",sep = "")
                           ,col.names = c("activityid"))

        # readable description for activity
        activityname <- activity_labels[activities$activityid,"activityname"]
        
        #- An identifier of the subject who carried out the experiment.
        subjects <- 
                read.table(paste(dir,dsq,"\\subject_",dsq,".txt",sep = "")
                           ,col.names = c("subjectid"))

        #- An identifier of the the experiment.
        experiment <- rep("test",times = length(subjects$subjectid))
        
        #Compose dataset from components - this last operation will return dataset
        data.frame(experiment
                           ,subjects
                           ,activities
                           ,activityname
                           ,features
        )
        
        }        


        ## Install and load packages
        print("Install and loading packages if necessary ...")
        if("dplyr" %in% rownames(installed.packages()) == FALSE){
                install.packages("dplyr")
        }         
        library(dplyr)
        
        
        ## Unzip files from url to a data directory in your working directory
        print("Unzipping files if necessary ...")
        # Check for data directory
        if(!file.exists("data")){
                dir.create("data")
        }
        
        # check for zip file
        if(!file.exists(".\\data\\Human+Activity+Recognition+Using+Smartphones.zip")){
                zipfileurl <-
                        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(zipfileurl,
                              destfile = ".\\data\\Human+Activity+Recognition+Using+Smartphones.zip")
                
                # timestamp of download
                dateDownLoaded <- date()
                
                # unpack downloaded zip file
                unzip(zipfile=".\\data\\Human+Activity+Recognition+Using+Smartphones.zip",
                      exdir=".\\data\\Human+Activity+Recognition+Using+Smartphones")
        
        }
        
        # create test and train datasets from download directory data using function
        print("Creating test and train datasets ...")
        downloaded_files_dir <- ".\\data\\Human+Activity+Recognition+Using+Smartphones\\UCI HAR Dataset\\"
        
        data_set_qualifier <- "test"
        test <- create.dataset(downloaded_files_dir,data_set_qualifier)
        
        data_set_qualifier <- "train"
        train <- create.dataset(downloaded_files_dir,data_set_qualifier)
        

        

        
        print("Merging test and train datasets ...")
        ## Merge test and train datasets
        # accomplishes 1. and 5. from above
        

        # create mean() functions formula list for input to summarise_
        formula_list <- paste("~mean(",names(features),")",sep = "")
        formula_list <- sapply(formula_list,function(x) as.formula(x)) 
        
        # create variable names list for input to summarise_
        formula_list_names <- paste("mean(",names(features),")",sep = "")
        
        
        
                
        ## merge datasets 
        # use all=TRUE for full join       
        experiments <- merge(test,train,all=TRUE)
        
        print("Summarizing new dataset ...")
        # group and summarize dataset
        # group by activiy and subject
        experiments_summary <- experiments %>% group_by(activityname,subjectid) %>%
        # summarise features by activiy and subject
        summarise_(.dots = setNames(formula_list, formula_list_names)) 
        
        #output dataset
        print("View tidy dataset")
        View(experiments_summary)
        
        
        
        

        