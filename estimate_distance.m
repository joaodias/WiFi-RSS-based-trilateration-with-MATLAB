%--------------------------------------------------------------------------
%
% DESCRIPTION: Estimates the distance between the WiFi Access Point and the
%              unknown position based on the observed WiFi RSS usign the 
%              FSPL (Free Space Path Loss) propagation model
%
%      INPUTS: Observed WiFi RSS vector(related to an access point)
%
%     OUTPUTS: Estimated distances vector between the unknown position and 
%              the APs (access points) 
%
%  REFERENCES: http://goo.gl/cGXmDw
%
%--------------------------------------------------------------------------

function [ d ] = distance( RSS )
	result = (27.55 - (20 * log10(2400)) + abs(RSS)) / 20;
	d = power(10, result);
end

