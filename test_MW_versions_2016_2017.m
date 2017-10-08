%%
% Test a new MOD-WET setup for 2016b vs 2017a to see why there are 
% different results for the Upper Merced/Kings basins between the two of them

% Set up and run 2016b and 2017a simulations for the Upper Merced/Kings basin,
% water year 20XX. Then load and plot the results.

cd('C:\Users\Jacob\Documents\My Documents\Classes\CEE150\')

old = load('C:\Users\Jacob\Box Sync\kings_output.mat');
new = load('./kings_outputs_10022017.mat');

%% TODO

% Make plots on the same axes; toggle this with a flag.
% Specify particular bounds on the axes

%% NOTES

% 2016b simulation with the parameters left as they are stored in the
% MODWET_2016b.zip folder on Box, except SDmean0 = 0.17.

% 2017b simulation with parameters changed to match those of 2016b, as much
% as possible.

% There were mass balance errors in both simulations for Merced, but they were not
% huge. There were no mass balance errors for Kings.

%%
% Soil States Time Series

h = figure;
subplot(3,2,1)
plot(new.time_vector_for_states_time_series, new.states.time_series.Srz)
title('Srz (new)'), xlabel('DOWY'), ylabel('Srz (m)')
set(gca,'FontSize',18)
subplot(3,2,2)
plot(old.time_states, old.time_series.Srz)
title('Srz (old)'), xlabel('DOWY'), ylabel('Srz (m)')
set(gca,'FontSize',18)
subplot(3,2,3)
plot(new.time_vector_for_states_time_series, new.states.time_series.Suz)
title('Suz (new)'), xlabel('DOWY'), ylabel('Suz (m)')
set(gca,'FontSize',18)
subplot(3,2,4)
plot(old.time_states, old.time_series.Suz)
title('Suz (old)'), xlabel('DOWY'), ylabel('Suz (m)')
set(gca,'FontSize',18)
subplot(3,2,5)
plot(new.time_vector_for_states_time_series, new.states.time_series.SD)
title('SD (new)'), xlabel('DOWY'), ylabel('SD (m)')
set(gca,'FontSize',18)
subplot(3,2,6)
plot(old.time_states, old.time_series.SD)
title('SD (old)'), xlabel('DOWY'), ylabel('SD (m)')
set(gca,'FontSize',18)
saveas(h, 'soil_states.png', 'png');
savefig(h, 'soil_states.fig');

%%
% Snow States Time Series

h = figure;
subplot(1,2,1)
plot(new.time_vector_for_states_time_series, new.states.time_series.Srz)
title('SWE (new)'), xlabel('DOWY'), ylabel('SWE (m)')
set(gca,'FontSize',18)
subplot(1,2,2)
plot(old.time_states, old.time_series.SWE)
title('SWE (old)'), xlabel('DOWY'), ylabel('SWE (m)')
set(gca,'FontSize',18)
saveas(h, 'snow_states.png', 'png');
savefig(h, 'snow_states.fig');

%%
% Temperature States Time Series
h = figure;
subplot(1,2,1)
plot(new.time_vector_for_states_time_series, new.states.time_series.Tsurf)
title('Tsurf (new)'), xlabel('DOWY'), ylabel('Tsurf (K)')
set(gca,'FontSize',18)
subplot(1,2,2)
plot(old.time_states, old.time_series.Tsurf)
title('Tsurf (old)'), xlabel('DOWY'), ylabel('Tsurf (K)')
set(gca,'FontSize',18)
saveas(h, 'temperature_states.png', 'png');
savefig(h, 'temperature_states.fig');

%%
% Energy Balance Fluxes Time Series

h = figure;

subplot(4,2,1)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.Rn)
title('Rn (new)'), xlabel('DOWY'); ylabel('Rn (W/m^2)')
set(gca,'FontSize',18)

subplot(4,2,2)
plot(old.time_states(1:end-1), old.time_series.Rn)
title('Rn (old)'), xlabel('DOWY');ylabel('Rn (W/m^2)')
set(gca,'FontSize',18)

subplot(4,2,3)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.Rlup)
title('Rlup (new)'), xlabel('DOWY'); ylabel('Rlup (W/m^2)')
set(gca,'FontSize',18)

subplot(4,2,4)
plot(old.time_states(1:end-1), old.time_series.Rlup)
title('Rlup (old)'), xlabel('DOWY'); ylabel('Rlup (W/m^2)')
set(gca,'FontSize',18)

subplot(4,2,5)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.LE)
title('LE (new)'), xlabel('DOWY'); ylabel('LE (W/m^2)')
set(gca,'FontSize',18)

subplot(4,2,6)
plot(old.time_states(1:end-1), old.time_series.LE)
title('LE (old)'), xlabel('DOWY'); ylabel('LE (W/m^2)')
set(gca,'FontSize',18)

