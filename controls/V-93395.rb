# encoding: UTF-8

control "V-93395" do
  title "Windows Server 2019 must have the Server Message Block (SMB) v1 protocol disabled on the SMB client."
  desc  "SMBv1 is a legacy protocol that uses the MD5 algorithm as part of SMB. MD5 is known to be vulnerable to a number of attacks such as collision and preimage attacks as well as not being FIPS compliant."
  desc  "rationale", ""
  desc  "check", "Different methods are available to disable SMBv1 on Windows Server 2019, if WN19-00-000380 is configured, this is NA.

    If the following registry value is not configured as specified, this is a finding:

    Registry Hive: HKEY_LOCAL_MACHINE
    Registry Path: \\SYSTEM\\CurrentControlSet\\Services\\mrxsmb10\\

    Value Name: Start

    Type: REG_DWORD
    Value: 0x00000004 (4)"
  desc  "fix", "Configure the policy value for Computer Configuration >> Administrative Templates >> MS Security Guide >> \"Configure SMBv1 client driver\" to \"Enabled\" with \"Disable driver (recommended)\" selected for \"Configure MrxSmb10 driver\".

    The system must be restarted for the changes to take effect.

    This policy setting requires the installation of the SecGuide custom templates included with the STIG package. \"SecGuide.admx\" and \"SecGuide.adml\" must be copied to the \\Windows\\PolicyDefinitions and \\Windows\\PolicyDefinitions\\en-US directories respectively."
  impact 0.5
  tag severity: nil
  tag gtitle: "SRG-OS-000095-GPOS-00049"
  tag gid: "V-93395"
  tag rid: "SV-103481r1_rule"
  tag stig_id: "WN19-00-000400"
  tag fix_id: "F-99639r1_fix"
  tag cci: ["CCI-000381"]
  tag nist: ["CM-7 a", "Rev_4"]

  # SK: Modified and copied from Windows 2012 V-73523
  # Q: Condition to add -  if WN19-00-000380 is configured, this is NA.

  describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\mrxsmb10') do
    it { should have_property 'Start' }
    its('Start') { should cmp == 4 }
  end

end

