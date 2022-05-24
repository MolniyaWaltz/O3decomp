function [test_data] = data_inputter(test_textfile)
%DATA_INPUTTER Takes a test data testx.txt from Arduino data and creates
%the appropriate matrix of data points.
    format longG
    try
        test_data = readtable(test_textfile, 'Delimiter', {' -> ', ', '});
        test_data.Properties.VariableNames = {'time','voltage1','amplitude','voltage2','ppm'};
    catch
        fprintf(strcat("DATA_INPUTTER.m: No text file ",test_textfile," found.\n"));
    end
end 

