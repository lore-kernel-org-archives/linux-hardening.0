Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28C1DFFC;
	Wed,  8 Oct 2025 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897218; cv=none; b=e7TymfbH+a5UzutNgEmZuZCdl4RgvlBzg4KfoQdV56Be39QHhw6UIPvsaNIjRBDiAHb2WmNOPiNhjPiGbTYSEk4N8m37NEg5pnl3+PVBCCZEyOMkabwGlEPQm5QnV4UwoGkSGYVzGuyj/avAhHrH1DDu3zzMKDla/jQXR5NFKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897218; c=relaxed/simple;
	bh=gIXJCsumt6skJ3sfqf5pbZAzlXWzbFT/QpJ0QJ0WoEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WADkLCgpC6hdYYJT8W6WEiPWYzKVtQ6FQ+NCz2s0oP+O0fIalWLA2fCmOVP+ddqn6P978w2VvA8qCvCPs9X2W8AzKQsUENvYhOgVLbtWjYGse7tKfkmgQ30j1F/YdMrhE6rPN2+Xa/Ph2W02DbQ4uEScJjyloHXiQ56zMbcphh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6CHq2N3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6CHq2N3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2A7C4CEF4;
	Wed,  8 Oct 2025 04:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759897217;
	bh=gIXJCsumt6skJ3sfqf5pbZAzlXWzbFT/QpJ0QJ0WoEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6CHq2N3l4B147CgJt+zLqKYq2OtHwUWOsO4RanJM4icby3afXquF+ndgYR6fOYWP
	 H6OZ/NXfzhSG3ZWIrXgmRzfzJY6TdzUbkHIqcFx9jRuywjXfZ30C/ThFcJTssakaHa
	 8Pl8ETsSK4AyBuzZstrEd3Z+lNP+xUGQozD3xFAuMI7GnQHPjOrN8VoYC7s+PuJIdL
	 Sl/LucC+GWoVX24kZ80gXhCu1Zs8uXu1c7fSbZPdvVAmGxtpf/98jY+G3TKds5KbWT
	 ai2+dQBiC4bZTzbrfJnZsICkltmpxolSNNxBAdpghqjU9ZLCyE+8IndaxY2QfLJdx4
	 9jMu/5qAYT2JA==
Date: Tue, 7 Oct 2025 21:20:17 -0700
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
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
	linux-doc@vger.kernel.org, llvm@lists.linux.dev,
	Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
Message-ID: <202510072114.52B93ED736@keescook>
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-2-kees@kernel.org>
 <aOR15Xb6DfolYM0z@casper.infradead.org>
 <202510071001.11497F6708@keescook>
 <e019c59a-ba8b-ec04-dc5b-923cf9dd9d9c@gentwo.org>
 <CANpmjNMsSGY+QEn=GV8S2sXuuQsioikPR+OhGa3+6EoTqYPkHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMsSGY+QEn=GV8S2sXuuQsioikPR+OhGa3+6EoTqYPkHQ@mail.gmail.com>

On Tue, Oct 07, 2025 at 08:18:28PM +0200, Marco Elver wrote:
> On Tue, 7 Oct 2025 at 19:47, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
> >
> > On Tue, 7 Oct 2025, Kees Cook wrote:
> >
> > > But all of that is orthogonal to just _having_ the type info available.
> >
> > iOS did go the path of creating basically one slab cache for each
> > "type" of kmalloc for security reasons.
> >
> > See https://security.apple.com/blog/towards-the-next-generation-of-xnu-memory-safety/
> 
> We can get something similar to that with:
> https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/
> Pending compiler support which is going to become available in a few
> months (probably).
> That version used the existing RANDOM_KMALLOC_CACHES choice of 16 slab
> caches, but there's no fundamental limitation to go higher.

Right -- having compiler support for dealing with types at compile time
means we can create the slab caches statically (instead of any particular
fixed number, even the 16 from RANDOM_KMALLOC_CACHES). Another compiler
feature that might help here is getting a unique u32 for arbitrary type
info, which is also how KCFI works:
https://lore.kernel.org/linux-hardening/20250926030252.2387681-1-kees@kernel.org/

My main issue is that I prefer explicitly exposing the type instead of
having the compiler have to guess. We want it for more than just slab
isolation (e.g. examining alignment).

> Note, this mitigation is likely not as strong as we'd like to without
> SLAB_VIRTUAL (or so I'm told): https://lwn.net/Articles/944647/

True, but both "halves" are needed -- SLAB_VIRTUAL isn't as robust
without the type separation either.

-Kees

-- 
Kees Cook
