within Tests.MathOperations;
model IntegerOperations
  "Integer Add, Sub, Mult, Div, Mod, Pow against precomputed results"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time of the sampled variants";
  Modelica.Blocks.Sources.IntegerExpression a(y=if time < 1 then -7 elseif time < 2 then 7 elseif time < 3 then 9 elseif time < 4 then 0 elseif time < 5 then 13 else -12) "First operand"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Modelica.Blocks.Sources.IntegerExpression b(y=if time < 1 then 2 elseif time < 2 then -2 elseif time < 3 then 3 elseif time < 4 then 5 elseif time < 5 then -4 else -5) "Second operand"
    annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
  Modelica.Blocks.Sources.IntegerExpression base(y=if time < 1 then 2 elseif time < 2 then -3 elseif time < 3 then 0 elseif time < 4 then 5 elseif time < 5 then 1 else -2) "Base for Pow"
    annotation (Placement(transformation(extent={{-160,-50},{-140,-30}})));
  Modelica.Blocks.Sources.IntegerExpression expo(y=if time < 1 then 3 elseif time < 2 then 2 elseif time < 3 then 4 elseif time < 4 then 1 elseif time < 5 then 0 else 3) "Exponent for Pow"
    annotation (Placement(transformation(extent={{-160,-80},{-140,-60}})));
  IndustrialControlSystems.MathOperations.IntegerType.Add add_c(Ts=0)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.IntegerExpression add_exp_c(y=if time < 1 then -5 elseif time < 2 then 5 elseif time < 3 then 12 elseif time < 4 then 5 elseif time < 5 then 9 else -17) "Expected Add"
    annotation (Placement(transformation(extent={{-90,-40},{-70,-20}})));
  Utilities.CheckInteger chk_add_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  IndustrialControlSystems.MathOperations.IntegerType.Sub sub_c(Ts=0)
    annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  Modelica.Blocks.Sources.IntegerExpression sub_exp_c(y=if time < 1 then -9 elseif time < 2 then 9 elseif time < 3 then 6 elseif time < 4 then -5 elseif time < 5 then 17 else -7) "Expected Sub"
    annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));
  Utilities.CheckInteger chk_sub_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mult mult_c(Ts=0)
    annotation (Placement(transformation(extent={{-90,-130},{-70,-110}})));
  Modelica.Blocks.Sources.IntegerExpression mult_exp_c(y=if time < 1 then -14 elseif time < 2 then -14 elseif time < 3 then 27 elseif time < 4 then 0 elseif time < 5 then -52 else 60) "Expected Mult"
    annotation (Placement(transformation(extent={{-90,-160},{-70,-140}})));
  Utilities.CheckInteger chk_mult_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-30,-150},{-10,-130}})));
  IndustrialControlSystems.MathOperations.IntegerType.Div div_c(Ts=0)
    annotation (Placement(transformation(extent={{-90,-190},{-70,-170}})));
  Modelica.Blocks.Sources.IntegerExpression div_exp_c(y=if time < 1 then -3 elseif time < 2 then -3 elseif time < 3 then 3 elseif time < 4 then 0 elseif time < 5 then -3 else 2) "Expected Div"
    annotation (Placement(transformation(extent={{-90,-220},{-70,-200}})));
  Utilities.CheckInteger chk_div_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-30,-210},{-10,-190}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mod mod_c(Ts=0)
    annotation (Placement(transformation(extent={{-90,-250},{-70,-230}})));
  Modelica.Blocks.Sources.IntegerExpression mod_exp_c(y=if time < 1 then 1 elseif time < 2 then -1 elseif time < 3 then 0 elseif time < 4 then 0 elseif time < 5 then -3 else -2) "Expected Mod"
    annotation (Placement(transformation(extent={{-90,-280},{-70,-260}})));
  Utilities.CheckInteger chk_mod_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-30,-270},{-10,-250}})));
  IndustrialControlSystems.MathOperations.IntegerType.Pow pow_c(Ts=0)
    annotation (Placement(transformation(extent={{-90,-310},{-70,-290}})));
  Modelica.Blocks.Sources.IntegerExpression pow_exp_c(y=if time < 1 then 8 elseif time < 2 then 9 elseif time < 3 then 0 elseif time < 4 then 5 elseif time < 5 then 1 else -8) "Expected Pow"
    annotation (Placement(transformation(extent={{-90,-340},{-70,-320}})));
  Utilities.CheckInteger chk_pow_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{-30,-330},{-10,-310}})));
  IndustrialControlSystems.MathOperations.IntegerType.Add add_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Sources.IntegerExpression add_exp_s(y=if time < 1 then -5 elseif time < 2 then 5 elseif time < 3 then 12 elseif time < 4 then 5 elseif time < 5 then 9 else -17) "Expected Add"
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Utilities.CheckInteger chk_add_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{110,-30},{130,-10}})));
  IndustrialControlSystems.MathOperations.IntegerType.Sub sub_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Blocks.Sources.IntegerExpression sub_exp_s(y=if time < 1 then -9 elseif time < 2 then 9 elseif time < 3 then 6 elseif time < 4 then -5 elseif time < 5 then 17 else -7) "Expected Sub"
    annotation (Placement(transformation(extent={{50,-100},{70,-80}})));
  Utilities.CheckInteger chk_sub_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{110,-90},{130,-70}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mult mult_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-130},{70,-110}})));
  Modelica.Blocks.Sources.IntegerExpression mult_exp_s(y=if time < 1 then -14 elseif time < 2 then -14 elseif time < 3 then 27 elseif time < 4 then 0 elseif time < 5 then -52 else 60) "Expected Mult"
    annotation (Placement(transformation(extent={{50,-160},{70,-140}})));
  Utilities.CheckInteger chk_mult_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{110,-150},{130,-130}})));
  IndustrialControlSystems.MathOperations.IntegerType.Div div_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-190},{70,-170}})));
  Modelica.Blocks.Sources.IntegerExpression div_exp_s(y=if time < 1 then -3 elseif time < 2 then -3 elseif time < 3 then 3 elseif time < 4 then 0 elseif time < 5 then -3 else 2) "Expected Div"
    annotation (Placement(transformation(extent={{50,-220},{70,-200}})));
  Utilities.CheckInteger chk_div_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{110,-210},{130,-190}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mod mod_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-250},{70,-230}})));
  Modelica.Blocks.Sources.IntegerExpression mod_exp_s(y=if time < 1 then 1 elseif time < 2 then -1 elseif time < 3 then 0 elseif time < 4 then 0 elseif time < 5 then -3 else -2) "Expected Mod"
    annotation (Placement(transformation(extent={{50,-280},{70,-260}})));
  Utilities.CheckInteger chk_mod_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{110,-270},{130,-250}})));
  IndustrialControlSystems.MathOperations.IntegerType.Pow pow_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-310},{70,-290}})));
  Modelica.Blocks.Sources.IntegerExpression pow_exp_s(y=if time < 1 then 8 elseif time < 2 then 9 elseif time < 3 then 0 elseif time < 4 then 5 elseif time < 5 then 1 else -8) "Expected Pow"
    annotation (Placement(transformation(extent={{50,-340},{70,-320}})));
  Utilities.CheckInteger chk_pow_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{110,-330},{130,-310}})));
  Boolean passed = chk_add_c.passed and chk_sub_c.passed and chk_mult_c.passed and chk_div_c.passed and chk_mod_c.passed and chk_pow_c.passed and chk_add_s.passed and chk_sub_s.passed and chk_mult_s.passed and chk_div_s.passed and chk_mod_s.passed and chk_pow_s.passed "true if every check in this test passed";
