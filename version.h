/*
 *      $Id: version.h,v 1.2 2005/06/07 05:38:12 richardh Exp $
 */

/*
[name rule]

	v.[a].[b].[c].[d].[e][f]

 	- v: version
	- [a]: Model(note1)
 	- [b]: Realtek release adk/cmd/sdk version(note2)
 	- [c]: AboCom source code base(if Realtek release v1.1a, 1 means "a"; v1.1c, 3 means "c"...and so on)
 	- [d]: Vendor(note3)
 	- [e]: release
 	- [f]: language(note4)

	[note1]
	"2": WAP252
	"3": WAP253
	"4": WR254

	[note2]
	adk/cmk/sdk v1.1 means "1"
 	adk/cmk/sdk v1.2 means "2"

	[note3]
	vendor:
	"0": Generic(Synnex)
  	"1": AboCom
  	"2": OSLink
  	"3": OvisLink
  	"4": PCI(Planex)
  	"5": Hawking
  	"6": ZyXEL

	[note4]
	"e":  english
	"j":  japanese
	"k":  korean
	"sc": simplified chinese
	"tc": tranditional chinese
*/

#define FW_VERSION "v3.2.1.3.7e"