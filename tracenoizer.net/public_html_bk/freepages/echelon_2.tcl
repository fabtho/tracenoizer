

#!/usr/bin/tclsh
#echelon.tcl, text generator for echelon regression testing (21 oct 1999)
#
# ADMechelon-lagger project (ref: http://www.echelon.wiretapped.net/)
# most keywords from: http://www.attrition.org/attrition/keywords.html
# most phrases from: http://www.echelon.wiretapped.net/echelon.cgi
# tcl code by ADMcrack@adm.freelsd.net
#

set main {
[header]
[of hello] [of {} {[one grif]}]
[of {} {\nFrom: [one addr]}][of {} {\nTo: [one addr]}]

 [one text]

 [one keywords][of ps]
}regsub -all "\n" {
  UMBRA, GAMMA, NOFORN, ORCON, KILTING, VORTEX, MERINO, WORM, MP5K-SD, Tesla, WINGS, cdi, DynCorp, UXO, Ti, THAAD, package, chosen, PRIME, SURVIAC, MAGNUM, RHYOLITE, AQUACADE, CHALET, EG&G, AIEWS, AMW, Halibut, SONANGOL, Loin, IDP, IDF, SBIRS, SGDN, ADIU, DEADBEEF, NB, CBM, CTP, Sardine, SIN, advisors, SAP, OAU, 312, SVR, NIMA, MOIS, UOP, SSCI, MSW, Spyderco, SISMI, FIS, advise, TUSA, HoHoCon, JITEM, SADF, roglegs, IBf, BfV, FSB, SISDE, BND, FBIS, Chobetsu, Armani, BOSS, NSP, SRI, Ronco, GSS, RUOP, GRU, IRS, INS, INR, ISI, package, Patel, snuffle, Glock 26, NRO, Red Cell, USP, PCS, bank, EUB, sardine, USP, H&K, niche, Soros, Standford, Cohiba, Majestic
 LUK, Templeton, Yukon, eternity server, Skytel, Lynch, Pixar, IRIDF, Delta, TWA, Kiwi, Nike, Atlas, Whitewater, plutonium, BATF, SGDN, mailbomb, Chelsea, virus, anarchy, rogue, fraud, assasinate, E.T., credit
 card, b9, ESN, COS, cocaine, Roswell, illuminati, president, freedom, government, hate, speedbump, 1984, Flintlock, cybercash, DSD, BVD, Pine Gap, Menwith, Mantis, veggie, 3848, Morwenstow, Consul, Oratory, Geraldton, UKUSA, 8182, Gatt, Platform, 1911, Yakima, Sugar Grove, Cowboy, Gist, VLSI, mega, Leitrim, Pseudonyms, MITM, Gray Data, Alica, SHA, Global, gorilla, Bob, utopia, orthodox, market, Stego, unclassified, SABC, garbage, screws, Black-Ops, Area51, Dolch, secure shell, virtual, Delta
 Force, SEAL, fissionable, Sears Tower, NORAD, FBI, Panama, Planet-1, cryptanalysis, nuclear, Satellite phones, ABC, Propaganda, Blackmednet, 3, bullion, supercomputer, Fort Meade, Uzi, SDI, jihad, Texas, plutonium, KLM, Blackbird, Middleman, Blacknet, SGI, SUN, MCI, crypto-anarchy, AT&T, SWAT, Ortega, Digicash, zip, e-cash, Bubba the Love Sponge, wire transfer, Indigo, press-release, Ft. Meade, Glock, Blowfish, Gorelick, Salsa, M72750, Dead, GRU, Zen, World Domination, Weekly World News, CdC, CUD, TDYC, W3, Retinal Fetish, Blacklisted 411, Internet Underground, XS4ALL, CCC, Virii, botux, CTU, Hillal, GGL, mol, Wackendude, EO, Wackenhutt, Rand
 Corporation, SAR, Keyhole, Minox, S.A.I.C., SBI, DSS, ANC, zone, SORO, M5, Austin, Comirex, GPMG, Speakeasy, humint, GEODSS, Becker, Nerd, fangs, primacord, RSP, GSA, Kilo Class, squib, OSS, Blowpipe, CCS, racal, OTP, SEMTEX, penrep, sigvoice, ssa, E.O.D., loch, Ingram Mac-10, Locks, industrial intelligence, H.N.P., Juiliett Class
 Submarine, PI, TSCI, industrial, espionage, counterintelligence, sneakers, NATOA, DES, NATIA, Nuclear, quiche, codes, chaining, Sex, Anonymous, Playboy, AVN, Pornstars, FLAME, explicit, RX-7, redheads, replay, remailers, TRW, Coderpunks, Cypherpunks, force, Satellite imagery, Asset, SWS, 1080H, Harvard, VIP, Audiotel, TELINT, sweeping, TDR, TRD, Medco, sweep, SIG, Protection, Macintosh Security, 50BMG, Mossberg, top secret, M.P.R.I., CRA, pink noise, white noise, Fax encryption, finks, Fax, Porno, ETA, Embassy, CSE, MSEE, Time, RIT, 69, MIT, MSCJ, NTT, SLI, PBX, TIE, Tie-fighter, Rolm, SL-1, NTT, Merlin, EOD, Oscor, ISA, ASIS, ninja, stakeout, Cap-Stun, Mace, Event Security, executive, Alouette, Chan, CEO, Competitor, Covert Video, POCSAG, IMF, FXR, FX, Trump, Talent, Spoke, Reflection, Stephanie, Sphinx, B.D.M., Vinnell, Juile, Jasmine, Hollyhock, Iris, Egret, Daisy, Cornflower, Badger, Artichoke, Kilderkin, Keyhole, Mole, Ionosphere, Guppy, Gorizont, Gamma, Capricorn, Broadside, Amherst, SETA, rhosts, rhost, COCOT, interception, debugging, eavesdropping, spies, Counterterrorism, MI-17, Electronic Surveillance, Security Evaluation, High
 Security, Security Consulting, TSCM, ASLET, ASIS, PPS, sniper, Police, Corporate
 Security, Rapid Reaction, Counter Terrorism Security, NVD, CQB, afsatcom, argus, nkvd, Clandestine, Bletchley Park, enigma, M-14, Pretoria, nitrate, 15kg, smuggle, domestic disruption, Colonel, WANK, SASP, SHF, UHF, VHF, MF, ELF, TELINT, SUSLO, TDM. SUKLO, SIGDASYS, RFI, PTT, PSAC, NACSI, SIGDEV, LRTS, GRU, FDM, DSD, DF, DEVGRP, DREC, MP5k, S.E.T. Team, ARC, VIP, SERT, D-11, grom, Psyops, RAID, Duress, Halcon, NOCS, CIO, Recce, Spetznaz, SADMS, Shayet-13, Kh-11, 757, MI6, MI5, MYK, MDA, MD4, MD2, Dictionary, Echelon, STEP, BBE, EADA, GEOS, SAS, 22d, GSG-9, SASR, GRU, RCMP, CTU, CONUS, CQB, Exon Shell, GIGN, AT, Forte, Masuda, GEO, DOE, GOE, UDT, SBS, SAS, EDI, HIC, NSG, AMEMB, SORT, DITSA, GCHQ, 868, FKS, HAHO, HALO, DCJFTF, BECCA, SACLANT, SHAPE, DRA, CDA, DREO, CFC, UNCPCJ, SGC, DJC, ISN, CIM, SIRC, CISE, USCODE, SEL, NTIS, HPCC, FMS, DOE, CDC, NRC, USCG, USACIL, LABLINK, ARPA, AHPCRC, USAFA, NSWC, NAVWCWPNS, RL, NRL, NAVWAN, BMDO, AFSPC, ACC, NIJ, FLETC, FINCEN, BOP, CID, USCOI, DIA, HRT, Flashbangs, Lacrosse, FLiR, SCIF, NSCT, Lexis-Nexis, NRO, ICE, Lebed, ASIO, Secure, Verisign, spook words, NCSA, ISACA, Investigation, jack, Sundevil, Archives, Freeh, Bubba, Infowar, Flame, Scully, Military Intelligence, Telex, Steve Case, Meta-hackers, Mavricks, DERA, LLC, Compsec, CIDA, CBNRC, CANSLO, BZ, BRLO, VNET, UTU, LEETAC, ReMOB, JICC, JANET, UT/RUS, IACIS, HTCIA, FCIC, E911, DATTA, COSMOS, BITNET, 3B2, STARLAN, AIMSX, CBOT, CIS, AOL TOS, AOL, bet, MSNBC, Perl-RSA, RSA, PEM, PGP, Mayfly, NCCS, Undercover, White House, Military, Defcon, USSS, Secret Service, FBI, SSL, S/Key, CIA, NSA, USDOJ, Espionage, Hackers, Encryption, DefCon V, Passwords, ISS, Secure Internet Connections, Firewalls, Computer
 Terrorism, Compsec, Reno, InfoSec, National Information Infrastructure, Offensive Information Warfare, Offensive Information, Information Warfare, Defense, Terrorism Defensive Information, Information Terrorism, Priavacy, IS, IW, Information Warfare, 

} {} keywords
regsub -all {, } $keywords , keywords
set keywords [join [split $keywords ,] "\n"]

