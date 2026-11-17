within IndustrialControlSystems.Logical;
package Counter "This package contains UP and DOWN counters."
  extends Modelica.Icons.Package;


  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains sampled-data models of a modular up/down counter. The counter supports
  the following operations, evaluated at each sampling step:
  </p>
  <ul>
  <li><b>Set</b> &mdash; loads the counter with a configurable preset value on a rising edge of
  the Set signal.</li>
  <li><b>Count Up / Count Down</b> &mdash; increments or decrements the current value by 1 on
  each rising edge of the CU or CD signal respectively, while Set is active.</li>
  <li><b>Reset</b> &mdash; immediately clears the counter to zero.</li>
  </ul>
  <p>
  The counter wraps around modulo a configurable maximum value <em>Max</em>. A Boolean status
  output <em>Q</em> indicates whether the counter is active (current value &gt; 0).
  </p>
  </HTML>", revisions="<html>
</html>"));
end Counter;
