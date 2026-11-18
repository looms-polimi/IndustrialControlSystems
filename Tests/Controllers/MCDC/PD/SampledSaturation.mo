within Tests.Controllers.MCDC.PD;
model SampledSaturation "PD: saturation outputs on, anti-windup off, sampled (Ts = 0.05)"
  extends Base(useSAT=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PD: saturation outputs on, anti-windup off, sampled (Ts = 0.05). Configuration: <code>useSAT=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with SampledSaturationAntiWindup for AntiWindup in `CS >= CSmax and AntiWindup` (satHI/satLOW stay false).</p>
</html>"));
end SampledSaturation;
