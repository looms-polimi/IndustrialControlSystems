within IndustrialControlSystems.Controllers.AutoTuning;
package Examples "Examples"
  extends IndustrialControlSystems.Icons.ExamplesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains example models that demonstrate the auto-tuning controllers
  of the <b>AutoTuning</b> sub-package. The examples show the relay-based auto-tuning
  procedure applied to a PI controller, covering both the fully digital implementation
  (<a href=\"modelica://IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCdigital\">ATPIrelayNCdigital</a>)
  and the mixed continuous/discrete-time implementation
  (<a href=\"modelica://IndustrialControlSystems.Controllers.AutoTuning.ATPIrelayNCmixedMode\">ATPIrelayNCmixedMode</a>).
  Each example illustrates how a relay-induced oscillation is used to identify the
  process frequency response and automatically compute suitable PI parameters for a
  desired phase margin.
  </p>
  </HTML>",
  revisions="<html>
</html>"));
end Examples;
