function [X,Y,Z] = OrbitalCalc(valPeri,valApa,Inc)
% calculates the postion of the satellite as it moves around the Earth
mu = 3.986004418e14;

EMass = 5.9722e24;
ERad = 6.371e6;
IntDist = ERad + valPeri;
OrbVal = zeros(3,3,1);
% Initial Position
OrbVal(1,1,1) = IntDist*cosd(Inc);
OrbVal(1,2,1) = 0;
OrbVal(1,3,1) = -IntDist*sind(Inc);
% Initial Accleration
OrbVal(3,1,1) = -GravAccel(norm(OrbVal(1,:,1)),EMass);
% Initial Velocity
OrbVal(2,2,1) = OrbitalVel(norm(OrbVal(1,:,1)),OrbVal(3,1));
% Specific Mechanical Energy
a = (valPeri+valApa + 2*ERad)/2;
eng = -mu/(2*a);
% Period
seconds = round(2*pi*sqrt((a^3)/mu));
%seconds = 24 * 3600;
time = linspace(0,seconds,seconds);

for k = 1:length(time)
    % New Velocity
    Vx = OrbVal(2,1,k) + OrbVal(3,1,k);
    Vy = OrbVal(2,2,k) + OrbVal(3,2,k);
    Vz = OrbVal(2,3,k) + OrbVal(3,3,k);
    eVx = Vx/norm([Vx Vy Vz]);
    eVy = Vy/norm([Vx Vy Vz]);
    eVz = Vz/norm([Vx Vy Vz]);
    R = norm(OrbVal(1,:,k));
    V = sqrt(2*((mu/R)+ eng));
    
    OrbVal(2,1,k+1) = V*eVx;
    OrbVal(2,2,k+1) = V*eVy;
    OrbVal(2,3,k+1) = V*eVz;
    
    % New Position
    OrbVal(1,1,k+1) = OrbVal(1,1,k) + OrbVal(2,1,k);
    OrbVal(1,2,k+1) = OrbVal(1,2,k) + OrbVal(2,2,k);
    OrbVal(1,3,k+1) = OrbVal(1,3,k) + OrbVal(2,3,k);
    % New Acceleration
    CurAccel = -GravAccel(norm(OrbVal(1,:,k+1)),EMass);
    RadialVec = OrbVal(1,:,k+1)/norm(OrbVal(1,:,k+1));
    OrbVal(3,1,k+1) = CurAccel*RadialVec(1);
    OrbVal(3,2,k+1) = CurAccel*RadialVec(2);
    OrbVal(3,3,k+1) = CurAccel*RadialVec(3);
    % Plot position
    %plot(MoonVal(1,1,k),MoonVal(1,2,k),'x')
end
for i = 1:length(OrbVal(1,1,:))
    X(i) = OrbVal(1,1,i);
    Y(i) = OrbVal(1,2,i);
    Z(i) = OrbVal(1,3,i);
end
end