Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357E267B77;
	Wed, 26 Feb 2025 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553014; cv=none; b=IeUylUzRjMhRYzcAy0EuSUK5J9K7WVvfs7ky3bfPcBechKnugpNsWloeSX1ga7wdcE8sfmYHGZ6CYt+1vBAeMK+Da+X3ZI+JrJo9I68AUcAss3WDGVebOCsCFqRYsAyDC7kZP+CaHrKLuS0Skjt7bAx0rzfdr/m5WGwYeqqfmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553014; c=relaxed/simple;
	bh=oC8X1r5Bp9u4Te+gPu5p4PdHDO2o2swwbII27w2F7Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XW4QUl9Eju6UhIcLdiDQsluMv44Xg8sUfKaiydlfdQtukJGPqHz9ZsMeUkpoxuQm06Znjruw1+gJk/X2R3P3G+2Dh22TTSHtffuqYJNkyoGSeT5VTroLyk0FasK/6QIZQEWQ+qUihNPpwmxXCT+1HLydzAi+ZtUaXRgQ+RlFO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCVOpUqK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCVOpUqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D16C4CED6;
	Wed, 26 Feb 2025 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740553013;
	bh=oC8X1r5Bp9u4Te+gPu5p4PdHDO2o2swwbII27w2F7Q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vCVOpUqKGHIYoLt6mA2ejxvK/qJ5K3ocbUovRZmIOEH1cKuB+WBbAPpDLYsbmyzKE
	 tQQ3NzWaT1SlVW/8CBI/AJkLEY8oWJHE8idDJXbFN5zyYv8L9VJvQmg8nxUkpE/bVI
	 yJQg0YKD64V4qvxJnKDkviXBXeQLlDqbbUH5sBTztWP1338BtkbeDe4cRAcHzYkNf/
	 maDHYtEZlpT20C2VakJm8wp76UFO3lzYWcFdtIdRycoFVnORL5z4qaAZsDGUN+x0ia
	 cG92woJr9xh2mJt/VHcbnyp8o8JprDOVq8gvgWa4GugXFOXuoR/NOyunR0M2VhTZRY
	 6xm1T3jbFH9yQ==
Date: Wed, 26 Feb 2025 07:56:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/39] scripts/kernel-doc.py: add a Python parser
Message-ID: <20250226075647.5de4c7b0@foz.lan>
In-Reply-To: <87tt8hyedw.fsf@trenco.lwn.net>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
	<3905b7386d5f1bfa76639cdf1108a46f0bccbbea.1740387599.git.mchehab+huawei@kernel.org>
	<87v7sy29rh.fsf@trenco.lwn.net>
	<20250225083814.51975742@foz.lan>
	<87tt8hyedw.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 25 Feb 2025 13:10:19 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > Em Mon, 24 Feb 2025 16:38:58 -0700
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> > =20
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >>=20
> >>=20
> >> I also think you should give consideration to preserving the other
> >> copyright notices in the Perl version.  A language translation doesn't
> >> remove existing copyrights...who knows how much creativity went into
> >> some of those regexes? =20
> >
> > Makes sense, but the copyrights at kernel-doc.pl:
> >
> > 	## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
> > 	## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
> > 	## Copyright (C) 2001  Simon Huggins                             ##
> > 	## Copyright (C) 2005-2012  Randy Dunlap                         ##
> > 	## Copyright (C) 2012  Dan Luedtke                               ##
> > 	##                                                               ##
> > 	## #define enhancements by Armin Kuster <akuster@mvista.com>     ##
> > 	## Copyright (c) 2000 MontaVista Software, Inc.                  ##
> > 	#
> > 	# Copyright (C) 2022 Tomasz Warnie=C5=82=C5=82o (POD)
> >
> > Also doesn't preserve all copyrights from people that worked hard to
> > maintain it all over those years. =20
>=20
> Agreed ... and I'm not sure what we can do about that.  But *removing*
> existing copyright notices is a bit of a different story; that is
> generally considered to be fairly bad form.

I'm with you: we shall not remove copyrights.

Yet, copyrights were originally developed for artwork (paintings, music
and such). So I guess we can borrow an analogy from there to try=20
understanding what a conversion like that would mean. At least for me,
it sounds like having two paintings of the same image: they both
reflect the same picture, but they have different brush strokes. They
also may have different painting styles that may look similar but are
different.

Using such analogy, let's say someone draws a new painting while looking
at a famous painting like Monalisa. Surely the painter should give credits
to Leonardo Da Vinci  for his brilliant artwork, but, on the other hand,
he cannot and should not sign that his painting was authored by Leonardo
Da Vinci.=20

This is the same here: the Python code, while derivated from the
Perl version, doesn't have the same coding style ("brush strokes") nor
we can say that it were authored by the original writers. IMO, all we
can do is to give credits for the original authors and preserve GPLv2
license, which explicitly allows derivative work.=20

That's why I think we could give such credits with some preamble
note to distinguish it from the Python copyrights.=20

It could be something like:

	# Converted from the kernel-doc script originally written in Perl
	# under GPLv2, copyrighted since 1998 by the following authors:

Followed by a list of the contributors, or it could be mentioning the
original script and how people could browse to see the developers
who wrote/modified kernel-doc.

Feel free to suggest a better text if you think the above won't fit.

