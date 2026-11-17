within IndustrialControlSystems.MathOperations.RealType;
package Signals "Real signals for modelling disturbances or smooth set point references"
  extends Modelica.Icons.Package;


annotation (Documentation(revisions="<html>
</html>", info="
  <HTML>
  <h4>Description</h4>
  <p>
  This sub-package contains set-point signal generators and noise sources for use in
  control system simulations. All signals produce real-valued outputs compatible with
  the standard Modelica real connector. The package includes:
  </p>
  <ul>
    <li><b>SmoothStep</b> — a free-running smooth step signal that transitions from an
        initial value to a final value <code>yfin</code> using a trapezoidal-velocity
        profile with configurable slope <code>m</code> and parabolic blending
        coefficient <code>alfa</code>.</li>
    <li><b>SmoothTooth</b> — a periodic smooth tooth-wave signal built from repeated
        smooth step transitions.</li>
    <li><b>SmoothStepSignal</b> — a triggered version of <code>SmoothStep</code>: the
        transition is initiated by a Boolean enable input and an optional delay.</li>
    <li><b>SmoothToothSignal</b> — a triggered tooth signal driven by separate Boolean
        rise and fall enable inputs, with configurable start and end levels.</li>
    <li><b>noiseGen</b> — a pseudo-random noise signal generator producing a bounded
        real disturbance signal.</li>
  </ul>
  </HTML>"));
end Signals;
