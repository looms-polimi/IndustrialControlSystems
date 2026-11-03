within IndustrialControlSystems.MathOperations.IntegerType;
package Interfaces "Interfaces"
  extends IndustrialControlSystems.Icons.InterfacesPackage;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package collects the partial interface models for integer-type mathematical operation
  blocks in the IndustrialControlSystems library. It defines the port contracts that concrete
  integer operation models must satisfy:
  </p>
  <ul>
    <li><b>IntSimpleOperation</b> — interface for a two-input, single-output integer block,
        providing scalar integer ports <code>u1</code>, <code>u2</code>, and <code>y</code>
        together with a sampling-time parameter <code>Ts</code>.</li>
    <li><b>IntNinOperation</b> — interface for an N-input, single-output integer block,
        providing a configurable-length integer input vector <code>u[nInput]</code>,
        a scalar output <code>y</code>, and parameters <code>Ts</code> and
        <code>nInput</code>.</li>
  </ul>
  </HTML>", revisions="<html>
</html>"));
end Interfaces;
