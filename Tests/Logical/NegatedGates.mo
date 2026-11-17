within Tests.Logical;
model NegatedGates
  "Nand, Nor and Xnor against Modelica Boolean operators"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time of the sampled variants";
  Modelica.Blocks.Sources.BooleanPulse p(period=1) "Input 1"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Modelica.Blocks.Sources.BooleanPulse q(period=2) "Input 2"
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
  Modelica.Blocks.Sources.BooleanPulse r(period=4) "Input 3"
    annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nand nand3c(nInput=3, Ts=0)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.BooleanExpression nand3c_exp(y=not (p.y and q.y and r.y)) "Expected 3-input Nand"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Utilities.CheckBoolean chk_nand3c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nand nand3s(nInput=3, Ts=Ts)
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Sources.BooleanExpression nand3s_exp(y=not (p.y and q.y and r.y)) "Expected 3-input Nand"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Utilities.CheckBoolean chk_nand3s(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nand nand2c(nInput=2, Ts=0)
    annotation (Placement(transformation(extent={{-100,-130},{-80,-110}})));
  Modelica.Blocks.Sources.BooleanExpression nand2c_exp(y=not (p.y and q.y)) "Expected 2-input Nand"
    annotation (Placement(transformation(extent={{-100,-160},{-80,-140}})));
  Utilities.CheckBoolean chk_nand2c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{-40,-150},{-20,-130}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nor nor3c(nInput=3, Ts=0)
    annotation (Placement(transformation(extent={{-100,-190},{-80,-170}})));
  Modelica.Blocks.Sources.BooleanExpression nor3c_exp(y=not (p.y or q.y or r.y)) "Expected 3-input Nor"
    annotation (Placement(transformation(extent={{-100,-220},{-80,-200}})));
  Utilities.CheckBoolean chk_nor3c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{-40,-210},{-20,-190}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nor nor3s(nInput=3, Ts=Ts)
    annotation (Placement(transformation(extent={{-100,-250},{-80,-230}})));
  Modelica.Blocks.Sources.BooleanExpression nor3s_exp(y=not (p.y or q.y or r.y)) "Expected 3-input Nor"
    annotation (Placement(transformation(extent={{-100,-280},{-80,-260}})));
  Utilities.CheckBoolean chk_nor3s(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{-40,-270},{-20,-250}})));
  IndustrialControlSystems.Logical.LogicalOperations.Nor nor2c(nInput=2, Ts=0)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Sources.BooleanExpression nor2c_exp(y=not (p.y or q.y)) "Expected 2-input Nor"
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Utilities.CheckBoolean chk_nor2c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  IndustrialControlSystems.Logical.LogicalOperations.Xnor xnor3c(nInput=3, Ts=0)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Modelica.Blocks.Sources.BooleanExpression xnor3c_exp(y=(p.y <> (q.y == r.y))) "Expected 3-input Xnor"
    annotation (Placement(transformation(extent={{30,-100},{50,-80}})));
  Utilities.CheckBoolean chk_xnor3c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  IndustrialControlSystems.Logical.LogicalOperations.Xnor xnor3s(nInput=3, Ts=Ts)
    annotation (Placement(transformation(extent={{30,-130},{50,-110}})));
  Modelica.Blocks.Sources.BooleanExpression xnor3s_exp(y=(p.y <> (q.y == r.y))) "Expected 3-input Xnor"
    annotation (Placement(transformation(extent={{30,-160},{50,-140}})));
  Utilities.CheckBoolean chk_xnor3s(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{90,-150},{110,-130}})));
  IndustrialControlSystems.Logical.LogicalOperations.Xnor xnor2c(nInput=2, Ts=0)
    annotation (Placement(transformation(extent={{30,-190},{50,-170}})));
  Modelica.Blocks.Sources.BooleanExpression xnor2c_exp(y=(p.y == q.y)) "Expected 2-input Xnor"
    annotation (Placement(transformation(extent={{30,-220},{50,-200}})));
  Utilities.CheckBoolean chk_xnor2c(tStart=0.3, dt=0.5)
    annotation (Placement(transformation(extent={{90,-210},{110,-190}})));
  Boolean passed = chk_nand3c.passed and chk_nand3s.passed and chk_nand2c.passed and chk_nor3c.passed and chk_nor3s.passed and chk_nor2c.passed and chk_xnor3c.passed and chk_xnor3s.passed and chk_xnor2c.passed "true if every check in this test passed";
