within IndustrialControlSystems.MathOperations;
package IntegerType "Integer mathematical operations"
  extends Modelica.Icons.TypeInteger;


  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This sub-package contains mathematical operation blocks and supporting components for
  integer-valued signals. It is organised into three child packages:
  </p>
  <ul>
    <li><b>Interfaces</b> — partial base models that define the port contracts for integer
        operation blocks: <code>IntSimpleOperation</code> (two scalar inputs) and
        <code>IntNinOperation</code> (variable-length input vector).</li>
    <li><b>Functions</b> — partial and concrete function definitions for integer computations,
        including the base interface <code>GeneralFunction</code> that accepts an integer
        vector and returns a single integer scalar.</li>
    <li><b>Expression</b> — a configurable block that evaluates a user-supplied integer
        function on a vector of integer input signals, with an optional display name.</li>
  </ul>
  <p>
  All integer operations use <code>Integer</code> connectors from the Modelica Standard
  Library and support a configurable sampling time parameter <code>Ts</code>.
  </p>
  </HTML>", revisions="<html>
</html>"));
end IntegerType;
