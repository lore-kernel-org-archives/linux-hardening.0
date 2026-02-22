Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7B29CEB;
	Sun, 22 Feb 2026 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771752777; cv=none; b=KfHGZAqxSynuMQOItq8LeXU516hVrZQtTgL2nLI0bEaUljIAsQs8nxUsy4CWwPzotQ/vpSWzMUu19gvJmE9OLIB7z7dwIt9ymGwoVVCCt98IB/98ZiqVwxivd3op+46DjXn4BVtYlsjoQvUJBb9mPNuuhrwmDNiu+Vk/q7AJfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771752777; c=relaxed/simple;
	bh=onFI7DM/JzzNLdxszuzdOYePUCf/Q3RzFrnlbRSJ1D0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N7ac3DU89/hOXPQo/IQxz8XDDCqFQvSFffNbU8l6CV0CzHPyzFxEclwKekeEIrp95r2z4NXJFSx+JU6hFVRlL6Rm4qcTk8Qm40TGPdkYSuTK+0+XDjNHvi0scP/n7JRUzCbvfeaKEVG3y28odgljYJ+kvQBUuoi2s8o314EZaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fG5XupDj; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fG5XupDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jU7N+0FZIxmxEwn1Lp5kVygLKRMnvrCrP1wvwY45zN8=;
  b=fG5XupDjBMoGO7fb708vqeI6OVeCTN84B2F345qCuRSbpPLY8zCB1/Ke
   QuC3JP0K3PaMeidqLXldmfcv/5skRO5ymtDel3QVdp4zHpD09ZDOYJKsG
   4h6S6ReTL1GAtuR+7CpQcGEgdpyQZQGsvZ4b8dQ8OWnMjw5Q4bezAW7tu
   8=;
X-CSE-ConnectionGUID: vaOREB1kR4erODUIhCjHtw==
X-CSE-MsgGUID: 48AynL+nT8SXUoCsDo0xsg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.21,304,1763420400"; 
   d="scan'208";a="264582621"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 10:31:42 +0100
Date: Sun, 22 Feb 2026 10:31:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Eric Biggers <ebiggers@kernel.org>
cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>, 
    Joe Perches <joe@perches.com>, Christoph Lameter <cl@linux.com>, 
    Marco Elver <elver@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
    Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>, 
    Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
    Nathan Chancellor <nathan@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
    Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, 
    Yafang Shao <laoar.shao@gmail.com>, 
    Tony Ambardar <tony.ambardar@gmail.com>, 
    Alexander Lobakin <aleksander.lobakin@intel.com>, 
    Jan Hendrik Farr <kernel@jfarr.cc>, 
    Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
    llvm@lists.linux.dev
Subject: Re: [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion script
In-Reply-To: <20260222041324.GA10695@sol>
Message-ID: <c6ae637-a2de-7919-e9b5-42cd47ddc1a5@inria.fr>
References: <20251203233029.it.641-kees@kernel.org> <20251203233036.3212363-5-kees@kernel.org> <20260222041324.GA10695@sol>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 21 Feb 2026, Eric Biggers wrote:

> On Wed, Dec 03, 2025 at 03:30:35PM -0800, Kees Cook wrote:
> > Finds and converts sized kmalloc-family of allocations into the
> > typed kmalloc_obj-family of allocations.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Julia Lawall <Julia.Lawall@inria.fr>
> > Cc: Nicolas Palix <nicolas.palix@imag.fr>
> > Cc: cocci@inria.fr
> > ---
> >  scripts/coccinelle/api/kmalloc_objs.cocci | 109 ++++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci
>
> Is there a way to reproduce commit 69050f8d6d075dc using this semantic
> patch as claimed?  I spend a while installing the latest version of
> spatch (which was quite hard to do due to all the unusual dependencies),
> but it complains that no rules apply:

I guess you would have to write on the command line -D patch?

julia

>
> $ /usr/local/bin/spatch --sp-file scripts/coccinelle/api/kmalloc_objs.cocci --dir . --in-place
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u8 as a type
> SPECIAL NAMES: adding u16 as a type
> SPECIAL NAMES: adding u32 as a type
> SPECIAL NAMES: adding u64 as a type
> SPECIAL NAMES: adding __u8 as a type
> SPECIAL NAMES: adding __u16 as a type
> SPECIAL NAMES: adding __u32 as a type
> SPECIAL NAMES: adding __u64 as a type
> SPECIAL NAMES: adding uint8_t as a type
> SPECIAL NAMES: adding uint16_t as a type
> SPECIAL NAMES: adding uint32_t as a type
> SPECIAL NAMES: adding uint64_t as a type
> SPECIAL NAMES: adding uchar as a type
> SPECIAL NAMES: adding ushort as a type
> SPECIAL NAMES: adding uint as a type
> SPECIAL NAMES: adding ulong as a type
> SPECIAL NAMES: adding __le16 as a type
> SPECIAL NAMES: adding __le32 as a type
> SPECIAL NAMES: adding __le64 as a type
> SPECIAL NAMES: adding __be16 as a type
> SPECIAL NAMES: adding __be32 as a type
> SPECIAL NAMES: adding __be64 as a type
> SPECIAL NAMES: adding wchar_t as a type
> No rules apply.  Perhaps your semantic patch doesn't contain any +/-/* code, or you have a failed dependency.  If the problem is not clear, try --debug-parse-cocci or check whether any virtual rules (e.g., patch) should be defined.
>
