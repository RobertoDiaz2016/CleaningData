code book describes the variables

function: create.dataset  
description: function to return a dataset using qualifer for directory and filenames   
function parameters
- dir - root directory of downloaded files
- dsq - data set qualifier - used to designate sub directory or filename 
tranformation: none  

datasets:
- total_acc_x
- total_acc_y
- total_acc_z
- body_acc_x
- body_acc_y
- body_acc_z
- gyro_acc_x
- gyro_acc_y
- gyro_acc_z  
description: Inertial Signals acceration data for body, gyroscope and total readings  
tranformation: loaded with variable names defined by the columns names for each of               the 128 readings
        	columns names
- acceleration col.names key
- first character - type of acceleration t = total, b = body, g = gyro
- second character - acceleration abbreviated - a         
- third character - direction of measurement - x,y,z
- fourth - seventh characters - reading prefix - rdng
- eigth - tenth characters - index of one of the 128 readings - 1:128

vector: feature_labels  
description: 561-feature vector with time and frequency domain variables  
tranformation: Remove - () . , from func for better readability of column names  

dataset: features  
description: calculations described by feature_labels  
transformation: made global for reuse in function,
                redefined features for filtered on mean and std column
                see mean_std_columns description  
	
vector:mean_std_columns  
description: filter for features functions with only mean and standard deviation variables  
transformation: none  

dataset: activity_labels  
description: activities with id and name  
transformation: none  

dataset: activities 
description: activity ids for experiment  
transformation: transformation  

dataset: activityname  
description: activitynames for ids  
transformation: derived from activities$activityid  

dataset: subjects  
description: subject ids for experiment  
transformation: none  

dataset: experiment  
description: test or train indicator  
tranformation:none  

vector: zipfileurl  
description: data url of zip file  
tranformation:none  

vector: dateDownLoaded  
description: timestamp of download  
tranformation:none  
	
vector: downloaded_files_dir  
description: local working directory for data  
tranformation:none  

vector: data_set_qualifier  
description: name of experiment dataset, test and train values used  
tranformation:none  

vector: formula_list  
description: mean() functions formula list for input to summarise_  
tranformation: derived from names(features)  

vector: formula_list_names  
description: variable names list for input to summarise_  
tranformation: derived from names(features)  

dataset: experiments 
description: merge test and tran datasets  
tranformation: none  

dataset: experiments_summary  
description: summarized expiments dataset  
transform: group by activiy and subject  
           summarize dataset  

refer to unarchived files,README.txt and features_info.txt, from downloaded_files_dir location for more detailed descriptions  
