function [OrbVel] = OrbitalVel(distance,acceleration)

OrbVel = sqrt(abs(acceleration)*distance);
end