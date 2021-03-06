# encoding: UTF-8

control "V-93163" do
  title "Windows Server 2019 must be configured to audit Object Access - Other
Object Access Events successes."
  desc  "Maintaining an audit trail of system activity logs can help identify
configuration errors, troubleshoot service disruptions, and analyze compromises
that have occurred, as well as detect attacks. Audit logs are necessary to
provide a trail of evidence in case the system or network is compromised.
Collecting this data is essential for analyzing the security of information
assets and detecting signs of suspicious and unexpected behavior.

    Auditing for other object access records events related to the management
of task scheduler jobs and COM+ objects.
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

    Object Access >> Other Object Access Events - Success
  "
  desc  "fix", "Configure the policy value for Computer Configuration >>
Windows Settings >> Security Settings >> Advanced Audit Policy Configuration >>
System Audit Policies >> Object Access >> \"Audit Other Object Access Events\"
with \"Success\" selected."
  impact 0.5
  tag severity: nil
  tag gtitle: "SRG-OS-000470-GPOS-00214"
  tag gid: "V-93163"
  tag rid: "SV-103251r1_rule"
  tag stig_id: "WN19-AU-000220"
  tag fix_id: "F-99409r1_fix"
  tag cci: ["CCI-000172"]
  tag nist: ["AU-12 c", "Rev_4"]
end

