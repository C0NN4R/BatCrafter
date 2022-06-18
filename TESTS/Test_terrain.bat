
@Echo Off
Set "Variable=Hello"
:: On definit la variable.
Echo Variable~0 = "%Variable:~0%"
Echo Variable~0,4 = "%Variable:~0,4%"
Echo Variable~1 = "%Variable:~1%"
Echo Variable~4 = "%Variable:~4%"
Echo Variable~1,1 = "%Variable:~1,1%"
Echo Variable~-3 = "%Variable:~-3%"
Pause>Nul
Exit