subplot(4,2,7)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.H)
title('H (new)'), xlabel('DOWY'); ylabel('H (W/m^2)')
set(gca,'FontSize',18)

subplot(4,2,8)
plot(old.time_states(1:end-1), old.time_series.H)
title('H (old)'), xlabel('DOWY');ylabel('H (W/m^2)')
set(gca,'FontSize',18)

saveas(h, 'eb_fluxes.png', 'png');
savefig(h, 'eb_fluxes.fig');

%%
% Water Balance Fluxes Time Series

h = figure;
m = 4; n = 2;

subplot(m,n,1)
plot(new.time_vector_for_fluxes_time_series, new.disaggregated_forcing.time_series.PPT)
title('PPT (new)'), xlabel('DOWY'); ylabel('PPT (m)')
set(gca,'FontSize',18)

subplot(m,n,2)
plot(old.time_states(1:end-1), old.disaggregated_forcing.time_series.PPT)
title('PPT (old)'), xlabel('DOWY');ylabel('PPT (m)')
set(gca,'FontSize',18)

subplot(m,n,3)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.snowmelt)
title('snowmelt (new)'), xlabel('DOWY'); ylabel('snowmelt (m/h)')
set(gca,'FontSize',18)

subplot(m,n,4)
plot(old.time_states(1:end-1), old.time_series.snowmelt)
title('snowmelt (old)'), xlabel('DOWY'); ylabel('snowmelt (m/h)')
set(gca,'FontSize',18)

subplot(m,n,5)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.infil)
title('infil (new)'), xlabel('DOWY'); ylabel('infil (m/h)')
set(gca,'FontSize',18)

subplot(m,n,6)
plot(old.time_states(1:end-1), old.time_series.infil)
title('infil (old)'), xlabel('DOWY'); ylabel('infil (m/h)')
set(gca,'FontSize',18)

subplot(m,n,7)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.ET)
title('ET (new)'), xlabel('DOWY'); ylabel('ET (m/h)')
set(gca,'FontSize',18)

subplot(m,n,8)
plot(old.time_states(1:end-1), old.time_series.ET)
title('ET (old)'), xlabel('DOWY');ylabel('ET (m/h)')
set(gca,'FontSize',18)

saveas(h, 'wb_fluxes.png', 'png');
savefig(h, 'wb_fluxes.fig');

%%
% Runoff Fluxes Time Series

h = figure;

subplot(4,2,1)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.qie)
title('qie (new)'), xlabel('DOWY'); ylabel('qie (m/h)')
set(gca,'FontSize',18)

subplot(4,2,2)
plot(old.time_states(1:end-1), old.time_series.qie)
title('qie (old)'), xlabel('DOWY');ylabel('qie (m/h)')
set(gca,'FontSize',18)

subplot(4,2,3)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.qse)
title('qse (new)'), xlabel('DOWY'); ylabel('qse (m/h)')
set(gca,'FontSize',18)

subplot(4,2,4)
plot(old.time_states(1:end-1), old.time_series.qse)
title('qse (old)'), xlabel('DOWY'); ylabel('qse (m/h)')
set(gca,'FontSize',18)

subplot(4,2,5)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.qb)
title('qb (new)'), xlabel('DOWY'); ylabel('qb (m/h)')
set(gca,'FontSize',18)

subplot(4,2,6)
plot(old.time_states(1:end-1), old.time_series.qb)
title('qb (old)'), xlabel('DOWY'); ylabel('qb (m/h)')
set(gca,'FontSize',18)

subplot(4,2,7)
plot(new.time_vector_for_fluxes_time_series, new.fluxes.time_series.outlet_hydrograph)
title('outlet hydrograph (new)'), xlabel('DOWY'); ylabel('outlet_hydrograph (m^3/s)')
set(gca,'FontSize',18)

subplot(4,2,8)
plot(old.time_states(1:end-1), old.time_series.outlet_hydrograph)
title('outlet hydrograph (old)'), xlabel('DOWY');ylabel('outlet_hydrograph (m^3/s)')
set(gca,'FontSize',18)

saveas(h, 'runoff_fluxes.png', 'png');
savefig(h, 'runoff_fluxes.fig');

%%
% Cumulative Water Balance Time Series (PPT, ET, Runoff, Total Storage)

% daily, volume units (m^3)

h = figure; 
day_vect = 1:365;

% PPT
subplot(4,2,1)
new.PPT_daily=squeeze(sum(reshape(new.disaggregated_forcing.time_series.PPT*new.params.basin_area,24,365))); % m^3/day
new.PPT_daily_cum=cumsum(new.PPT_daily); % m^3
plot(day_vect, new.PPT_daily_cum)
title('Cumulative PPT (new)'); xlabel('DOWY'), ylabel('PPT (m^3)')
subplot(4,2,2)
old.PPT_daily=squeeze(sum(reshape(old.disaggregated_forcing.time_series.PPT*old.params.basin_area,24,365))); % m^3/day
old.PPT_daily_cum=cumsum(old.PPT_daily); % m^3
plot(day_vect, old.PPT_daily_cum)
title('Cumulative PPT (old)'); xlabel('DOWY'), ylabel('PPT (m^3)')

