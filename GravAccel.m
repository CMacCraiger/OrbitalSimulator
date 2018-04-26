function [acceleration] = GravAccel(distance,mass)
G = 6.67408e-11;

acceleration = (G*mass)/(distance^2);
end