# encoding: UTF-8

control "V-93003" do
  title "Windows Server 2019 Deny log on as a service user right must be
configured to include no accounts or groups (blank) on domain controllers."
  desc  "Inappropriate granting of user rights can provide system,
administrative, and other high-level capabilities.

    The \"Deny log on as a service\" user right defines accounts that are
denied logon as a service.

    Incorrect configurations could prevent services from starting and result in
a denial of service.
  "
  desc  "rationale", ""
  desc  "check", "
    This applies to domain controllers. A separate version applies to other
systems.

    Verify the effective setting in Local Group Policy Editor.

    Run \"gpedit.msc\".

    Navigate to Local Computer Policy >> Computer Configuration >> Windows
Settings >> Security Settings >> Local Policies >> User Rights Assignment.

    If any accounts or groups are defined for the \"Deny log on as a service\"
user right, this is a finding.

    For server core installations, run the following command:

    Secedit /Export /Areas User_Rights /cfg c:\\path\\filename.txt

    Review the text file.

    If any SIDs are granted the \"SeDenyServiceLogonRight\" user right, this is
a finding.
  "
  desc  "fix", "Configure the policy value for Computer Configuration >>
Windows Settings >> Security Settings >> Local Policies >> User Rights
Assignment >> \"Deny log on as a service\" to include no entries (blank)."
  impact 0.5
  tag severity: nil
  tag gtitle: "SRG-OS-000080-GPOS-00048"
  tag gid: "V-93003"
  tag rid: "SV-103091r1_rule"
  tag stig_id: "WN19-DC-000390"
  tag fix_id: "F-99249r1_fix"
  tag cci: ["CCI-000213"]
  tag nist: ["AC-3", "Rev_4"]
end

