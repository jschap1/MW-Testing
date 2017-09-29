% Test a new MOD-WET setup for 2016a vs 2017a to see why there are 
% different results for the Upper Merced basins between the two of them

% Set up and run 2016a and 2017b simulations for the Upper Merced basin,
% water year 2010. Then load and plot the results.

cd /Users/jschapMac/Documents/Classes/CEE150/Upper_Merced/

old = load('./2016b/merced_output.mat');
new = load('./2017a/merced_output.mat');

%% TODO

% Create a revised water balance figure, with PPT, ET, Runoff, and Storage
% (cumulative daily values)

% Make plots on the same axes; toggle this with a flag.

%% NOTES

% 2016b simulation with the parameters left as they are stored in the
% MODWET_2016b.zip folder on Box, except SDmean0 = 0.17.

% 2017b simulation with parameters changed to match those of 2016b, as much
% as possible.

% There were mass balance errors in both simulations, but they were not
% huge.

%%
% Soil States Time Series

h = figure;
subplot(3,2,1)
plot(new.time_vector_for_states_time_series, new.states.time_series.Srz)
title('Srz (new)'), xlabel('DOWY'), ylabel('Srz (m)')
set(gca,'FontSize',18)
subplot(3,2,2)
plot(old.time_states, old.time_series.Srz)
title('Srz (new)'), xlabel('DOWY'), ylabel('Srz (m)')
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
plot(old.time_states(1:end-1), old.time_series.LE)
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

%%

PPT_daily=squeeze(sum(reshape(disaggregated_forcing.time_series.PPT*params.basin_area,24,365))); % m^3/day
PPT_daily_cum=cumsum(PPT_daily); % m^3