set grif {
  NOFORN-ORCON
  Intelligence Report
  GAMMA Item
  UMBRA
  Important
  Secret
  Top Secret
  National Security Action Memorandum
  For Your Eyes Only
  Classified
  Proprietary
  US Government
  Not For Public Release
  }
 
 
 
 set 1st_name {
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  Yosy
  Stevie
  Frank
  Arnold
  Ivan
  Bob
  George
  John
  William
  Alan
  Tony
  Larry
  Perry
  Scott
  Chris
  Ronald
  Ken
  Harry
  Richard
  David
  Joseph
  Michael
  Edwin
  Barry
  Frank
  }

set 2nd_name {
  Richards
    Dickinson
    Igels
    Ivanov
    Swartz
    Fritz
    Keily
    Williamson
    Perry
    Killer
    Hafich
    Stotts
    Brotherton
    Kelley
    Jackson
    Johnson
    Benett
    Swedberg
    Casserino
    }


set 3rd_name {

 {} {} {} {} {} A. B. C. D. E. F. G. H. I. J. K. L. M. N. O. P. Q. R. S. T. U.
 
 
}

set lev1 {
  Major
    {Lt Colonel}
    {Lieutenant Colonel}
    Lt General
    Colonel
    }



set lev2 {
  exCommande 
   {Vice Commander} 
   Inspector Commander 
   {Deputy Director} 
   {Chief of Staff} 
   Director 
   }

