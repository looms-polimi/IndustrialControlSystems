within Tests.Controllers.MCDC.P;
model GainScheduling "P: gain-scheduling input on (Kp_GS = 4)"
  extends Base(useGS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>P: gain-scheduling input on (Kp_GS = 4). Configuration: <code>useGS=true</code>.</p>
<p>MC/DC role: pairs with Base for useGS (output follows the scheduled gain).</p>
</html>"));
end GainScheduling;
