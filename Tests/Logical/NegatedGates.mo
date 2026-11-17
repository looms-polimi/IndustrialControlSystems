within Tests.Logical;
model NegatedGates
  "Nand, Nor and Xnor against Modelica Boolean operators"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time of the sampled variants";
  Modelica.Blocks.Sources.BooleanPulse p(period=1) "Input 1"
    annotation (Placement(transformation(extent={{-100,82},{-84,98}})));
  Modelica.Blocks.Sources.BooleanPulse q(period=2) "Input 2"
    annotation (Placement(transformation(extent={{-100,57},{-84,73}})));
  Modelica.Blocks.Sources.BooleanPulse r(period=4) "Input 3"
    annotation (Placement(transformation(extent={{-100,32},{-84,48}})));
  Modelica.Blocks.Sources.BooleanExpression nand3_exp(y=not (p.y and q.y and r.y)) "Expected 3-input Nand"
    annotation (Placement(transformation(extent={{-50,82},{-34,98}})));
  Modelica.Blocks.Sources.BooleanExpression nand2_exp(y=not (p.y and q.y)) "Expected 2-input Nand"
    annotation (Placement(transformation(extent={{-50,57},{-34,73}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nand nand3c(nInput=3, Ts=0)
    annotation (Placement(transformation(extent={{0,82},{16,98}})));
  Utilities.CheckBoolean chk_nand3c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,82},{66,98}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nand nand3s(nInput=3, Ts=Ts)
    annotation (Placement(transformation(extent={{0,57},{16,73}})));
  Utilities.CheckBoolean chk_nand3s(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,57},{66,73}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nand nand2c(nInput=2, Ts=0)
    annotation (Placement(transformation(extent={{0,32},{16,48}})));
  Utilities.CheckBoolean chk_nand2c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,32},{66,48}})));
  Modelica.Blocks.Sources.BooleanExpression nor3_exp(y=not (p.y or q.y or r.y)) "Expected 3-input Nor"
    annotation (Placement(transformation(extent={{-50,32},{-34,48}})));
  Modelica.Blocks.Sources.BooleanExpression nor2_exp(y=not (p.y or q.y)) "Expected 2-input Nor"
    annotation (Placement(transformation(extent={{-50,7},{-34,23}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nor nor3c(nInput=3, Ts=0)
    annotation (Placement(transformation(extent={{0,7},{16,23}})));
  Utilities.CheckBoolean chk_nor3c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,7},{66,23}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nor nor3s(nInput=3, Ts=Ts)
    annotation (Placement(transformation(extent={{0,-18},{16,-2}})));
  Utilities.CheckBoolean chk_nor3s(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,-18},{66,-2}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nor nor2c(nInput=2, Ts=0)
    annotation (Placement(transformation(extent={{0,-43},{16,-27}})));
  Utilities.CheckBoolean chk_nor2c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,-43},{66,-27}})));
  Modelica.Blocks.Sources.BooleanExpression xnor3_exp(y=(p.y <> (q.y == r.y))) "Expected 3-input Xnor"
    annotation (Placement(transformation(extent={{-50,-18},{-34,-2}})));
  Modelica.Blocks.Sources.BooleanExpression xnor2_exp(y=(p.y == q.y)) "Expected 2-input Xnor"
    annotation (Placement(transformation(extent={{-50,-43},{-34,-27}})));
  IndustrialControlSystems.Logical.LogicalOperations.Xnor xnor3c(nInput=3, Ts=0)
    annotation (Placement(transformation(extent={{0,-68},{16,-52}})));
  Utilities.CheckBoolean chk_xnor3c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,-68},{66,-52}})));
  IndustrialControlSystems.Logical.LogicalOperations.Xnor xnor3s(nInput=3, Ts=Ts)
    annotation (Placement(transformation(extent={{0,-93},{16,-77}})));
  Utilities.CheckBoolean chk_xnor3s(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,-93},{66,-77}})));
  IndustrialControlSystems.Logical.LogicalOperations.Xnor xnor2c(nInput=2, Ts=0)
    annotation (Placement(transformation(extent={{0,-118},{16,-102}})));
  Utilities.CheckBoolean chk_xnor2c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{50,-118},{66,-102}})));
  Boolean passed = chk_nand3c.passed and chk_nand3s.passed and chk_nand2c.passed and chk_nor3c.passed and chk_nor3s.passed and chk_nor2c.passed and chk_xnor3c.passed and chk_xnor3s.passed and chk_xnor2c.passed "true if every check in this test passed";
equation
  connect(p.y, nand3c.u[1]);
  connect(q.y, nand3c.u[2]);
  connect(r.y, nand3c.u[3]);
  connect(nand3c.y[1], chk_nand3c.actual);
  connect(nand3_exp.y, chk_nand3c.expected);
  connect(p.y, nand3s.u[1]);
  connect(q.y, nand3s.u[2]);
  connect(r.y, nand3s.u[3]);
  connect(nand3s.y[1], chk_nand3s.actual);
  connect(nand3_exp.y, chk_nand3s.expected);
  connect(p.y, nand2c.u[1]);
  connect(q.y, nand2c.u[2]);
  connect(nand2c.y[1], chk_nand2c.actual);
  connect(nand2_exp.y, chk_nand2c.expected);
  connect(p.y, nor3c.u[1]);
  connect(q.y, nor3c.u[2]);
  connect(r.y, nor3c.u[3]);
  connect(nor3c.y[1], chk_nor3c.actual);
  connect(nor3_exp.y, chk_nor3c.expected);
  connect(p.y, nor3s.u[1]);
  connect(q.y, nor3s.u[2]);
  connect(r.y, nor3s.u[3]);
  connect(nor3s.y[1], chk_nor3s.actual);
  connect(nor3_exp.y, chk_nor3s.expected);
  connect(p.y, nor2c.u[1]);
  connect(q.y, nor2c.u[2]);
  connect(nor2c.y[1], chk_nor2c.actual);
  connect(nor2_exp.y, chk_nor2c.expected);
  connect(p.y, xnor3c.u[1]);
  connect(q.y, xnor3c.u[2]);
  connect(r.y, xnor3c.u[3]);
  connect(xnor3c.y[1], chk_xnor3c.actual);
  connect(xnor3_exp.y, chk_xnor3c.expected);
  connect(p.y, xnor3s.u[1]);
  connect(q.y, xnor3s.u[2]);
  connect(r.y, xnor3s.u[3]);
  connect(xnor3s.y[1], chk_xnor3s.actual);
  connect(xnor3_exp.y, chk_xnor3s.expected);
  connect(p.y, xnor2c.u[1]);
  connect(q.y, xnor2c.u[2]);
  connect(xnor2c.y[1], chk_xnor2c.actual);
  connect(xnor2_exp.y, chk_xnor2c.expected);
  annotation (
    experiment(StopTime=8),
    Diagram(coordinateSystem(extent={{-110,-128},{76,100}})),
    Documentation(info="<html>
<p>Tests <a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.Nand\">Nand</a>,
<a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.Nor\">Nor</a> and
<a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.Xnor\">Xnor</a> with 3 inputs
(continuous <code>_3c</code> and sampled <code>_3s</code>) and with 2 inputs (continuous <code>_2c</code>).
Three Boolean pulses with periods 1, 2 and 4 s run through all 8 input combinations in 4 s;
the expected outputs use the Modelica operators <code>and</code>, <code>or</code>, <code>not</code> and
<code>==</code> (3-input XNOR = even number of true inputs). Checks are at t = 0.3 + 0.5k s.</p>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end NegatedGates;
