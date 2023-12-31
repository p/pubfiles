# xsecurelock Patches

## More Attempts

Increases the number of authentication attempts from 3 to 9 per
authentication process lifetime.

When authentication process is restarted, keyboard input is lost
(because the input is routed to the previous process).
The number of attempts should be greater than the largest number of attempts
generally needed to successfully authenticate.

## Force Auth

Makes xsecurelock always show the authentication prompt.

This makes it more clear when the locker is accepting keyboard input,
since it takes quite some time for x280 to wake up.
