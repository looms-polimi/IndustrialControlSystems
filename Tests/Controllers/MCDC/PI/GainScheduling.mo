within Tests.Controllers.MCDC.PI;
model GainScheduling "PI: gain-scheduling inputs on (Kp_GS = 4, Ti_GS = 2.5)"
  extends Base(useGS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PI: gain-scheduling inputs on (Kp_GS = 4, Ti_GS = 2.5). Configuration: <code>useGS=true</code>.</p>
<p>MC/DC role: pairs with Base for useGS.</p>
</html>"));
end GainScheduling;