set dept {
  HQ Consolidated Space Test Center (HQ CSTC)
    United States National Security Council
    United States Joint Chiefs of Staff
    Tactical Information Broadcasting Service (TIBS)/Tactical Receiver and Related Applications (TRAPS) Data Dissemination System (TDDS) (TIBS/TDDS)
    TACCSF (Theater Air Command & Control Simulation Facility, Kirtland AFB, NM)
    STRATCOM (US Strategic Command, Omaha, NE)
    Office of the [of {Vice President} President] of the United States of America
    NSWC (Naval Surface Warfare Center, Dahlgren, VA)
    Joint Defence Space Research Facility
    Joint National Test Facility
    [rand 800 50]th Communications Squadron Commander, USAF
    [rand 300 50]th Space Group, USAF
    [rand 300 50]th Mission Support Squadron
    [rand 50 4]th Space Operations Squadron, USAF
    Intelligence and Security (IGIS)
    Departament of Justice
    Federal Emergency Management Agency
    Federal Bureau of Investigation
    US Defence Intelligence Agency
    National Security Agency
    Security Awareness Division (M56)
    }

set addr {[of lev1], [one dept]
 [of lev1] [of 1st_name] [of 3rd_name] [of 2nd_name], [of lev2], [one dept]
 [of lev1] [of 3rd_name] [of 2nd_name], [of lev2], [one dept]
 [of lev1] [of 1st_name] [of 3rd_name] [of 2nd_name], [one dept]
 [of lev1] of [of lev2], [one dept]
 [of lev2] of [one dept]
 [one dept]
 
 }


set place {
  Moscow suburbs {Fort Meade}
    {[of country]}
    {[of country]}
    {[of country]}
    Nurrungar
    Chicago
    Dallas
    Washington
    {Los Angeles}
    {New York}
    }

set when {
  after the satellite has passed over
   when you least expect it
   this morning
   next month
   soon
   about [rand 20 4] hours
   in a couple of days time
   just as everybodys sitting down for [of {Christmas dinner} {thanksgiving}]
   tomorrow
   next week
   as that year 2000 thing really heats up
   on January 1st
   }

set time {
 last night
 this night
 this morning
 today
 yesterday
 last monday
 [rand 14 2] days ago
 [rand 4 1] months ago
}



set person {
  President
   Al Amn al-Askari
   Xu Yongyue
   Khalfan Khamis Mohamed
   Usame bin Laden
   Ayman Al Zawahiri
   }

set who {
  [one person]s people 
   [one ss] guys 
   INFOSEC 
   islamic fundamentalists 
   Teams up to date from the training facility 
   SIGINT from the KWT-46 
   members of the holy revolutionary front 
   Supreme Assembly of the Islamic Revolution in Iraq (SAIRI) 
   Cypherpunks 
   copycat Unabomber 
   }

