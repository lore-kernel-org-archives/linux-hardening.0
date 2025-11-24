Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F523F431;
	Mon, 24 Nov 2025 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019222; cv=none; b=Y84NfC42+pNcSsN2tLqMbuIjXdxYHaNZGpv2m+LMj9lHy7CqXw4FvWbPsavH1dAq56GKBxx3DzsHrtMEHb6KOJtbxdk25obr6IOgWWV/4ADYcKv3/uRufhKK5LIGE0acJr8n024t8leBwkS29RF7jiKDI+Nvxgm3GM15puqmSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019222; c=relaxed/simple;
	bh=Y94JlBIHLA/laoTq4h3TEpMFWZb/beHXXRUBICAqz4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKqU/tpbEfx3MiTezGN8eenjnQ1sFHUxLlPcuIV67F9UFmsbu39AKxujOmwzH2Ymo3g76S1aaI9C83cptAZf2UoO0zV0t0fQwBEZGOmsGAHz6fh81V9KK1XOhFynNv3Wf/fSQ9+rl9xLos8Wz0kb2su1vFNZS9E2KOiYnnXhTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekqcbge6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekqcbge6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B34C4CEF1;
	Mon, 24 Nov 2025 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764019221;
	bh=Y94JlBIHLA/laoTq4h3TEpMFWZb/beHXXRUBICAqz4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekqcbge6rAcDI+vCK69msAZ9ML3+CijFroR0b3AHsruJPJSvQ3noWvLTMSnppkKFl
	 qXFyify01DoKJErGd0BBVdT105e/DEHg+sxCdybxEwiR2mhdmrcxeWnKu5ccjRczsO
	 DNtfhJTJTxDkZNpH/0Gld6cIW5pFWKnN+GJHBT63x7sNsg/owugYAg10Ujmsn2D2xJ
	 GdWhpkUqmbvxF6CZxjW6wV+OjEvSJRer7UWpG8RrLHChBv/kQWP/+Lm33186vc87VV
	 BJuqTDJYc92FShtapn0/rmaoXHEkZxZcEDW3BJt6KnC/vP3D5RSaW0qntmn7G/CvoJ
	 vpDa8V0/Ngkmg==
Date: Mon, 24 Nov 2025 13:20:21 -0800
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
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
Message-ID: <202511241317.516BDE7B@keescook>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
 <aSTKLsRNiEKtDqPI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTKLsRNiEKtDqPI@casper.infradead.org>

On Mon, Nov 24, 2025 at 09:12:14PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 24, 2025 at 12:38:57PM -0800, Kees Cook wrote:
> > For code like:
> > 
> > 	u8 size;
> > 	...
> > 	size = struct_size(ptr, flex_member, count);
> > 	ptr = kmalloc(size, gfp);
> > 
> > While struct_size() is designed to deal with overflows beyond SIZE_MAX,
> > it can't do anything about truncation of its return value since it has
> > no visibility into the lvalue type. So this code pattern happily
> > truncates, allocates too little memory, and then usually does stuff like
> > runs a for-loop based on "count" instead of "size" and walks right off
> > the end of the heap allocation, clobbering whatever follows it.
> 
> Have we investigated a compiler warning like
> -Wimplicit-arithmetic-truncation that would complain about this kind of
> thing and could be shut up by an explicit cast:
> 
> 	size = (u8)struct_size(ptr, flex_member, count);
> 
> or arithmetic that can be proven to not overflow:
> 	size = struct_size(ptr, flex_member, count) & 0xff;
> 
> Maybe such a warning already exists and it's just too noisy to even
> start thinking about turning it on?

Yes, -Wconversion (W=3) is mind-blowingly noisy, unfortunately.

-- 
Kees Cook
