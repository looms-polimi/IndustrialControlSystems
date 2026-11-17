within IndustrialControlSystems.Logical.LogicalOperations;
package Interfaces "Interfaces"
  extends IndustrialControlSystems.Icons.InterfacesPackage;

annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the partial base interfaces for logical operation blocks.
  <em>LogicalBlock</em> defines a generic n-input m-output Boolean block with a configurable
  sampling time. <em>LogicalBlock2x2</em> defines a two-input two-output Boolean block used
  as the base for SR flip-flop type elements.
  </p>
  </HTML>"));
end Interfaces;
