/*********************************************
 * OPL 22.1.1.0 Model
 * Author: mlarosa
 * Creation Date: Mar 4, 2025 at 10:55:43 AM
 *********************************************/

 main {

  /* Imports a .mod file */
  var src = new IloOplModelSource("chems_pro.mod");

  /* Creates a model with an imported .mod file */
  var def = new IloOplModelDefinition(src);

  /* Creates a solver object */
  var cplex = new IloCplex();

  /* Links the model with the solver */
  var model = new IloOplModel(def,cplex);

  /* Imports a .dat file */
  var data = new IloOplDataSource("chems_pro.dat");

  /* Adds the data to the model */
  model.addDataSource(data);

  /* Prepare the model for the solver to be run */
  model.generate();

  /* Call the solver */
  if (cplex.solve()) {

    /* Do whatever with the outcome of the optimization */
    writeln("Optimal profit: " + cplex.getObjValue());
    for (var c=1;c<=model.nProducts;c++) {
      writeln("Production of product #" + c + ": " + model.Production[c]);
    }
  }
  else {
    writeln("Not solution found");
  }
  data.end();
  model.end();
  cplex.end();
  def.end();
  src.end();
};