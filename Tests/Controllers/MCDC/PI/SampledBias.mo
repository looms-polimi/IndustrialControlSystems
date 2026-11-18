within Tests.Controllers.MCDC.PI;
model SampledBias "PI: bias input on, sampled (Ts = 0.05)"
  extends Base(useBIAS=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PI: bias input on, sampled (Ts = 0.05). Configuration: <code>useBIAS=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Sampled for useBIAS (output = reference + bias).</p>
</html>"));
end SampledBias;
