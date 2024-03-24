% This function is used to load the model trained in Python and get
% prediction of touch/no touch
function prediction= predict_touch(table)
    % load model
    model = py.joblib.load('RFClassifier');
    % Convert table to cell array
    matlabData = table2cell(table); 
    % Convert cell array elements to double
    matlabCellArray = cellfun(@double, matlabData, 'UniformOutput', false);
    % Convert MATLAB cell array to Python dictionary
    pyDict = py.dict();
    for i = 1:size(matlabCellArray, 2)
        pyDict{table.Properties.VariableNames{i}} = matlabCellArray(:, i);
    end

    % Import the pandas module
    pandas = py.importlib.import_module('pandas');
    % Convert Python dictionary to pandas DataFrame
    pyDataFrame = pandas.DataFrame(pyDict);
    % Use the pandas DataFrame to make predictions
    predictions= model.predict(pyDataFrame);
    % Convert np array to int
    prediction = int64(predictions);
end