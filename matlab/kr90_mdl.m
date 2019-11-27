%MDL_KR5 Create model of Kuka KR5 manipulator
%
% MDL_KR5 is a script that creates the workspace variable mico which
% describes the kinematic characteristics of a Kuka KR5 manipulator using
% standard DH conventions.
%
% Also define the workspace vectors:
%   qk1        nominal working position 1
%   qk2        nominal working position 2
%   qk3        nominal working position 3
%
% Notes::
% - SI units of metres are used.
% - Includes 11.5cm tool in the z-direction
%
% Author::
% - Gautam sinha
%   Indian Institute of Technology, Kanpur.
%
% See also SerialLink, mdl_irb140, mdl_fanuc10l, mdl_motomanHP6, mdl_S4ABB2p8, mdl_puma560.

% MODEL: Kuka, KR5, 6DOF, standard_DH

%mdl_KR5 
%Define simplest line model for KUKA KR5 robot
%Contain DH parameters for KUKA KR5 robot
%All link lenghts and offsets are measured in cm
function KR90=kr90_mdl
clear L
close all
L(1) = Link('offset', pi/2,  'd',0.675,  'a',0.350,  'alpha',pi/2);
L(2) = Link('offset', pi/2,  'd',0,      'a',1.350,  'alpha',0);
L(3) = Link('offset', 0,     'd',0,      'a',0,      'alpha',pi/2);
L(4) = Link('offset', 0,     'd',1.2,    'a',0,      'alpha',-pi/2);
L(5) = Link('offset', 0,     'd',0,      'a',0,      'alpha',pi/2);
L(6) = Link('offset', 0,     'd',0.25,   'a',0,      'alpha',0);

KR90=SerialLink(L, 'name', 'Kuka KR90');
%KR90.tool=transl(0,0,0.115);
KR90.ikineType = 'kr90';
%KR90.model3d = 'KUKA/KR5_arc';

q0=[0 0 0 0 0 0];
qk1=[pi/4 pi/3 pi/4 pi/6 pi/4 pi/6];
qk2=[pi/4 pi/3 pi/6 pi/3 pi/4 pi/6];
qk3=[pi/6 pi/3 pi/6 pi/3 pi/6 pi/3];
