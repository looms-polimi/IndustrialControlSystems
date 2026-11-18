within Tests.LinearSystems.MCDC.DiscreteTransferFunction;
model Tustin "DiscreteTransferFunction: Tustin"
  extends Base(method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU);
  annotation (experiment(StopTime=10, Interval=0.005, Tolerance=1e-8), Documentation(info="<html>
<p>DiscreteTransferFunction: Tustin. Configuration: <code>method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU</code>.</p>
<p>MC/DC role: covers method = TU.</p>
</html>"));
end Tustin;
