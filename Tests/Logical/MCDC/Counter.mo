within Tests.Logical.MCDC;
model Counter "MC/DC scenario: IndustrialControlSystems.Logical.Counter.Counter"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.BooleanTable cu(table={1.03, 1.53, 2.03, 2.53, 3.03, 3.53, 4.03, 4.53, 5.03, 5.53,
    11.03, 11.53, 12.03, 12.53, 14.03, 14.53}, startValue=false) "Count up"
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.BooleanTable cd(table={7.03, 7.53, 8.03, 8.53, 12.03, 12.53}, startValue=false) "Count down"
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Sources.BooleanTable s(table={0.53, 13.03}, startValue=false) "Set (enables counting)"
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.BooleanTable r(table={10.03, 10.53}, startValue=false) "Reset"
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Sources.IntegerConstant pv(k=5) "Preset value"
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  IndustrialControlSystems.Logical.Counter.Counter dut(Max=9) "Counter under test (Ts = 0.01, modulus 9)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Tests.Utilities.CheckRealWhile chkCV(
      actual=dut.CV,
      expected=if time < 0.53 then 0 elseif time < 1.03 then 5 elseif time < 2.03 then 6 elseif time < 3.03 then 7 elseif time < 4.03 then 8 elseif time < 5.03 then 9 elseif time < 7.03 then 0 elseif time < 8.03 then 9 elseif time < 10.03 then 8 elseif time < 11.03 then 0 else 1,
      active=abs((time - floor(time)) - 0.03) > 0.05 and abs((time - floor(time)) - 0.03 - 1) > 0.05 and abs((time - floor(time)) - 0.53) > 0.05 and abs((time - floor(time)) - 0.53 - 1) > 0.05,
      absTol=0.5,
      tStart=0.01,
      dt=0.02)
    "CV: preset 5 on the rising edge of S, +1 per rising CU, wrap 9 -> 0, -1 per rising CD, wrap 0 -> 9, 0 on R, no change for CU and CD together or without S"
    annotation (Placement(transformation(extent={{30,20},{50,40}})));
  Tests.Utilities.CheckRealWhile chkQ(
      actual=if dut.Q then 1 else 0,
      expected=if (if time < 0.53 then 0 elseif time < 1.03 then 5 elseif time < 2.03 then 6 elseif time < 3.03 then 7 elseif time < 4.03 then 8 elseif time < 5.03 then 9 elseif time < 7.03 then 0 elseif time < 8.03 then 9 elseif time < 10.03 then 8 elseif time < 11.03 then 0 else 1) <> 0 and not r.y then 1 else 0,
      active=abs((time - floor(time)) - 0.03) > 0.05 and abs((time - floor(time)) - 0.03 - 1) > 0.05 and abs((time - floor(time)) - 0.53) > 0.05 and abs((time - floor(time)) - 0.53 - 1) > 0.05 and time > 0.6,
      absTol=0.5,
      tStart=0.01,
      dt=0.02)
    "Q is true while the counter value is not 0 and R is false"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Boolean passed = chkCV.passed and chkQ.passed
    "true if every enabled check of this configuration passed";
equation
  connect(cu.y, dut.CU) annotation (Line(points={{-49,80},{-14,80},{-14,8},{-8,8}}, color={255,0,255}));
  connect(cd.y, dut.CD) annotation (Line(points={{-49,50},{-20,50},{-20,4},{-8,4}}, color={255,0,255}));
  connect(s.y, dut.S) annotation (Line(points={{-49,20},{-26,20},{-26,0},{-8,0}}, color={255,0,255}));
  connect(r.y, dut.R) annotation (Line(points={{-49,-20},{-17,-20},{-17,-4},{-8,-4}}, color={255,0,255}));
  connect(pv.y, dut.PV) annotation (Line(points={{-49,-50},{-4,-50},{-4,-8}}, color={255,127,0}));
  annotation (
    experiment(StopTime=16, Interval=0.005, Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-80,-70},{90,100}}, grid={1,1})),
    Documentation(info="<html>
<p>MC/DC scenario of <a href=\"modelica://IndustrialControlSystems.Logical.Counter.Counter\">Counter</a> (Max = 9, PV = 5): preset, five counts up with the wrap 9 -> 0, two counts down with the wrap 0 -> 9, reset, a count up after the reset, CU and CD together (no change), and CU while S is false (no change). Each condition of the count function's decisions takes both values.</p>
<p>Checks (each enabled only where it applies; <code>passed</code> is their conjunction):</p>
<ul><li><code>chkCV</code>: CV: preset 5 on the rising edge of S, +1 per rising CU, wrap 9 -> 0, -1 per rising CD, wrap 0 -> 9, 0 on R, no change for CU and CD together or without S</li><li><code>chkQ</code>: Q is true while the counter value is not 0 and R is false</li></ul>
</html>"));
end Counter;
