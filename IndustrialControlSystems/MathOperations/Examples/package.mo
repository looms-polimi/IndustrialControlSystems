within IndustrialControlSystems.MathOperations;
package Examples "Examples"
  extends IndustrialControlSystems.Icons.ExamplesPackage;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains executable simulation examples for the
  <code>MathOperations</code> library. The examples cover:
  <ul>
    <li><b>SimpleMathOperations</b> — demonstrates the basic arithmetic blocks (Add, Sub, Mult,
        Div, Pow) operating on real-valued signals with optional fixed-point quantisation.</li>
    <li><b>CustomMathOperation</b> — shows how user-defined functions conforming to the
        <code>GeneralFunction</code> interface can be plugged into the generic Expression
        blocks for both integer and real types.</li>
    <li><b>SetPointGeneration</b> — illustrates the set-point signal generators available in
        <code>RealType.Signals</code>, including SmoothStep, SmoothTooth, SmoothStepSignal,
        SmoothToothSignal, and the noise generator.</li>
    <li><b>Mean</b> — a custom real-type function that computes the arithmetic mean of a vector.</li>
    <li><b>SumSquare</b> — a custom integer-type function that computes the sum of squares of a vector.</li>
    <li><b>reScale</b> — a custom rescaling function for fixed-point output correction.</li>
  </ul>
  </p>
  </HTML>", revisions="<html>
</html>"));
end Examples;
