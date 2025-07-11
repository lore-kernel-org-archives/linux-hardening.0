Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4918DF6E;
	Fri, 11 Jul 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261896; cv=none; b=Qo7gskp5Buy8y6jVO4tRCgT6FHCu56TPbyMsAoj2uB6jHglvodoaMlOwohQRC+dWHK338YfShSsIuijdzPFeNkkwdcFlkgv5Belzvr15kxdVTAGxBmffDseb182HVnD/Ppsgw2B/YbiOlyoCtuNJXYFWPw3wnu8JGt59hd2kig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261896; c=relaxed/simple;
	bh=FDb8/h29A8eGL9/8IfBnksHl4dYEH8rtCxJjEQvLraU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtMN/gSi3eLZQ8PWkkmCLmU1xpPBWLnFWA+3KDxsAzB+AYvihVe8kMK9/1IUFMrh0+1RZMZUrCFC8fZkwJfHR5Xa3Z8HvBpkU9Dpp/AejIur+o4UG6fZT+JZppIWHhjR1idStDFiUc4VPALApm0CxjeXL/Ffq+KYlZUkb8DEI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QXOczNP4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QXOczNP4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=An5C+0gDMIwtsouH1107rmybVZLRBPlp9Sd8kmMnl+E=; b=QXOczNP4OEoHhuOgaALaPU/URb
	uClAjhReAwuuNp4RHmzvF4FCxmQSqkqctqFHgBdZrIno7bvCXciVbei9xOICMBgiC/qSDxN7LAXQg
	reF2vX8XfxXR4UkJwFpYO1eatqqbaNqfui7mulMYMbtQOe5YEJUryNK8+s6uTYpTAAE/ONI9UMKLS
	G3F2BFNF5t6AZj0fnrtlSi7S2E9Hyz1VJZcYN6lf/VGcVLqicgOi0JTef4nlx0EHCwh8/+jIsRBZw
	18XZpGLirqupNWPRMuSN7/crhMbhxLL3Gn2U14YcB2mZ5WPP/xYDhYFoms3Z6BDhexGeQt9rAI6a0
	MhD34mYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaJMW-0000000E8fs-1liL;
	Fri, 11 Jul 2025 19:24:48 +0000
Date: Fri, 11 Jul 2025 20:24:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Martin Uecker <ma.uecker@gmail.com>,
	Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <aHFlAB6paP2CU9Im@casper.infradead.org>
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com>
 <20250711184541.68d770b9@pumpkin>
 <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>

On Fri, Jul 11, 2025 at 10:58:56AM -0700, Linus Torvalds wrote:
> That kind of "string buffer" obviously isn't useful for things like
> the printf family, but we do have others. Like "struct seq_buf", which
> already has "seq_buf_printf()" helpers.
> 
> That's the one you probably should use for most kernel "print to
> buffer", but it has very few users despite not being complicated to
> use:
> 
>         struct seq_buf s;
>         seq_buf_init(&s, buf, szie);
> 
> and you're off to the races, and can do things like
> 
>         seq_buf_printf(&s, ....);
> 
> without ever having to worry about overflows etc.

I actually wanted to go one step further with this (that's why I took
readpos out of seq_buf in d0ed46b60396).  If you look at the guts of
vsprintf.c, it'd be much improved by using seq_buf internally instead
of passing around buf and end.

Once we've done that, maybe we can strip these annoying %pXYZ out
of vsprintf.c and use seq_buf routines like it's a StringBuilder (or
whatever other language/library convention you prefer).

Anyway, I ran out of time to work on it, but I still think it's
worthwhile.  And then there'd be a lot more commonality between regular
printing and trace printing, which would be nice.
