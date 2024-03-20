function pos_next_confidence = predictBallPositionOnGround(pos, time, time_next)
    x = pos.x;
    z = pos.z;
    fitX = fit(time, x, 'poly3');
    fitZ = fit(time, z, 'poly3');
    [x_next_low, x_next_high] = predint(fitX, time_next, 0.95, 'observation');
    [z_next_low, z_next_high] = predint(fitZ, time_next, 0.95, 'observation');
    pos_next_confidence.x_low = x_next_low;
    pos_next_confidence.x_high = x_next_high;
    pos_next_confidence.z_low = z_next_low;
    pos_next_confidence.z_high = z_next_high;
    