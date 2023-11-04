$ENV:STARSHIP_CONFIG = "${env:APPDATA}\starship.toml"

Invoke-Expression (&starship init powershell)

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl-r -Function ReverseSearchHistory -ViMode Command

function which ($command) { 
  Get-Command -Name $command -ErrorAction SilentlyContinue | 
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue 
} 

#### Setup PSFzf ####
if (-not (Get-Module PSFzf -ListAvailable)) {
  write-output "installing psfzf"
  install-module -name psfzf -scope currentuser -force
}
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

#### Setup posh-git ####
if (-not (Get-Module posh-git -ListAvailable)) {
  Install-Module -Name posh-git -Scope CurrentUser -Force
}
Import-Module posh-git

#### Setup z ####
if (-not (Get-Module z -ListAvailable)) {
  Install-Module -Name z -Scope CurrentUser -Force
}
Import-Module z

#### Setup aliases ####
function Invoke-Config { git --git-dir $HOME/.cfg/ --work-tree $HOME $args }
function Invoke-ConfigUi { gitui --directory $HOME/.cfg/ --workdir $HOME $args }
function Invoke-Eza { eza.exe --icons --git $args }
function Invoke-EzaA { eza -a }
function Invoke-EzaL { eza -l }
function Invoke-EzaLa { eza -la }
function Invoke-EzaTree { eza eza --all --tree --ignore-glob "__pycache__|node_modules|.git|venv|obj" --icons --sort type }
function Invoke-NvimDiff { nvim -d }
function Invoke-ScoopInstall { scoop install $args; scoop export > $HOME/scoop.json }
Set-Alias -Name config -Value Invoke-Config
Set-Alias -Name configui -Value Invoke-ConfigUi
Set-Alias -Name eza -Value Invoke-Eza
Set-Alias -Name la -Value Invoke-EzaA
Set-Alias -Name ll -Value Invoke-EzaL
Set-Alias -Name lla -Value Invoke-EzaLa
Set-Alias -Name ls -Value Invoke-Eza
Set-Alias -Name scoopi -Value Invoke-ScoopInstall
Set-Alias -Name tree -Value Invoke-EzaTree
Set-Alias -Name vi -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name vimdiff -Value Invoke-NvimDiff
Set-Alias -Name watch -Value 'viddy'
