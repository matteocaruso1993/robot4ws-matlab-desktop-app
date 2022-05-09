tab = load('external_loads_processed.mat');
initial_force = false;
target1 = 2.5;
target2 = 1.5;

Df_required = zeros(numel(tab.pippo.Row),1);
Cable_tension = zeros(numel(tab.pippo.Row),1);
Desired_tension = zeros(numel(tab.pippo.Row),1);
Preload = zeros(numel(tab.pippo.Row),1);
for i=1:numel(Df_required)
    row_name = tab.pippo.Row{i};
    if strcmp(row_name(end),'1')
        target = target1;
    elseif strcmp(row_name(end),'2')
        target = target2;
    end
    
    delta = target - tab.pippo(row_name,'F_mean').F_mean;
    Df_required(i) = delta;
    current_cab_tension = computeLinearSpringTension(tab.pippo(row_name,'F_mean').F_mean,0.1,0.03);
    current_desired_tension = computeLinearSpringTension(target, 0.1,0.03);
    Cable_tension(i) = current_cab_tension;
    Desired_tension(i) = current_desired_tension;
    [~,x] = computeAdditionalPreload(14.7,current_cab_tension*9.81,current_desired_tension*9.81);
    Preload(i) = x;
    
    
end
tab.pippo.Df = Df_required; %Delta of force (Expressed in kilograms)
tab.pippo.T_cab = Cable_tension; %Tension of the cable (Expressed in kilograms)
tab.pippo.T_target = Desired_tension; %Desired tension of the cable (Expressed in kilograms)
tab.pippo.D_T = tab.pippo.T_target - tab.pippo.T_cab; %Delta of cable tension
tab.pippo.D_x = Preload; %Delta x [mm]

tmp = tab.pippo;
save('preprocessed_tensions.mat','tmp');
