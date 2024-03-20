% This function is used to load the model trained in Python and get
% prediction of touch/no touch
function predictions = multiple_prediction(table)
    % Load model
    model = py.joblib.load('RFClassifier');
    
    % Preallocate space for predictions
    num_rows = size(table, 1);
    predictions = zeros(num_rows, 1, 'int64');
    
    % Iterate over each row of the table
    for row = 1:num_rows
        % Convert row to cell array
        row_data = table2cell(table(row, :));
        
        % Convert cell array elements to double
        row_data = cellfun(@double, row_data, 'UniformOutput', false);
        
        % Convert MATLAB cell array to Python dictionary
        pyDict = py.dict();
        for i = 1:size(row_data, 2)
            pyDict{table.Properties.VariableNames{i}} = row_data(:, i);
        end
        
        % Import the pandas module
        pandas = py.importlib.import_module('pandas');
        
        % Convert Python dictionary to pandas DataFrame
        pyDataFrame = pandas.DataFrame(pyDict);
        
        % Use the pandas DataFrame to make predictions
        py_predictions = model.predict(pyDataFrame);
        
        % Convert np array to int and store the prediction
        predictions(row) = int64(py_predictions);
    end
end