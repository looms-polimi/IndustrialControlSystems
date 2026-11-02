within IndustrialControlSystems.MathOperations;
package RealType "Real mathematical operations"
  extends Modelica.Icons.TypeReal;


  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This sub-package contains mathematical operation blocks and supporting components for
  real-valued signals, including an optional fixed-point quantisation mode. It is organised
  into four child packages:
  </p>
  <ul>
    <li><b>Interfaces</b> — partial base models defining the port and parameter contracts
        for real-type operation blocks, including the standard two-input interface and
        fixed-point parameters (<code>FixedPoint</code>, <code>Nbit</code>,
        <code>scaleFactor</code>, <code>Ts</code>).</li>
    <li><b>Functions</b> — function definitions for the real-type domain, including the
        partial interfaces <code>GeneralFunction</code> and
        <code>GeneralReScalingFunction</code>, the smooth-step profile functions
        <code>fSmoothStep</code> and <code>f</code>, and the fixed-point conversion
        utility <code>toFixedPoint</code>.</li>
    <li><b>Signals</b> — set-point and disturbance signal generators: smooth step, smooth
        tooth, triggered variants, and a pseudo-random noise source.</li>
    <li><b>Arithmetic blocks</b> — concrete operation blocks for addition (<code>Add</code>),
        subtraction (<code>Sub</code>), multiplication (<code>Mult</code>), division
        (<code>Div</code>), and exponentiation (<code>Pow</code>), all supporting optional
        fixed-point output quantisation.</li>
  </ul>
  </HTML>", revisions="<html>
</html>"));
end RealType;
