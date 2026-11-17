within Tests.Logical;
model RealComparisons
  "All Real comparisons against a truth table"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time of the sampled variants";
  parameter Real eps = 1e-06 "Tolerance of Equal and NotEqual";
  Modelica.Blocks.Sources.RealExpression u1(y=if time < 1 then 1.0 elseif time < 2 then 2.0 elseif time < 3 then 3.0 elseif time < 4 then 2.0000001 else 1.9999999) "First input"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Modelica.Blocks.Sources.RealExpression u2(y=if time < 1 then 2.0 elseif time < 2 then 2.0 elseif time < 3 then 2.0 elseif time < 4 then 2.0 else 2.0) "Second input"
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.Equal equal_c(Ts=0, eps=eps)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.BooleanExpression equal_exp_c(y=if time < 1 then false elseif time < 2 then true elseif time < 3 then false elseif time < 4 then true else true) "Expected Equal"
    annotation (Placement(transformation(extent={{-110,-40},{-90,-20}})));
  Utilities.CheckBoolean chk_equal_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.NotEqual notequal_c(Ts=0, eps=eps)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Sources.BooleanExpression notequal_exp_c(y=if time < 1 then true elseif time < 2 then false elseif time < 3 then true elseif time < 4 then false else false) "Expected NotEqual"
    annotation (Placement(transformation(extent={{-110,-100},{-90,-80}})));
  Utilities.CheckBoolean chk_notequal_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.Great great_c(Ts=0, eps=eps)
    annotation (Placement(transformation(extent={{-110,-130},{-90,-110}})));
  Modelica.Blocks.Sources.BooleanExpression great_exp_c(y=if time < 1 then false elseif time < 2 then false elseif time < 3 then true elseif time < 4 then true else false) "Expected Great"
    annotation (Placement(transformation(extent={{-110,-160},{-90,-140}})));
  Utilities.CheckBoolean chk_great_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-50,-150},{-30,-130}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.GreatEq greateq_c(Ts=0, eps=eps)
    annotation (Placement(transformation(extent={{-110,-190},{-90,-170}})));
  Modelica.Blocks.Sources.BooleanExpression greateq_exp_c(y=if time < 1 then false elseif time < 2 then true elseif time < 3 then true elseif time < 4 then true else false) "Expected GreatEq"
    annotation (Placement(transformation(extent={{-110,-220},{-90,-200}})));
  Utilities.CheckBoolean chk_greateq_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-50,-210},{-30,-190}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.Less less_c(Ts=0, eps=eps)
    annotation (Placement(transformation(extent={{-110,-250},{-90,-230}})));
  Modelica.Blocks.Sources.BooleanExpression less_exp_c(y=if time < 1 then true elseif time < 2 then false elseif time < 3 then false elseif time < 4 then false else true) "Expected Less"
    annotation (Placement(transformation(extent={{-110,-280},{-90,-260}})));
  Utilities.CheckBoolean chk_less_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-50,-270},{-30,-250}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.LessEq lesseq_c(Ts=0, eps=eps)
    annotation (Placement(transformation(extent={{-110,-310},{-90,-290}})));
  Modelica.Blocks.Sources.BooleanExpression lesseq_exp_c(y=if time < 1 then true elseif time < 2 then true elseif time < 3 then false elseif time < 4 then false else true) "Expected LessEq"
    annotation (Placement(transformation(extent={{-110,-340},{-90,-320}})));
  Utilities.CheckBoolean chk_lesseq_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-50,-330},{-30,-310}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.Equal equal_s(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.BooleanExpression equal_exp_s(y=if time < 1 then false elseif time < 2 then true elseif time < 3 then false elseif time < 4 then true else true) "Expected Equal"
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Utilities.CheckBoolean chk_equal_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.NotEqual notequal_s(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  Modelica.Blocks.Sources.BooleanExpression notequal_exp_s(y=if time < 1 then true elseif time < 2 then false elseif time < 3 then true elseif time < 4 then false else false) "Expected NotEqual"
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  Utilities.CheckBoolean chk_notequal_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.Great great_s(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{10,-130},{30,-110}})));
  Modelica.Blocks.Sources.BooleanExpression great_exp_s(y=if time < 1 then false elseif time < 2 then false elseif time < 3 then true elseif time < 4 then true else false) "Expected Great"
    annotation (Placement(transformation(extent={{10,-160},{30,-140}})));
  Utilities.CheckBoolean chk_great_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{70,-150},{90,-130}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.GreatEq greateq_s(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{10,-190},{30,-170}})));
  Modelica.Blocks.Sources.BooleanExpression greateq_exp_s(y=if time < 1 then false elseif time < 2 then true elseif time < 3 then true elseif time < 4 then true else false) "Expected GreatEq"
    annotation (Placement(transformation(extent={{10,-220},{30,-200}})));
  Utilities.CheckBoolean chk_greateq_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{70,-210},{90,-190}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.Less less_s(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{10,-250},{30,-230}})));
  Modelica.Blocks.Sources.BooleanExpression less_exp_s(y=if time < 1 then true elseif time < 2 then false elseif time < 3 then false elseif time < 4 then false else true) "Expected Less"
    annotation (Placement(transformation(extent={{10,-280},{30,-260}})));
  Utilities.CheckBoolean chk_less_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{70,-270},{90,-250}})));
  IndustrialControlSystems.Logical.Comparisons.RealType.LessEq lesseq_s(Ts=Ts, eps=eps)
    annotation (Placement(transformation(extent={{10,-310},{30,-290}})));
  Modelica.Blocks.Sources.BooleanExpression lesseq_exp_s(y=if time < 1 then true elseif time < 2 then true elseif time < 3 then false elseif time < 4 then false else true) "Expected LessEq"
    annotation (Placement(transformation(extent={{10,-340},{30,-320}})));
  Utilities.CheckBoolean chk_lesseq_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{70,-330},{90,-310}})));
  Boolean passed = chk_equal_c.passed and chk_notequal_c.passed and chk_great_c.passed and chk_greateq_c.passed and chk_less_c.passed and chk_lesseq_c.passed and chk_equal_s.passed and chk_notequal_s.passed and chk_great_s.passed and chk_greateq_s.passed and chk_less_s.passed and chk_lesseq_s.passed "true if every check in this test passed";
