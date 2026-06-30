Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719E32B127;
	Tue, 30 Jun 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803597; cv=none; b=CJsWP3EbPWDcPSwk1QE+1Wh2cqeP7XTAYtucwB2NfEkTLvU6MfcvIt/W8lQxR4RoQ1WgY4HiOu573NcyuIvCXCQUDCwFaYCxzRYCMMAlHQNqw1OblFwW3KA9BfP96zDIrDAHIGFeM1T5ieoxEFox80oY7qzw13SdldowzeqzBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803597; c=relaxed/simple;
	bh=pOfMh9Hq1daVJVkfP5gj20TYFSvF81WaDS4yyAqyUxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF0oqJFL7YGceKI8BVatzoTKCopA3elli3Mp1bEshTjv35KrwlDRNeH1kjl4H6E/iLC18wJV82KjDY9ToOxAKyP9V724i0I7yOtKFXQcHYwUVZnWnLQBDRSXts431S3cv5Kvdt2JaeS5EcjtJOs6vbptVkXwWb8B3JLgmTW+oBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U7jSTV9Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U7jSTV9Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ltn8huQzDTLXUab9Q5n+aJGIzC9O84HSVZQu7VwWF48=; b=U7jSTV9Y9V8TPzGDfgpk+Nc3iQ
	N51s2r0UBvtoa5D5Cwqa1wU/zyBEV0nJDoaH72pn7R1vMzMTjOWVMOTWdvAVrPaym0wUfyk3K3vOv
	WK+VzKtrfRhtgOQwEJRceav6gmuPgAkhSYFsr6krFi6gcL1rs37IS/Y3EyYt/Lytc3kofSJs9gQED
	dmeJ11zvvjXpkOjC0SYKqqpBJx3ZFBPdXknV4qClRrJjfPfHUlK7kLPOGg582MnAk8mUe/w67uhnI
	C3/NqqVIf/cgWaXb+EILlhOs0+BrNKwZAR/CWqVYH62uROyL+X6uc/wEaFmmip8y6IpU0b4dtd85C
	pNaW6ZcA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weSeR-00000004TzX-0PFH;
	Tue, 30 Jun 2026 07:12:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC4A930036F; Tue, 30 Jun 2026 09:12:57 +0200 (CEST)
Date: Tue, 30 Jun 2026 09:12:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hardening@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
	Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <20260630071257.GQ1181229@noisy.programming.kicks-ass.net>
References: <20260626173444.2252041-1-xmei5@asu.edu>
 <yu6l7zo4dmqcnho7thkf7sk42lt6xkz6uxxwxmg73x23vihlnp@pe7vdut4o2jc>
 <CAPpSM+Qwmv_wsNFnEjtk3GbLdZB_JtH5vW0v-Cj-CyiE8M_UEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpSM+Qwmv_wsNFnEjtk3GbLdZB_JtH5vW0v-Cj-CyiE8M_UEw@mail.gmail.com>

On Fri, Jun 26, 2026 at 10:48:46AM -0700, Xiang Mei wrote:

> >   - The displacement is attacker-chosen (via the immediates) up to 0x100ff,
> >     so the pivot can clear any guard narrower than that in one step.
> >   - ENTER is reachable as a gadget, so a pivot of this size is available
> >     without depending on register state at the hijack site.
> >   - The pivot happens after the control transfer, so it is not constrained
> >     by forward-edge CFI (kCFI / FineIBT).

> Please ignore this line; it is not related since we assume we already
> have a CFH primitive. Sorry for the confusion.

So I am still confused by all this. CFI does remove a ton of CFH
primitives. Until we have Shadow Stacks sorted, ROP will obviously be
the main alternative, but I'm really struggling to justify adding 16
guard pages rather than going after any actual control flow hijacking
primitives.

I mean, if you have a reliable CFH, we should be fixing that. But
somehow I'm thinking that if you do have one, ENTER isn't going to be
the worst of it.

Or am I missing something here?
