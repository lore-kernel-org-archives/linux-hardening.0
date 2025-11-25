Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98419274FE3;
	Tue, 25 Nov 2025 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042453; cv=none; b=Jjv/OPr/1i3AeboRAY8cXmyb0D5cjvC58GqFUoFukVgVVwGapkcik0e5Z4sVc99rClrL8ewhj2p7wOQowKgjyh00oNR/SS8U/Q+k7ZflGDqHE6RjEIsWL7pBfFZYDvl+2uNnVGwtcrEGCFX0/DTmt+AV/RQA29pIpFc9LPz+rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042453; c=relaxed/simple;
	bh=MbpfEtH3HJcUPzsyYyfonxu3YFWwAuq54Fd4/ZnOAYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV6lwwmxvoGiBh7bG3pc87sm+i6lhcEoH3SiZ/YTG8h0vTw9t+4nx8IWsjSl8MUbflgNWg9VwzhSTVl/uGcKk4g8MBz9jdcZq8AcG/SEorOPKzuv8lxYEcQ/d9qAjRnhwdvcloMh8v+/EC+cYQ9GYKYImV8655D3yXXNiNywywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGziSLEa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGziSLEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6754CC4CEF1;
	Tue, 25 Nov 2025 03:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764042453;
	bh=MbpfEtH3HJcUPzsyYyfonxu3YFWwAuq54Fd4/ZnOAYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGziSLEakKaN74XxtWFkEQAX82reG4g0Bzr3N0r1SXQRAsKAwa/KVzFV2e/REZ4w0
	 xhbGxJRYjhznVK01OwKYSNn4NQtIXo0hoi1hCkP0IPbmwK/HnRedWaqODnFG4AmJCL
	 MfCvzdsGWuo8MKMflYDi6J6KTTEJuOHNLzreuG2NUyWWDqklqYmtYQtJPhaLzB+cQo
	 VILMiaJrn137unmpfOgmPmALxdMSga2zxdOsuqp06tMQ1iolXaW0qBNZI5Iw13Gkmq
	 XlXaaDmBhVwxro9sMg3EkDmFBH4NYlh3kL9SjI3y+AS6+sfpjP2v9t4fBKhcCXz/Ke
	 1CuRmbBRPZ4MQ==
Date: Mon, 24 Nov 2025 19:47:32 -0800
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
Message-ID: <202511241940.8278C53C@keescook>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
 <aSTKLsRNiEKtDqPI@casper.infradead.org>
 <202511241317.516BDE7B@keescook>
 <aSTRsIUPeT5EC5An@casper.infradead.org>
 <CAHk-=wgn-2ieKtaHAXLLge1UFckLKa88vo3XOdLz+fP+DLpHGA@mail.gmail.com>
 <aSUB1qrfhXp3suGn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSUB1qrfhXp3suGn@casper.infradead.org>

On Tue, Nov 25, 2025 at 01:09:42AM +0000, Matthew Wilcox wrote:
> so the Rust language people have clearly decided that this is too
> complicated for your average programmer to figure out, and you need
> explicit casts to make it work.

Yup, and this is correct: "intent" becomes explicit. Doing implicit
extension, narrowing, and truncation is just a mess. As part of the
Overflow Behavior Type work, Justin has also been looking at something
that would allow a typedef to not be allowed to be mixed with other
types (i.e. to do so requires explicit casts). For example:

__strong typedef unsigned short only_u16;
...
only_u16 foo;
int bar = ...;
...
foo = bar; // Build failure: mismatched types
foo = (u16)bar; // okay, explicit truncation

-Kees

-- 
Kees Cook