equation
  connect(u1.y, equal_c.u1) annotation (Line(points={{-139,20},{-120,20},{-120,5},{-108,5}}, color={0,0,127}));
  connect(u2.y, equal_c.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-5},{-108,-5}}, color={0,0,127}));
  connect(equal_c.y, chk_equal_c.actual) annotation (Line(points={{-91,0},{-70,0},{-70,-14},{-52,-14}}, color={255,0,255}));
  connect(equal_exp_c.y, chk_equal_c.expected) annotation (Line(points={{-89,-30},{-60,-30},{-60,-26},{-52,-26}}, color={255,0,255}));
  connect(u1.y, notequal_c.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-55},{-108,-55}}, color={0,0,127}));
  connect(u2.y, notequal_c.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-65},{-108,-65}}, color={0,0,127}));
  connect(notequal_c.y, chk_notequal_c.actual) annotation (Line(points={{-91,-60},{-70,-60},{-70,-74},{-52,-74}}, color={255,0,255}));
  connect(notequal_exp_c.y, chk_notequal_c.expected) annotation (Line(points={{-89,-90},{-60,-90},{-60,-86},{-52,-86}}, color={255,0,255}));
  connect(u1.y, great_c.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-115},{-108,-115}}, color={0,0,127}));
  connect(u2.y, great_c.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-125},{-108,-125}}, color={0,0,127}));
  connect(great_c.y, chk_great_c.actual) annotation (Line(points={{-91,-120},{-70,-120},{-70,-134},{-52,-134}}, color={255,0,255}));
  connect(great_exp_c.y, chk_great_c.expected) annotation (Line(points={{-89,-150},{-60,-150},{-60,-146},{-52,-146}}, color={255,0,255}));
  connect(u1.y, greateq_c.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-175},{-108,-175}}, color={0,0,127}));
  connect(u2.y, greateq_c.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-185},{-108,-185}}, color={0,0,127}));
  connect(greateq_c.y, chk_greateq_c.actual) annotation (Line(points={{-91,-180},{-70,-180},{-70,-194},{-52,-194}}, color={255,0,255}));
  connect(greateq_exp_c.y, chk_greateq_c.expected) annotation (Line(points={{-89,-210},{-60,-210},{-60,-206},{-52,-206}}, color={255,0,255}));
  connect(u1.y, less_c.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-235},{-108,-235}}, color={0,0,127}));
  connect(u2.y, less_c.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-245},{-108,-245}}, color={0,0,127}));
  connect(less_c.y, chk_less_c.actual) annotation (Line(points={{-91,-240},{-70,-240},{-70,-254},{-52,-254}}, color={255,0,255}));
  connect(less_exp_c.y, chk_less_c.expected) annotation (Line(points={{-89,-270},{-60,-270},{-60,-266},{-52,-266}}, color={255,0,255}));
  connect(u1.y, lesseq_c.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-295},{-108,-295}}, color={0,0,127}));
  connect(u2.y, lesseq_c.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-305},{-108,-305}}, color={0,0,127}));
  connect(lesseq_c.y, chk_lesseq_c.actual) annotation (Line(points={{-91,-300},{-70,-300},{-70,-314},{-52,-314}}, color={255,0,255}));
  connect(lesseq_exp_c.y, chk_lesseq_c.expected) annotation (Line(points={{-89,-330},{-60,-330},{-60,-326},{-52,-326}}, color={255,0,255}));
  connect(u1.y, equal_s.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-350},{-10,-350},{-10,5},{12,5}}, color={0,0,127}));
  connect(u2.y, equal_s.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-360},{0,-360},{0,-5},{12,-5}}, color={0,0,127}));
  connect(equal_s.y, chk_equal_s.actual) annotation (Line(points={{29,0},{50,0},{50,-14},{68,-14}}, color={255,0,255}));
  connect(equal_exp_s.y, chk_equal_s.expected) annotation (Line(points={{31,-30},{60,-30},{60,-26},{68,-26}}, color={255,0,255}));
  connect(u1.y, notequal_s.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-350},{-10,-350},{-10,-55},{12,-55}}, color={0,0,127}));
  connect(u2.y, notequal_s.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-360},{0,-360},{0,-65},{12,-65}}, color={0,0,127}));
  connect(notequal_s.y, chk_notequal_s.actual) annotation (Line(points={{29,-60},{50,-60},{50,-74},{68,-74}}, color={255,0,255}));
  connect(notequal_exp_s.y, chk_notequal_s.expected) annotation (Line(points={{31,-90},{60,-90},{60,-86},{68,-86}}, color={255,0,255}));
  connect(u1.y, great_s.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-350},{-10,-350},{-10,-115},{12,-115}}, color={0,0,127}));
  connect(u2.y, great_s.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-360},{0,-360},{0,-125},{12,-125}}, color={0,0,127}));
  connect(great_s.y, chk_great_s.actual) annotation (Line(points={{29,-120},{50,-120},{50,-134},{68,-134}}, color={255,0,255}));
  connect(great_exp_s.y, chk_great_s.expected) annotation (Line(points={{31,-150},{60,-150},{60,-146},{68,-146}}, color={255,0,255}));
  connect(u1.y, greateq_s.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-350},{-10,-350},{-10,-175},{12,-175}}, color={0,0,127}));
  connect(u2.y, greateq_s.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-360},{0,-360},{0,-185},{12,-185}}, color={0,0,127}));
  connect(greateq_s.y, chk_greateq_s.actual) annotation (Line(points={{29,-180},{50,-180},{50,-194},{68,-194}}, color={255,0,255}));
  connect(greateq_exp_s.y, chk_greateq_s.expected) annotation (Line(points={{31,-210},{60,-210},{60,-206},{68,-206}}, color={255,0,255}));
  connect(u1.y, less_s.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-350},{-10,-350},{-10,-235},{12,-235}}, color={0,0,127}));
  connect(u2.y, less_s.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-360},{0,-360},{0,-245},{12,-245}}, color={0,0,127}));
  connect(less_s.y, chk_less_s.actual) annotation (Line(points={{29,-240},{50,-240},{50,-254},{68,-254}}, color={255,0,255}));
  connect(less_exp_s.y, chk_less_s.expected) annotation (Line(points={{31,-270},{60,-270},{60,-266},{68,-266}}, color={255,0,255}));
  connect(u1.y, lesseq_s.u1) annotation (Line(points={{-139,20},{-120,20},{-120,-350},{-10,-350},{-10,-295},{12,-295}}, color={0,0,127}));
  connect(u2.y, lesseq_s.u2) annotation (Line(points={{-139,-10},{-130,-10},{-130,-360},{0,-360},{0,-305},{12,-305}}, color={0,0,127}));
  connect(lesseq_s.y, chk_lesseq_s.actual) annotation (Line(points={{29,-300},{50,-300},{50,-314},{68,-314}}, color={255,0,255}));
  connect(lesseq_exp_s.y, chk_lesseq_s.expected) annotation (Line(points={{31,-330},{60,-330},{60,-326},{68,-326}}, color={255,0,255}));
  annotation (
    experiment(StopTime=5),
    Diagram(coordinateSystem(extent={{-170,-370},{100,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Tests all six Real comparisons of
<a href=\"modelica://IndustrialControlSystems.Logical.Comparisons.RealType\">IndustrialControlSystems.Logical.Comparisons.RealType</a>,
continuous (<code>Ts=0</code>, left column, suffix <code>_c</code>) and sampled (<code>Ts=0.1</code>, right column, suffix <code>_s</code>).
Each row is block under test, expected value, check. The inputs change every second; checks are at t = 0.45 + 0.5k s.</p><p>Segments 4 and 5 differ from <code>u2</code> by <code>eps/10</code>: <code>Equal</code> and
<code>NotEqual</code> use the tolerance <code>eps = 1e-06</code>, the ordering comparisons compare exactly.</p>
<table border=\"1\" cellpadding=\"3\"><tr><th>segment</th><th>u1</th><th>u2</th><th>Equal</th><th>NotEqual</th><th>Great</th><th>GreatEq</th><th>Less</th><th>LessEq</th></tr>
<tr><td>0</td><td>1.0</td><td>2.0</td><td>false</td><td>true</td><td>false</td><td>false</td><td>true</td><td>true</td></tr><tr><td>1</td><td>2.0</td><td>2.0</td><td>true</td><td>false</td><td>false</td><td>true</td><td>false</td><td>true</td></tr><tr><td>2</td><td>3.0</td><td>2.0</td><td>false</td><td>true</td><td>true</td><td>true</td><td>false</td><td>false</td></tr><tr><td>3</td><td>2.0000001</td><td>2.0</td><td>true</td><td>false</td><td>true</td><td>true</td><td>false</td><td>false</td></tr><tr><td>4</td><td>1.9999999</td><td>2.0</td><td>true</td><td>false</td><td>false</td><td>false</td><td>true</td><td>true</td></tr></table>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end RealComparisons;
