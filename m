Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680A1DD9AD;
	Tue, 25 Nov 2025 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030593; cv=none; b=X0+oBEquYtQpEIFpQd0HLUJTnYoh5M6kFDQD4/x6DpzWxV43LNeyDs7IgvncuPoUzZUltpWhuDtY1+NX3kF6AiEqeoKiuPXQjBx8kNM3/ab79q0FsjT2SR9AufxeW1Cn7T9ZTEaREvw6At2rK9h1NEo5zFaCtr1JtPni2mkv1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030593; c=relaxed/simple;
	bh=4uLLAgDc9tGcrBcub+QCJwRh5UloS519zmliLS4+WTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmdmCemEMxO8COCvKTuGZhwqJNk6+WhbUckijdjA7g295iY9CNSR4GeDeC4ugiGIeVBMUfjO9t+jt2AfWzIOKRUpuudfjshBvNK1LRYMrgL4YKaJxefeO/bf9C66j/jyORo4FCjKdvpVHKwCzIzkC7y02o1f7N3CExLu21ewL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vP0pDW+B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vP0pDW+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD8C4CEF1;
	Tue, 25 Nov 2025 00:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764030593;
	bh=4uLLAgDc9tGcrBcub+QCJwRh5UloS519zmliLS4+WTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vP0pDW+BLmy48fCW+CGIvxSSOBpyZLYqJlIFcgFof2izgXQUBhwAbWrNhiXRBRkXe
	 GG4SgKT9qZsApPZSuXAOjUNhLTFptYI/vhbzI49vtWUzFvUfn/p6YDwl0QxXi513+C
	 Vpg/Fmf9P0BEeHtlxJv8H6UeuikiIv1VjgSQMa+6PjlBo5C3FpmcKscSFnP/utdse5
	 KZzgwabQE8amERyL/vtIu1c4gltor3c68XQs4cQIeMeTPM7E6vz91pqB7hmuS/+PW2
	 M9JbOdwp/XqZNni55nZnDncPu+HxP+OkBHc1AIn/vOCItrqo1Ru3C0d84jmTT2dC4q
	 SS3PI2PS8mJ5Q==
Date: Mon, 24 Nov 2025 16:29:52 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
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
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
Message-ID: <202511241612.6CF90E9@keescook>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
 <CAHk-=wikqnc16e7yUTJuqnc5f4rL+y_-JpRzCLRu9WPnt3nmiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wikqnc16e7yUTJuqnc5f4rL+y_-JpRzCLRu9WPnt3nmiQ@mail.gmail.com>

On Mon, Nov 24, 2025 at 01:35:12PM -0800, Linus Torvalds wrote:
> Those macros are illegible. And 99% of all users DO NOT WANT ANY OF
> THAT COMPLEXITY.

Okay, I think you're saying "I don't want the common helpers to include
the infrastructure for supporting the ..._sz() variants"?

> So no. We're not doing *any* of that. You make it simple and targeted
> to the *common* case, of you don't do this at all. Because that
> over-designed mess that actually turned some users *less* readable,
> but one line shorter, was bad.

Fair enough. Looking at the treewide change I prepared[1], it's less
than 1% of those mechanical replacements:

$ git show f79ee96ad6a3 | grep -E 'k.*alloc_(objs?|flex)\(' | wc -l
17473
$ git show f79ee96ad6a3 | grep '_sz(' | wc -l
114

I'll respin without the _sz variants, and try to improve the flex stuff.

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=dev/v6.18-rc6/alloc_obj/v5

-- 
Kees Cook
