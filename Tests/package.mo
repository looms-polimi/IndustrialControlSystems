within ;
package Tests "Verification tests for the IndustrialControlSystems library"
  extends Modelica.Icons.Package;
  annotation (
    uses(IndustrialControlSystems(version="2.0.1"), Modelica(version="4.1.0")),
    version="0.1.0",
    Documentation(info="<html>
<p>Self-checking test models for classes of
<a href=\"modelica://IndustrialControlSystems\">IndustrialControlSystems</a>
that are not exercised by any example of the library itself. Together with the
library's own <code>Examples</code> and <code>Applications</code> they cover every
non-partial model, block and function of the library.</p>
<p>Each test drives the class under test with known inputs and compares its output
with an independently stated expected value, using the blocks in
<a href=\"modelica://Tests.Utilities\">Tests.Utilities</a>. Each test model has a
Boolean <code>passed</code>; it is <code>true</code> when every check in the model
passed. A failed check also issues an assertion warning at the end of the simulation,
so the result is still stored and can be inspected.</p>
<p>Where a block has a continuous (<code>Ts=0</code>) and a sampled (<code>Ts&gt;0</code>)
branch, both are tested.</p>
</html>"));
end Tests;
