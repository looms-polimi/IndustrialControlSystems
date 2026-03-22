# IndustrialControlSystems

![LevelControl](https://raw.github.com/mbonvini/IndustrialControlSystems/master/IndustrialControlSystems/help/images/LevelControl_Scheme.png)

## Library description

Package Industrial Control Systems is a library that is developed with the [Modelica language](https://www.modelica.org) and provides a set of continuous and discrete control systems.
This library can be used to set up or replicate the majority of industrial controllers.

The first version of the library has been presented at the 9th Modelica conference,
held in Munich 3-5 September 2012, see [paper](http://dx.doi.org/10.3384/ecp12076477). The library won the 2nd prize at the Modelica library competition award.

## Latest releases

IndustrialControlSystems v1.2.0 (2024-08-07)

IndustrialControlSystems v2.0.0 (2024-08-07)

IndustrialControlSystems v.2.0.1-rc (2025-04-04) 

#### Release notes

Version 1.2.0 adds gain scheduling to analog P and PI controllers and fixes some Modelica language issues.

Version 2.0.0 is the same as 1.2.0 but it works with MSL 4.0.0. Technically speaking it is not backwards compatible with 1.2.0 because it depends on the non-backwards compatible MSL 4.0.0, but in practice the conversion script only affects the examples and applications in the library, but it doesn't change the code of the used blocks in the library.

Version 2.0.1 removed a few minor Modelica language issues to make the library compatible with Modelon Impact, and updated the library to Modelica 4.1.0. 

#### Main authors

Marco Bonvini and Alberto Leva

#### Minor fixes (2026-03-18, Hubertus Tummescheit, Model Based Innovation LLC)

 - Updated to Modelica Standard Library 4.1.0
 - Replaced illegal used of conditional component with legal use to make library compatible with Modelon Impact
 - Removed an illegal use of noEvent()-operator in when-clause
 - Added size info for one function output to make it more readable
 - All models compile and give smoke-test-sensible results in Modelon Impact.
 - Fixed typo, TrasferFunction to TransferFunction
