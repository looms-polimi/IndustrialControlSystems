within Tests.Utilities;
block Never "Passes while the condition u has never been true"
  extends Modelica.Blocks.Icons.BooleanBlock;
  parameter Boolean enable = true "= false: no check, passed = true"
    annotation(Evaluate=true);
  parameter String name = getInstanceName() "Name used in the failure message";
  input Boolean u "Condition that must not occur (bind by modifier)";
  discrete Boolean seen(start=false, fixed=true) "u has been true";
  discrete Real tFirst(start=-1, fixed=true) "Time u first became true";
  Modelica.Blocks.Interfaces.BooleanOutput passed "true while u has never been true (or not enabled)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  when u then
    seen = true;
    tFirst = if pre(seen) then pre(tFirst) else time;
  end when;
  passed = not seen or not enable;
  when terminal() then
    assert(passed, name + ": the condition occurred, first at t = " + String(tFirst), AssertionLevel.warning);
  end when;
  annotation (Icon(graphics={Text(extent={{-90,40},{90,-40}}, textString="∄")}),
    Documentation(info="<html>
<p>Shows that a behaviour never occurs in the run (for example, that the output stays within its
limits when anti-windup is on). The verdict is the final value of <code>passed</code>.</p>
</html>"));
end Never;
