within Tests.Utilities;
block CheckReal
  "Checks |actual - expected| <= absTol + relTol*|expected| at regular instants"
  extends Modelica.Blocks.Icons.Block;
  parameter Real absTol = 1e-6 "Absolute tolerance";
  parameter Real relTol = 0 "Relative tolerance (relative to |expected|)";
  parameter Modelica.Units.SI.Time tStart = 0 "First check instant";
  parameter Modelica.Units.SI.Time dt = 0.1 "Interval between check instants";
  parameter String name = getInstanceName() "Name used in the failure message";
  Modelica.Blocks.Interfaces.RealInput actual "Signal under test"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput expected "Expected value"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput passed "true while every check so far passed"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Real err = actual - expected "Error";
  discrete Real maxErr(start=0, fixed=true) "Largest |err| seen at a check instant";
  discrete Real maxRatio(start=0, fixed=true)
    "Largest |err|/(absTol + relTol*|expected|) seen at a check instant; passed if <= 1";
equation
  when sample(tStart, dt) then
    maxErr = max(pre(maxErr), abs(actual - expected));
    maxRatio = max(pre(maxRatio), abs(actual - expected)/(absTol + relTol*abs(expected)));
  end when;
  passed = maxRatio <= 1;
  when terminal() then
    assert(passed, name + ": check failed, max |error| = " + String(maxErr)
      + ", max error/tolerance = " + String(maxRatio), AssertionLevel.warning);
  end when;
  annotation (Icon(graphics={Text(extent={{-90,40},{90,-40}}, textString="R?")}),
    Documentation(info="<html>
<p>At every check instant <code>tStart + k*dt</code> the block records the largest
error seen so far. <code>passed</code> is true while the largest error is within
<code>absTol + relTol*|expected|</code>. Place check instants away from the instants
where the inputs switch, so the verdict does not depend on event ordering.</p>
</html>"));
end CheckReal;
