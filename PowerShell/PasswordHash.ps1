
Add-Type -AssemblyName System.Security;

$code = @"

using System;
using System.Security.Cryptography;
using System.Runtime.CompilerServices;


public class PasswordHasher
{

    public static string HashPassword(string password)
    {

        int saltSize = 0x10;
        int iterations = 0x3e8;

        byte[] salt;
        byte[] buffer2;

        if (password == null)
        {
            throw new ArgumentNullException("password");
        }
        
        using (Rfc2898DeriveBytes bytes = new Rfc2898DeriveBytes(password, saltSize, iterations))
        {
            salt = bytes.Salt;
            buffer2 = bytes.GetBytes(0x20);
        }
        
        byte[] dst = new byte[0x31];
        Buffer.BlockCopy(salt, 0, dst, 1, 0x10);
        Buffer.BlockCopy(buffer2, 0, dst, 0x11, 0x20);
        
        return Convert.ToBase64String(dst);
    }


    

}
"@



Function HashPassword
{

    param (
        [string]$password
    )

    $saltSize = 16;
    $iters = 10000;
    $password = "TEST"

    $hashSize = 32; # 32 bytes

    $salt = New-Object byte[] $saltSize  # 16 byte array


    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $rng.GetBytes($salt)


    $bytes = New-Object System.Security.Cryptography.Rfc2898DeriveBytes("TEST", $salt, $iters)


    $hash = $bytes.GetBytes($hashSize);

    $buffer = New-Object byte[] 49;


    [System.Buffer]::BlockCopy($salt, 0, $buffer, 1, $saltSize);
    [System.Buffer]::BlockCopy($hash, 0, $buffer, 17, $hashSize);


    [System.Convert]::ToBase64String($buffer);

}

Fucntion VerifyPassword
{

    param (

        [string]$PasswordHash,
        [string]$Password

    )





}


