# encoding: UTF-8

control "V-93475" do
  title "Windows Server 2019 passwords must be configured to expire."
  desc  "Passwords that do not expire or are reused increase the exposure of a password with greater probability of being discovered or cracked."
  desc  "rationale", ""
  desc  "check", "Review the password never expires status for enabled user accounts.
    Open \"PowerShell\".

    Domain Controllers:
    Enter \"Search-ADAccount -PasswordNeverExpires -UsersOnly | FT Name, PasswordNeverExpires, Enabled\".
    Exclude application accounts, disabled accounts (e.g., DefaultAccount, Guest) and the krbtgt account.
    If any enabled user accounts are returned with a \"PasswordNeverExpires\" status of \"True\", this is a finding.

    Member servers and standalone systems:
    Enter 'Get-CimInstance -Class Win32_Useraccount -Filter \"PasswordExpires=False and LocalAccount=True\" | FT Name, PasswordExpires, Disabled, LocalAccount'.
    Exclude application accounts and disabled accounts (e.g., DefaultAccount, Guest).
    If any enabled user accounts are returned with a \"PasswordExpires\" status of \"False\", this is a finding."
  desc  "fix", "Configure all enabled user account passwords to expire.
    Uncheck \"Password never expires\" for all enabled user accounts in Active Directory Users and Computers for domain accounts and Users in Computer Management for member servers and standalone systems. Document any exceptions with the ISSO."
  impact 0.5
  tag severity: nil
  tag gtitle: "SRG-OS-000076-GPOS-00044"
  tag gid: "V-93475"
  tag rid: "SV-103561r1_rule"
  tag stig_id: "WN19-00-000210"
  tag fix_id: "F-99719r1_fix"
  tag cci: ["CCI-000199"]
  tag nist: ["IA-5 (1) (d)", "Rev_4"]

  #Check out Windows 2012 control 'V-6840'

  # SK: Copied from Windows 2012 V-6840
  # Q: Test pending | Need to modify code to remove previous conditions

  application_accounts = input('application_accounts_domain')
  excluded_accounts = input('excluded_accounts_domain') 

  domain_role = command('wmic computersystem get domainrole | Findstr /v DomainRole').stdout.strip
  
  if domain_role == '4' || domain_role == '5'
    list_of_accounts = json({ command: "Search-ADAccount -PasswordNeverExpires -UsersOnly | Where-Object {$_.PasswordNeverExpires -eq 'True' -and $_.Enabled -eq 'True'} | Select -ExpandProperty Name | ConvertTo-Json" })
    ad_accounts = list_of_accounts.params
    # Check if application_accounts is empty to avoid control output error - No Value Set
    untracked_accounts = ad_accounts - application_accounts - excluded_accounts
    
    describe 'Untracked Accounts' do
      it 'No Enabled Domain Account should be set to have Password Never Expire' do
        failure_message = "Users Accounts are set to Password Never Expire: #{untracked_accounts}"
        expect(untracked_accounts).to be_empty, failure_message
      end
    end
  else
    local_users = json({ command: "Get-CimInstance -Class Win32_Useraccount -Filter 'PasswordExpires=False and LocalAccount=True and Disabled=False' | Select -ExpandProperty Name | ConvertTo-Json" })
    local_users_list = local_users.params
    if local_users_list.empty?
      impact 0.0
      describe 'The system does not have any local accounts where password is set to Password Never Expires, control is NA' do
         skip 'The system does not have any local accounts where password is set to Password Never Expires, controls is NA'
      end
    else
      describe "Account or Accounts exists" do
        it 'Server should not have Accounts with Password Never Expire' do
          failure_message = "User or Users #{local_users_list} have Password set to not expire" 
          expect(local_users_list).to be_empty, failure_message
        end
      end
    end
  end

end