within IndustrialControlSystems.Logical.LogicalOperations;
package Examples "Examples"
  extends IndustrialControlSystems.Icons.ExamplesPackage;

annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains example models that demonstrate the logical operation blocks. The
  examples include a basic logic operations test showing AND, OR, NOT, and XOR gates driven
  by Boolean table sources, and an SR flip-flop test showing how the Set-Reset latch responds
  to asynchronous Set and Reset pulses. Both examples illustrate the effect of the sampling
  time parameter on the timing of output transitions.
  </p>
  </HTML>"));
end Examples;
