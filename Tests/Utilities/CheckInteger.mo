within Tests.Utilities;
block CheckInteger "Counts check instants at which actual <> expected"
  extends Modelica.Blocks.Icons.IntegerBlock;
  parameter Modelica.Units.SI.Time tStart = 0 "First check instant";
  parameter Modelica.Units.SI.Time dt = 0.1 "Interval between check instants";
  parameter String name = getInstanceName() "Name used in the failure message";
  Modelica.Blocks.Interfaces.IntegerInput actual "Signal under test"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.IntegerInput expected "Expected value"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput passed "true while every check so far passed"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  discrete Integer nChecks(start=0, fixed=true) "Number of check instants so far";
  discrete Integer nFail(start=0, fixed=true) "Number of check instants with actual <> expected";
equation
  when sample(tStart, dt) then
    nChecks = pre(nChecks) + 1;
    nFail = pre(nFail) + (if actual <> expected then 1 else 0);
  end when;
  passed = nFail == 0;
  when terminal() then
    assert(passed, name + ": " + String(nFail) + " of " + String(nChecks)
      + " checks failed", AssertionLevel.warning);
  end when;
  annotation (Icon(graphics={Text(extent={{-90,40},{90,-40}}, textString="I?")}),
    Documentation(info="<html>
<p>At every check instant <code>tStart + k*dt</code> the block compares
<code>actual</code> with <code>expected</code> and counts mismatches in
<code>nFail</code>. <code>passed</code> is true while <code>nFail = 0</code>.</p>
</html>"));
end CheckInteger;