> I don't have a problem with adding a longer credits area, I guess, if we
> want to do that (though it's not normal for other source files).  But
> I'm not sure we need to.

I have the same doubts, but on the other hand, looking at the
copyrights written on kernel-doc.pl since 2005 (git version), I can see=20
records for just 3 persons:

- Dan Luedtke: a single patch adding html5 support
  1b40c1944db4 ("scripts/kernel-doc: added support for html5")

  We didn't port html5 to Python - and html output was already removed
  from kernel-doc a long time ago. Maybe there might have some small
  pieces of his original work that could have been ported. I dunno.

- Tomasz Warnie=C5=82=C5=82o: basically, changes at the help/man part of th=
e script

  2b306ecaf57b scripts: kernel-doc: Refresh the copyright lines
  258092a89085 scripts: kernel-doc: Drop obsolete comments
  252b47da9fd9 scripts: kernel-doc: Replace the usage function
  834cf6b9039e scripts: kernel-doc: Translate the "Other parameters" subsec=
tion of OPTIONS
  c15de5a19a28 scripts: kernel-doc: Translate the "Output selection modifie=
rs" subsection of OPTIONS
  9c77f108f43a scripts: kernel-doc: Translate the "Output selection" subsec=
tion of OPTIONS
  dd803b04b0a0 scripts: kernel-doc: Translate the "Output format selection =
modifier" subsection of OPTIONS
  2875f7870821 scripts: kernel-doc: Translate the "Output format selection"=
 subsection of OPTIONS
  f1583922bf93 scripts: kernel-doc: Translate the DESCRIPTION section
  43caf1a6823d scripts: kernel-doc: Relink argument parsing error handling =
to pod2usage
  a5cdaea525c3 scripts: kernel-doc: Add the basic POD sections

  Parts of the text used at the POD sections were preserved at the=20
  Python version. I didn't check if the texts we're using were
  authored by him.

- Randy Dunlap: 64 patches fixing things and improving the script

  I'm pretty sure I ported lots of stuff from Randy to the Python
  version.

At least for me, while it sounds right to give credits for the above
3 developers and also for Michael, Simon and Armin, who collaborated
and authored it before git time, it doesn't sound right to not mention=20
any but one of the several developers that have been maintaining it=20
since 2005. Now, the list, ordered by the number of patches is:

     65 Randy Dunlap
     57 Mauro Carvalho Chehab
     32 Jani Nikula
     20 Jonathan Corbet
     11 Tomasz Warnie=C5=82=C5=82o
     11 Johannes Berg
      7 Kees Cook
      6 Vegard Nossum
      6 Aditya Srivastava
      5 Paolo Bonzini
      5 Martin Waitz
      4 Matthew Wilcox
      4 Daniel Vetter
      3 Mike Rapoport
      3 Danilo Cesar Lemes de Paula
      3 Daniel Santos
      3 Conch=C3=BAr Navid
      3 Borislav Petkov
      3 Ben Hutchings
      3 Andy Shevchenko
      3 Andr=C3=A9 Almeida
      3 Akira Yokosawa
      2 Yujie Liu
      2 Yacine Belkadi
      2 Sakari Ailus
      2 Pavel Pisa
      2 Pavan Kumar Linga
      2 Markus Heiser
      2 Jonathan Neusch=C3=A4fer
      2 Jason Baron
      2 Jakub Kicinski
      2 Ilya Dryomov
      1 Will Deacon
      1 valdis.kletnieks@vt.edu
      1 Utkarsh Tripathi
      1 Silvio Fricke
      1 Rolf Eike Beer
      1 Rich Walker
      1 Richard Kennedy
      1 Randy.Dunlap
      1 Pierre-Louis Bossart
      1 Peter Maydell
      1 Nishanth Menon
      1 Niklas S=C3=B6derlund
      1 Michal Wajdeczko
      1 Masahiro Yamada
      1 Mark Rutland
      1 Lucas De Marchi
      1 Linus Torvalds
      1 Levin, Alexander (Sasha Levin)
      1 Laurent Pinchart
      1 Kamil Rytarowski
      1 Jonathan Cameron
      1 Johannes Weiner
      1 J=C3=A9r=C3=A9my Bobbio
      1 Jason Gunthorpe
      1 Horia Geanta
      1 Harvey Harrison
      1 Greg Kroah-Hartman
      1 Gabriel Krisman Bertazi
      1 Donald Hunter
      1 Dan Luedtke
      1 Coco Li
      1 Chen-Yu Tsai
      1 Bart Van Assche
      1 Anna-Maria Behnsen
      1 Alexander Lobakin
      1 Alexander A. Klimov

If you think the list is too long, one option would be to draw a line
(for instance picking developers with more than 2 patches or something
like that) and add an "and others" to not forget about the others.

We might analyze each individual contribution to see what was relevant
or not, ignoring for instance single-line authors that did changes like
this one:

	diff --git a/scripts/kernel-doc b/scripts/kernel-doc
	index 28b761567815..f565536a2bef 100755
	--- a/scripts/kernel-doc
	+++ b/scripts/kernel-doc
	@@ -2082 +2081,0 @@ sub dump_function($$) {
	-    $prototype =3D~ s/__devinit +//;

which almost certainly doesn't affect copyrights, which doesn't add any new
code to it, while preserving credits for single-patch authors that did=20
regex changes like this one:

	diff --git a/scripts/kernel-doc b/scripts/kernel-doc
	index 3982d47048a7..724528f4b7d6 100755
	--- a/scripts/kernel-doc
	+++ b/scripts/kernel-doc
	@@ -1086 +1086 @@ sub dump_struct($$) {
	-    if ($x =3D~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned=
|____cacheline_aligned_in_smp|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/=
) {
	+    if ($x =3D~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned=
|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-=
z0-9,_\s\(\)]*\)\)))*/) {
	@@ -1101,0 +1102 @@ sub dump_struct($$) {
	+       $members =3D~ s/\s*____cacheline_aligned/ /gos;


but for me it sounds a waste of our time to analyze all patches, and
we may risk of get things wrong, so I prefer to place the complete list.

Thanks,
Mauro
