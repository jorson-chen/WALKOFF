<?xml version="1.0"?>
<workflow name="multiactionErrorWorkflow">
    <options>
        <enabled>true</enabled>
        <scheduler type="cron" autorun="false">
            <month>11-12</month>
            <day>*</day>
            <hour>*</hour>
            <minute>*/0.1</minute>
        </scheduler>
    </options>
    <steps>
        <step id="start">
            <action>helloWorld</action>
            <app>HelloWorld</app>
            <device>hwTest</device>
            <next step="1">
                <flag action="regMatch">
                    <args>
                        <regex>(.*)</regex>
                    </args>
                    <filters>
                        <filter action="length"/>
                    </filters>
                </flag>
            </next>
            <error step="1"></error>
        </step>
        <step id="1">
            <action>Buggy</action>
            <app>HelloWorld</app>
            <device>hwTest</device>
            <error step="error">
                <flag action="regMatch">
                    <args>
                        <regex format="str">(.*)</regex>
                    </args>
                </flag>
            </error>
        </step>
        <step id="error">
            <action>repeatBackToMe</action>
            <app>HelloWorld</app>
            <device>hwTest</device>
            <inputs>
                <call>Hello World</call>
            </inputs>
        </step>
    </steps>
</workflow>
