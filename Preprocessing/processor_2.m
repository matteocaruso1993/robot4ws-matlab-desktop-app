tab = load('external_loads_processed.mat');
fields = tab.pippo.Row;
for i=1:numel(fields)
    field = fields{i};
    F_mean_kgf(i) = tab.pippo(field,'F_mean').F_mean;

