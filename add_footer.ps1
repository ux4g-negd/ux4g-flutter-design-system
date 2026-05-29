$path = "example\lib\stories\pattern_stories.dart"
$content = Get-Content $path -Raw

$footerOuter = @"

    // Powered by - Digital India footer pinned to the bottom.
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(`'Powered by -`',
            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          SizedBox(height: 6),
          Image.asset(`'assets/digital_india_logo.png`', height: 22),
        ],
      ),
    ),
"@

$footerInner = @"

        // Powered by - Digital India footer pinned to the bottom.
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(`'Powered by -`',
                style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
              SizedBox(height: 6),
              Image.asset(`'assets/digital_india_logo.png`', height: 22),
            ],
          ),
        ),
"@

$snippets = @(
    "_signInDefaultCode",
    "_signInWithMobileCode",
    "_enterOtpCode",
    "_aadhaarCode",
    "_successCode",
    "_verifyMobileOtpCode",
    "_verifyVoiceFallbackCode",
    "_verifyAttemptWarningCode",
    "_verifyLastAttemptCode",
    "_verifyAccountLockedCode",
    "_otpVerifiedSuccessCode",
    "_authIncorrectOtpCode",
    "_authOtpAttemptWarningCode"
)

$endMarker = ")" + ([char]39 + [char]39 + [char]39) + ";"
$patternA = "    ],`r`n  ),`r`n" + $endMarker  # Container-wrapped Column close
$patternB = "  ],`r`n" + $endMarker            # Top-level Column close

$totalAdded = 0
foreach ($name in $snippets) {
    $startIdx = $content.IndexOf("const $name")
    if ($startIdx -lt 0) {
        Write-Host "SKIP $name not found"
        continue
    }
    $endIdx = $content.IndexOf($endMarker, $startIdx)
    if ($endIdx -lt 0) {
        Write-Host "SKIP $name end marker not found"
        continue
    }
    $injectAtA = $content.IndexOf($patternA, $startIdx)
    $injectAtB = $content.IndexOf($patternB, $startIdx)

    if ($injectAtA -ge 0 -and $injectAtA -lt $endIdx) {
        $before = $content.Substring(0, $injectAtA)
        $after = $content.Substring($injectAtA)
        $content = $before + $footerInner.TrimStart("`r","`n") + $after
        Write-Host "OK   $name (Pattern A)"
        $totalAdded++
    } elseif ($injectAtB -ge 0 -and $injectAtB -lt $endIdx) {
        $before = $content.Substring(0, $injectAtB)
        $after = $content.Substring($injectAtB)
        $content = $before + $footerOuter.TrimStart("`r","`n") + $after
        Write-Host "OK   $name (Pattern B)"
        $totalAdded++
    } else {
        Write-Host "SKIP $name no closing pattern matched"
    }
}

Set-Content -Path $path -Value $content -NoNewline
Write-Host ""
Write-Host "Total: $totalAdded"
