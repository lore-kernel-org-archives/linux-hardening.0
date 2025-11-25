Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA99316900
	for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071704; cv=none; b=WffkyH8PDouICswTK12lKXbLvFaltdYsdI/aIh2LfM6gMbf1il9iV1nMxE/UT+Ih92c3B4pgluC5fyirzxqdWZR36tKGTloSTQU39Sm6AO5bq1wJKFlFtV2jbhrWldm7zCQ1d5TEhaSy4sER8AD724sTHs4N2Db6XKHfwxvKCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071704; c=relaxed/simple;
	bh=BPWfFIUTpCxOb1fWxTd/JDnjJ3ZqgKBG+StcP6J882c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNsYGDptKP1v1U4O8QZwmpLRGzbWmpdyJel+dBS80crKuZSd1ULXzx5Mi2ZCAdcWHPTpm3MT4t/q3b6RHGdoO7K60gLtCEt1+pRGswEGyn4GxScmyj5HkcLFEsLRtxHI5W4nlbFWOn+df8msuYXiVb0IEC7wVQINeFa8STcSBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=EsKve/ru; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="EsKve/ru"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vNrd0-006412-Sv; Tue, 25 Nov 2025 12:54:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=nh1yNsaA292fV48gsHMIHyahU+adY0Wr/dx1SDRWz+0=; b=EsKve/ruDXUky0Bwr9Xi1Sg5vp
	7NtQbfQbv8jtsD9obrDBg+F/qyUUADAC+gcoummm2LjVYk07NWvAosJ0qNxceq/6T+r9w7/IwbD1R
	0ntJ/uvks7vKhNaWoxjV/HGAiC3R+uQFHH0Uhd+KSlgYGy33sleRXhSgpUMuP4ZeWI44IA/0s0QKk
	/NuPzCOz9OoQ8/RWcaZSdoJKqlqO+bP10xlt0FX9+WTE4OwahixrhZyy7XIamoaaAbLiyklRLZBo6
	3FpwZghadJ9jkY1cdf8PTNqTLV0flKUCWz6KsHaMucyoIhuJ1A/h4Y1F4toewDR0c+nmvu+UbUBtQ
	e3mKoqAg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vNrcy-0006lj-Dg; Tue, 25 Nov 2025 12:54:36 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vNrcl-00C0XM-Jr; Tue, 25 Nov 2025 12:54:23 +0100
Date: Tue, 25 Nov 2025 11:54:19 +0000
From: david laight <david.laight@runbox.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook
 <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter
 <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
 <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
 <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Jann Horn <jannh@google.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
 <sashal@kernel.org>, linux-mm@kvack.org, Randy Dunlap
 <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Vegard Nossum
 <vegard.nossum@oracle.com>, Harry Yoo <harry.yoo@oracle.com>, Nathan
 Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao
 <laoar.shao@gmail.com>, Tony Ambardar <tony.ambardar@gmail.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
Message-ID: <20251125115419.304dd2a9@pumpkin>
In-Reply-To: <aSUB1qrfhXp3suGn@casper.infradead.org>
References: <20251122014258.do.018-kees@kernel.org>
	<20251122014304.3417954-2-kees@kernel.org>
	<CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
	<202511241119.C547DEF80@keescook>
	<aSTKLsRNiEKtDqPI@casper.infradead.org>
	<202511241317.516BDE7B@keescook>
	<aSTRsIUPeT5EC5An@casper.infradead.org>
	<CAHk-=wgn-2ieKtaHAXLLge1UFckLKa88vo3XOdLz+fP+DLpHGA@mail.gmail.com>
	<aSUB1qrfhXp3suGn@casper.infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 01:09:42 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Nov 24, 2025 at 03:30:19PM -0800, Linus Torvalds wrote:
> > That all a very standard thing in assembly programming, which this is
> > all about. 'entry' is a signed offset from its own address.  
> 
> I used to be an assembly programmer ... 28 years ago.  I've mostly put
> that world out of my mind (and being able to write a 20,000 instruction
> ARM32 program entirely in assembly is just not that useful an
> accomplishment to put on my CV).  Anyway, this isn't the point ...
> 
> > > The warning is ... not the best phrased, but in terms of divining the
> > > programmer's intent, I genuinely don't know if this code is supposed
> > > to zero-extend or sign-extend the s32 to unsigned long.  
> > 
> > What?
> > 
> > A signed value gets sign-extended when cast to a larger type. That's
> > how all of this always works. Casting a signed value to 'unsigned
> > long' will set the high bits in the result.
> > 
> > That's pretty much the *definition* of a signed value. It gets
> > sign-extended when used, and then obviously it becomes a large
> > unsigned value, but this is how two's complement addition
> > fundamentally works.  
> 
> Yes, agreed.
> 
> > So honestly, what's the problem with this code?
> > 
> > The warning makes no sense, and is garbage. Are we not allowed to add
> > signed integers to unsigned 64-bit values now, because that addition
> > involves that cast of a signed 32-bit entry to an unsigned 64-bit one?
> > 
> > There is NO WAY that warning is valid, it's; not *ever* something we
> > should enable, and the fact that you people are discussing it as such
> > is just crazy.
> > 
> > That code would not be improved at all by adding another cast (to
> > first cast that s32 to 'long', in order to then add it to 'unsigned
> > long').
> > 
> > Imagine how many other places you add integers to 'unsigned long'.
> > EVERY SINGLE ONE of those places involves sign-extending the integer
> > and then doing arithmetic in unsigned.  
> 
> I have bad news.  Rust requires it.
> 
> fn add(base: u64, off: i32) -> u64 {
>     base + off
> }
> 
> error[E0308]: mismatched types
>  --> add.rs:2:12  
>   |
> 2 |     base + off
>   |            ^^^ expected `u64`, found `i32`
> 
> error[E0277]: cannot add `i32` to `u64`
>  --> add.rs:2:10  
>   |
> 2 |     base + off
>   |          ^ no implementation for `u64 + i32`
>   |
>   = help: the trait `Add<i32>` is not implemented for `u64`
>   = help: the following other types implement trait `Add<Rhs>`:
>             <u64 as Add>
>             <u64 as Add<&u64>>
>             <&'a u64 as Add<u64>>
>             <&u64 as Add<&u64>>
> 
> so the Rust language people have clearly decided that this is too
> complicated for your average programmer to figure out, and you need
> explicit casts to make it work.
> 

Jeepers...
As I've found looking at min_t() you can't trust kernel programmers
(never mind 'average' ones) to use the correct cast.
It wouldn't surprise be if the casts cause more bugs that the automatic
conversions that C does.

It wouldn't be as bad if there were separate 'casts' for widening and narrowing.
You also need the compiler to be doing 'value tracking' rather than just
looking at the types.
If I do:
	int len = read(.....);
	if (len < 0)
		return -1;
	if (len > sizeof (...))
		...
then -Wsign-compare complains, but a statically_true(len >= 0) is fine.

	David

