main {
	var src = new IloOplModelSource("P1.mod");
	var def = new IloOplModelDefinition(src);
	var cplex = new IloCplex();
	var model = new IloOplModel(def,cplex);
	var data = new IloOplDataSource("P1.dat");
	model.addDataSource(data);
	model.generate();
	cplex.epgap=0.01;
	if (cplex.solve()) {
		writeln("Max load " + 100 * cplex.getObjValue() + "%");
		for (var c=1;c<=model.nCPUs;c++) {
			var load=0;			
			for (var t=1;t<=model.nTasks;t++){
				load+=(model.rt[t]* model.x_tc[t][c]);
 			}	
		
			load = (1/model.rc[c])*load;
			writeln("CPU " + c + " loaded at " + 100 * load + "%");
		};
		for (var t=1;t<=model.nTasks;t++){
			writeln(model.x_tc[t]);
		};
		/*
        var x_tc = [];
        for (var t = 1; t <= nTasks; t++) {
            x_tc[t] = [];
            for (var c = 1; c <= nCPUs; c++) {
                x_tc[t][c] = modelA.x_tc[t][c];
            }
        };
		
		var src2 = new IloOplModelSource("P1_capacity.mod");
		var def2 = new IloOplModelDefinition(src2);
		var cplex2 = new IloCplex();
		var model2 = new IloOplModel(def2,cplex2);
		model2.addDataSource(data);
		model2.x_tc = x_tc;
		model2.generate();*/
	}
	else {
		writeln("Not solution found");
	}
	model.end();
	data.end();
	def.end();
	cplex.end();
	src.end();
};	