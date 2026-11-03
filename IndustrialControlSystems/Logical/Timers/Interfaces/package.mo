within IndustrialControlSystems.Logical.Timers;
package Interfaces "Interfaces"
extends IndustrialControlSystems.Icons.InterfacesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the partial base interfaces shared by all timer blocks.
  <em>BaseTimer</em> defines the common connector layout (Set, Reset, and Preset Value inputs;
  Boolean status output Q) and the sampling time parameter. <em>BaseResidualTimer</em> extends
  <em>BaseTimer</em> with an additional real output <em>tr</em> that provides the residual time
  remaining before the timer expires.
  </p>
  </HTML>", revisions="<html>
</html>"));
end Interfaces;
