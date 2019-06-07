<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>WI_to_contact_email_alert</fullName>
        <description>WI to contact email alert</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_To__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Public_Test/WI_Email_to_contact</template>
    </alerts>
    <fieldUpdates>
        <fullName>WI_End_Date</fullName>
        <field>End_Date__c</field>
        <formula>NOW()</formula>
        <name>WI End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WI_Start_Date</fullName>
        <field>Start_Date__c</field>
        <formula>NOW()</formula>
        <name>WI Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>WI Contact Assigned</fullName>
        <actions>
            <name>WI_to_contact_email_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND( 
ISCHANGED(Status__c), 
TEXT(PRIORVALUE(Status__c)) = &quot;New&quot;, 
TEXT(Status__c) = &quot;Ready&quot;,
 NOT(ISBLANK(Assigned_To__c))   
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WI End Date</fullName>
        <actions>
            <name>WI_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Work_Item__c.Status__c</field>
            <operation>equals</operation>
            <value>Done</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WI Start Date</fullName>
        <actions>
            <name>WI_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
    ISCHANGED(Status__c),
    TEXT(PRIORVALUE(Status__c)) = &quot;New&quot;,
    TEXT(Status__c) = &quot;Ready&quot;
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
