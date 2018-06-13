

# Byte arrays

$randArray = New-Object byte[] 16  # 16 byte array

$bytes = [byte[]](16,17,18) # will generate a 3 byte array


$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()


$rng.GetBytes($randArray)

$randArray


