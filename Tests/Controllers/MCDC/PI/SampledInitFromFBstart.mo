within Tests.Controllers.MCDC.PI;
model SampledInitFromFBstart "PI: reset state initialised from FBstart = 0.4, sampled (Ts = 0.05)"
  extends Base(initFromFBstart=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PI: reset state initialised from FBstart = 0.4, sampled (Ts = 0.05). Configuration: <code>initFromFBstart=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with Sampled for initFromFBstart (output starts at FBstart and keeps it as an offset).</p>
</html>"));
end SampledInitFromFBstart;
