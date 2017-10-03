%% This is a code plotting the outputs from MODWET 2016b and MODWET 2017
% Writen by Yufei Liu, Oct 1st. 
clc; clear all; close all
set(0,'DefaultAxesXGrid','on','DefaultAxesYGrid','on',...
    'DefaultAxesXminortick','on','DefaultAxesYminortick','on',...
    'DefaultLineLineWidth',2,'DefaultLineMarkerSize',6,...
    'DefaultAxesFontName','Arial','DefaultAxesFontSize',20,...
    'DefaultAxesFontWeight','bold',...
    'DefaultTextFontWeight','normal','DefaultTextFontSize',20)

%% Plot outputs from 2016 model 
load /Users/yufeiliu/Desktop/CEE150/Data/output/upper_merced_outputs_Steve_2016.mat
 time_vector_for_fluxes_time_series = time_states(1:end-1);
 time_vector_for_states_time_series = time_states;
 
% Plot the fluxes
figure
subplot(6,1,1)
plot(time_vector_for_fluxes_time_series, time_series.infil)
xlabel('DOWY'); title('infil (m)'); ylim([0 1*10^-3]); hold on;
subplot(6,1,2)
plot(time_vector_for_fluxes_time_series, time_series.qie)
xlabel('DOWY'); title('qie (m)'); ylim([0 3*10^-3]);hold on;
subplot(6,1,3)
plot(time_vector_for_fluxes_time_series, time_series.qse)
xlabel('DOWY'); title('qse (m)'); ylim([0 1*10^-3]);hold on;
subplot(6,1,4)
plot(time_vector_for_fluxes_time_series, time_series.snowmelt)
xlabel('DOWY'); title('snowmelt (m)'); ylim([0 2*10^-3]);hold on;
subplot(6,1,5)
plot(time_vector_for_fluxes_time_series, disaggregated_forcing.time_series.PPT)
xlabel('DOWY'); title('PPT (m)'); ylim([0 5*10^-3]);hold on;
subplot(6,1,6)
plot(time_vector_for_fluxes_time_series, time_series.outlet_hydrograph)
xlabel('DOWY'); title('outlet hydrograph (m3/s)');hold on;
t = annotation('textbox', [0 0.9 1 0.1], 'String','Merced Basin-averaged Time Series Outputs', 'EdgeColor', 'none', 'HorizontalAlignment', 'center');
t.FontSize =15;  t.FontWeight = 'bold';

 % Plot the cumulative fluxes
figure
subplot(6,1,1)
plot(time_vector_for_fluxes_time_series, cumsum(time_series.infil))
xlabel('DOWY'); title('infil (m)'); hold on;
subplot(6,1,2)
plot(time_vector_for_fluxes_time_series, cumsum(time_series.qie))
xlabel('DOWY'); title('qie (m)'); hold on;
subplot(6,1,3)
plot(time_vector_for_fluxes_time_series, cumsum(time_series.qse))
xlabel('DOWY'); title('qse (m)'); hold on;
subplot(6,1,4)
plot(time_vector_for_fluxes_time_series, cumsum(time_series.snowmelt))
xlabel('DOWY'); title('snowmelt (m)'); hold on;
subplot(6,1,5)
plot(time_vector_for_fluxes_time_series, cumsum(disaggregated_forcing.time_series.PPT))
xlabel('DOWY'); title('PPT (m)'); hold on;
subplot(6,1,6)
plot(time_vector_for_fluxes_time_series, cumsum(time_series.outlet_hydrograph))
xlabel('DOWY'); title('outlet hydrograph (m3/s)');hold on;
t = annotation('textbox', [0 0.9 1 0.1], 'String','Merced Basin-averaged Time Series Outputs', 'EdgeColor', 'none', 'HorizontalAlignment', 'center');
t.FontSize =15;  t.FontWeight = 'bold';

 % Plot the states