% ET
subplot(4,2,3)
new.ET_daily=squeeze(sum(reshape(new.fluxes.time_series.ET*new.params.basin_area,24,365))); % m^3/day
new.ET_daily_cum=cumsum(new.ET_daily); % m^3
plot(day_vect, new.ET_daily_cum)
title('Cumulative ET (new)'); xlabel('DOWY'), ylabel('ET (m^3)')
subplot(4,2,4)
old.ET_daily=squeeze(sum(reshape(old.time_series.ET*old.params.basin_area,24,365))); % m^3/day
old.ET_daily_cum=cumsum(old.ET_daily); % m^3
plot(day_vect, old.ET_daily_cum)
title('Cumulative ET (old)'); xlabel('DOWY'), ylabel('ET (m^3)')

% Runoff
subplot(4,2,5)
new.outlet_hydrograph_daily=squeeze(sum(reshape(3600*new.fluxes.time_series.outlet_hydrograph,24,365))); % m^3/day
new.outlet_hydrograph_daily_cum=cumsum(new.outlet_hydrograph_daily); % m^3
plot(day_vect, new.outlet_hydrograph_daily_cum)
title('Cumulative Outlet Hydrograph (new)'); xlabel('DOWY'), ylabel('Q (m^3)')
subplot(4,2,6)
old.outlet_hydrograph_daily=squeeze(sum(reshape(3600*old.time_series.outlet_hydrograph,24,365))); % m^3/day
old.outlet_hydrograph_daily_cum=cumsum(old.outlet_hydrograph_daily); % m^3
plot(day_vect, old.outlet_hydrograph_daily_cum)
title('Cumulative Outlet Hydrograph (old)'); xlabel('DOWY'), ylabel('Q (m^3)')

% Total Storage
subplot(4,2,7)
new.total_storage_cum = new.PPT_daily_cum - new.ET_daily_cum - ...
    new.outlet_hydrograph_daily_cum; % m^3
plot(day_vect, new.total_storage_cum)
title('Cumulative Total Storage (new)'); xlabel('DOWY'), ylabel('S (m^3)')
subplot(4,2,8)
old.total_storage_cum = old.PPT_daily_cum - old.ET_daily_cum - ...
    old.outlet_hydrograph_daily_cum; % m^3
plot(day_vect, old.total_storage_cum)
title('Cumulative Total Storage (old)'); xlabel('DOWY'), ylabel('S (m^3)')

saveas(h, 'daily_cum_wb.png', 'png');
savefig(h, 'daily_cum_wb.fig');

%% 
% Same as above, but with snowmelt, too.

% Cumulative Water Balance Time Series (PPT, ET, Runoff, Total Storage)

% daily, volume units (m^3)

