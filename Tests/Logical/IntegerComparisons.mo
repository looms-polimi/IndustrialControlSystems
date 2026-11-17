within Tests.Logical;
model IntegerComparisons
  "All Integer comparisons against a truth table"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time of the sampled variants";
  Modelica.Blocks.Sources.IntegerExpression u1(y=if time < 1 then 1 elseif time < 2 then 2 elseif time < 3 then 3 elseif time < 4 then -5 else -6) "First input"
    annotation (Placement(transformation(extent={{-100,82},{-84,98}})));
  Modelica.Blocks.Sources.IntegerExpression u2(y=if time < 1 then 2 elseif time < 2 then 2 elseif time < 3 then 2 elseif time < 4 then -5 else -5) "Second input"
    annotation (Placement(transformation(extent={{-100,57},{-84,73}})));
  Modelica.Blocks.Sources.BooleanExpression equal_exp(y=if time < 1 then false elseif time < 2 then true elseif time < 3 then false elseif time < 4 then true else false) "Expected Equal"
    annotation (Placement(transformation(extent={{-50,82},{-34,98}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.Equal equal_c(Ts=0)
    annotation (Placement(transformation(extent={{0,82},{16,98}})));
  Utilities.CheckBoolean chk_equal_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,82},{116,98}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.Equal equal_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,82},{66,98}})));
  Utilities.CheckBoolean chk_equal_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,82},{166,98}})));
  Modelica.Blocks.Sources.BooleanExpression notequal_exp(y=if time < 1 then true elseif time < 2 then false elseif time < 3 then true elseif time < 4 then false else true) "Expected NotEqual"
    annotation (Placement(transformation(extent={{-50,57},{-34,73}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.NotEqual notequal_c(Ts=0)
    annotation (Placement(transformation(extent={{0,57},{16,73}})));
  Utilities.CheckBoolean chk_notequal_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,57},{116,73}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.NotEqual notequal_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,57},{66,73}})));
  Utilities.CheckBoolean chk_notequal_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,57},{166,73}})));
  Modelica.Blocks.Sources.BooleanExpression great_exp(y=if time < 1 then false elseif time < 2 then false elseif time < 3 then true elseif time < 4 then false else false) "Expected Great"
    annotation (Placement(transformation(extent={{-50,32},{-34,48}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.Great great_c(Ts=0)
    annotation (Placement(transformation(extent={{0,32},{16,48}})));
  Utilities.CheckBoolean chk_great_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,32},{116,48}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.Great great_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,32},{66,48}})));
  Utilities.CheckBoolean chk_great_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,32},{166,48}})));
  Modelica.Blocks.Sources.BooleanExpression greateq_exp(y=if time < 1 then false elseif time < 2 then true elseif time < 3 then true elseif time < 4 then true else false) "Expected GreatEq"
    annotation (Placement(transformation(extent={{-50,7},{-34,23}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.GreatEq greateq_c(Ts=0)
    annotation (Placement(transformation(extent={{0,7},{16,23}})));
  Utilities.CheckBoolean chk_greateq_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,7},{116,23}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.GreatEq greateq_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,7},{66,23}})));
  Utilities.CheckBoolean chk_greateq_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,7},{166,23}})));
  Modelica.Blocks.Sources.BooleanExpression less_exp(y=if time < 1 then true elseif time < 2 then false elseif time < 3 then false elseif time < 4 then false else true) "Expected Less"
    annotation (Placement(transformation(extent={{-50,-18},{-34,-2}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.Less less_c(Ts=0)
    annotation (Placement(transformation(extent={{0,-18},{16,-2}})));
  Utilities.CheckBoolean chk_less_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,-18},{116,-2}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.Less less_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-18},{66,-2}})));
  Utilities.CheckBoolean chk_less_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,-18},{166,-2}})));
  Modelica.Blocks.Sources.BooleanExpression lesseq_exp(y=if time < 1 then true elseif time < 2 then true elseif time < 3 then false elseif time < 4 then true else true) "Expected LessEq"
    annotation (Placement(transformation(extent={{-50,-43},{-34,-27}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.LessEq lesseq_c(Ts=0)
    annotation (Placement(transformation(extent={{0,-43},{16,-27}})));
  Utilities.CheckBoolean chk_lesseq_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,-43},{116,-27}})));
  IndustrialControlSystems.Logical.Comparisons.IntegerType.LessEq lesseq_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-43},{66,-27}})));
  Utilities.CheckBoolean chk_lesseq_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,-43},{166,-27}})));
  Boolean passed = chk_equal_c.passed and chk_equal_s.passed and chk_notequal_c.passed and chk_notequal_s.passed and chk_great_c.passed and chk_great_s.passed and chk_greateq_c.passed and chk_greateq_s.passed and chk_less_c.passed and chk_less_s.passed and chk_lesseq_c.passed and chk_lesseq_s.passed "true if every check in this test passed";
