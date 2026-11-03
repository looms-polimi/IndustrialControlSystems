within IndustrialControlSystems.MathOperations.IntegerType;
package Functions "Functions"
  extends Icons.FunctionsPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains function definitions for integer-type mathematical operations
  in the IndustrialControlSystems library. It provides:
  <ul>
    <li><b>GeneralFunction</b> — the partial base function defining the interface
        (input integer vector, output integer scalar) that all concrete integer functions
        must extend.</li>
  </ul>
  Concrete implementations such as <code>SumSquare</code> reside in the
  <code>Examples</code> package and extend <code>GeneralFunction</code> to supply
  specific algorithmic behaviour.
  </p>
  </HTML>", revisions="<html>
</html>"));
end Functions;
