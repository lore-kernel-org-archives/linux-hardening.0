Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A351F60A;
	Tue, 25 Feb 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469099; cv=none; b=ZRlIvAGXwa6cuqrmebPxMnYowRiamEhHHoqiaE/27KQ9Cl0iGV02W157eKedartJDnkOKTkAn1Q40MtAwEdmF7ToHIpOC6T0GcvC/+K2SCAK3prThIIi1WDPJMufPQyq7E+ZXhjf93AoquZqIOhl77N10VMOHCHzvVQpmLpJLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469099; c=relaxed/simple;
	bh=tT2niTwoBYVO9mGuyqYE+01wPaaljZ/pBtsqLp/zrzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mA7HnVXIwf9EW2dSOQVesh2IcHIO324+QiGznued+evlSF7A/+NhrU4Fc5IyqHcEmR6w+7sZMW35h+we+caKo7pJJZz3MW3ce8zavHJ2HQfzHILlngDtSOj5utLGD2DcOg9u15mYc6as9KRQe18/1lA0C8PDKxZsQU1ETeyLwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZByzwb7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZByzwb7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694ECC4CEDD;
	Tue, 25 Feb 2025 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740469098;
	bh=tT2niTwoBYVO9mGuyqYE+01wPaaljZ/pBtsqLp/zrzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZByzwb7AkfjiAxqbq1rGLo/1zHFCiiPZY2beJFXyCwCoB5EYAV7U0and0NjMZZxhd
	 NqQYkMNWgg4kWgCsQJdsq7IwwG2pR8vMulfH7BfqfJ4jjybwBUzZHWt1Ln80qX/Xga
	 O3RlTZFh0xQny12Iu1+4zqC0x0RrFWaG/k5Wo+WUInXsuaG24tmkF+LvsFSD/lXZXR
	 z6l9+mvEGxsnzfgiGa7HLcsZZtcooGS30viMaS0PTdfwd9w8pohCUXZXvdTdmSN1IW
	 wv3l2mciX25yW55nWKWmARZOj96ouX8/rm6saKQ6pF2IrkUGjYU/J1r+voK+BkPMUZ
	 DnFVoSESssflg==
Date: Tue, 25 Feb 2025 08:38:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/39] scripts/kernel-doc.py: add a Python parser
Message-ID: <20250225083814.51975742@foz.lan>
In-Reply-To: <87v7sy29rh.fsf@trenco.lwn.net>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
	<3905b7386d5f1bfa76639cdf1108a46f0bccbbea.1740387599.git.mchehab+huawei@kernel.org>
	<87v7sy29rh.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Mon, 24 Feb 2025 16:38:58 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > Maintaining kernel-doc has been a challenge, as there aren't many
> > perl developers among maintainers. Also, the logic there is too
> > complex. Having lots of global variables and using pure functions
> > doesn't help.
> >
> > Rewrite the script in Python, placing most global variables
> > inside classes. This should help maintaining the script in long
> > term. =20
>=20
> [...]
>=20
> > diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> > new file mode 100755
> > index 000000000000..5cf5ed63f215
> > --- /dev/null
> > +++ b/scripts/kernel-doc.py
> > @@ -0,0 +1,2757 @@
> > +#!/usr/bin/env python3
> > +# pylint: disable=3DR0902,R0903,R0904,R0911,R0912,R0913,R0914,R0915,R0=
917,R1702
> > +# pylint: disable=3DC0302,C0103,C0301
> > +# pylint: disable=3DC0116,C0115,W0511,W0613
> > +# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
> > +# SPDX-License-Identifier: GPL-2.0 =20
>=20
> The SPDX tag is supposed to be up top, right under the shebang

I'll move it.=20

>=20
> I also think you should give consideration to preserving the other
> copyright notices in the Perl version.  A language translation doesn't
> remove existing copyrights...who knows how much creativity went into
> some of those regexes?

Makes sense, but the copyrights at kernel-doc.pl:

	## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
	## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
	## Copyright (C) 2001  Simon Huggins                             ##
	## Copyright (C) 2005-2012  Randy Dunlap                         ##
	## Copyright (C) 2012  Dan Luedtke                               ##
	##                                                               ##
	## #define enhancements by Armin Kuster <akuster@mvista.com>     ##
	## Copyright (c) 2000 MontaVista Software, Inc.                  ##
	#
	# Copyright (C) 2022 Tomasz Warnie=C5=82=C5=82o (POD)

