function Get-ComplexPassword {
    param(
    [int]$length = 16

    )

    $charlower = 'abcdefghikmnprstuvwxyz'
    $charupper = 'ABCDEFGHKLMNPRSTUVWXYZ'
    $nums = '23456789'
    $symbs = '$%&/()=?*+#'

    #Generate Random lowercase
	$random = 1..([math]::Round($length/4)) | foreach { Get-Random -Maximum $charlower.Length}
    $private:ofs=""
    $password = [string]$charlower[$random]

    #Generate Random Uppercase
	$random = 1..([math]::Round($length/4)) | foreach { Get-Random -Maximum $charupper.Length}
    $private:ofs=""
    $password += [string]$charupper[$random]

    #Generate Random Uppercase
	$random = 1..([math]::Round($length/4)) | foreach { Get-Random -Maximum $nums.Length}
    $private:ofs=""
    $password += [string]$nums[$random]

    #Generate Random Uppercase
	$random = 1..([math]::Round($length/4)) | foreach { Get-Random -Maximum $symbs.Length}
    $private:ofs=""
    $password += [string]$symbs[$random]

    #Generate One additional random character
    $full = $charlower + $charupper + $nums + $symbs
    $random = 1..1 | foreach { Get-Random -Maximum $full.Length}
    $private:ofs=""
    $password += [string]$full[$random]
	
    if ($password.Length -lt ($length + 1)){
        
        Do{
        #Generate One additional random character
        $full = $charlower + $charupper + $nums + $symbs
        $random = 1..1 | foreach { Get-Random -Maximum $full.Length}
        $private:ofs=""
        $password += [string]$full[$random]
        }

        Until ($password.Length -eq ($length + 1))
    }
    elseif ($password.Length -gt ($length + 1)){
        Do{
        $number = $password.length -1
	    $random = Get-Random -InputObject (0..$number) -Count $number       
        $private:ofs=''
	    $password = [String]$password[$random]
        }
        Until ($password.Length -eq ($length + 1))

    }	


    #Randomize the contents of the generated password
	$number = $password.length -1
	$randomize = Get-Random -InputObject (0..$number) -Count $number
    
   	$private:ofs=''
	[String]$password[$randomize]


    


}