within Tests.Controllers.MCDC.Logic.RelayHysteresis;
model Sampled "Logic.RelayHysteresis: sampled (Ts = 0.1)"
  extends Base(Ts=0.1);
  annotation (experiment(StopTime=12, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>Logic.RelayHysteresis: sampled (Ts = 0.1). Configuration: <code>Ts=0.1</code>.</p>
<p>MC/DC role: pairs with Base for `Ts > 0`.</p>
</html>"));
end Sampled;
