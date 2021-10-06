% ## SINGLEMISSILEDATA Creates time series data for single projectile
% ##
% ## Parameters:
% ## v : Velovity
% ## theta : altitude angle
% ## phi : azimuth angle
% ## x0, y0, z0: point of release of missile
% ## t0 : time of release
% ## ts : time step
% ## rangex : horizontal detection range
% ## rangey : vertical detection range
% ## tmax : maximum time measure

function pMat = SingleMissileData(v,theta,phi,x0,y0,z0,t0,ts,rangexy,rangez,tmax)

    g = 9.8;
    
    if v <= 0
        error('Velocity should be positive');
    elseif theta > 90 || theta < 0
        error('Theta must lie between 0 and 180');
    elseif phi > 360 || phi < 0
        error('Theta must lie between 0 and 360');
    elseif t0 < 0
        error('Start time must be positive');
    elseif rangexy <= 0 || rangez <= 0
        error('Range must be positive');
    elseif ts <= 0
        error('Timestep must be positive');
    elseif tmax <= t0
        error('tmax should be greater than t0');
    end

    T = 0:ts:tmax;

    lowT = t0;
    uppT = t0 + 2*v*sin(pi*theta/180)/g;

    syms x(t) y(t) z(t);
    x(t) = piecewise(t > lowT && t < uppT, v * (t - t0) * cos(theta) * cos(phi) + x0, NaN);
    y(t) = piecewise(t > lowT && t < uppT, v * (t - t0) * cos(theta) * sin(phi) + y0, NaN);
    z(t) = piecewise(t > lowT && t < uppT, v * (t - t0) * sin(theta) - g * ((t - t0)^2) / 2, NaN);

    pT = T;
    pX = x(T);
    pY = y(T);
    pZ = z(T);
    pMat = [pT pX pY pZ];

    for i = 1:size(pMat, 1)
        if (pMat(i, 2)^2 + pMat(i, 3)^2 > rangexy^2) || (pMat(i, 4) > rangez && pMat(i, 4) < 0)
            pMat(i, 2:4) = [NaN NaN NaN];
        end
    end
end
