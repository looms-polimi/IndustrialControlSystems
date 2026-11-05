within IndustrialControlSystems.Applications;
package ControlStrategies "Examples demonstrating signal conditioning and control strategies"
  extends .Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains examples that illustrate common industrial control and signal
  conditioning strategies built from the ICS library blocks. Each example is a
  self-contained simulation model with documented parameter choices and suggested
  plot variables.
  </p>
  <p>Currently included examples:</p>
  <ul>
    <li><b>LeadLagFilter</b> — a three-stage signal-conditioning chain consisting of
        a first-order sensor model with additive noise, a low-pass filter for noise
        rejection, and a lead-lag filter to recover the speed lost by the low-pass
        stage.</li>
  </ul>
  </HTML>"));
end ControlStrategies;