equation
  connect(u1.y, equal_c.u1);
  connect(u2.y, equal_c.u2);
  connect(equal_c.y, chk_equal_c.actual);
  connect(equal_exp.y, chk_equal_c.expected);
  connect(u1.y, equal_s.u1);
  connect(u2.y, equal_s.u2);
  connect(equal_s.y, chk_equal_s.actual);
  connect(equal_exp.y, chk_equal_s.expected);
  connect(u1.y, notequal_c.u1);
  connect(u2.y, notequal_c.u2);
  connect(notequal_c.y, chk_notequal_c.actual);
  connect(notequal_exp.y, chk_notequal_c.expected);
  connect(u1.y, notequal_s.u1);
  connect(u2.y, notequal_s.u2);
  connect(notequal_s.y, chk_notequal_s.actual);
  connect(notequal_exp.y, chk_notequal_s.expected);
  connect(u1.y, great_c.u1);
  connect(u2.y, great_c.u2);
  connect(great_c.y, chk_great_c.actual);
  connect(great_exp.y, chk_great_c.expected);
  connect(u1.y, great_s.u1);
  connect(u2.y, great_s.u2);
  connect(great_s.y, chk_great_s.actual);
  connect(great_exp.y, chk_great_s.expected);
  connect(u1.y, greateq_c.u1);
  connect(u2.y, greateq_c.u2);
  connect(greateq_c.y, chk_greateq_c.actual);
  connect(greateq_exp.y, chk_greateq_c.expected);
  connect(u1.y, greateq_s.u1);
  connect(u2.y, greateq_s.u2);
  connect(greateq_s.y, chk_greateq_s.actual);
  connect(greateq_exp.y, chk_greateq_s.expected);
  connect(u1.y, less_c.u1);
  connect(u2.y, less_c.u2);
  connect(less_c.y, chk_less_c.actual);
  connect(less_exp.y, chk_less_c.expected);
  connect(u1.y, less_s.u1);
  connect(u2.y, less_s.u2);
  connect(less_s.y, chk_less_s.actual);
  connect(less_exp.y, chk_less_s.expected);
  connect(u1.y, lesseq_c.u1);
  connect(u2.y, lesseq_c.u2);
  connect(lesseq_c.y, chk_lesseq_c.actual);
  connect(lesseq_exp.y, chk_lesseq_c.expected);
  connect(u1.y, lesseq_s.u1);
  connect(u2.y, lesseq_s.u2);
  connect(lesseq_s.y, chk_lesseq_s.actual);
  connect(lesseq_exp.y, chk_lesseq_s.expected);
  annotation (
    experiment(StopTime=5),
    Diagram(coordinateSystem(extent={{-110,-53},{176,100}})),
    Documentation(info="<html>
<p>Tests all six Integer comparisons of
<a href=\"modelica://IndustrialControlSystems.Logical.Comparisons.IntegerType\">IndustrialControlSystems.Logical.Comparisons.IntegerType</a>,
each continuous (<code>Ts=0</code>, suffix <code>_c</code>) and sampled (<code>Ts=0.1</code>, suffix <code>_s</code>).
The inputs change every second; checks are at t = 0.45 + 0.5k s.</p>
<table border=\"1\" cellpadding=\"3\"><tr><th>segment</th><th>u1</th><th>u2</th><th>Equal</th><th>NotEqual</th><th>Great</th><th>GreatEq</th><th>Less</th><th>LessEq</th></tr>
<tr><td>0</td><td>1</td><td>2</td><td>false</td><td>true</td><td>false</td><td>false</td><td>true</td><td>true</td></tr><tr><td>1</td><td>2</td><td>2</td><td>true</td><td>false</td><td>false</td><td>true</td><td>false</td><td>true</td></tr><tr><td>2</td><td>3</td><td>2</td><td>false</td><td>true</td><td>true</td><td>true</td><td>false</td><td>false</td></tr><tr><td>3</td><td>-5</td><td>-5</td><td>true</td><td>false</td><td>false</td><td>true</td><td>false</td><td>true</td></tr><tr><td>4</td><td>-6</td><td>-5</td><td>false</td><td>true</td><td>false</td><td>false</td><td>true</td><td>true</td></tr></table>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end IntegerComparisons;
