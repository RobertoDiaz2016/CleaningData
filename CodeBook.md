CodeBook
================

code book that
modifies and updates the available codebooks with the data to
describe
the variables,
the data,
and any transformations or work that you performed to clean up the data called
indicate all the variables and summaries calculated add calculation
along with units,and any other relevant information. add units

Code book variables
-------------------

#### create a table with columns

<table style="width:121%;">
<colgroup>
<col width="13%" />
<col width="15%" />
<col width="19%" />
<col width="18%" />
<col width="23%" />
<col width="19%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">variable type</th>
<th align="left">variable name</th>
<th align="left">description</th>
<th align="left">parameters</th>
<th align="left">transformation</th>
<th align="left">calculation</th>
<th align="left">units</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">function</td>
<td align="left">create.dataset</td>
<td align="left">function to return a dataset using qualifer for directory and filenames</td>
<td align="left">dir - root directory of downloaded files<br />
<br />
dsq - data set qualifier used to designate sub directory or filename</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">dataset</td>
<td align="left">feature_labels</td>
<td align="left">561-feature vector with time and frequency domain variables</td>
<td align="left">none</td>
<td align="left">remove - () . , from func for better readability of column names</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">dataset</td>
<td align="left">features</td>
<td align="left">calculations described by feature_labels</td>
<td align="left">none</td>
<td align="left">made global for reuse in function,redefined features for filtered on mean and std column, see mean_std_columns description</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">vector</td>
<td align="left">mean_std_columns</td>
<td align="left">filter for features functions with only mean and standard deviation variables</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">dataset</td>
<td align="left">activity_labels</td>
<td align="left">activities with id and name</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">dataset</td>
<td align="left">activities</td>
<td align="left">activity ids for experiment</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">dataset</td>
<td align="left">activityname</td>
<td align="left">activitynames for ids</td>
<td align="left">none</td>
<td align="left">derived from activities$activityid</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">dataset</td>
<td align="left">subjects</td>
<td align="left">subject ids for experiment</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">dataset</td>
<td align="left">experiment</td>
<td align="left">test or train indicator</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">vector</td>
<td align="left">zipfileurl</td>
<td align="left">data url of zip file</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">vector</td>
<td align="left">dateDownLoaded</td>
<td align="left">timestamp of download</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">vector</td>
<td align="left">downloaded_files_dir</td>
<td align="left">local working directory for data</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">vector</td>
<td align="left">data_set_qualifier</td>
<td align="left">name of experiment dataset, test and train values used</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">vector</td>
<td align="left">formula_list</td>
<td align="left">mean() functions formula list for input to summarise_</td>
<td align="left">none</td>
<td align="left">derived from names(features)</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">vector</td>
<td align="left">formula_list_names</td>
<td align="left">variable names list for input to summarise_</td>
<td align="left">none</td>
<td align="left">derived from names(features)</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="even">
<td align="left">dataset</td>
<td align="left">experiments</td>
<td align="left">merge test and tran datasets</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
<tr class="odd">
<td align="left">dataset</td>
<td align="left">experiments_summary</td>
<td align="left">summarized expiments dataset</td>
<td align="left">none</td>
<td align="left">group by activiy and subject summarize dataset</td>
<td align="left">none</td>
<td align="left">none</td>
</tr>
</tbody>
</table>

**Refer to unarchived files, README.txt and features\_info.txt, from downloaded\_files\_dir location for more detailed descriptions**
