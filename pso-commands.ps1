# Modern Password Policy — Key Commands
# Lab: LAB.local
# Reference: NIST SP 800-63B

# Verify resultant password policy for a user
Get-ADUserResultantPasswordPolicy -Identity "ljackson"

# Test weak password — should be rejected by PSO
Set-ADAccountPassword -Identity "ljackson" `
    -Reset `
    -NewPassword (ConvertTo-SecureString "Password1" -AsPlainText -Force)

# Test strong password — should be accepted
Set-ADAccountPassword -Identity "ljackson" `
    -Reset `
    -NewPassword (ConvertTo-SecureString "xK9#mP2qvL7@nQ4!" -AsPlainText -Force)

# Check all PSOs in the domain
Get-ADFineGrainedPasswordPolicy -Filter *

# Check which groups a PSO applies to
Get-ADFineGrainedPasswordPolicySubject -Identity "Modern-Password-Policy"
```
