# Caminho para o arquivo .txt com os repositórios
$reposFile = "repositories.txt"

# Caminho onde você deseja clonar os repositórios
$cloneDir = "C:\projetos\github"

# Certifique-se de que o diretório de destino existe
if (-not (Test-Path $cloneDir)) {
    New-Item -ItemType Directory -Path $cloneDir
}

# Ler o arquivo de repositórios e clonar cada repositório
Get-Content $reposFile | ForEach-Object {
    $repoUrl = $_.Trim()
    
    if ($repoUrl) {
        # directory name
        $repoName = $repoUrl.Split("/")[-1].Replace(".git", "")
        $repoPath = Join-Path $cloneDir $repoName

        if (-not (Test-Path $repoPath)) {
            Write-Host "Cloning: $repoUrl"
            git clone $repoUrl $repoPath
        } else {
            Write-Host "The '$repoName' repository has already been cloned in the directory '$repoPath'"
        }
    }
}