figure
subplot(6,1,1)
plot(time_vector_for_states_time_series, time_series.Srz)
xlabel('DOWY'); title('Srz (m)'); hold on;
subplot(6,1,2)
plot(time_vector_for_states_time_series, time_series.SD)
xlabel('DOWY'); title('SD (m)'); hold on;
subplot(6,1,3)
plot(time_vector_for_states_time_series, time_series.Suz)
xlabel('DOWY'); title('Suz (m)'); hold on;
subplot(6,1,4)
plot(time_vector_for_states_time_series, time_series.SWE)
xlabel('DOWY'); title('SWE (m)'); hold on;
subplot(6,1,5)
plot(time_vector_for_fluxes_time_series, cumsum(time_series.ET))
xlabel('DOWY'); title('ET (m)'); hold on;
subplot(6,1,6)
plot(time_vector_for_fluxes_time_series, cumsum(time_series.qb))
xlabel('DOWY'); title('qb (m)'); hold on;
t = annotation('textbox', [0 0.9 1 0.1], 'String','Merced Basin-averaged Time Series Outputs', 'EdgeColor', 'none', 'HorizontalAlignment', 'center');
t.FontSize =15;  t.FontWeight = 'bold';


%% Water Balance analysis
Q_hr=reshape(time_series.outlet_hydrograph*3600,24,365); % m^3/hr
Q_daily=sum(Q_hr); % m^3/day
Q_daily_cum=cumsum(Q_daily); % m^3

ET_daily=squeeze(sum(reshape(time_series.ET*params.basin_area,24,365))); % m^3/day
ET_daily_cum=cumsum(ET_daily); % m^3

PPT_daily=squeeze(sum(reshape(disaggregated_forcing.time_series.PPT*params.basin_area,24,365))); % m^3/day
PPT_daily_cum=cumsum(PPT_daily); % m^3

S_daily_cum=PPT_daily_cum - ET_daily_cum - Q_daily_cum; % m^3

figure
subplot(4,1,1)
plot(1:365,Q_daily_cum)
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Runoff (m^3)')

subplot(4,1,2)
plot(1:365,ET_daily_cum)
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Evaporation (m^3)')

subplot(4,1,3)
plot(1:365,PPT_daily_cum)
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Precipitation (m^3)')

subplot(4,1,4)
plot(1:365,S_daily_cum)
hold on
plot([0 365],[0 0],'--k')
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Storage (m^3)')
t = annotation('textbox', [0 0.9 1 0.1], 'String','Merced Water Balance 2016', 'EdgeColor', 'none', 'HorizontalAlignment', 'center');
t.FontSize =15;  t.FontWeight = 'bold';
%% Plot outputs from 2017 model 
clear all;
load /Users/yufeiliu/Desktop/CEE150/Data/output/upper_merced_output_Yufei_2017.mat

% Plot the fluxes
figure(1)
subplot(6,1,1)
plot(time_vector_for_fluxes_time_series, fluxes.time_series.infil)
xlabel('DOWY'); title('infil (m)'); ylim([0 1*10^-3]); legend('2016','2017');
subplot(6,1,2)
plot(time_vector_for_fluxes_time_series, fluxes.time_series.qie)
xlabel('DOWY'); title('qie (m)'); ylim([0 3*10^-3]); legend('2016','2017');
subplot(6,1,3)
plot(time_vector_for_fluxes_time_series, fluxes.time_series.qse)
xlabel('DOWY'); title('qse (m)'); ylim([0 1*10^-3]); legend('2016','2017');
subplot(6,1,4)
plot(time_vector_for_fluxes_time_series, fluxes.time_series.snowmelt)
xlabel('DOWY'); title('snowmelt (m)'); ylim([0 2*10^-3]); legend('2016','2017');
subplot(6,1,5)
plot(time_vector_for_fluxes_time_series, disaggregated_forcing.time_series.PPT)
xlabel('DOWY'); title('PPT (m)'); ylim([0 5*10^-3]); legend('2016','2017');
subplot(6,1,6)
plot(time_vector_for_fluxes_time_series, fluxes.time_series.outlet_hydrograph)
xlabel('DOWY'); title('outlet hydrograph (m3/s)'); legend('2016','2017');

 % Plot the cumulative fluxes
