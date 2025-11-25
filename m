Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95C36D4E8;
	Tue, 25 Nov 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764033010; cv=none; b=mL4f1HljUT8Uq1ucblBK4vRowPpiNkHfAyMyfKbJN3TL863Qs8Qf4m+KjEjYDQK8IFCheHLiSaYT76WfSFJ12bCOeY/0jkXvmBdUIV54pQ/nEbhIkvYzL4Y2Hd75jB+8cEB14BYu7zMB2jgbQcpd4HudhbHVmQBNaIiqC62Tw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764033010; c=relaxed/simple;
	bh=wjk5CUNuNF0f2JkxCDx2/7plyDy9Ph7mBARvo+EvdoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEiJhMXqYQg67NKr4ARJPG1ZJRZLX2cPVii7Jyc7hO6OIJZJk9iltKnUDo5SyUO5mT2qxHUA1V9vLXRFqEa+YPe+wikn3/fLMUJxkZpx6vlRWHgtWvSl5yLK2g0+5pPY+OufZ8KauP5MJtodLMTV3uRTE72QhlXLHFXW8l4jCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DVdKEk5K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DVdKEk5K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kODB23LtSbraMlqmSxfIt3k86wJC3FJBaXEatSPUpUQ=; b=DVdKEk5KJpBpl4fxfo17HNT9Sn
	FguEXYplzXPLC2lfaSPPb+sZHMy3AZtx01hgFGTzP7cs0ll7knzhR/LjNNFeTrTIQQDXpuiTx8NHZ
	ZCBoo299KS4ajjUc7Pt51EG6RLjcAF1A9pRwozBoUWqKBt35C8isgETMOimHohxhxxH6N4eEmC44Z
	nBzm3cIO3FCf0xxvcucbFzT6TfLpIdLjiF00ngCX5H9O0jmqSmtB0V6/fR2vaUmlcVkprQrsiMNAO
	AQXJBEyIo+o12XDvE7T8NXiHzdF0Zed+SI0pTTTLXqrUnNQsx/f3RttycuGMJOe05pnge9Vljdy6T
	vZKmeWKw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhYs-00000007nVS-1SdO;
	Tue, 25 Nov 2025 01:09:42 +0000
Date: Tue, 25 Nov 2025 01:09:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
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
Message-ID: <aSUB1qrfhXp3suGn@casper.infradead.org>
References: <20251122014258.do.018-kees@kernel.org>
 <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook>
 <aSTKLsRNiEKtDqPI@casper.infradead.org>
 <202511241317.516BDE7B@keescook>
 <aSTRsIUPeT5EC5An@casper.infradead.org>
 <CAHk-=wgn-2ieKtaHAXLLge1UFckLKa88vo3XOdLz+fP+DLpHGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgn-2ieKtaHAXLLge1UFckLKa88vo3XOdLz+fP+DLpHGA@mail.gmail.com>

On Mon, Nov 24, 2025 at 03:30:19PM -0800, Linus Torvalds wrote:
> That all a very standard thing in assembly programming, which this is
> all about. 'entry' is a signed offset from its own address.

I used to be an assembly programmer ... 28 years ago.  I've mostly put
that world out of my mind (and being able to write a 20,000 instruction
ARM32 program entirely in assembly is just not that useful an
accomplishment to put on my CV).  Anyway, this isn't the point ...

> > The warning is ... not the best phrased, but in terms of divining the
> > programmer's intent, I genuinely don't know if this code is supposed
> > to zero-extend or sign-extend the s32 to unsigned long.
> 
> What?
> 
> A signed value gets sign-extended when cast to a larger type. That's
> how all of this always works. Casting a signed value to 'unsigned
> long' will set the high bits in the result.
> 
> That's pretty much the *definition* of a signed value. It gets
> sign-extended when used, and then obviously it becomes a large
> unsigned value, but this is how two's complement addition
> fundamentally works.

Yes, agreed.

> So honestly, what's the problem with this code?
> 
> The warning makes no sense, and is garbage. Are we not allowed to add
> signed integers to unsigned 64-bit values now, because that addition
> involves that cast of a signed 32-bit entry to an unsigned 64-bit one?
> 
> There is NO WAY that warning is valid, it's; not *ever* something we
> should enable, and the fact that you people are discussing it as such
> is just crazy.
> 
> That code would not be improved at all by adding another cast (to
> first cast that s32 to 'long', in order to then add it to 'unsigned
> long').
> 
> Imagine how many other places you add integers to 'unsigned long'.
> EVERY SINGLE ONE of those places involves sign-extending the integer
> and then doing arithmetic in unsigned.

I have bad news.  Rust requires it.

fn add(base: u64, off: i32) -> u64 {
    base + off
}

error[E0308]: mismatched types
 --> add.rs:2:12
  |
2 |     base + off
  |            ^^^ expected `u64`, found `i32`

error[E0277]: cannot add `i32` to `u64`
 --> add.rs:2:10
  |
2 |     base + off
  |          ^ no implementation for `u64 + i32`
  |
  = help: the trait `Add<i32>` is not implemented for `u64`
  = help: the following other types implement trait `Add<Rhs>`:
            <u64 as Add>
            <u64 as Add<&u64>>
            <&'a u64 as Add<u64>>
            <&u64 as Add<&u64>>

so the Rust language people have clearly decided that this is too
complicated for your average programmer to figure out, and you need
explicit casts to make it work.
