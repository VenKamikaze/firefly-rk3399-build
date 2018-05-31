I've been working on an SDCard image for the Firefly RK3399 (2GB variant) that boots in conjunction with the Firefly provided eMMC images.

I have flashed a recent eMMC image provided by Firefly on the board (I think approx date of 2018-04-14?), this image will try to find the params & kernel image on the SDCard before it then uses eMMC.

I have only had limited success in my current path. I can get the linux kernel booting, but it hangs after near 2 seconds of bootup messages, always at the same point.

Here is a copy of compiled binary files and some notes I've taken in trying to make this image work. Perhaps it might be useful for someone.

