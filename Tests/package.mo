within ;
package Tests "Verification tests for the IndustrialControlSystems library"
  extends Modelica.Icons.Package;
  annotation (
    uses(IndustrialControlSystems(version="2.0.1"), Modelica(version="4.1.0")),
    version="2.0.1",
    Documentation(info="<html>
<p>Test and example models for
<a href=\"modelica://IndustrialControlSystems\">IndustrialControlSystems</a>.
The packages mirror the library's structure. They hold the former
<code>Examples</code> sub-packages of the library (moved here, without the
<code>Examples</code> level) and self-checking tests for the classes those examples
did not exercise. Together with the library's <code>Applications</code> they cover every
non-partial model, block and function of the library.</p>
<p>Each self-checking test drives the class under test with known inputs and compares its output
with an independently stated expected value, using the blocks in
<a href=\"modelica://Tests.Utilities\">Tests.Utilities</a>. Each test model has a
Boolean <code>passed</code>; it is <code>true</code> when every check in the model
passed. A failed check also issues an assertion warning at the end of the simulation,
so the result is still stored and can be inspected.</p>
<p>Where a block has a continuous (<code>Ts=0</code>) and a sampled (<code>Ts&gt;0</code>)
branch, both are tested.</p>
</html>"));
end Tests;
