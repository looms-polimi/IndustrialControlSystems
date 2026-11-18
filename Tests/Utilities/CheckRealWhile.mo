within Tests.Utilities;
block CheckRealWhile
  "Checks |actual - expected| <= absTol + relTol*|expected| at regular instants while active"
  extends Modelica.Blocks.Icons.Block;
  parameter Boolean enable = true "= false: no check, passed = true"
    annotation(Evaluate=true);
  parameter Real absTol = 1e-6 "Absolute tolerance";
  parameter Real relTol = 0 "Relative tolerance (relative to |expected|)";
  parameter Modelica.Units.SI.Time tStart = 0 "First check instant";
  parameter Modelica.Units.SI.Time dt = 0.1 "Interval between check instants";
  parameter String name = getInstanceName() "Name used in the failure message";
  input Real actual "Signal under test (bind by modifier)";
  input Real expected "Expected value (bind by modifier)";
  input Boolean active = true "Check instants count only while true (bind by modifier)";
  Modelica.Blocks.Interfaces.BooleanOutput passed
    "true when it has been checked at least once and every check passed"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  discrete Real maxErr(start=0, fixed=true) "Largest |error| at an active check instant";
  discrete Real maxRatio(start=0, fixed=true)
    "Largest |error|/(absTol + relTol*|expected|) at an active check instant; passed if <= 1";
  discrete Integer nChecked(start=0, fixed=true) "Number of active check instants";
equation
  if enable then
    when sample(tStart, dt) then
      maxErr = if active then max(pre(maxErr), abs(actual - expected)) else pre(maxErr);
      maxRatio = if active then max(pre(maxRatio), abs(actual - expected)/(absTol + relTol*abs(expected))) else pre(maxRatio);
      nChecked = if active then pre(nChecked) + 1 else pre(nChecked);
    end when;
    passed = maxRatio <= 1 and nChecked > 0;
  else
    maxErr = 0;
    maxRatio = 0;
    nChecked = 0;
    passed = true;
  end if;
  when terminal() then
    assert(not enable or (passed and nChecked > 0), name + ": check failed, max |error| = " + String(maxErr)
      + ", max error/tolerance = " + String(maxRatio) + ", active checks = " + String(nChecked),
      AssertionLevel.warning);
  end when;
  annotation (Icon(graphics={Text(extent={{-90,40},{90,-40}}, textString="R?w")}),
    Documentation(info="<html>
<p>Like <a href=\"modelica://Tests.Utilities.CheckReal\">CheckReal</a>, with the signals bound by
modifiers instead of connections, a run-time window <code>active</code>, and a structural
<code>enable</code>. A test model enables the checks that apply to its configuration; a disabled
check passes. An enabled check that was never active fails (<code>passed</code> requires at least one active
check instant) and gives an assertion warning at the end, so a window that never opens cannot pass
silently.</p>
<p>The verdict is <code>passed</code>. The assertion warning at the end of the run uses
<code>terminal()</code>, which OCT (Modelon Impact) does not support: there only <code>passed</code> reports a failure.</p>
</html>"));
end CheckRealWhile;
