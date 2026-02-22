Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420C1534EC;
	Sun, 22 Feb 2026 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744360; cv=none; b=YbrXmzoCmQOXA7VCswV3mYVcnQcPzJf1txYIo0bsLIH+vrW38393fcC2ydJvgYWJHSuO++cZaus4MPWM4L6fOdOooEZhsB8dzEC5wYqvMWseLKpVATIUD0p/2LheqzR0CAuqLiM4dqHnPYQd77WoRSG8QEDxzpNLSu5DPGCTsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744360; c=relaxed/simple;
	bh=DmIYaptlf7pY4fnaKfTkBxqecJdfaE7l+PBLh5NmUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlCIWutgH0ItSlCBHAY5jZ8hGjcdKp/TCNaDxoDjZMdbYeliV6HYpGvl8QeR1zvRwvRMjtoBIol7OAYdrfYvIp1ytffl5HOPt/yG+Y8IQSxmMX20vjGbar6VWKveqQxyTXKKUmfiMQ1hxUMtd+yxO/wUygtESOrTkJEXQOLHwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsp6UoNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsp6UoNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819E6C116D0;
	Sun, 22 Feb 2026 07:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771744359;
	bh=DmIYaptlf7pY4fnaKfTkBxqecJdfaE7l+PBLh5NmUV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsp6UoNmMj3lcvtgDnsP9DNOlmwsbewFHhdUreKfP92YaZx/EM4E0mN4TZhNWrMDO
	 CohMXKT5TLYh3l5i7zWVReBdakhTfH5lMJHPG0BYMf9nYcn9TYSBu+/OHoYTD+b+tn
	 ks+/rKTqf0SI8YAETZNG+haXBEJ4BRAh2RH/BxlDSJrkVa6HnyBW0kcSNnBBoy7CUp
	 5BPx1t+ZVNgApJsSZD4RMAASI51pHkOETF3mioaQmmVAsUyEAOg1tMhcPBqkH8Thby
	 wxImQkHL5ysMRVutJD0cObrkNtccIx/p7e2xTQ+okr7QmCRsn6MO9FH8uCHNqV/Kz6
	 U4Y04OIiQYHmw==
Date: Sat, 21 Feb 2026 23:12:39 -0800
From: Kees Cook <kees@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>, Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
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
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion script
Message-ID: <202602212306.BC7A8E8F@keescook>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-5-kees@kernel.org>
 <20260222041324.GA10695@sol>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222041324.GA10695@sol>

On Sat, Feb 21, 2026 at 08:13:24PM -0800, Eric Biggers wrote:
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

I'm running:

$ spatch --version
spatch version 1.1.1-00467-g578998d7826c compiled with OCaml version 4.13.1

Running Coccinelle scripts is normally done with the coccicheck target:

$ make coccicheck V=1 MODE=patch COCCI=scripts/coccinelle/api/kmalloc_objs.cocci

-Kees

-- 
Kees Cook
