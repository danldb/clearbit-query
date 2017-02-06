#ClearBit Query

Takes a CSV full of supplier names and attempts to get the logo and domain from clearbit. If multiple companies exist in clearbits database, it will take the domain and logo of the biggest company in terms of employee numbers. Has a very ugly sleep function included to slow down the requests and avoid rate limiting, but the advantage of that is that you don't need a clearbit account key.

Meant to be a one-off use, so probably not for use by anyone else ever. If you do decide to use this, remember that this is a very imperfect program calling an API that is covered in warnings about its own accuracy. Do not make life or death decisions based on this data unless you like accidental death. You have been warned. 

Usage:

* clone this repo and cd into the directory
* run `bundle`
* run `ruby clearbit.rb [path to source file] [path to destination]`

The source file should have a heading 'supplier' and the destination will be a copy of the source with additional headers 'logo' and 'domain'. I made some fixtures in the spec file that could also serve as an example of the required input files, and the resulting output.

You can add terms to the EXTRANEOUS_TERMS constant in Query if you want to sanitize your incoming strings by removing annoying extra words like LTD that cause clearbit to not find the company you seek.