set os {
 {
 Windows NT
 Linux
 Windows 2000
 CISCO
 Cray UNICOS
}
 


set net {
  [one person]s people 
   [one ss] guys 
   INFOSEC 
   islamic fundamentalists 
   Teams up to date from the training facility 
   SIGINT from the KWT-46 
   members of the holy revolutionary front 
   Supreme Assembly of the Islamic Revolution in Iraq (SAIRI) 
   Cypherpunks 
   copycat Unabomber 
   high profile 
   important 
   NAVAL 
   *.mil 
   *.gov 
   gchq.gov.uk 
   nasa.gov 
   ARPANET 
   SIRPNet 
   }



set sigint {
  [one person]s people
    [one ss] guys
    INFOSEC
    islamic fundamentalists
    Teams up to date from the training facility
    SIGINT from the KWT-46
    members of the holy revolutionary front
    Supreme Assembly of the Islamic Revolution in Iraq (SAIRI)
    Cypherpunks
    copycat Unabomber
    high profile
    important
    NAVAL
    *.mil
    *.gov
    gchq.gov.uk
    nasa.gov
    ARPANET
    SIRPNet
    LASINT
    RADINT
    ELINT
    COMINT
    SIGINT
    }

set thing {
  to lauch Internet smurf attack against [one ss] [one when]
    to use [one ss] s [of DES IDEA RSA DH CAST] breaking machine
    to build quantum computers and break [of RSA DH] keys
    to sponsor development of new criptography algorithm
    to kill [one person] as they pass through Washington after the satellite has passed over.
    lost [one what] somewhere in [of place] [one time]
    to spread Sarin somewhere at [of place] s metro
    to rob bank at [of place] [one time]
    to pass the [one what] to a [one ss] [of worker] stationed in [of place] [one when]
    to create some domestic disruption [of place] [one when]
    to incite the masses [one thing]
    to hack into the Virtual Data Center (VDC) Network from an insecure dialin in [of place] [one when]
    to break [one person] out of federal custody and get him to [of place] [one when]
    to start a crypto-anarchy jihad (holy war) on the [one ss] boys stationed in [of place] [one when]
    broadcast this morning
    to hook-up with the [one ss] defector in hiding in [of place] [one when]
    to sell details of the updated AFIWC COMPUSEC plans to the [of place] diplomat in [of place] [one when]
    bring the DF, ZARK, SERT, VIP, ARC and S.E.T
    to inflict minimal casualties on [one ss] personnel at [of place] [one when]
    to get some Information Terrorism going, primarily from the [one ss] in [of place] [one when]
    to wiretap the T1 coming out of the [one ss] in [of place] [one when]
    to destroy [of sigint] capabilities operating in [of place] [one when]
    to get the layout of the M51 Physical Security Division into the diplomatic bag out of The White House [one when]
    fly out to [of place] [one when]
    meet up with the GSG-9 defectors in [of place] [one when]
    to hijack a 747 out of [of place]
    to drive a tanker full of fertiliser and diesel across the border from Mexico
    to use the [one os] backdoor on some [one net] nodes
    released a manifesto [one when]
    a meeting set up in [of place] [one when]
    to pass the counterfeit notes to the [one ss] [of worker] working out of [of place]
    press conference in [of place]
    release approximately a kilogram of botulinum toxin into the water supply in [of place]
    }



set what {
  weapon papers) dangerous chemicals key codes [one grif] documents important gears documents }

set do {
  You have got
   Theyve no choice other than
   I heard they were going
   We found plans on him about
   Those damn [one who]
   They are going
   There is a planned
   They have
   }

set ss {
  Spetznatz
   BATF
   NSA
   850th Communications Squadron
   [one who]
   Tactical Information Broadcasting Service
   DoJ
   GRU
   DoD
   MI-6
   Siemens
   DEA
   CIA
   MOSSAD
   Secret Service
   }

set worker {
  guy {deep cover agent} officer informer defector agent commander }

