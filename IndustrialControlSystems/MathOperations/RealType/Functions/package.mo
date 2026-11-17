within IndustrialControlSystems.MathOperations.RealType;
package Functions "Functions"
  extends IndustrialControlSystems.Icons.FunctionsPackage;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains function definitions for real-type mathematical operations and
  signal generation in the IndustrialControlSystems library. It provides:
  </p>
  <ul>
    <li><b>GeneralFunction</b> — the partial base function defining the interface for
        real-valued multi-input, single-output functions (input real vector, output real
        scalar).</li>
    <li><b>GeneralReScalingFunction</b> — the partial base function defining the interface
        for fixed-point rescaling functions, called after the main computation to convert
        the raw result back to a physical value.</li>
    <li><b>fSmoothStep</b> — computes a smooth trapezoidal-velocity transition profile
        between two real values, with configurable slope and parabolic blending.</li>
    <li><b>f</b> — wraps <code>fSmoothStep</code> with Boolean rise/fall control signals,
        providing the core logic for triggered smooth-step signal generators.</li>
    <li><b>toFixedPoint</b> — converts a real value to a saturated fixed-point integer
        using a scale factor and configurable bit-width limits.</li>
  </ul>
  </HTML>", revisions="<html>
</html>"));
end Functions;
