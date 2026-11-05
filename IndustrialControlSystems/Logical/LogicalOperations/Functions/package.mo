within IndustrialControlSystems.Logical.LogicalOperations;
package Functions "Package that contains the set of functions used by the logical operations"
  extends IndustrialControlSystems.Icons.FunctionsPackage;

annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains pure algorithmic functions that implement the elementary Boolean
  operations used by the logical operation blocks. Available functions are:
  </p>
  <ul>
  <li><em>And</em> &mdash; logical AND over an array of Boolean inputs.</li>
  <li><em>Or</em> &mdash; logical OR over an array of Boolean inputs.</li>
  <li><em>Not</em> &mdash; element-wise logical NOT over an array of Boolean inputs.</li>
  <li><em>Xor</em> &mdash; logical XOR over an array of Boolean inputs (chained pairwise).</li>
  <li><em>SR</em> &mdash; Set-Reset latch logic.</li>
  </ul>
  </HTML>"));
end Functions;
