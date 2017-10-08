% CEE150 Intro to Hydrology HW Checker for MOD-WET
% Jacob Schaperow and Yufei Liu, Fall 2017
%
% Todo:
% Update with MOD-WET problems from each homework set as they are assigned.

% Matlab plotting template:
set(0,'DefaultAxesXGrid','on','DefaultAxesYGrid','on',...
    'DefaultAxesXminortick','on','DefaultAxesYminortick','on',...
    'DefaultLineLineWidth',2,'DefaultLineMarkerSize',6,...
    'DefaultAxesFontName','Arial','DefaultAxesFontSize',14,...
    'DefaultAxesFontWeight','bold',...
    'DefaultTextFontWeight','normal','DefaultTextFontSize',14)

%% PS1

clear, clc, close all

% load MOD-WET variables
load('C:\Users\Jacob\Documents\My Documents\Classes\CEE150\Inputs\processed_dem.mat');
load('C:\Users\Jacob\Documents\My Documents\Classes\CEE150\Inputs\met_data.mat');
load('C:\Users\Jacob\Documents\My Documents\Classes\CEE150\Outputs\outputs.mat');

% 3a  --------- Plot elevation contour with cross-section line --------- 

% Generate new figure for elevation contours 
figure
% Contour interval (meters)
% v = min(elev(:)) : 100 : max(elev(:));
v = 2000:100:max(elev(:));
% Generate topographic map
[C,h] = contour(easting,northing,elev,v,'linewidth',2);
% Add colorbar
c = colorbar;
colormap(jet);
% Label contours
clabel(C,h,'LabelSpacing',300)
% Maintain aspect ratio
axis image
% Set orientation of map
set(gca,'ydir','normal');

% Include cross-section line
% Define YsectionEasting (m) where taking cross-section
YsectionEasting = 355000;
hold on
h(2) = plot([YsectionEasting YsectionEasting],[northing(1) northing(end)],'--k','linewidth',2);
% Add labels
xlabel('Easting (m)')
ylabel('Northing (m)')
title({'Topographic map: Elevation (m)',''})

% Add max/min elevations and legend to map
[max_elev, ~] = max(elev(:))
[min_elev, ~] = min(elev(:))
[i_max,j_max] = find(elev == max_elev)
[i_min,j_min] = find(elev == min_elev)

easting(i_max)
northing(j_max)
easting(i_min)
northing(j_min)

h(3) = plot(easting(i_min), northing(j_min), 'bp');
h(4) = plot(easting(i_max), northing(j_max), 'rp');

legend([h(2), h(3), h(4)], {'Cross-Section','Min Elev','Max Elev'}, ...
    'Location', 'southoutside', 'orientation', 'horizontal')

% 3b  --------- Plot  cross-section ---------

% Extract elevations along the cross-section
[~,Ieast] = min(abs(easting - YsectionEasting));
NSelev = elev(:,Ieast);
% Generate new figure for cross-section
figure
plot(northing,NSelev,'linewidth',2)
% Add grid
grid on
% Add minor tick marks
set(gca,'xminortick','on','yminortick','on')
% Set major tick marks
set(gca, 'ytick', 2000:500:4000);
% Maintain aspect ratio
axis image
% Add labels
xlabel('Northing (m)')
ylabel('Elevation (m)')
title('Cross-section at easting coord. of 3.55x10^5 m') 

% --------- 4abc ---------

% Get basin area;
basin_area=params.basin_area %m^2 
 
% Get difference in elevation btw max elev in the basin and the outlet
elev_mask = mask.*elev;
elev_mask(elev_mask==0) = NaN;
[val,ind1] = min(abs(outlet_coordinate(1) - easting));
[val,ind2] = min(abs(outlet_coordinate(2) - northing));
max_diff = max(elev_mask(:)) - elev_mask(ind2, ind1);

% Compute the hourly precipitation  
PPT_hr = reshape(disaggregated_forcing.time_series.PPT,24,365);% in m/hr
[ppt_max_hourly,time_step]= max(PPT_hr(:))
doy=ceil(time_step/24) % day of the year from Oct 1. 
DOWY=time_vector_for_fluxes_time_series;
 
PPT_daily=sum(PPT_hr)*1000; % mm/day
PPT_daily_max=max(PPT_daily) % mm/day
 
figure;  plot (DOWY,PPT_hr(:).*1000, 'r')% plot in mm/hr
xlim([0 365])
xlabel('Day of Water Year')
ylabel(' Precipitation (mm/hr)')
title('Hourly precipitation water year 2010')
grid on 
 
% Compute cumulative precipitation 
PPT_daily_cum=cumsum((PPT_daily/1000)*params.basin_area); % m^3
total_volume_ppt=sum((PPT_daily/1000)*params.basin_area)% m^3/year
total_height_ppt=total_volume_ppt/params.basin_area %m/year
 
figure
plot(1:365,PPT_daily_cum)
xlim([0 365])
xlabel('Day of Water Year')
ylabel('Cumulative Daily PPT (m^3)')

% --------- 5abcd ---------

% Discharge analysis
Q_hr=reshape(fluxes.time_series.outlet_hydrograph*3600,24,365); % m^3/hr
Q_daily=sum(Q_hr); % m^3/day
Q_daily_cum=cumsum(Q_daily); % m^3
Q_total_volume=sum(Q_daily) % m^3/yr
Q_total_height=sum(Q_daily)/params.basin_area % m^3/yr
Q_yr_volume_average=mean(Q_daily) % m^3/day
Q_yr_height_average=(mean(Q_daily)*1000)/params.basin_area % mm/day
 
figure
plot(1:365,Q_daily_cum)
xlim([0 365])
xlabel('Day of Water Year')
ylabel('Cumulative Daily Runoff (m^3)')
 
 
% Evaporation analysis
ET_daily=squeeze(sum(reshape(fluxes.time_series.ET*params.basin_area,24,365))); % m^3/day
ET_daily_cum=cumsum(ET_daily); % m^3
ET_total_volume=sum(ET_daily) % m^3/yr
ET_total_height=sum(ET_daily)/params.basin_area % m/yr
ET_yr_volume_average=mean(ET_daily) % m^3/day
ET_yr_height_average=(mean(ET_daily)*1000)/params.basin_area  % mm/day
 
figure
plot(1:365,ET_daily_cum)
xlim([0 365])
xlabel('Day of Water Year')
ylabel('Cumulative Daily Evaporation (m^3)')
 
% Water balance
 
% Compute total storage over the year
S_daily_cum=PPT_daily_cum - ET_daily_cum - Q_daily_cum; % m^3
S_change_volume = S_daily_cum(1)-S_daily_cum(end);
S_change_height = S_change_volume/params.basin_area;
 
figure
plot(1:365,S_daily_cum)
hold on
plot([0 365],[0 0],'--k')
xlim([0 365])
xlabel('Day of Water Year')
ylabel('Cumulative Daily Storage (m^3)')

%% PS2

%% PS3

%% PS4

%% PS5