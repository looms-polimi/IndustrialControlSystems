within Tests.Controllers.MCDC.PID;
model SampledTustin "PID: sampled, Tustin"
  extends Base(Ts=0.05, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PID: sampled, Tustin. Configuration: <code>Ts=0.05, method=IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU</code>.</p>
<p>MC/DC role: covers method = TU in the discretisation decision.</p>
</html>"));
end SampledTustin;
