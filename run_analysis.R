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
                

        # acceleration col.names key
        # first character - type of acceleration t = total, b = body, g = gyro
        # second character - acceleration abbreviated - a         
        # third character - direction of measurement - x,y,z
        # fourth - seventh characters - reading prefix - rdng
        # eigth - tenth characters - index of one of the 128 readings - 1:128
                
        #- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
        # total data
        total_acc_x <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\total_acc_x_",dsq,".txt",sep="")
                    ,col.names = paste("taxrdng",seq(128),sep = ""))
        total_acc_y <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\total_acc_y_",dsq,".txt",sep="")
                    ,col.names = paste("tayrdng",seq(128),sep = ""))
        total_acc_z <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\total_acc_z_",dsq,".txt",sep="")
                    ,col.names = paste("tazrdng",seq(128),sep = ""))
        
        # body data
        body_acc_x <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\body_acc_x_",dsq,".txt",sep="")
                    ,col.names = paste("baxrdng",seq(128),sep = ""))
        body_acc_y <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\body_acc_y_",dsq,".txt",sep="")
                    ,col.names = paste("bayrdng",seq(128),sep = ""))
        body_acc_z <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\body_acc_z_",dsq,".txt",sep="")
                    ,col.names = paste("bazrdng",seq(128),sep = ""))
        
        #- Triaxial Angular velocity from the gyroscope. 
        # gyro data
        gyro_acc_x <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\body_gyro_x_",dsq,".txt",sep="")
                    ,col.names = paste("gaxrdng",seq(128),sep = ""))
        gyro_acc_y <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\body_gyro_y_",dsq,".txt",sep="")
                    ,col.names = paste("gayrdng",seq(128),sep = ""))
        gyro_acc_z <- 
         read.table(paste(dir,dsq,"\\Inertial Signals\\body_gyro_z_",dsq,".txt",sep="")
                    ,col.names = paste("gazrdng",seq(128),sep = ""))
        

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
                           ,body_acc_x
                           ,body_acc_y
                           ,body_acc_z
                           ,gyro_acc_x
                           ,gyro_acc_y
                           ,gyro_acc_z
                           ,total_acc_x
                           ,total_acc_y
                           ,total_acc_z
                           ,features
        )
        
        }        


        ## Install and load packages
        if("dplyr" %in% rownames(installed.packages()) == FALSE){
                install.packages("dplyr")
        }         
        library(dplyr)
        
        
        ## Unzip files from url to a data directory in your working directory
        # Check for data directory
        if(!file.exists("data")){
                dir.create("data")
        }
        
        # data url of zip file
        zipfileurl <-
                "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(zipfileurl,
                      destfile = ".\\data\\Human+Activity+Recognition+Using+Smartphones.zip")
        
        # timestamp of download
        dateDownLoaded <- date()
        
        # unpack downloaded zip file
        unzip(zipfile=".\\data\\Human+Activity+Recognition+Using+Smartphones.zip",
              exdir=".\\data\\Human+Activity+Recognition+Using+Smartphones")
        

        # create test and train datasets from download directory data using function
                
        downloaded_files_dir <- ".\\data\\Human+Activity+Recognition+Using+Smartphones\\UCI HAR Dataset\\"
        
        data_set_qualifier <- "test"
        test <- create.dataset(downloaded_files_dir,data_set_qualifier)
        
        data_set_qualifier <- "train"
        train <- create.dataset(downloaded_files_dir,data_set_qualifier)
        

        

        
        
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
        

        # group and summarize dataset
        # group by activiy and subject
        experiments_summary <- experiments %>% group_by(activityname,subjectid) %>%
        # summarise features by activiy and subject
        summarise_(.dots = setNames(formula_list, formula_list_names)) 
        