tic
% We Need to import python modules 
py.importlib.import_module('joblib');
py.importlib.import_module('sklearn.ensemble');

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

% Call function to predict touch
prediction = predict_touch(matlabTable);

if prediction == 1
    disp("Touch")
elseif prediction == 0
    disp("No Touch")
end
toc