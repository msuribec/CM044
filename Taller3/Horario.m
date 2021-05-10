load_system('LVTresEspecies')
set_param('LVTresEspecies/eco','ci',ci,'ri',ri,'K',K,'ic',ic,'pc',pc)
      
U1 = 10;
U2 = 0;
U3 = 0;

sim('LVTresEspecies');

plot(t,x(:))