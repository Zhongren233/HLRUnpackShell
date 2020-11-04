$fileList = Get-ChildItem .\input\*.bnk -name
Write-Output $fileList
foreach ($file in $fileList) {
    $outDir = "out\" + $file.Substring(0, $file.IndexOf(".bnk"))
    $file = ".\input\"+$file
    .\bin\bnkextr.exe $file
    $wemList = Get-ChildItem *.wem -name
    foreach ($wem in $wemList) {
        .\bin\ww2ogg024\ww2ogg.exe $wem --pcb .\bin\ww2ogg\packed_codebooks_aoTuV_603.bin
    }
    mkdir $outDir
    Move-Item *.ogg $outDir
    Remove-Item *.wem
}
Write-Output 'FINISHED'
[System.Console]::ReadKey(1)