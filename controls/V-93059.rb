# encoding: UTF-8

control "V-93059" do
  title "Windows Server 2019 Create global objects user right must only be
assigned to Administrators, Service, Local Service, and Network Service."
  desc  "Inappropriate granting of user rights can provide system,
administrative, and other high-level capabilities.

    Accounts with the \"Create global objects\" user right can create objects
that are available to all sessions, which could affect processes in other
users' sessions."
  desc  "rationale", ""
  desc  'check', "Verify the effective setting in Local Group Policy Editor.

    Run \"gpedit.msc\".

    Navigate to Local Computer Policy >> Computer Configuration >> Windows
Settings >> Security Settings >> Local Policies >> User Rights Assignment.

    If any accounts or groups other than the following are granted the \"Create
global objects\" user right, this is a finding:

    - Administrators
    - Service
    - Local Service
    - Network Service

    For server core installations, run the following command:

    Secedit /Export /Areas User_Rights /cfg c:\\path\\filename.txt

    Review the text file.

    If any SIDs other than the following are granted the
\"SeCreateGlobalPrivilege\" user right, this is a finding:

    S-1-5-32-544 (Administrators)
    S-1-5-6 (Service)
    S-1-5-19 (Local Service)
    S-1-5-20 (Network Service)

    If an application requires this user right, this would not be a finding.

    Vendor documentation must support the requirement for having the user right.

    The requirement must be documented with the ISSO.

    The application account must meet requirements for application account
passwords, such as length (WN19-00-000050) and required frequency of changes
(WN19-00-000060)."
  desc  'fix', "Configure the policy value for Computer Configuration >> Windows Settings
>> Security Settings >> Local Policies >> User Rights Assignment >> \"Create
global objects\" to include only the following accounts or groups:

    - Administrators
    - Service
    - Local Service
    - Network Service"
  impact 0.5
  tag 'severity': nil
  tag 'gtitle': 'SRG-OS-000324-GPOS-00125'
  tag 'gid': 'V-93059'
  tag 'rid': 'SV-103147r1_rule'
  tag 'stig_id': 'WN19-UR-000070'
  tag 'fix_id': 'F-99305r1_fix'
  tag 'cci': ["CCI-002235"]
  tag 'nist': ["AC-6 (10)", "Rev_4"]

  os_type = command('Test-Path "$env:windir\explorer.exe"').stdout.strip

  if os_type == 'false'
     describe 'This system is a Server Core Installation, and a manual check will need to be performed with command Secedit /Export /Areas User_Rights /cfg c:\\path\\filename.txt' do
      skip 'This system is a Server Core Installation, and a manual check will need to be performed with command Secedit /Export /Areas User_Rights /cfg c:\\path\\filename.txt'
     end
  else
    describe security_policy do
     its('SeCreateGlobalPrivilege') { should include "S-1-5-32-544" }
    end
    describe security_policy do
     its('SeCreateGlobalPrivilege') { should include "S-1-5-6" }
    end
    describe security_policy do
     its('SeCreateGlobalPrivilege') { should include "S-1-5-19" }
    end
    describe security_policy do
     its('SeCreateGlobalPrivilege') { should include "S-1-5-20" }
    end
 end
end