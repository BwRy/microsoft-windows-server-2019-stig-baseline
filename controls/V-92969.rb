# encoding: UTF-8

control "V-92969" do
  title "Windows Server 2019 must be configured to audit logon failures."
  desc  "Maintaining an audit trail of system activity logs can help identify
configuration errors, troubleshoot service disruptions, and analyze compromises
that have occurred, as well as detect attacks. Audit logs are necessary to
provide a trail of evidence in case the system or network is compromised.
Collecting this data is essential for analyzing the security of information
assets and detecting signs of suspicious and unexpected behavior.

    Logon records user logons. If this is an interactive logon, it is recorded
on the local system. If it is to a network share, it is recorded on the system
accessed.


  "
  desc  "rationale", ""
  desc  "check", "
    Security Option \"Audit: Force audit policy subcategory settings (Windows
Vista or later) to override audit policy category settings\" must be set to
\"Enabled\" (WN19-SO-000050) for the detailed auditing subcategories to be
effective.

    Use the \"AuditPol\" tool to review the current Audit Policy configuration:

    Open \"PowerShell\" or a \"Command Prompt\" with elevated privileges (\"Run
as administrator\").

    Enter \"AuditPol /get /category:*\"

    Compare the \"AuditPol\" settings with the following:

    If the system does not audit the following, this is a finding.

    Logon/Logoff >> Logon - Failure
  "
  desc  "fix", "Configure the policy value for Computer Configuration >>
Windows Settings >> Security Settings >> Advanced Audit Policy Configuration >>
System Audit Policies >> Logon/Logoff >> \"Audit Logon\" with \"Failure\"
selected."
  impact 0.5
  tag severity: nil
  tag gtitle: "SRG-OS-000032-GPOS-00013"
  tag satisfies: ["SRG-OS-000032-GPOS-00013", "SRG-OS-000470-GPOS-00214",
"SRG-OS-000472-GPOS-00217", "SRG-OS-000473-GPOS-00218",
"SRG-OS-000475-GPOS-00220"]
  tag gid: "V-92969"
  tag rid: "SV-103057r1_rule"
  tag stig_id: "WN19-AU-000200"
  tag fix_id: "F-99215r1_fix"
  tag cci: ["CCI-000067", "CCI-000172"]
  tag nist: ["AC-17 (1)", "AU-12 c", "Rev_4"]
end

