# Push local Terraform repo to GitHub as TERRAFORM-WORK (public)
# Run this script from PowerShell on your machine

$repoPath = 'C:\Users\Roshan.daf\terrafrom1030am'
$githubUser = 'RoshanChhanikar'
$repoName = 'TERRAFORM-WORK'
$repoUrl = "https://github.com/$githubUser/$repoName.git"

Write-Output "=== Setting up and pushing to GitHub ==="
Write-Output "Repo path: $repoPath"
Write-Output "Target URL: $repoUrl"
Write-Output ""

# Check if git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Error "ERROR: git is not installed or not on PATH."
  Write-Output "Install Git from https://git-scm.com/download/win and re-run this script."
  exit 1
}

# Check if gh is installed (optional but recommended for creating repo)
$useGh = $false
if (Get-Command gh -ErrorAction SilentlyContinue) {
  Write-Output "[INFO] GitHub CLI (gh) detected. Will use it to create the repo."
  $useGh = $true
}

cd $repoPath

# Initialize local git repo if needed
if (-not (Test-Path .git)) {
  Write-Output "[STEP 1/4] Initializing local git repo..."
  git init
  git config user.email "you@example.com"
  git config user.name "Your Name"
  git add --all
  git commit -m "Initial commit: Terraform code"
  git branch -M main
  Write-Output "[✓] Local repo initialized."
} else {
  Write-Output "[STEP 1/4] Local git repo already exists. Skipping init."
}

# Option A: Use gh to create and push
if ($useGh) {
  Write-Output ""
  Write-Output "[STEP 2/4] Creating GitHub repo with gh..."
  
  # Verify authentication
  gh auth status 2>$null
  if ($LASTEXITCODE -ne 0) {
    Write-Output "ERROR: gh is not authenticated. Run 'gh auth login' first, then re-run this script."
    exit 1
  }
  
  # Create repo (will fail if it already exists; that's OK)
  gh repo create $githubUser/$repoName --public --source=. --remote=origin --push 2>$null
  if ($LASTEXITCODE -eq 0) {
    Write-Output "[✓] Repo created and code pushed."
  } else {
    Write-Output "[INFO] Repo may already exist. Attempting to update remote and push..."
    git remote set-url origin $repoUrl 2>$null
    if ($LASTEXITCODE -eq 0) {
      Write-Output "[✓] Remote updated to existing repo."
    } else {
      git remote add origin $repoUrl
      Write-Output "[✓] Remote added."
    }
  }
} else {
  # Option B: Use git remote and push (manual HTTPS approach)
  Write-Output ""
  Write-Output "[STEP 2/4] Adding remote origin..."
  
  # Check if remote already exists
  $remoteExists = git remote get-url origin 2>$null
  if ($remoteExists) {
    Write-Output "[INFO] Remote already exists. Updating URL..."
    git remote set-url origin $repoUrl
  } else {
    git remote add origin $repoUrl
  }
  Write-Output "[✓] Remote added/updated: $repoUrl"
}

# Push to GitHub
Write-Output ""
Write-Output "[STEP 3/4] Pushing code to GitHub..."
git push -u origin main
if ($LASTEXITCODE -eq 0) {
  Write-Output "[✓] Code pushed successfully."
} else {
  Write-Output "ERROR: Push failed. You may need to authenticate (GitHub may prompt for credentials or PAT)."
  exit 1
}

Write-Output ""
Write-Output "[STEP 4/4] Verifying repository..."
Write-Output ""
Write-Output "=== SUCCESS ==="
Write-Output "Repository URL: $repoUrl"
Write-Output "View on GitHub: https://github.com/$githubUser/$repoName"
Write-Output ""
Write-Output "Next steps (optional):"
Write-Output "  - Rename local folder: Rename-Item -Path '$repoPath' -NewName '$repoName'"
Write-Output "  - Clone from GitHub: git clone $repoUrl"