set threat {
  threat
  
   An [of country] diplomat is well positioned [one thing]
  
   [one person] just got picked up [one time] by our agents.
  
   [one person] made broadcast [one time]. [one do] [one thing]
  
   [one person] plan [one thing]
  
   Gotta hand it to the [one ss] guys - turns out the group were going [one thing]
  
   The [of worker] we have inside the [one ss] says they are planning [one thing]
  
   The [of worker] in the [one ss] passed on some new information
  
   The defector inside [one ss] cabled us [one when]
  
   The [one ss] boys are kidding themselves if they think they can get away with it
  
   You should pay the [one ss] agent so he can get on with the job! He has got [one thing]
  
   If we are to succed in halting the [one who] community, theres no better time than now [one thing] then [one thing]
  
   [one do] [one thing]
  
   [one who] suggests that theyre being blackmailed
  
   Never underestimate the [one who] - they resolved [one thing]
  
   A [one who] sent in a threat [one when] [one thing]
  
   As [one who], we must [one thing]
  
   Finally, we got that info about [one ss], you will receive it [one when]
  
   }

set country {
  UAE Yemen Syria {United Arab Emirates} Qatar {Saudi Arabia} Oman Libya Lebanon Kuwait Iraq Bahrain Pakistan Japan India Australia Italy Korea China Greece England France Germany USA Russia Afganistan Cuba Israel Iraq }

set text {
 [upcase [one threat]].
 [upcase [one threat]]..
 [upcase [one threat]]. Further to that, [one text]
 [upcase [one threat]]. Additionally, [one text]
 [upcase [one threat]]. Also, [one text]
 [upcase [one threat]].\nbtw.\n[one text]
 [upcase [one threat]]. Finally, [one threat].
}

