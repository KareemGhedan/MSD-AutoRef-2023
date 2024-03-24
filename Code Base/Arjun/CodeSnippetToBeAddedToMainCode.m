%% This code snippet will be added to the function that Joseph writes to get the data from the OptiTrack Server into MATLAB. This section will be added before the data stream is started
%Adjust the parameters based on the frequency of data frames as well
posBall.x = [];
posBall.z = [];
posBallTime = [];
numberOfDataPointsInSequenceForRegression = 15;

collisionCounter = 0;
collisionCounterMax = 15;
lastTouchRobot = 0;

radiusOfBall = 220;
distanceTolerance = 15;
ballOnGround = true;

distanceOfPointsOnRobotsToBall.robot1 = [];
distanceOfPointsOnRobotsToBall.robot2 = [];
distanceOfPointsOnRobotsToBall.robot3 = [];
distanceOfPointsOnRobotsToBall.robot4 = [];
numberOfDataPointsInSequenceForClamping = 20;
isBallClampedByRobot = 0;

% Connect to OptiTrack
natnetclient = natnet;
natnetclient.HostIP = '192.168.5.101';
natnetclient.ClientIP = '192.168.6.51';
natnetclient.ConnectionType = 'Unicast';
natnetclient.connect;
if ( natnetclient.IsConnected == 0 )
		fprintf( 'Client failed to connect\n' )
		fprintf( '\tMake sure the host is connected to the network\n' )
		fprintf( '\tand that the host and client IP addresses are correct\n\n' ) 
end

%% Then we will need to add the following code snippet to within the loop in which the data is streamed
% I need the positions of the points on robots and ball in particular named
% vectors

if(newBallPosition.y - radiusOfBall > distanceTolerance)
    ballOnGround = false;
else
    ballOnGround = true;
end

if(ballOnGround == true)
    
    if(size(distanceOfPointsOnRobotsToBall.robot1,1) < numberOfDataPointsInSequenceForClamping)
        distanceOfPointsOnRobotsToBall.robot1 = [distanceOfPointsOnRobotsToBall.robot1; ...
            sqrt(sum((pointsOnRobot1.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot1.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot1.point3 - newBallPosition).^2))];
        distanceOfPointsOnRobotsToBall.robot2 = [distanceOfPointsOnRobotsToBall.robot2; ...
            sqrt(sum((pointsOnRobot2.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot2.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot2.point3 - newBallPosition).^2))];
        distanceOfPointsOnRobotsToBall.robot3 = [distanceOfPointsOnRobotsToBall.robot3; ...
            sqrt(sum((pointsOnRobot3.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot3.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot3.point3 - newBallPosition).^2))];
        distanceOfPointsOnRobotsToBall.robot4 = [distanceOfPointsOnRobotsToBall.robot4; ...
            sqrt(sum((pointsOnRobot4.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot4.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot4.point3 - newBallPosition).^2))];
    else
        if(max(std(distanceOfPointsOnRobotsToBall.robot1)) < distanceTolerance)
            isBallClampedByRobot = 1;
            lastTouchRobot = 1;
        elseif(max(std(distanceOfPointsOnRobotsToBall.robot2)) < distanceTolerance)
            isBallClampedByRobot = 2;
            lastTouchRobot = 2;
        elseif(max(std(distanceOfPointsOnRobotsToBall.robot3)) < distanceTolerance)
            isBallClampedByRobot = 3;
            lastTouchRobot = 3;
        elseif(max(std(distanceOfPointsOnRobotsToBall.robot4)) < distanceTolerance)
            isBallClampedByRobot = 4;
            lastTouchRobot = 4;
        else
            isBallClampedByRobot = 0;
        end
        distanceOfPointsOnRobotsToBall.robot1 = [distanceOfPointsOnRobotsToBall.robot01(2:end,:); ...
            sqrt(sum((pointsOnRobot1.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot1.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot1.point3 - newBallPosition).^2))];
        distanceOfPointsOnRobotsToBall.robot2 = [distanceOfPointsOnRobotsToBall.robot2(2:end,:); ...
            sqrt(sum((pointsOnRobot2.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot2.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot2.point3 - newBallPosition).^2))];
        distanceOfPointsOnRobotsToBall.robot3 = [distanceOfPointsOnRobotsToBall.robot3(2:end,:); ...
            sqrt(sum((pointsOnRobot3.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot3.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot3.point3 - newBallPosition).^2))];
        distanceOfPointsOnRobotsToBall.robot4 = [distanceOfPointsOnRobotsToBall.robot4(2:end,:); ...
            sqrt(sum((pointsOnRobot4.point1 - newBallPosition).^2)) sqrt(sum((pointsOnRobot4.point2 - newBallPosition).^2)) sqrt(sum((pointsOnRobot4.point3 - newBallPosition).^2))];
    end
    
    if(collisionCounter == 0 && isBallClampedByRobot == 0)
        
        if(size(posBall.x, 2) < numberOfDataPointsInSequence)
            posBall.x = [posBall.x data.RigidBodies(1).x];
            posBall.z = [posBall.z data.RigidBodies(1).z];
            posBallTime = [posBallTime data.fTimestamp];
        else
            pos_next_confidence = predictBallPositionOnGround(posBall, posBallTime, newTimeStamp);
            if(pos_next_confidence.x_low < newBallPosition.x ...
                    && pos_next_confidence.x_high > newBallPosition.x ...
                    && pos_next_confidence.z_low < newBallPosition.z ...
                    && pos_next_confidence.z_high > newBallPosition.z)
                %No collision detected
                posBall.x = [posBall.x(2:end) newBallPosition.x];
                posBall.z = [posBall.z(2:end) newBallPosition.z];
                posBallTime = [posBallTime(2:end) newTimeStamp];
            else
                %Collision detected
                collisionCounter = collisionCounterMax;
                posBall.x = [];
                posBall.z = [];
                posBallTime = [];
                [~, lastTouchRobot] = min([mean(distanceOfPointsOnRobotsToBall.robot1(end,:)) ...
                    mean(distanceOfPointsOnRobotsToBall.robot2(end,:)) ...
                    mean(distanceOfPointsOnRobotsToBall.robot3(end,:)) ...
                    mean(distanceOfPointsOnRobotsToBall.robot4(end,:))]);
            end
        end
        
    else
        
        collisionCounter = collisionCounter-1;
        
    end
    
else
    
    posBall.x = [];
    posBall.z = [];
    posBallTime = [];
    distanceOfPointsOnRobotsToBall.robot1 = [];
    distanceOfPointsOnRobotsToBall.robot2 = [];
    distanceOfPointsOnRobotsToBall.robot3 = [];
    distanceOfPointsOnRobotsToBall.robot4 = [];
    
end