equation
  connect(p.y, nand3c.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,1},{-98,1}}, color={255,0,255}));
  connect(q.y, nand3c.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,0},{-98,0}}, color={255,0,255}));
  connect(r.y, nand3c.u[3]) annotation (Line(points={{-139,-40},{-130,-40},{-130,-1},{-98,-1}}, color={255,0,255}));
  connect(nand3c.y[1], chk_nand3c.actual) annotation (Line(points={{-81,0},{-60,0},{-60,-14},{-42,-14}}, color={255,0,255}));
  connect(nand3c_exp.y, chk_nand3c.expected) annotation (Line(points={{-79,-30},{-50,-30},{-50,-26},{-42,-26}}, color={255,0,255}));
  connect(p.y, nand3s.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-59},{-98,-59}}, color={255,0,255}));
  connect(q.y, nand3s.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-60},{-98,-60}}, color={255,0,255}));
  connect(r.y, nand3s.u[3]) annotation (Line(points={{-139,-40},{-130,-40},{-130,-61},{-98,-61}}, color={255,0,255}));
  connect(nand3s.y[1], chk_nand3s.actual) annotation (Line(points={{-81,-60},{-60,-60},{-60,-74},{-42,-74}}, color={255,0,255}));
  connect(nand3s_exp.y, chk_nand3s.expected) annotation (Line(points={{-79,-90},{-50,-90},{-50,-86},{-42,-86}}, color={255,0,255}));
  connect(p.y, nand2c.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-119},{-98,-119}}, color={255,0,255}));
  connect(q.y, nand2c.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-121},{-98,-121}}, color={255,0,255}));
  connect(nand2c.y[1], chk_nand2c.actual) annotation (Line(points={{-81,-120},{-60,-120},{-60,-134},{-42,-134}}, color={255,0,255}));
  connect(nand2c_exp.y, chk_nand2c.expected) annotation (Line(points={{-79,-150},{-50,-150},{-50,-146},{-42,-146}}, color={255,0,255}));
  connect(p.y, nor3c.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-179},{-98,-179}}, color={255,0,255}));
  connect(q.y, nor3c.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-180},{-98,-180}}, color={255,0,255}));
  connect(r.y, nor3c.u[3]) annotation (Line(points={{-139,-40},{-130,-40},{-130,-181},{-98,-181}}, color={255,0,255}));
  connect(nor3c.y[1], chk_nor3c.actual) annotation (Line(points={{-81,-180},{-60,-180},{-60,-194},{-42,-194}}, color={255,0,255}));
  connect(nor3c_exp.y, chk_nor3c.expected) annotation (Line(points={{-79,-210},{-50,-210},{-50,-206},{-42,-206}}, color={255,0,255}));
  connect(p.y, nor3s.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-239},{-98,-239}}, color={255,0,255}));
  connect(q.y, nor3s.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-240},{-98,-240}}, color={255,0,255}));
  connect(r.y, nor3s.u[3]) annotation (Line(points={{-139,-40},{-130,-40},{-130,-241},{-98,-241}}, color={255,0,255}));
  connect(nor3s.y[1], chk_nor3s.actual) annotation (Line(points={{-81,-240},{-60,-240},{-60,-254},{-42,-254}}, color={255,0,255}));
  connect(nor3s_exp.y, chk_nor3s.expected) annotation (Line(points={{-79,-270},{-50,-270},{-50,-266},{-42,-266}}, color={255,0,255}));
  connect(p.y, nor2c.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-290},{0,-290},{0,1},{32,1}}, color={255,0,255}));
  connect(q.y, nor2c.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-300},{10,-300},{10,-1},{32,-1}}, color={255,0,255}));
  connect(nor2c.y[1], chk_nor2c.actual) annotation (Line(points={{49,0},{70,0},{70,-14},{88,-14}}, color={255,0,255}));
  connect(nor2c_exp.y, chk_nor2c.expected) annotation (Line(points={{51,-30},{80,-30},{80,-26},{88,-26}}, color={255,0,255}));
  connect(p.y, xnor3c.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-290},{0,-290},{0,-59},{32,-59}}, color={255,0,255}));
  connect(q.y, xnor3c.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-300},{10,-300},{10,-60},{32,-60}}, color={255,0,255}));
  connect(r.y, xnor3c.u[3]) annotation (Line(points={{-139,-40},{-130,-40},{-130,-310},{20,-310},{20,-61},{32,-61}}, color={255,0,255}));
  connect(xnor3c.y[1], chk_xnor3c.actual) annotation (Line(points={{49,-60},{70,-60},{70,-74},{88,-74}}, color={255,0,255}));
  connect(xnor3c_exp.y, chk_xnor3c.expected) annotation (Line(points={{51,-90},{80,-90},{80,-86},{88,-86}}, color={255,0,255}));
  connect(p.y, xnor3s.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-290},{0,-290},{0,-119},{32,-119}}, color={255,0,255}));
  connect(q.y, xnor3s.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-300},{10,-300},{10,-120},{32,-120}}, color={255,0,255}));
  connect(r.y, xnor3s.u[3]) annotation (Line(points={{-139,-40},{-130,-40},{-130,-310},{20,-310},{20,-121},{32,-121}}, color={255,0,255}));
  connect(xnor3s.y[1], chk_xnor3s.actual) annotation (Line(points={{49,-120},{70,-120},{70,-134},{88,-134}}, color={255,0,255}));
  connect(xnor3s_exp.y, chk_xnor3s.expected) annotation (Line(points={{51,-150},{80,-150},{80,-146},{88,-146}}, color={255,0,255}));
  connect(p.y, xnor2c.u[1]) annotation (Line(points={{-139,20},{-110,20},{-110,-290},{0,-290},{0,-179},{32,-179}}, color={255,0,255}));
  connect(q.y, xnor2c.u[2]) annotation (Line(points={{-139,-10},{-120,-10},{-120,-300},{10,-300},{10,-181},{32,-181}}, color={255,0,255}));
  connect(xnor2c.y[1], chk_xnor2c.actual) annotation (Line(points={{49,-180},{70,-180},{70,-194},{88,-194}}, color={255,0,255}));
  connect(xnor2c_exp.y, chk_xnor2c.expected) annotation (Line(points={{51,-210},{80,-210},{80,-206},{88,-206}}, color={255,0,255}));
  annotation (
    experiment(StopTime=8),
    Diagram(coordinateSystem(extent={{-170,-320},{120,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Tests <a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.Nand\">Nand</a>,
<a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.Nor\">Nor</a> and
<a href=\"modelica://IndustrialControlSystems.Logical.LogicalOperations.Xnor\">Xnor</a> with 3 inputs
(continuous <code>_3c</code> and sampled <code>_3s</code>) and with 2 inputs (continuous <code>_2c</code>).
Each row is gate under test, expected value, check.
Three Boolean pulses with periods 1, 2 and 4 s run through all 8 input combinations in 4 s;
the expected outputs use the Modelica operators <code>and</code>, <code>or</code>, <code>not</code> and
<code>==</code> (3-input XNOR = even number of true inputs). Checks are at t = 0.3 + 0.5k s.</p>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end NegatedGates;