equation
  connect(a.y, add_c.u1) annotation (Line(points={{-139,20},{-100,20},{-100,4},{-88,4}}, color={255,127,0}));
  connect(b.y, add_c.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-4},{-88,-4}}, color={255,127,0}));
  connect(add_c.y, chk_add_c.actual) annotation (Line(points={{-71,0},{-50,0},{-50,-14},{-32,-14}}, color={255,127,0}));
  connect(add_exp_c.y, chk_add_c.expected) annotation (Line(points={{-69,-30},{-40,-30},{-40,-26},{-32,-26}}, color={255,127,0}));
  connect(a.y, sub_c.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-56},{-88,-56}}, color={255,127,0}));
  connect(b.y, sub_c.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-64},{-88,-64}}, color={255,127,0}));
  connect(sub_c.y, chk_sub_c.actual) annotation (Line(points={{-71,-60},{-50,-60},{-50,-74},{-32,-74}}, color={255,127,0}));
  connect(sub_exp_c.y, chk_sub_c.expected) annotation (Line(points={{-69,-90},{-40,-90},{-40,-86},{-32,-86}}, color={255,127,0}));
  connect(a.y, mult_c.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-116},{-88,-116}}, color={255,127,0}));
  connect(b.y, mult_c.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-124},{-88,-124}}, color={255,127,0}));
  connect(mult_c.y, chk_mult_c.actual) annotation (Line(points={{-71,-120},{-50,-120},{-50,-134},{-32,-134}}, color={255,127,0}));
  connect(mult_exp_c.y, chk_mult_c.expected) annotation (Line(points={{-69,-150},{-40,-150},{-40,-146},{-32,-146}}, color={255,127,0}));
  connect(a.y, div_c.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-176},{-88,-176}}, color={255,127,0}));
  connect(b.y, div_c.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-184},{-88,-184}}, color={255,127,0}));
  connect(div_c.y, chk_div_c.actual) annotation (Line(points={{-71,-180},{-50,-180},{-50,-194},{-32,-194}}, color={255,127,0}));
  connect(div_exp_c.y, chk_div_c.expected) annotation (Line(points={{-69,-210},{-40,-210},{-40,-206},{-32,-206}}, color={255,127,0}));
  connect(a.y, mod_c.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-236},{-88,-236}}, color={255,127,0}));
  connect(b.y, mod_c.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-244},{-88,-244}}, color={255,127,0}));
  connect(mod_c.y, chk_mod_c.actual) annotation (Line(points={{-71,-240},{-50,-240},{-50,-254},{-32,-254}}, color={255,127,0}));
  connect(mod_exp_c.y, chk_mod_c.expected) annotation (Line(points={{-69,-270},{-40,-270},{-40,-266},{-32,-266}}, color={255,127,0}));
  connect(base.y, pow_c.u1) annotation (Line(points={{-139,-40},{-120,-40},{-120,-296},{-88,-296}}, color={255,127,0}));
  connect(expo.y, pow_c.u2) annotation (Line(points={{-139,-70},{-130,-70},{-130,-304},{-88,-304}}, color={255,127,0}));
  connect(pow_c.y, chk_pow_c.actual) annotation (Line(points={{-71,-300},{-50,-300},{-50,-314},{-32,-314}}, color={255,127,0}));
  connect(pow_exp_c.y, chk_pow_c.expected) annotation (Line(points={{-69,-330},{-40,-330},{-40,-326},{-32,-326}}, color={255,127,0}));
  connect(a.y, add_s.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-350},{10,-350},{10,4},{52,4}}, color={255,127,0}));
  connect(b.y, add_s.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-360},{20,-360},{20,-4},{52,-4}}, color={255,127,0}));
  connect(add_s.y, chk_add_s.actual) annotation (Line(points={{69,0},{90,0},{90,-14},{108,-14}}, color={255,127,0}));
  connect(add_exp_s.y, chk_add_s.expected) annotation (Line(points={{71,-30},{100,-30},{100,-26},{108,-26}}, color={255,127,0}));
  connect(a.y, sub_s.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-350},{10,-350},{10,-56},{52,-56}}, color={255,127,0}));
  connect(b.y, sub_s.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-360},{20,-360},{20,-64},{52,-64}}, color={255,127,0}));
  connect(sub_s.y, chk_sub_s.actual) annotation (Line(points={{69,-60},{90,-60},{90,-74},{108,-74}}, color={255,127,0}));
  connect(sub_exp_s.y, chk_sub_s.expected) annotation (Line(points={{71,-90},{100,-90},{100,-86},{108,-86}}, color={255,127,0}));
  connect(a.y, mult_s.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-350},{10,-350},{10,-116},{52,-116}}, color={255,127,0}));
  connect(b.y, mult_s.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-360},{20,-360},{20,-124},{52,-124}}, color={255,127,0}));
  connect(mult_s.y, chk_mult_s.actual) annotation (Line(points={{69,-120},{90,-120},{90,-134},{108,-134}}, color={255,127,0}));
  connect(mult_exp_s.y, chk_mult_s.expected) annotation (Line(points={{71,-150},{100,-150},{100,-146},{108,-146}}, color={255,127,0}));
  connect(a.y, div_s.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-350},{10,-350},{10,-176},{52,-176}}, color={255,127,0}));
  connect(b.y, div_s.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-360},{20,-360},{20,-184},{52,-184}}, color={255,127,0}));
  connect(div_s.y, chk_div_s.actual) annotation (Line(points={{69,-180},{90,-180},{90,-194},{108,-194}}, color={255,127,0}));
  connect(div_exp_s.y, chk_div_s.expected) annotation (Line(points={{71,-210},{100,-210},{100,-206},{108,-206}}, color={255,127,0}));
  connect(a.y, mod_s.u1) annotation (Line(points={{-139,20},{-100,20},{-100,-350},{10,-350},{10,-236},{52,-236}}, color={255,127,0}));
  connect(b.y, mod_s.u2) annotation (Line(points={{-139,-10},{-110,-10},{-110,-360},{20,-360},{20,-244},{52,-244}}, color={255,127,0}));
  connect(mod_s.y, chk_mod_s.actual) annotation (Line(points={{69,-240},{90,-240},{90,-254},{108,-254}}, color={255,127,0}));
  connect(mod_exp_s.y, chk_mod_s.expected) annotation (Line(points={{71,-270},{100,-270},{100,-266},{108,-266}}, color={255,127,0}));
  connect(base.y, pow_s.u1) annotation (Line(points={{-139,-40},{-120,-40},{-120,-370},{30,-370},{30,-296},{52,-296}}, color={255,127,0}));
  connect(expo.y, pow_s.u2) annotation (Line(points={{-139,-70},{-130,-70},{-130,-380},{40,-380},{40,-304},{52,-304}}, color={255,127,0}));
  connect(pow_s.y, chk_pow_s.actual) annotation (Line(points={{69,-300},{90,-300},{90,-314},{108,-314}}, color={255,127,0}));
  connect(pow_exp_s.y, chk_pow_s.expected) annotation (Line(points={{71,-330},{100,-330},{100,-326},{108,-326}}, color={255,127,0}));
  annotation (
    experiment(StopTime=6),
    Diagram(coordinateSystem(extent={{-170,-390},{140,40}}, grid={1,1})),
    Documentation(info="<html>
<p>Tests the integer operations
<a href=\"modelica://IndustrialControlSystems.MathOperations.IntegerType.Add\">Add</a>, Sub, Mult, Div, Mod and Pow,
continuous (<code>Ts=0</code>, left column, suffix <code>_c</code>) and sampled (<code>Ts=0.1</code>, right column, suffix <code>_s</code>).
Each row is block under test, expected value, check. The operands change every second; the expected values were
computed outside Modelica (<code>div</code> truncates toward zero, <code>mod(a,b) = a - floor(a/b)*b</code>).
Checks are at t = 0.45 + 0.5k s, away from the switching instants.</p>
<table border=\"1\" cellpadding=\"3\"><tr><th>segment</th><th>a</th><th>b</th><th>a+b</th><th>a-b</th><th>a*b</th><th>div(a,b)</th><th>mod(a,b)</th><th>Pow</th></tr>
<tr><td>0</td><td>-7</td><td>2</td><td>-5</td><td>-9</td><td>-14</td><td>-3</td><td>1</td><td>2^3 = 8</td></tr><tr><td>1</td><td>7</td><td>-2</td><td>5</td><td>9</td><td>-14</td><td>-3</td><td>-1</td><td>-3^2 = 9</td></tr><tr><td>2</td><td>9</td><td>3</td><td>12</td><td>6</td><td>27</td><td>3</td><td>0</td><td>0^4 = 0</td></tr><tr><td>3</td><td>0</td><td>5</td><td>5</td><td>-5</td><td>0</td><td>0</td><td>0</td><td>5^1 = 5</td></tr><tr><td>4</td><td>13</td><td>-4</td><td>9</td><td>17</td><td>-52</td><td>-3</td><td>-3</td><td>1^0 = 1</td></tr><tr><td>5</td><td>-12</td><td>-5</td><td>-17</td><td>-7</td><td>60</td><td>2</td><td>-2</td><td>-2^3 = -8</td></tr></table>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end IntegerOperations;
