tic
% We Need to import python modules 
py.importlib.import_module('joblib');
py.importlib.import_module('sklearn.ensemble');

% Create an example data to predict
X_Ball =[1.513287];
Y_Ball = [0.109077];
Z_Ball = [-0.239286];
X_Turtle = [0.640121];
Y_Turtle = [0.004257];
Z_Turtle = [1.161693];
X_dist = X_Ball - X_Turtle;
Y_dist = Y_Ball - Y_Turtle;
Z_dist = Z_Ball - Z_Turtle;
distance = [1.654131];
Table1 = table(X_dist, Y_dist, Z_dist, distance);
% % Second Sample
% X_Ball = [3.034037];
% Y_Ball = [0.855579];
% Z_Ball = [1.586254];
% X_Turtle = [3.001582];
% Y_Turtle = [0.784243];
% Z_Turtle = [1.401741];
% X_dist = X_Ball - X_Turtle;
% Y_dist = Y_Ball - Y_Turtle;
% Z_dist = Z_Ball - Z_Turtle;
% distance = [0.200467];
% Table2= table(X_dist, Y_dist, Z_dist, distance);
% Create a new Table including both tables
% Table = [Table1; Table2];

% Predict
predictions = multiple_prediction(Table1);
% 
% for sample = 1:size(predictions)
%     if sample == 1
%         disp("Touch")
%     elseif sample == 0
%         disp("No Touch")
%     end
% end
toc