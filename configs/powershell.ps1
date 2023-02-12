################TERMINAL PROMPTS################
# for using starship
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "C:\Users\timot\.config\starship\starship.toml"

# for using oh-my-posh
# Import-Module oh-my-posh
# Import-Module -Name Terminal-Icons
# Import-Module posh-git
# Set-PoshPrompt -Theme night-owl
################TERMINAL PROMPTS################


################ALIASES################
Set-Alias -Name "reset" -Value $profile -Description "Reset the prompt"
Set-Alias -Name "dig" -Value Resolve-DnsName -Description "Resolve DNS name similar to dig"
Set-Alias 'sudo' 'gsudo'
################ALIASES################

################FUNCTIONS################
# function runkubectl {
#     C:\ProgramData\chocolatey\bin\kubectl.exe --kubeconfig .\config @args
# }
# Set-Alias kub runkubectl -Description "run kubectl"

function runkubectl {
    C:\ProgramData\chocolatey\bin\kubectl.exe @args
}
Set-Alias k runkubectl -Description "run kubectl"

function runBat {
    C:\ProgramData\chocolatey\bin\bat.exe @args --paging=never
}
Set-Alias cat runBat -Description "Run bat with paging disabled"

function cheat {
    curl @args https://cheat.sh/
}

function touch {
    set-content -Path ($args[0]) -Value ($null)
}

function runGlances {
    C:\Users\timot\.pyenv\pyenv-win\versions\3.10.4\Scripts\glances.exe
}
Set-Alias glances runGlances -Description "Runs glances.exe"
################FUNCTIONS################

################AUTO-COMPLETIONS################
# autocompletions
kubectl completion powershell | Out-String | Invoke-Expression
datree completion powershell | Out-String | Invoke-Expression
k9s completion powershell | Out-String | Invoke-Expression
################AUTO-COMPLETIONS################

################OTHER################
# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})
################OTHER################