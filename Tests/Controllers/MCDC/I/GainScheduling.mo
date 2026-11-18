within Tests.Controllers.MCDC.I;
model GainScheduling "I: gain-scheduling input on (T_GS = 2.5)"
  extends Base(useGS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>I: gain-scheduling input on (T_GS = 2.5). Configuration: <code>useGS=true</code>.</p>
<p>MC/DC role: pairs with Base for useGS (output follows the scheduled integral time).</p>
</html>"));
end GainScheduling;