Also doesn't preserve all copyrights from people that worked hard to
maintain it all over those years.

A quick check with git log shows 68 different authors touching it
(didn't check how trivial/hard were the changes):

$ git log --follow --pretty=3D"%an" scripts/kernel-doc.pl|sort|uniq -c|sort=
 -n
      1 Alexander A. Klimov
      1 Alexander Lobakin
      1 Anna-Maria Behnsen
      1 Bart Van Assche
      1 Chen-Yu Tsai
      1 Coco Li
      1 Dan Luedtke
      1 Donald Hunter
      1 Gabriel Krisman Bertazi
      1 Greg Kroah-Hartman
      1 Harvey Harrison
      1 Horia Geanta
      1 Jason Gunthorpe
      1 J=C3=A9r=C3=A9my Bobbio
      1 Johannes Weiner
      1 Jonathan Cameron
      1 Kamil Rytarowski
      1 Laurent Pinchart
      1 Levin, Alexander (Sasha Levin)
      1 Linus Torvalds
      1 Lucas De Marchi
      1 Mark Rutland
      1 Masahiro Yamada
      1 Michal Wajdeczko
      1 Niklas S=C3=B6derlund
      1 Nishanth Menon
      1 Peter Maydell
      1 Pierre-Louis Bossart
      1 Randy.Dunlap
      1 Richard Kennedy
      1 Rich Walker
      1 Rolf Eike Beer
      1 Silvio Fricke
      1 Utkarsh Tripathi
      1 valdis.kletnieks@vt.edu
      1 Will Deacon
      2 Ilya Dryomov
      2 Jakub Kicinski
      2 Jason Baron
      2 Jonathan Neusch=C3=A4fer
      2 Markus Heiser
      2 Pavan Kumar Linga
      2 Pavel Pisa
      2 Sakari Ailus
      2 Yacine Belkadi
      2 Yujie Liu
      3 Akira Yokosawa
      3 Andr=C3=A9 Almeida
      3 Andy Shevchenko
      3 Ben Hutchings
      3 Borislav Petkov
      3 Conch=C3=BAr Navid
      3 Daniel Santos
      3 Danilo Cesar Lemes de Paula
      3 Mike Rapoport
      4 Daniel Vetter
      4 Matthew Wilcox
      5 Martin Waitz
      5 Paolo Bonzini
      6 Aditya Srivastava
      6 Vegard Nossum
      7 Kees Cook
     11 Johannes Berg
     11 Tomasz Warnie=C5=82=C5=82o
     20 Jonathan Corbet
     32 Jani Nikula
     57 Mauro Carvalho Chehab
     65 Randy Dunlap

So, picking the latest e-mails from the above authors, maybe we can add
some credit lines like these:

# Converted from the kernel-doc script originally written in Perl
# under GPLv2, copyrighted since 1998 by the following authors:
#
#    Aditya Srivastava <yashsri421@gmail.com>
#    Akira Yokosawa <akiyks@gmail.com>
#    Alexander A. Klimov <grandmaster@al2klimov.de>
#    Alexander Lobakin <aleksander.lobakin@intel.com>
#    Andr=C3=A9 Almeida <andrealmeid@igalia.com>
#    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
#    Anna-Maria Behnsen <anna-maria@linutronix.de>
#    Armin Kuster <akuster@mvista.com>
#    Bart Van Assche <bart.vanassche@sandisk.com>
#    Ben Hutchings <ben@decadent.org.uk>
#    Borislav Petkov <bbpetkov@yahoo.de>
#    Chen-Yu Tsai <wenst@chromium.org>
#    Coco Li <lixiaoyan@google.com>
#    Conch=C3=BAr Navid <conchur@web.de>
#    Daniel Santos <daniel.santos@pobox.com>
#    Danilo Cesar Lemes de Paula <danilo.cesar@collabora.co.uk>
#    Dan Luedtke <mail@danrl.de>
#    Donald Hunter <donald.hunter@gmail.com>
#    Gabriel Krisman Bertazi <krisman@collabora.co.uk>
#    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
#    Harvey Harrison <harvey.harrison@gmail.com>
#    Horia Geanta <horia.geanta@freescale.com>
#    Ilya Dryomov <idryomov@gmail.com>
#    Jakub Kicinski <kuba@kernel.org>
#    Jani Nikula <jani.nikula@intel.com>
#    Jason Baron <jbaron@redhat.com>
#    Jason Gunthorpe <jgg@nvidia.com>
#    J=C3=A9r=C3=A9my Bobbio <lunar@debian.org>
#    Johannes Berg <johannes.berg@intel.com>
#    Johannes Weiner <hannes@cmpxchg.org>
#    Jonathan Cameron <Jonathan.Cameron@huawei.com>
#    Jonathan Corbet <corbet@lwn.net>
#    Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
#    Kamil Rytarowski <n54@gmx.com>
#    Kees Cook <kees@kernel.org>
#    Laurent Pinchart <laurent.pinchart@ideasonboard.com>
#    Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
#    Linus Torvalds <torvalds@linux-foundation.org>
#    Lucas De Marchi <lucas.demarchi@profusion.mobi>
#    Mark Rutland <mark.rutland@arm.com>
#    Markus Heiser <markus.heiser@darmarit.de>
#    Martin Waitz <tali@admingilde.org>
#    Masahiro Yamada <masahiroy@kernel.org>
#    Matthew Wilcox <willy@infradead.org>
#    Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
#    Michal Wajdeczko <michal.wajdeczko@intel.com>
#    Michael Zucchi
#    Mike Rapoport <rppt@linux.ibm.com>
#    Niklas S=C3=B6derlund <niklas.soderlund@corigine.com>
#    Nishanth Menon <nm@ti.com>
#    Paolo Bonzini <pbonzini@redhat.com>
#    Pavan Kumar Linga <pavan.kumar.linga@intel.com>
#    Pavel Pisa <pisa@cmp.felk.cvut.cz>
#    Peter Maydell <peter.maydell@linaro.org>
#    Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
#    Randy Dunlap <rdunlap@infradead.org>
#    Richard Kennedy <richard@rsk.demon.co.uk>
#    Rich Walker <rw@shadow.org.uk>
#    Rolf Eike Beer <eike-kernel@sf-tec.de>
#    Sakari Ailus <sakari.ailus@linux.intel.com>
#    Silvio Fricke <silvio.fricke@gmail.com>
#    Simon Huggins
#    Tim Waugh <twaugh@redhat.com>=20
#    Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
#    Utkarsh Tripathi <utripathi2002@gmail.com>
#    valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu>
#    Vegard Nossum <vegard.nossum@oracle.com>
#    Will Deacon <will.deacon@arm.com>
#    Yacine Belkadi <yacine.belkadi.1@gmail.com>
#    Yujie Liu <yujie.liu@intel.com>

Note: unfortunately, two of the original authors didn't send any patches
with their names since when we migrated to git. So, I'm placing them
without e-mails.

On a side note, I would keep the above credits line only at the main
kernel-doc.py, as it would be really hard to distribute it along
the several kernel-doc classes.


>=20
> > +# TODO: implement warning filtering
> > +
> > +"""
> > +kernel_doc
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Print formatted kernel documentation to stdout
> > +
> > +Read C language source or header FILEs, extract embedded
> > +documentation comments, and print formatted documentation
> > +to standard output.
> > +
> > +The documentation comments are identified by the "/**"
> > +opening comment mark.
> > +
> > +See Documentation/doc-guide/kernel-doc.rst for the
> > +documentation comment syntax.
> > +"""
> > +
> > +import argparse
> > +import logging
> > +import os
> > +import re
> > +import sys
> > +
> > +from datetime import datetime
> > +from pprint import pformat
> > +
> > +from dateutil import tz
> > +
> > +# Local cache for regular expressions
> > +re_cache =3D {}
> > +
> > +
> > +class Re: =20
>=20
> So I have to say this bugs me a bit ... the class is fine, but the
> one-letter case-only difference from the standard "re" class is just
> going to make the code harder for others to approach.  "kern_re" or
> something like that?  Or even "kre" if you really want it to be as short
> as possible.

A short name close to "re" made easier to convert the script ;-)

