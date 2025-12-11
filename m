Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FB2DAFA1;
	Thu, 11 Dec 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490404; cv=none; b=Iv4OnXv7bgD0Lyvtw27u5qzVH7DIMecV/5jLvbZhgFFGNkIF3AKNH/uN7fMG9JJvhsLql6TTZes1t9qyNdqUxyh7cldO91/J38dLSvyowd+1jdl32UKQQ9ceXZOfRzGANt73+1BDbYLhRxvNlF/z54XMGsxT35cox0Az2J4LP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490404; c=relaxed/simple;
	bh=UvpgNVZQBWlxwITboFxyD5AfPO8Qk05RYT6bTgKrZ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmeU+s4L353uqbpOxSY7QAw1BvXlDF8XP2ssx0FnG6pCViedZBbIFOeuBu9za0iwXUwoVPhhmFYTH+AV9FDKKoTmvy7BZc3Nfl3A7WXioUJGutb5JwpMKyczD2Rj8E6C4oY7QQ7ybpouXTHQoY/ccNHLYLExGSRwFmKfh/nh/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLgG52d2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLgG52d2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1F1C4CEF7;
	Thu, 11 Dec 2025 22:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765490403;
	bh=UvpgNVZQBWlxwITboFxyD5AfPO8Qk05RYT6bTgKrZ7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLgG52d2/iqu1sxj7GYeS2a/Sxw8ThW6asIItsBe4kdxmkTf8muRLSxBmDfDUTeAF
	 guQJFMWlzhh11fUv6sxEdcmn/B9+GrK0YpJUOqE7A5THK68fja/llOeE22CgM8PLgo
	 56ivDIlpPa8XuqMLyAPrOmA07fT29ybf+hXS1MRhbIdq0+qLFMIPntyOA4br2g9nha
	 PCNZe03aSRsb04tEgRdKfNkcDlc01Uvwi75gsu7SDAFpyCQM+3hd9aroWHh5f8wiXU
	 VShVo5/xMhwkWswOD6iQteeJ7JE/5mZy7VLpW5MosqnduOK9I0Bm6h1O7oc4PJK2lY
	 5X0kyKCamIa6A==
Date: Thu, 11 Dec 2025 14:00:02 -0800
From: Kees Cook <kees@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Jakub Kicinski <kuba@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Justin Stitt <justinstitt@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Pekka Enberg <penberg@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [cocci] [PATCH v5 4/4] coccinelle: Add kmalloc_objs conversion
 script
Message-ID: <202512111352.387A339CE@keescook>
References: <20251122014304.3417954-4-kees@kernel.org>
 <71d406fb-9fb1-44a9-912a-7a0d270b9577@web.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71d406fb-9fb1-44a9-912a-7a0d270b9577@web.de>

On Mon, Nov 24, 2025 at 01:50:23PM +0100, Markus Elfring wrote:
> > Finds and converts sized kmalloc-family of allocations into the
> > typed kmalloc_obj-family of allocations.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.18-rc7#n94

"Describe your changes in imperative mood"

I guess I can try rewording this, but it is describing the behavior of
the script. Normally the imperative language for a patch is about what
the patch accomplishes. In this case, I've added a script and it does a
thing itself.

> …
> > +++ b/scripts/coccinelle/api/kmalloc_objs.cocci
> > @@ -0,0 +1,168 @@
> …
> > +// Comments:
> …
> 
> * Please omit such an empty information line.

Agreed; I removed this in v5.

> 
> * Would a field like “Keywords” become helpful?

I only see a few using this -- what benefit is there to adding it? It
seems redundant to the rest of the file, its opening comment, etc.

> > +virtual patch
> 
> Will additional operation modes become relevant after clarification of implementation details?

I am not interested in other modes; if people want to contribute them,
they are welcome. :)

> 
> 
> …
> > +def alloc_array(name):
> > +	func = "FAILED_RENAME"
> > +	if name == "kmalloc_array":
> > +		func = "kmalloc_objs"
> …
> 
> * I suggest to avoid duplicate variable assignments.
> 
> * How do you think about to collaborate with the Python data structure “dictionary”?

I wanted the stderr warning when there was no match, but to return
"FAILED_RENAME" in such a case. Using a dictionary was basically the
same length as the elif stack. If you have an alternative, I'm happy to
replace it with what you come up with.

> 
> 
> …
> > +type TYPE;
> > +TYPE *P;
> > +TYPE INST;
> > +expression VAR;
> > +expression GFP;
> …
> 
> Such repetition of SmPL key words can eventually be also avoided.

That is true, but I like having them separated -- I find it more
readable that way.

-- 
Kees Cook
