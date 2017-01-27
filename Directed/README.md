# Directed vs Undirected project Scripts
For the direct vs undirect project

## START
Load in 'context_index.mat' which will be located with the .mov and .csv files. This has 2 fields, directed and undirected.
go to the .mat folder, and run:


```
>> FS_Move(directed,undirected,'*.mat');
```

This will separate the .mat files into 2 directories.

```
>> FS_Template_match
```

Manually remove bad .gif trials from bad extractions:


```
>>FS_Prune % run in the mat directory
```

Follow protocols for template matching and ROI selection, which can be found on the FreedomScope wiki

Rename roi_ave into 'Directed' and 'Undirected' respectively. Then, to format ROIs into something useable:

```
>> FS_Format_Directed(Directed, Undirected)
```


Some functions to tun:

```
>> FS_plot(data)       % Plot the variance between the cells

>> FS_schnitz(data)    % Make schnitzer plots of data
```