I'll rename the class to KernRe (*)

(*) I opted to follow pylint convention for class names, which
    is using camel case. As we don't have classes in C, this
    doesn't strictly conflicts with our Kernel conventions ;-)

To make easier, I'll do such change as a separate patch at the end
of the series.

>=20
> > +    """
> > +    Helper class to simplify regex declaration and usage,
> > +
> > +    It calls re.compile for a given pattern. It also allows adding
> > +    regular expressions and define sub at class init time.
> > +
> > +    Regular expressions can be cached via an argument, helping to spee=
dup
> > +    searches.
> > +    """ =20
>=20
> [...]
>=20
> > +
> > +class KernelDoc:
> > +    # Parser states
> > +    STATE_NORMAL        =3D 0        # normal code
> > +    STATE_NAME          =3D 1        # looking for function name
> > +    STATE_BODY_MAYBE    =3D 2        # body - or maybe more description
> > +    STATE_BODY          =3D 3        # the body of the comment
> > +    STATE_BODY_WITH_BLANK_LINE =3D 4 # the body which has a blank line
> > +    STATE_PROTO         =3D 5        # scanning prototype
> > +    STATE_DOCBLOCK      =3D 6        # documentation block
> > +    STATE_INLINE        =3D 7        # gathering doc outside main block
> > +
> > +    st_name =3D [
> > +        "NORMAL",
> > +        "NAME",
> > +        "BODY_MAYBE",
> > +        "BODY",
> > +        "BODY_WITH_BLANK_LINE",
> > +        "PROTO",
> > +        "DOCBLOCK",
> > +        "INLINE",
> > +    ] =20
>=20
> So these ... kind of look like enums?

