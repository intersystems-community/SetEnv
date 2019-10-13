# SetEnv

Set Environment Variables

# Installation

1. Download [latest release](https://github.com/intersystems-ru/SetEnv/releases).
2. Import `isc.SetEnv` class into any namespace.
3. Place callout DLL/SO/DYLIB in the `bin` folder of your InterSystems IRIS installation. Library file should be placed into a path returned by `write ##class(isc.SetEnv).GetLib()`

# User guide

1. Once per system start call: `write ##class(isc.SetEnv).Setup()`
2. Call: `write ##class(isc.SetEnv).SetEnvVar(VarName, Value)` to set environment variable
3. Call: `write $system.Util.GetEnviron(VarName)` to check that variable assignment was a success. This is a required action on some platforms.
