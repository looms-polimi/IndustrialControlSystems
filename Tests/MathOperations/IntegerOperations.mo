within Tests.MathOperations;
model IntegerOperations
  "Integer Add, Sub, Mult, Div, Mod, Pow against precomputed results"
  extends Modelica.Icons.Example;
  parameter Real Ts = 0.1 "Sampling time of the sampled variants";
  Modelica.Blocks.Sources.IntegerExpression a(y=if time < 1 then -7 elseif time < 2 then 7 elseif time < 3 then 9 elseif time < 4 then 0 elseif time < 5 then 13 else -12) "First operand"
    annotation (Placement(transformation(extent={{-100,82},{-84,98}})));
  Modelica.Blocks.Sources.IntegerExpression b(y=if time < 1 then 2 elseif time < 2 then -2 elseif time < 3 then 3 elseif time < 4 then 5 elseif time < 5 then -4 else -5) "Second operand"
    annotation (Placement(transformation(extent={{-100,57},{-84,73}})));
  Modelica.Blocks.Sources.IntegerExpression base(y=if time < 1 then 2 elseif time < 2 then -3 elseif time < 3 then 0 elseif time < 4 then 5 elseif time < 5 then 1 else -2) "Base for Pow"
    annotation (Placement(transformation(extent={{-100,32},{-84,48}})));
  Modelica.Blocks.Sources.IntegerExpression expo(y=if time < 1 then 3 elseif time < 2 then 2 elseif time < 3 then 4 elseif time < 4 then 1 elseif time < 5 then 0 else 3) "Exponent for Pow"
    annotation (Placement(transformation(extent={{-100,7},{-84,23}})));
  Modelica.Blocks.Sources.IntegerExpression add_exp(y=if time < 1 then -5 elseif time < 2 then 5 elseif time < 3 then 12 elseif time < 4 then 5 elseif time < 5 then 9 else -17) "Expected Add"
    annotation (Placement(transformation(extent={{-50,82},{-34,98}})));
  IndustrialControlSystems.MathOperations.IntegerType.Add add_c(Ts=0)
    annotation (Placement(transformation(extent={{0,82},{16,98}})));
  Utilities.CheckInteger chk_add_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,82},{116,98}})));
  IndustrialControlSystems.MathOperations.IntegerType.Add add_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,82},{66,98}})));
  Utilities.CheckInteger chk_add_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,82},{166,98}})));
  Modelica.Blocks.Sources.IntegerExpression sub_exp(y=if time < 1 then -9 elseif time < 2 then 9 elseif time < 3 then 6 elseif time < 4 then -5 elseif time < 5 then 17 else -7) "Expected Sub"
    annotation (Placement(transformation(extent={{-50,57},{-34,73}})));
  IndustrialControlSystems.MathOperations.IntegerType.Sub sub_c(Ts=0)
    annotation (Placement(transformation(extent={{0,57},{16,73}})));
  Utilities.CheckInteger chk_sub_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,57},{116,73}})));
  IndustrialControlSystems.MathOperations.IntegerType.Sub sub_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,57},{66,73}})));
  Utilities.CheckInteger chk_sub_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,57},{166,73}})));
  Modelica.Blocks.Sources.IntegerExpression mult_exp(y=if time < 1 then -14 elseif time < 2 then -14 elseif time < 3 then 27 elseif time < 4 then 0 elseif time < 5 then -52 else 60) "Expected Mult"
    annotation (Placement(transformation(extent={{-50,32},{-34,48}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mult mult_c(Ts=0)
    annotation (Placement(transformation(extent={{0,32},{16,48}})));
  Utilities.CheckInteger chk_mult_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,32},{116,48}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mult mult_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,32},{66,48}})));
  Utilities.CheckInteger chk_mult_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,32},{166,48}})));
  Modelica.Blocks.Sources.IntegerExpression div_exp(y=if time < 1 then -3 elseif time < 2 then -3 elseif time < 3 then 3 elseif time < 4 then 0 elseif time < 5 then -3 else 2) "Expected Div"
    annotation (Placement(transformation(extent={{-50,7},{-34,23}})));
  IndustrialControlSystems.MathOperations.IntegerType.Div div_c(Ts=0)
    annotation (Placement(transformation(extent={{0,7},{16,23}})));
  Utilities.CheckInteger chk_div_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,7},{116,23}})));
  IndustrialControlSystems.MathOperations.IntegerType.Div div_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,7},{66,23}})));
  Utilities.CheckInteger chk_div_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,7},{166,23}})));
  Modelica.Blocks.Sources.IntegerExpression mod_exp(y=if time < 1 then 1 elseif time < 2 then -1 elseif time < 3 then 0 elseif time < 4 then 0 elseif time < 5 then -3 else -2) "Expected Mod"
    annotation (Placement(transformation(extent={{-50,-18},{-34,-2}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mod mod_c(Ts=0)
    annotation (Placement(transformation(extent={{0,-18},{16,-2}})));
  Utilities.CheckInteger chk_mod_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,-18},{116,-2}})));
  IndustrialControlSystems.MathOperations.IntegerType.Mod mod_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-18},{66,-2}})));
  Utilities.CheckInteger chk_mod_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,-18},{166,-2}})));
  Modelica.Blocks.Sources.IntegerExpression pow_exp(y=if time < 1 then 8 elseif time < 2 then 9 elseif time < 3 then 0 elseif time < 4 then 5 elseif time < 5 then 1 else -8) "Expected Pow"
    annotation (Placement(transformation(extent={{-50,-43},{-34,-27}})));
  IndustrialControlSystems.MathOperations.IntegerType.Pow pow_c(Ts=0)
    annotation (Placement(transformation(extent={{0,-43},{16,-27}})));
  Utilities.CheckInteger chk_pow_c(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{100,-43},{116,-27}})));
  IndustrialControlSystems.MathOperations.IntegerType.Pow pow_s(Ts=Ts)
    annotation (Placement(transformation(extent={{50,-43},{66,-27}})));
  Utilities.CheckInteger chk_pow_s(tStart=0.45, dt=0.5)
    annotation (Placement(transformation(extent={{150,-43},{166,-27}})));
  Boolean passed = chk_add_c.passed and chk_add_s.passed and chk_sub_c.passed and chk_sub_s.passed and chk_mult_c.passed and chk_mult_s.passed and chk_div_c.passed and chk_div_s.passed and chk_mod_c.passed and chk_mod_s.passed and chk_pow_c.passed and chk_pow_s.passed "true if every check in this test passed";
