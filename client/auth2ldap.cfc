<cfcomponent name="auth2ldap" displayname="auth2ldap" hint="check username and password">
<!--- 
*******************************************************************************
 Copyright (C) 2007 Scott Pinkston
  
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*******************************************************************************

Component: auth2ldap.cfc
Created By: Scott Pinkston (spinkston@ozarka.edu)
Creation Date: 1/27/2007
Description: authenticates username & password against ldap servers.
Can be used for Active Directory or OpenLdap servers.
 --->
		<!--- setup the bindings, for Active Directory 
		This example is for a fictional domain called dummy.com
			<cfset variables.ldapBind = "cn=users,dc=dummy,dc=com">
			<cfset variables.ldapCNBind = "@dummy.com">
			<cfset variables.ldapPrefix = "">
	
		Bindings for openldap using fictional dummy.com
			<cfset variables.ldapCNBind = ",ou=Users,dc=dummy,dc=com">
			<cfset variables.ldapBind = "dc=dummy,dc=com">
			<cfset variables.ldapPrefix = "uid=">
		--->
		
	<cfset variables.LdapServer = "192.168.5.8">
	<cfset variables.ldapPort = "389">
	
	<cfset variables.ldapBind = "cn=users,dc=dummy,dc=com">
	<cfset variables.ldapCNBind = "@dummy.com">
	<cfset variables.ldapPrefix = "">


	<cffunction name="AuthenticateUser" access="public" returntype="boolean" output="false" hint="Returns true/false for a given userName & password">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="ldapServer" default="#variables.ldapServer#" required="false">
		<cfargument name="ldapPort" default="#variables.ldapPort#" required="false">
		<cfargument name="ldapBind" default="#variables.ldapBind#" required="false">
		<cfargument name="ldapCNBind" default="#variables.ldapCNBind#" required="false">
		
		<cfset var ChkUserName = "">

		<cftry>
				  <cfldap action="QUERY"
    			  name="ChkUserName"
	    		  attributes="cn"
		    	  start="#variables.ldapBind#"
			      server="#variables.ldapServer#"
				  scope="SUBTREE"
		    	  username="#variables.ldapPrefix##arguments.username##variables.ldapCNBind#"
			      password="#arguments.password#" 
			      port="#variables.LdapPort#">
		
				<cfcatch>
					<cflog text="#arguments.username# bad password from #cgi.remote_addr#" type="Information" file="#application.applicationname#_auth_error" thread="yes" date="yes" time="yes" application="Yes"> 
					<cfreturn false>
				</cfcatch>
		</cftry>
					
		<cfif isdefined("chkUserName.recordcount") and chkUserName.recordcount>
				<cflog text="#arguments.username# logged in from #cgi.remote_addr#" type="Information" file="#application.applicationname#_auth_log" thread="yes" date="yes" time="yes" application="Yes"> 
				<cfreturn true>
		</cfif>
		
	</cffunction>	

</cfcomponent>