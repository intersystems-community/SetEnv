Class isc.SetEnv
{

Parameter SetEnvLibId As Integer = 4938;

Parameter SetEnvVar As Integer = 1;

/// Get path to the shared library file. 
/// Library file is assumed to be in a bin folder, unless specified otherwise in ^isc.py.Callout global.
/// write ##class(isc.SetEnv).GetLib()
ClassMethod GetLib() [ CodeMode = expression ]
{
$g(^isc.SetEnv, $g(^%SYS("bindir")) _ "iscsetenv." _ $select($$$isWINDOWS:"dll", $$$isMACOSX:"dylib", 1:"so"))
}

/// Should be executed once per system start. Idempotent.
/// Add to ZSTART or production start.
/// write ##class(isc.SetEnv).Setup()
ClassMethod Setup() As %Status
{
	#dim sc As %Status = $$$OK
	set file = ..GetLib()
	quit:'##class(%File).Exists(file) $$$ERROR($$$GeneralError, "Library file: " _ file _ " does not exist")	

	try {
		set result = $ZF(-4,6,..#SetEnvLibId)
		if result'=0 {
			set sc = $$$ERROR($$$GeneralError, "Failed $ZF(-4, 6,..#PyLibId) call with result: " _ result _ " expected 0")
			quit
		}
		
		set result =$ZF(-4,5,..#SetEnvLibId, file)
		if result'=0 {
			set sc = $$$ERROR($$$GeneralError, "Failed $ZF(-4, 5,..GetLib()) call with result: " _ result _ " expected 0")
			quit
		}
	} catch ex {
		set sc = ex.AsStatus()
	}
	
	
    quit sc
}

/// Set Environment variable
/// w ##class(isc.SetEnv).SetEnvVar("ABC", "123")
/// w $system.Util.GetEnviron("ABC") 
ClassMethod SetEnvVar(name As %String, value As %String) As %Status
{
	#dim sc As %Status = $$$OK
	try {
		do $ZF(-6, ..#SetEnvLibId, ..#SetEnvVar, name, value)
	} catch ex {
		set sc = ex.AsStatus()
	}
	quit sc
}

}