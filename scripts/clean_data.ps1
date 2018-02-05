#!/usr/bin/env powershell

$BASE = Get-Location

Write-Host "This will reset all the class data under $BASE !!!"
Write-Host ""
Write-Host "Are you sure this is what you want to do?"

$confirmation = Read-Host "You must type 'yes' to confirm: "
if ($confirmation -eq 'yes') {
  rm "${BASE}/mongodb/data/db/*" -r -fo
  rm "${BASE}/rocketchat/data/uploads/*" -r -fo
  rm "${BASE}/zmachine/saves/*" -r -fo
  cp "$BASE/.git_keep" "$BASE/mongodb/data/db/.git_keep"
  cp "$BASE/.git_keep" "$BASE/rocketchat/data/uploads/.git_keep"
  cp "$BASE/.git_keep" "$BASE/zmachine/saves/.git_keep"
  Write-Host "completed"
} else {
  Write-Host "aborted"
}

