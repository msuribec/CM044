U2=20;
U1=0;
U3=0;


rep = [2.84 1.5 0.62];
pred = [0.02 0 0.03];
cap = [0.22 0 0.1 8640 ];
ui = [0 20 0];

xe = [704.569      80      13.04203];


ri = strcat('[',num2str(rep),']');
K = num2str(cap(4));
ic =  strcat('[',num2str(pred),']');
pc =  strcat('[',num2str(cap([1:3])),']');
ci =  strcat('[',num2str(xe),']');

load_system('LVTresEspecies')
set_param('LVTresEspecies/eco','ci',ci,'ri',ri,'K',K,'ic',ic,'pc',pc)


