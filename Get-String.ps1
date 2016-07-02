<#
    The MIT License (MIT)

    Copyright (c) 2016 QuietusPlus

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
#>

function Get-String {
    <#
    .SYNOPSIS
        Returns the defined amount of characters.
    .DESCRIPTION
        Returns the defined amount of characters, starting from either the -First or -Last position.
    .PARAMETER String
        String to process.
    .PARAMETER First
        Amount of characters to return, starting at the first character.
    .PARAMETER Last
        Amount of characters to return, starting at the last character.
    .EXAMPLE
        C:\PS> Get-String 'ABCDEFGHIJKL' -First 4

        Returns the first four characters of the input string: "ABCD".

    .EXAMPLE
        C:\PS> Get-String 'ABCDEFGHIJKL' -Last 4

        Returns the last four characters of the input string: "IJKL".
    #>

    [CmdletBinding()]

    param(
        [Parameter(ValueFromPipeline = $true)]
        [string]
        $String,

        [Parameter()]
        [int16]
        $First,

        [Parameter()]
        [int16]
        $Last
    )

    # Error on -First AND -Last
    if ($First -and $Last) { Write-Error 'Cannot process -First and -Last at the same time.'; break }

    # -First
    if ($First) {
        if ($First -gt $String.Length) { Write-Error '-First cannot be greater than string length.'; break }
        $String = $String.Substring(0, $First)

    # -Last
    } elseif ($Last) {
        if ($Last -gt $String.Length) { Write-Error '-Last cannot be greater than string length.'; break }
        if ($Last -le 0) { Write-Error '-Last cannot be less than zero.'; break }
        $String = $String.Substring($String.Length - $Last, $Last)
    }

    return $String
}