% h = figure; 
% day_vect = 1:365;
% 
% % PPT
% subplot(5,2,1)
% new.PPT_daily=squeeze(sum(reshape(new.disaggregated_forcing.time_series.PPT*new.params.basin_area,24,365))); % m^3/day
% new.PPT_daily_cum=cumsum(new.PPT_daily); % m^3
% plot(day_vect, new.PPT_daily_cum)
% title('Cumulative PPT (new)'); xlabel('DOWY'), ylabel('PPT (m^3)')
% subplot(5,2,2)
% old.PPT_daily=squeeze(sum(reshape(old.disaggregated_forcing.time_series.PPT*old.params.basin_area,24,365))); % m^3/day
% old.PPT_daily_cum=cumsum(old.PPT_daily); % m^3
% plot(day_vect, old.PPT_daily_cum)
% title('Cumulative PPT (old)'); xlabel('DOWY'), ylabel('PPT (m^3)')
% 
% % ET
% subplot(5,2,3)
% new.ET_daily=squeeze(sum(reshape(new.fluxes.time_series.ET*new.params.basin_area,24,365))); % m^3/day
% new.ET_daily_cum=cumsum(new.ET_daily); % m^3
% plot(day_vect, new.ET_daily_cum)
% title('Cumulative ET (new)'); xlabel('DOWY'), ylabel('ET (m^3)')
% subplot(5,2,4)
% old.ET_daily=squeeze(sum(reshape(old.time_series.ET*old.params.basin_area,24,365))); % m^3/day
% old.ET_daily_cum=cumsum(old.ET_daily); % m^3
% plot(day_vect, old.ET_daily_cum)
% title('Cumulative ET (old)'); xlabel('DOWY'), ylabel('ET (m^3)')
% 
% % Runoff
% subplot(5,2,5)
% new.outlet_hydrograph_daily=squeeze(sum(reshape(3600*new.fluxes.time_series.outlet_hydrograph,24,365))); % m^3/day
% new.outlet_hydrograph_daily_cum=cumsum(new.outlet_hydrograph_daily); % m^3
% plot(day_vect, new.outlet_hydrograph_daily_cum)
% title('Cumulative Outlet Hydrograph (new)'); xlabel('DOWY'), ylabel('Q (m^3)')
% subplot(5,2,6)
% old.outlet_hydrograph_daily=squeeze(sum(reshape(3600*old.time_series.outlet_hydrograph,24,365))); % m^3/day
% old.outlet_hydrograph_daily_cum=cumsum(old.outlet_hydrograph_daily); % m^3
% plot(day_vect, old.outlet_hydrograph_daily_cum)
% title('Cumulative Outlet Hydrograph (old)'); xlabel('DOWY'), ylabel('Q (m^3)')
% 
% % Snowmelt
% subplot(5,2,7)
% new.snowmelt_daily=squeeze(sum(reshape(new.fluxes.time_series.snowmelt*new.params.basin_area,24,365))); % m^3/day
% new.snowmelt_daily_cum=cumsum(new.snowmelt_daily); % m^3
% plot(day_vect, new.snowmelt_daily_cum)
% title('Cumulative snowmelt (new)'); xlabel('DOWY'), ylabel('snowmelt (m^3)')
% subplot(5,2,8)
% old.snowmelt_daily=squeeze(sum(reshape(old.time_series.snowmelt*old.params.basin_area,24,365))); % m^3/day
% old.snowmelt_daily_cum=cumsum(old.snowmelt_daily); % m^3
% plot(day_vect, old.snowmelt_daily_cum)
% title('Cumulative snowmelt (old)'); xlabel('DOWY'), ylabel('snowmelt (m^3)')

% Total Storage % what exactly is the definition of this?
% subplot(5,2,9)
% new.total_storage_cum = new.PPT_daily_cum - new.ET_daily_cum - ...
%     new.outlet_hydrograph_daily_cum - new.snowmelt_daily_cum; % m^3
% plot(day_vect, new.total_storage_cum)
% title('Cumulative Total Storage (new)'); xlabel('DOWY'), ylabel('S (m^3)')
% subplot(5,2,10)
% old.total_storage_cum = old.PPT_daily_cum - old.ET_daily_cum - ...
%     old.outlet_hydrograph_daily_cum - old.snowmelt_daily_cum; % m^3
% plot(day_vect, old.total_storage_cum)
% title('Cumulative Total Storage (old)'); xlabel('DOWY'), ylabel('S (m^3)')

% saveas(h, 'daily_cum_wb_w_snowmelt.png', 'png');
% savefig(h, 'daily_cum_wb_w_snowmelt.fig');

%% 
% % Compare total storage calculated as a residual to total storage
% % calculated as the sum of all moisture in the basin
% 
% h = figure;
% 
% subplot(2,2,1)
% plot(day_vect, new.total_storage_cum)
% title('Cumulative Total Storage (new), residual'), xlabel('DOWY'), ylabel('S (m^3)')
% subplot(2,2,2)
% plot(day_vect, old.total_storage_cum)
% title('Cumulative Total Storage (old), residual'), xlabel('DOWY'), ylabel('S (m^3)')
% 
% % Calculating total storage as sum of other model terms:
% new.total_storage2 = new.states.time_series.Srz + new.states.time_series.Suz ...
%     + new.states.time_series.SWE - new.states.time_series.SD; % m
% new.total_storage2 = new.total_storage2*new.params.basin_area; % m^3
% new.total_storage_daily2=squeeze(sum(reshape(new.total_storage2(1:end-1),24,365))); % m^3/day
% new.total_storage_cum2 = cumsum(new.total_storage_daily2);
% 
% old.total_storage2 = old.time_series.Srz + old.time_series.Suz ...
%     + old.time_series.SWE - old.time_series.SD; % m
% old.total_storage2 = old.total_storage2*old.params.basin_area; % m^3
% old.total_storage_daily2=squeeze(sum(reshape(old.total_storage2(1:end-1),24,365))); % m^3/day
% old.total_storage_cum2 = cumsum(old.total_storage_daily2);
% 
% subplot(2,2,3)
% plot(day_vect, new.total_storage_cum2)
% title('Cumulative Total Storage (new), sum'), xlabel('DOWY'), ylabel('S (m^3)')
% subplot(2,2,4)
% plot(day_vect, old.total_storage_cum2)
% title('Cumulative Total Storage (old), sum'), xlabel('DOWY'), ylabel('S (m^3)')
% 
% saveas(h, 'total_storage_comparison.png', 'png');
% savefig(h, 'total_storage_comparison.fig');