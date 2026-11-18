within Tests.Utilities;
block Witness "Passes once the condition u has been true at least once"
  extends Modelica.Blocks.Icons.BooleanBlock;
  parameter Boolean enable = true "= false: no check, passed = true"
    annotation(Evaluate=true);
  parameter String name = getInstanceName() "Name used in the failure message";
  input Boolean u "Condition that must occur (bind by modifier)";
  discrete Boolean seen(start=false, fixed=true) "u has been true";
  Modelica.Blocks.Interfaces.BooleanOutput passed "true once u has been true (or not enabled)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  when u then
    seen = true;
  end when;
  passed = seen or not enable;
  when terminal() then
    assert(passed, name + ": the condition never occurred", AssertionLevel.warning);
  end when;
  annotation (Icon(graphics={Text(extent={{-90,40},{90,-40}}, textString="∃")}),
    Documentation(info="<html>
<p>Shows that a behaviour occurs at least once in the run (for example, that an output leaves
its limits when anti-windup is off). The verdict is the final value of <code>passed</code>.</p>
<p>The verdict is <code>passed</code>. The assertion warning at the end of the run uses
<code>terminal()</code>, which OCT (Modelon Impact) does not support: there only <code>passed</code> reports a failure.</p>
</html>"));
end Witness;
