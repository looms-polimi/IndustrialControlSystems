within IndustrialControlSystems.MathOperations.RealType;
package Interfaces "Interfaces"
  extends IndustrialControlSystems.Icons.InterfacesPackage;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package collects the partial interface models for real-type mathematical operation
  blocks in the IndustrialControlSystems library. It defines the port contracts and common
  parameter declarations that concrete real-type operation models must satisfy, including
  the standard two-input connector pattern (ports <code>u1</code>, <code>u2</code>,
  <code>y</code>) and the optional fixed-point quantisation parameters
  (<code>FixedPoint</code>, <code>Nbit</code>, <code>scaleFactor</code>, <code>Ts</code>).
  </p>
  </HTML>", revisions="<html>
</html>"));
end Interfaces;