Yes. I considered using Python enum there:
	https://docs.python.org/3/library/enum.html

but it would simply be:

	from enum import Enum

	class state(enum):
	    NORMAL        =3D 0        # normal code
	    NAME          =3D 1        # looking for function name
	    BODY_MAYBE    =3D 2        # body - or maybe more description
	    BODY          =3D 3        # the body of the comment
	    BODY_WITH_BLANK_LINE =3D 4 # the body which has a blank line
	    PROTO         =3D 5        # scanning prototype
	    DOCBLOCK      =3D 6        # documentation block
	    INLINE        =3D 7        # gathering doc outside main block

and we would replace:

	self.STATE_NORMAL
	...

to:
	state.NORMAL

(and a similar change for inline states as well)

Except for an ancillary number-to-string conversion with this syntax:

	Color =3D Enum('Color', [('RED', 1), ('GREEN', 2), ('BLUE', 3)])

I didn't see much advantage of using it. See, we only use the string
on a single line, when --debug is used to show the per-line state machine.

Yet, perhaps we can split the states on a separate class anyway.

> That's kind of it for nits ... I do have one wish that will kind of hard
> to grant overall ... for the long-term maintenance of this code, it
> would be really nice if every non-trivial regex were described by a
> comment explaining what it is trying to do.  It's not reasonable to
> expect that as a condition for accepting this rewrite, but it sure would
> be a nice goal to be working toward.

Agreed. For the future, the best would be to request a description for
every new regex added.

For the future, my plan is to split the C source parser (e.g. the code that
calls output_declaration() and/or modifies self.entry at the KernelDoc
class inside kdoc_parser to a separate file and class. We can then work
to implement some regexes to a more lexical way. For instance, all those
regexes:

            (Re(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
            (Re(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GRO=
UP('),
            (Re(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'str=
uct \1 \2; STRUCT_GROUP('),
            (Re(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP(=
'),

            (Re(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S), =
r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
            (Re(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S), r'DECL=
ARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
            (Re(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_patt=
ern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
            (Re(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_p=
attern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
            (Re(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_patte=
rn + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
            (Re(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' + args_p=
attern + r'\)', re.S), r'\2 *\1'),
            (Re(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' =
+ args_pattern + r'\)', re.S), r'\1 \2[]'),
            (Re(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S)=
, r'dma_addr_t \1'),
            (Re(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S),=
 r'__u32 \1'),

could be converted on a more lexical representation where the macro
name with their arguments could be represented on a clearer expression.

Something like:

	ReplaceMatch("DECLARE_HASHTABLE($1, $2)", "unsigned long $1[1 << (($2) - 1=
)]")

We have already the NestedMatch class that do something similar to
that(*) could be improved to do things like that - or we can come up with
something new.

(*) NestedMatch currently miss one feature: it doesn't split the contents
    inside parenthesis on multiple match groups. I guess it won't be hard to
    add such features to it.

Thanks,
Mauro