figure(2)
subplot(6,1,1)
plot(time_vector_for_fluxes_time_series, cumsum(fluxes.time_series.infil))
xlabel('DOWY'); title('infil (m)'); legend('2016','2017'); ylim([0 1]);
subplot(6,1,2)
plot(time_vector_for_fluxes_time_series, cumsum(fluxes.time_series.qie))
xlabel('DOWY'); title('qie (m)'); legend('2016','2017');ylim([0 1]);
subplot(6,1,3)
plot(time_vector_for_fluxes_time_series, cumsum(fluxes.time_series.qse))
xlabel('DOWY'); title('qse (m)'); legend('2016','2017');ylim([0 1]);
subplot(6,1,4)
plot(time_vector_for_fluxes_time_series, cumsum(fluxes.time_series.snowmelt))
xlabel('DOWY'); title('snowmelt (m)'); legend('2016','2017');ylim([0 1]);
subplot(6,1,5)
plot(time_vector_for_fluxes_time_series, cumsum(disaggregated_forcing.time_series.PPT))
xlabel('DOWY'); title('PPT (m)'); legend('2016','2017');
subplot(6,1,6)
plot(time_vector_for_fluxes_time_series, cumsum(fluxes.time_series.outlet_hydrograph))
xlabel('DOWY'); title('outlet hydrograph (m3/s)');legend('2016','2017');

 % Plot the states
figure(3)
subplot(6,1,1)
plot(time_vector_for_states_time_series, states.time_series.Srz)
xlabel('DOWY'); title('Srz (m)'); hold on;legend('2016','2017');
subplot(6,1,2)
plot(time_vector_for_states_time_series, states.time_series.SD)
xlabel('DOWY'); title('SD (m)'); hold on;legend('2016','2017');
subplot(6,1,3)
plot(time_vector_for_states_time_series, states.time_series.Suz)
xlabel('DOWY'); title('Suz (m)'); hold on;legend('2016','2017');
subplot(6,1,4)
plot(time_vector_for_states_time_series, states.time_series.SWE)
xlabel('DOWY'); title('SWE (m)'); hold on;legend('2016','2017');
subplot(6,1,5)
plot(time_vector_for_fluxes_time_series, cumsum(fluxes.time_series.ET))
xlabel('DOWY'); title('ET (m)'); hold on;legend('2016','2017');
subplot(6,1,6)
plot(time_vector_for_fluxes_time_series, cumsum(fluxes.time_series.qb))
xlabel('DOWY'); title('qb (m)'); hold on;legend('2016','2017');

%% Water Balance analysis
Q_hr=reshape(fluxes.time_series.outlet_hydrograph*3600,24,365); % m^3/hr
Q_daily=sum(Q_hr); % m^3/day
Q_daily_cum=cumsum(Q_daily); % m^3

ET_daily=squeeze(sum(reshape(fluxes.time_series.ET*params.basin_area,24,365))); % m^3/day
ET_daily_cum=cumsum(ET_daily); % m^3

PPT_daily=squeeze(sum(reshape(disaggregated_forcing.time_series.PPT*params.basin_area,24,365))); % m^3/day
PPT_daily_cum=cumsum(PPT_daily); % m^3

S_daily_cum=PPT_daily_cum - ET_daily_cum - Q_daily_cum; % m^3

figure
subplot(4,1,1)
plot(1:365,Q_daily_cum)
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Runoff (m^3)')

subplot(4,1,2)
plot(1:365,ET_daily_cum)
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Evaporation (m^3)')

subplot(4,1,3)
plot(1:365,PPT_daily_cum)
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Precipitation (m^3)')

subplot(4,1,4)
plot(1:365,S_daily_cum)
hold on
plot([0 365],[0 0],'--k')
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Storage (m^3)')
xlim([0 365]); xlabel('Day of Water Year'); title('Cum Daily Storage (m^3)')
t = annotation('textbox', [0 0.9 1 0.1], 'String','Merced Water Balance 2017', 'EdgeColor', 'none', 'HorizontalAlignment', 'center');
t.FontSize =15;  t.FontWeight = 'bold';