set ps {
 {[pgp]} {[pgp]} {[pgp]} {[pgp]} {[pgp]} {[pgp]} {} {} {} {} {} {} {\n} {\n\n}
 {[attachment]} {[attachment]} {[attachment]} {[attachment]} {[attachment]}
 {\nps. Don't keep this mail} {\nps. Do not go back to your house\n\n\n\n}
 {\nps. Did not reply to me back!} {\nps. Don't try to contact me\n\n}
 {\nNext keyword: [one keywords]} {\n\nDo not back to safehouse of course\n}
 {\t[of ORE WTP] [of 97 98 99]-100[rand 100 10][of X CX]}
}

set hello {
 {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {#[rand 999 99]th:\n}
 {See what I got [one time]:\n} {\n\n\n=====================================\n}
 {Sure, you will interested in this:\n\n------------------------------------\n}
 {That what i got from [one ss]:\n} {[of worker] sent me today:\n}
}

#MINSTD random generator (ref: ftp://ftp.inria.fr/prog/libraries/random.c.Z)
set rand_seed 1999
set rand_xor 0
proc rand {max {add 0}} {
global rand_seed rand_xor
 set hi [expr {$rand_seed / 127773}]
 set lo [expr {$rand_seed % 127773}]
 set rand_seed [set test [expr {16807 * $lo - 2836 * $hi}]]
 if {$test <= 0} {incr rand_seed 2147483647}
 set r [expr {($rand_seed % $max + $rand_seed / 65535) ^ $rand_xor}]
 return [expr {$add + ( $r % $max)}]
}

proc rand-urandom {} {
global rand_xor
 if {[catch {
  set f [open /dev/urandom r]
  scan [read $f 3] {%c%c%c} a b c
  close $f
  set rand_xor [expr {$a + ($b << 8) + ($c << 16)}]
 }]} {
  if {[info exists f]} {catch {close $f}}
 }
}

proc rep {s n} {
 for {set a {}} {$n} {incr n -1} {append a $s}
 return $a
}

proc rchar {s} {return [string index $s [rand [string length $s]]]}

set b64 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/
set pgp_crc 0x0b704ce
proc base64 {args} {
global b64 pgp_crc
 set l 0
 foreach i $args {
  set i [expr {$i}]
  set pgp_crc [expr {$pgp_crc ^ ($i << 16)}]
  for {set j 0} {$j < 8} {incr j} {
   if {[set pgp_crc [expr {$pgp_crc << 1}]] & 0x1000000} {
    set pgp_crc [expr {$pgp_crc ^ 0x1864cfb}]
   }
  }
  append o [string index $b64 [
   switch [expr {$l % 3}] {
    0 {expr {$i >> 2}}
    1 {expr {(($p & 0x03) << 4) | (($i & 0xF0) >> 4)}}
    2 {expr {(($p & 0x0F) << 2) | (($i & 0xC0) >> 6)}}
   }
  ]]
  if {($l % 3) == 2} {append o [string index $b64 [expr {$i & 0x3F}]]}
  set p $i
  incr l
 }
 append o [switch [expr {$l % 3}] {
  1 {set a A==}
  2 {set a ==}
 }]
 return $o
}

proc pgp {} {
global b64 pgp_crc
 set pgp_crc 0x0b704ce
 append a \"\n-----BEGIN PGP MESSAGE-----\n\"
 append a \"Version: 2.6.[rand 3 1]\n\n\"
 set len [rand 1000 200]
 append a [base64 0x84 [rand 256] [rand 256]]
 for {set n 4} {$n < $len} {incr n 4} {
   if {!($n % 64)} {append a \"\n\"}
   append a [base64 [rand 256] [rand 256] [rand 256]]
 }
 set c1 [expr {($pgp_crc >> 16) & 255}]
 set c2 [expr {($pgp_crc >> 8) & 255}]
 set c3 [expr {($pgp_crc) & 255}]
 append a \"\n=[base64 $c1 $c2 $c3]\n\"
 append a \"-----END PGP MESSAGE-----\n\"
 return $a
}

set ksusp {
 blast hack attack takeover hijack kill frame track strike burn rape alert
 break report tracking info
}

set attach {
 {[of place]-[of ksusp]}
 {[one ss]} {[one ss]-[of ksusp]}
 {[one keywords]} {[one keywords]-[of ksusp]}
 {[of sigint]-[of ksusp]}
}

proc attachment {} {
 set f [of attach].[of arj ARJ zip ZIP tgz tar.gz tar.Z]
 set len [rand 1000 500]
 append b \"\n--[rand 2147483647 214748364]-8[rand 99999999 10000000]-\"
 append b \"9[rand 99999999 10000000]=:$len\n\"
 append a \"\n$b\"
 append a \"Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=\\"$f\\"\n\"
 append a \"Content-Transfer-Encoding: BASE64\n\"
 append a \"Content-Disposition: ATTACHMENT; FILENAME=\\"$f\\"\n\"

 for {set n 0} {$n < $len} {incr n 4} {
   if {!($n % 76)} {append a "\n"}
   append a [base64 [rand 256] [rand 256] [rand 256]]
 }
 append a \"$b\"
}

set dom {mil MIL org ORG net com gov GOV}
set subject {
 Re: [one what]
 Re: [one ss]
 Re: [one keywords]
 [one keywords]
 [one ss] ALERT!
 [one dept] info
}

proc header {} {
 set td [clock format [clock seconds] -gmt 1 -format {%a, %d %b %Y %T +0000}]
 set tid [clock format [clock seconds] -gmt 1 -format {%Y%m%d%H%M}]
 regsub -all {[ ,&/]} [one keywords] {} f
 regsub -all {[ ,&/]} [one keywords] {} t
 foreach w [rep . [rand 3 1]] {append mf [base64 [rand 255] [rand 255] [rand 255]].[of dom]}
 foreach w [rep . [rand 3 1]] {append mt [base64 [rand 255] [rand 255] [rand 255]].[of dom]}
 set id [rchar ABCDEF][rep [rchar ABCDEF] 2]10[rand 900 100]
 set l [of localhost $mf [rand 174 24].[rand 255].[rand 255].[rand 254 1]]
 append a \"Received: (from $f@$l) by $mf (8.[of 9 8 9].[rand 6]/8.8.[rand 9]) od $id for $t@$mt; $td\n\"
 append a \"Date: $td\n\"
 append a \"From: $f <$f@$mf>\n\"
 append a \"Message-Id: <$tid.$id@$mf>\n\"
 append a \"To: $t@$mt\n\"
 append a \"Subject: [one subject]\n\"
}

proc one {array} {
 global $array
 set things [split [set $array] \"\n\"]
 set max [llength $things]
 if {$max == 2} {return (...)}
 set n [expr {[rand [expr {$max - 2}] 1]}]
 set a [string trimleft [subst [lindex $things $n]]]
 set $array [join [lreplace $things $n $n] "\n"]
 return $a
}

proc of {args} {
 set things [if {[llength $args] == 1} {global $args; set $args} {set args}]
 set max [llength $things]
 set x [lindex $things [expr {[rand $max]}]]
 return [string trim [subst $x] " "]
}

proc upcase {text} {
 return [string toupper [string index $text 0]][string range $text 1 end]
}

if {![llength $argv]} {
 puts \"Text generator for echelon regression test\"
 puts \"Usage: $argv0 <seed_number>\"
} {
 if {[file exists /dev/urandom] && [file readable /dev/urandom]} rand-urandom
 incr rand_seed [lindex $argv 0]
 catch {puts stdout [subst $main]}
}

\#end
