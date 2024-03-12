% We Need to import python modules 
py.importlib.import_module('joblib');
py.importlib.import_module('sklearn.ensemble');

% Load Model
model = py.joblib.load('C:\Users\20235600\Desktop\Touch-ML\RFClassifier');
% Create an example data to predict
X_Ball =[1.513287];%[3.034037];
Y_Ball = [0.109077];%[0.855579];
Z_Ball = [-0.239286];%[1.586254];
X_Turtle = [0.640121];%[3.001582];
Y_Turtle = [0.004257];%[0.784243];
Z_Turtle = [1.161693];%[1.401741];
X_dist = X_Ball - X_Turtle;
Y_dist = Y_Ball - Y_Turtle;
Z_dist = Z_Ball - Z_Turtle;
distance = [1.654131];%[0.200467];
matlabTable= table(X_Ball,Y_Ball,Z_Ball,X_Turtle,Y_Turtle,Z_Turtle,X_dist,...
    Y_dist, Z_dist, distance);
% To convert matlab table into pandas dataframe we need to do followings:
% 1. convert table to pandas dictionary
% 2. convert python dictionary to pandas dataframe

% Convert table to cell array
matlabData = table2cell(matlabTable); 
% Convert cell array elements to double
matlabCellArray = cellfun(@double, matlabData, 'UniformOutput', false);
% Convert MATLAB cell array to Python dictionary
pyDict = py.dict();
for i = 1:size(matlabCellArray, 2)
    pyDict{matlabTable.Properties.VariableNames{i}} = matlabCellArray(:, i);
end

% Import the pandas module
pandas = py.importlib.import_module('pandas');
% Convert Python dictionary to pandas DataFrame
pyDataFrame = pandas.DataFrame(pyDict);
% Use the pandas DataFrame to make predictions
predictions = model.predict(pyDataFrame);
% Display Prediction
%disp(int64(predictions))
if int64(predictions) == 1
    disp("Touch")
elseif int64(predictions) == 0
    disp("No Touch")
end