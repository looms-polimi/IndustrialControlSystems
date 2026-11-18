within Tests.Controllers.MCDC.D;
model SampledTracking "D: tracking inputs on, sampled (Ts = 0.05)"
  extends Base(useTS=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>D: tracking inputs on, sampled (Ts = 0.05). Configuration: <code>useTS=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Sampled for useTS, and gives TS both values within the run.</p>
</html>"));
end SampledTracking;
