Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425E3B4E87
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jul 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142388; cv=none; b=uZo9ba7KlXUDAGpJW9W4yoOJ2KVc2ehJ3v3gFWtUXbLk3rTVqRnt9jOWLjAcc4ofNA0tDtUsKIUvlmyxx751WhH0yqn4jkLjm0gX5JG7QnTUQz93OkIbjUNv1m4f3n7JhZA61bIUUBHVxgfGf6WnEQPGD7xe9WJ+j+29Ki8Mqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142388; c=relaxed/simple;
	bh=V7Q/qo28+1ZAcG7qa/SIkUDw8Vy35bmgcDcKj48LfD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbUCFbae4Aa+ZUjH3RbeojWUfhpchFyMTthCHTJ0bX2kgcGNpBAIPijeUSB+Pa957vR/JZdkIoyxD39AEaAQIsOLi5bcx8Ur5+o5e18eiftcO9objkmiKcvqMjbpHDnRnkkCg4Ohftr2GWoVcdgCsx+1pWX2Z38PLr0lfZxaEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng7E1BrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng7E1BrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DF51F000E9;
	Wed, 15 Jul 2026 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784142377;
	bh=nRhZfEbZrENSE0M2suAF1WmBkJXrxr5AZlRPVcFxltU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ng7E1BrUddltDsjOXHZiJWOg5bqLzCq7Tbi2E32y2LjC2/TwWYUrs7rQKjqZqMFdW
	 F7AkQ9LlTtlWGpH9OvRKhiKZ7O38nANURZ5VrWp89Hhcf1PSoXX8FPKRVKfsFadxWf
	 wdpXFrX1O1n5vgGds15ejo/rStaKuZfHIL1QU01t2AF9Vx8zsHxuB3yJURFe3v5TE5
	 QmomVsmgNBhHqnFMANqxPUTNEDJJkGnNEOaG8a8kbgZrxVaso/G1K5t70mHVHicqkb
	 HfkgFY/6G2M2ns6QxEYr6NJRYwxrITbppeToKPDgvtjsGvvkrLjDMuswz7vHhnSFIO
	 TGpUU4QYlsmMg==
Date: Wed, 15 Jul 2026 12:06:17 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v13 1/7] kcfi: Introduce KCFI typeinfo mangling API
Message-ID: <202607151151.AB5F1BD0@keescook>
References: <20260618204530.work.910-kees@kernel.org>
 <20260618204539.824446-1-kees@kernel.org>
 <CALvbMcCiQ1b0KDrJHS-irGMWNEk5oWaWs31KQor2ZHPSVewQ=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcCiQ1b0KDrJHS-irGMWNEk5oWaWs31KQor2ZHPSVewQ=A@mail.gmail.com>

On Sat, Jun 27, 2026 at 03:00:42PM -0700, Andrea Pinski wrote:
> On Thu, Jun 18, 2026 at 1:45 PM Kees Cook <kees@kernel.org> wrote:
> > [...]
> > diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
> > index 9f821f048533..2e7b7e4aed89 100644
> > --- a/gcc/doc/extend.texi
> > +++ b/gcc/doc/extend.texi
> > @@ -17967,6 +17967,101 @@ which will cause a @code{NULL} pointer to be used for the unsafe case.
> >
> >  @enddefbuiltin
> >
> > +@defbuiltin{{unsigned int} __builtin_linux_abi_kcfi_hash (@var{type})}
> > +
> > +The built-in function @code{__builtin_linux_abi_kcfi_hash} returns a hash value
> > +for the given type @var{type} (which is a type, not an expression).
> > +The hash is computed using the FNV-1a algorithm on the type's mangled
> > +name representation, which follows a subset of the Itanium C++ ABI
> > +conventions adapted for C types.  (See @code{__builtin_linux_abi_kcfi_name}
> > +for the string representation.)
> 
> I think we should add a link to the Itanium C++ ABI from the documentation.

Do you mean a literal URL?

> The documentation is missing that these builtins are only available
> from the C and Objective-C and not there for C++.
> Unless you are going to add a cp/cp-parser.cc implementation too.

Good point; I don't intend to add this to cp/cp-parser.cc unless there
is some extremely good reason, and if this is Linux-kernel specific, it
really should just be C.

> > [...]
> > +
> > +    printf("\n================================================================\n");
> > +    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pass + fail);
> > +    return fail;
> > +}
> 
> It would be a good idea to add a random generated testing here. See
> testsuite/objc.dg/gnu-encoding and testsuite/gcc.dg/compat for
> examples.

Okay, thanks for the pointer; I'll see what I can come up with. I
generally dislike random testing since they may appear to be "flaky"
when they trip, but I'll give it a shot.

> > [...]
> > --- /dev/null
> > +++ b/gcc/kcfi-typeinfo.h
> > @@ -0,0 +1,32 @@
> > +/* KCFI-compatible type mangling, based on Itanium C++ ABI.
> > +   Copyright (C) 2025 Free Software Foundation, Inc.
> 
> It is 2026 now.

Oops, yes.

> 
> > +
> > +This file is part of GCC.
> > +
> > +GCC is free software; you can redistribute it and/or modify it under
> > +the terms of the GNU General Public License as published by the Free
> > +Software Foundation; either version 3, or (at your option) any later
> > +version.
> > +
> > +GCC is distributed in the hope that it will be useful, but WITHOUT ANY
> > +WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> > +for more details.
> > +
> > +You should have received a copy of the GNU General Public License
> > +along with GCC; see the file COPYING3.  If not see
> > +<http://www.gnu.org/licenses/>.  */
> > +
> > +#ifndef GCC_KCFI_TYPEINFO_H
> > +#define GCC_KCFI_TYPEINFO_H
> > +
> > +#include "tree.h"
> > +#include <string>
> 
> Don't include string here. It will break on some host.

Ah! Okay. Do you know which combo trips this? I'd love to be able to
validate I've fixed this correctly.

> > [...]
> > +#include "config.h"
> Add `#define INCLUDE_STRING` here.

> > [...]
> > +/* Forward declaration for recursive type mangling.  */
> > +
> > +static void mangle_type (tree type, std::string *out_str, uint32_t *hash_state);
> 
> Forward declarations should be close to the top of the file.

Gotcha.

> > [...]
> > +  /* Unknown builtin type: this should never happen in a well-formed C.  */
> > +  debug_tree (type);
> > +  internal_error ("mangle: Unknown builtin type - please report this as a bug");
> Maybe fatal_error or sorry. I know we had some disagreement about this
> but I can't remember the out come.
> I am not sure we want internal_error exactly to be user friendly.

We've gone back and forth a few times in other places. My take on this
is that I do want it to be friendly because in at least the place I
tripped over this, it was very confusing for me: first I saw this for
vector types and later for builtins. So, at the very least, I'd like to
keep this as-is because of how hard I found it to be to debug when
something got missed. :P

> Note I also have not doubled check but do you have some testcases
> testing VLAs inside a struct here?
> What about _BitInt testcases?

I can add both; Linux uses neither so I hadn't considered/tripped over
those.

-- 
Kees Cook
