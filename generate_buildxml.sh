#!/bin/bash

# Check if the environment variable PROVAR_HOME is set
if [ -z "$1" ]; then
  echo "Usage: $0 <PROVAR_HOME>"
  echo "Example: $0 'C:/Program Files/Provar21311/'"
  exit 1
fi

# Define the output file
OUTPUT_FILE="build.xml"

# Create the build.xml file
cat <<EOL > $OUTPUT_FILE
<project default="runtests">
    <property environment="env"/>
    <property name="provar.home" value="C:/Program Files/Provar21311/"/>
    <property name="testproject.home" value=".."/>
    <property name="testproject.results" value="../ANT/Results"/>
    <property name="secrets.password" value="\${env.ProvarSecretsPassword}"/>
    <property name="testenvironment.secretspassword" value="\${env.ProvarSecretsPassword_EnvName}"/>

    <taskdef name="Provar-Compile" classname="com.provar.testrunner.ant.CompileTask" classpath="\${provar.home}/ant/ant-provar.jar"/>
    <taskdef name="Run-Test-Case" classname="com.provar.testrunner.ant.RunnerTask" classpath="\${provar.home}/ant/ant-provar.jar;\${provar.home}/ant/ant-provar-bundled.jar;\${provar.home}/ant/ant-provar-sf.jar"/>
    <taskdef name="Test-Cycle-Report" classname="com.provar.testrunner.ant.TestCycleReportTask" classpath="\${provar.home}/ant/ant-provar.jar;\${provar.home}/ant/ant-provar-bundled.jar;\${provar.home}/ant/ant-provar-sf.jar"/>

    <target name="runtests">

        <Provar-Compile provarHome="\${provar.home}" projectPath="\${testproject.home}"/>

        <Run-Test-Case provarHome="\${provar.home}" 
                projectPath="\${testproject.home}" 
                resultsPath="\${testproject.results}" 
                resultsPathDisposition="Replace" 
                testEnvironment="" 
                webBrowser="Chrome" 
                webBrowserConfiguration="Full Screen"
                webBrowserProviderName="Desktop"
                webBrowserDeviceName="Full Screen" 
                excludeCallableTestCases="true" 
                salesforceMetadataCache="Reload" 
                projectCachePath="../../.provarCaches"
                testOutputlevel="BASIC" 
                pluginOutputlevel="SEVERE"
                stopTestRunOnError="false"
                secretsPassword="\${secrets.password}"
                testEnvironmentSecretsPassword="\${testenvironment.secretspassword}"
                invokeTestRunMonitor="true">

            <fileset id="testcases" dir="../tests"></fileset>
            <fileset id="testcases" dir="../tests"><include name="Test Case 120.testcase"/></fileset>
            <fileset id="testcases" dir="../tests"><include name="Test Case 121.testcase"/></fileset>
            <fileset id="testcases" dir="../tests"><include name="Test Case 1.testcase"/></fileset>
            <fileset id="testcases" dir="../tests"><include name="Test Case 114.testcase"/></fileset>
            <fileset id="testcases" dir="../tests"><include name="Test Case 115.testcase"/></fileset>
            <fileset id="testcases" dir="../tests"><include name="Test Case 116.testcase"/></fileset>

            <emailProperties sendEmail="true" primaryRecipients="prakash.ranjan@provartesting.com" ccRecipients="" bccRecipients="" emailSubject="Provar test run report" attachExecutionReport="true" attachZip="true"/>
            <attachmentProperties includeAllFailuresInSummary="true" includeBdd="false" includeSkipped="false" includeTestCasePathHierarchy="true" includeTestCaseShowSummary="true" includeBasicLogs="false" includeDetailLogs="false" includeDiagnosticTrace="false" includeTestStepTime="true" includeNoScreenshot="false" includeScreenshotThumbnail="false" includeFullScreenShot="true"/>
        </Run-Test-Case>

    </target>
</project>
EOL

echo "build.xml has been generated with PROVAR_HOME set to '$1'."