equation
  connect(a.y, add_c.u1);
  connect(b.y, add_c.u2);
  connect(add_c.y, chk_add_c.actual);
  connect(add_exp.y, chk_add_c.expected);
  connect(a.y, add_s.u1);
  connect(b.y, add_s.u2);
  connect(add_s.y, chk_add_s.actual);
  connect(add_exp.y, chk_add_s.expected);
  connect(a.y, sub_c.u1);
  connect(b.y, sub_c.u2);
  connect(sub_c.y, chk_sub_c.actual);
  connect(sub_exp.y, chk_sub_c.expected);
  connect(a.y, sub_s.u1);
  connect(b.y, sub_s.u2);
  connect(sub_s.y, chk_sub_s.actual);
  connect(sub_exp.y, chk_sub_s.expected);
  connect(a.y, mult_c.u1);
  connect(b.y, mult_c.u2);
  connect(mult_c.y, chk_mult_c.actual);
  connect(mult_exp.y, chk_mult_c.expected);
  connect(a.y, mult_s.u1);
  connect(b.y, mult_s.u2);
  connect(mult_s.y, chk_mult_s.actual);
  connect(mult_exp.y, chk_mult_s.expected);
  connect(a.y, div_c.u1);
  connect(b.y, div_c.u2);
  connect(div_c.y, chk_div_c.actual);
  connect(div_exp.y, chk_div_c.expected);
  connect(a.y, div_s.u1);
  connect(b.y, div_s.u2);
  connect(div_s.y, chk_div_s.actual);
  connect(div_exp.y, chk_div_s.expected);
  connect(a.y, mod_c.u1);
  connect(b.y, mod_c.u2);
  connect(mod_c.y, chk_mod_c.actual);
  connect(mod_exp.y, chk_mod_c.expected);
  connect(a.y, mod_s.u1);
  connect(b.y, mod_s.u2);
  connect(mod_s.y, chk_mod_s.actual);
  connect(mod_exp.y, chk_mod_s.expected);
  connect(base.y, pow_c.u1);
  connect(expo.y, pow_c.u2);
  connect(pow_c.y, chk_pow_c.actual);
  connect(pow_exp.y, chk_pow_c.expected);
  connect(base.y, pow_s.u1);
  connect(expo.y, pow_s.u2);
  connect(pow_s.y, chk_pow_s.actual);
  connect(pow_exp.y, chk_pow_s.expected);
  annotation (
    experiment(StopTime=6),
    Diagram(coordinateSystem(extent={{-110,-53},{176,100}})),
    Documentation(info="<html>
<p>Tests the integer operations
<a href=\"modelica://IndustrialControlSystems.MathOperations.IntegerType.Add\">Add</a>, Sub, Mult, Div, Mod and Pow,
each continuous (<code>Ts=0</code>, suffix <code>_c</code>) and sampled (<code>Ts=0.1</code>, suffix <code>_s</code>).
The operands change every second; the expected values below were computed outside Modelica
(<code>div</code> truncates toward zero, <code>mod(a,b) = a - floor(a/b)*b</code>).
Checks are at t = 0.45 + 0.5k s, away from the switching instants.</p>
<table border=\"1\" cellpadding=\"3\"><tr><th>segment</th><th>a</th><th>b</th><th>a+b</th><th>a-b</th><th>a*b</th><th>div(a,b)</th><th>mod(a,b)</th><th>Pow</th></tr>
<tr><td>0</td><td>-7</td><td>2</td><td>-5</td><td>-9</td><td>-14</td><td>-3</td><td>1</td><td>2^3 = 8</td></tr><tr><td>1</td><td>7</td><td>-2</td><td>5</td><td>9</td><td>-14</td><td>-3</td><td>-1</td><td>-3^2 = 9</td></tr><tr><td>2</td><td>9</td><td>3</td><td>12</td><td>6</td><td>27</td><td>3</td><td>0</td><td>0^4 = 0</td></tr><tr><td>3</td><td>0</td><td>5</td><td>5</td><td>-5</td><td>0</td><td>0</td><td>0</td><td>5^1 = 5</td></tr><tr><td>4</td><td>13</td><td>-4</td><td>9</td><td>17</td><td>-52</td><td>-3</td><td>-3</td><td>1^0 = 1</td></tr><tr><td>5</td><td>-12</td><td>-5</td><td>-17</td><td>-7</td><td>60</td><td>2</td><td>-2</td><td>-2^3 = -8</td></tr></table>
<p>The verdict is <code>passed</code>.</p>
</html>"));
end IntegerOperations;
