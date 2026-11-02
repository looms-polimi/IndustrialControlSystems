within IndustrialControlSystems.Logical.Comparisons.RealType;
package Interfaces "Interfaces"
  extends IndustrialControlSystems.Icons.InterfacesPackage;
annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the partial base interface <em>RealComparison</em> shared by all real-valued
  comparison blocks. It defines the common connector layout: two real inputs and one Boolean output,
  together with the sampling time parameter and the numerical tolerance <em>eps</em> used to handle
  floating-point precision in equality and inequality comparisons.
  </p>
  </HTML>"));
end Interfaces;
