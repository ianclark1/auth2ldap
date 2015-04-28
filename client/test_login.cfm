
<form action="" method="post">

	<label for="username">Username</label>
	<input type="text" name="username" size="15"><br>
	
	<label for="password">Password</label>
	<input type="password" name="password" size="15"><br>
		
	<input type="submit">
</form>


<cfif structKeyExists(form,"username") and structKeyExists(form,"password")>
	<!---
		You can pass these into the cfc or code the values into the cfc variables.
		
		<cfinvoke name="ldapServer" value="192.168.1.1">
		<cfinvoke name="ldapPort" value="389">
		<cfinvoke name="ldapBind" value="cn=users,dc=dummy,dc=com">
		<cfinvoke name="ldapCNBind" value="@dummy.com">
	
	--->
	<cfinvoke component="auth2ldap" method="AuthenticateUser" returnvariable="goodLogin">
		<cfinvokeargument name="username" value="#form.username#">
		<cfinvokeargument name="password" value="#form.password#">	
	</cfinvoke>

	<cfif goodlogin>
		Valid login
		<cfelse>
		Invalid username and password
	</cfif>
	
</cfif>




	
	