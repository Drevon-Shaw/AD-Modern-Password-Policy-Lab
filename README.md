# AD-Modern-Password-Policy-Lab
Implementing NIST-aligned password policy  in Windows Server 2019 using Fine Grained  Password Policy and Password Settings Objects

# Ditching Password Expiration — Modern Password Policy in Active Directory

## Overview

Forced password expiration doesn't work. Users cycle through 
predictable patterns, write passwords down, and make them 
weaker with every rotation. NIST SP 800-63B recognized this 
and moved away from expiration entirely  enforce complexity, 
ditch the timer, detect breaches instead.

This lab implements that approach natively in Windows Server 
2019 using Fine Grained Password Policy. No third party tools. 
No extra cost. Just what Active Directory already gives you.

---

## Lab Environment

| Component | Details |
|-----------|---------|
| Domain Controller | Windows Server 2019 |
| Workstation | Windows 10 — joined to LAB.local |
| Domain | LAB.local |
| Tool | Active Directory Administrative Center |

---

## PSO Configuration

| Setting | Value | Reason |
|---------|-------|--------|
| Minimum Password Length | 14 characters | Length is the strongest complexity factor |
| Complexity Required | Enabled | Upper, lower, number, symbol required |
| Maximum Password Age | 0 — never expires | NIST SP 800-63B compliance |
| Minimum Password Age | 0 | No restriction on when user can change |
| Password History | 10 passwords | Prevents reuse of recent passwords |
| Lockout Threshold | 5 attempts | Brute force protection |
| Lockout Duration | 30 minutes | Auto unlock after observation window |
| Reversible Encryption | Disabled | Security best practice |

---

## Key Commands
```powershell
# Verify PSO is applied to a user
Get-ADUserResultantPasswordPolicy -Identity "username"

# Test weak password — should be rejected
Set-ADAccountPassword -Identity "username" `
-Reset `
-NewPassword (ConvertTo-SecureString "Password1" -AsPlainText -Force)

# Test strong password — should be accepted
Set-ADAccountPassword -Identity "username" `
-Reset `
-NewPassword (ConvertTo-SecureString "xK9#mP2qvL7@nQ4!" -AsPlainText -Force)
```

---

## What I Learned

PSOs apply to security groups not OUs  that distinction
matters when troubleshooting why a policy isn't applying.

The Get-ADUserResultantPasswordPolicy command is the
authoritative way to confirm what's actually being enforced
on a user. The ADUC checkbox reflects default domain policy
visually  not PSO settings.

Setting maximum password age to 0 tells Active Directory
the password never expires. Complexity and length requirements
do the work that rotation used to fake.

---

## Enterprise Context

In production environments tools like Specops Password Policy
and Netwrix Password Policy Enforcer extend this concept with
real time breach detection  checking every password against
databases of billions of compromised credentials at the point
of creation or reset.


---

## Full Walkthrough

Complete blog post with annotated screenshots:
https://medium.com/@shawdrevon/ditching-password-expiration-implementing-modern-password-policy-in-active-directory-15203c20dfb3
