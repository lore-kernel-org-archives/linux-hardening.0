Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA32F43;
	Sat, 18 May 2024 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716009094; cv=none; b=I/IN6osR/93fEUBYvp7mwa5Xw/S6ckpGuVuQgr9kU5YAxfhptxfyfogWLcM/XTQl1XABaNJAnc2C2epQMzFXZPWrcibErN2jpHLf5NMoflLzQ9f4i3p9gpeRVcyPjeNS9i8H/noK10D1CoOjaCqN4VMpZNpu27MknpnuHHPw+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716009094; c=relaxed/simple;
	bh=EsXtHbU2yk5VmkzRSlicLeffzpHEB9yQz3OE5uXkSWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZZ/WwQAXKYUPv1ySxqDtZdsAOn7p+JqKbF9pb+Bd5oemuOPjOBW7BtDq18eRkbWoNE3ROJ7WiXIIHm5t8ss5q+pyvOlZvviiE/xpyeFvrwGCAZrePoVAGXllmsK7FF9n9AbpbtMZEXJQ504cgQHe/oeficj7B8eS6NREbnwbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fJOMrUGX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJOMrUGX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RoAGfadQ7PdVFjjVcYuXWttxVHnjeRkrlb3syjR3P+0=; b=fJOMrUGXOjxXmyL5KL1dhgWmka
	EGheI4UAYl0+iPcoNaHQ43zTsjOYaHU7TVJLZwADXTXWhZk5uGgyfoTsjcjbirLkX+TGJmnP791IO
	7/n7p/ajmhCgw+/V7/+g2HtBGWsxM/FL4vvG13jN6ryuIRYeObpzEihyhX9FFqQef7yp/yAE2te//
	nU9KcIEHlmvv3+GyvIduCMJNO7UqY24/nAgVZxk4fpcJHmmEb3qvxe0maDgG88Rb64OMz+t+PbiVd
	pWzHe7e/3T91gTLXiTvGWDdpVD1ulOGHmtwg7i4nAy2pHLfEIpCnVtjV2s7w2wlFvsg6OR9hirClN
	BMKMoKaA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8CLu-0000000DhSK-1QJh;
	Sat, 18 May 2024 05:11:26 +0000
Date: Sat, 18 May 2024 06:11:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <Zkg4fl1t6sKGPSb6@casper.infradead.org>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405081949.0565810E46@keescook>

On Wed, May 08, 2024 at 11:11:35PM -0700, Kees Cook wrote:
> 	Or even just simple math between u8s:
> 
> 	while (xas->xa_offset == 255) {
> 		xas->xa_offset = xas->xa_node->offset - 1;
> 
> 	Is it expecting to wrap (truncate)? How is it distinguished from
> 	the "num_elems++" case?

Hi ;-)

This looks to me like it's walking up the tree, looking to go to the
'prev' element.  So yes, the wrapping from 0 to 255 is intentional,
because once we find an offset that's not 0, we've set offset to the
right one.  Just to give more context, here's the few lines around it:

        if (xas->xa_offset != get_offset(xas->xa_index, xas->xa_node))
                xas->xa_offset--;

        while (xas->xa_offset == 255) {
                xas->xa_offset = xas->xa_node->offset - 1;
                xas->xa_node = xa_parent(xas->xa, xas->xa_node);
                if (!xas->xa_node)
                        return set_bounds(xas);
        }

So it's kind of nasty.  I don't want to write it as:

	while (xas->xa_offset == 0) {
		xas->xa_offset = xas->xa_node->offset;
		xas->xa_node = xa_parent(xas->xa, xas->xa_node);
	}
	xas->xa_offset--;

because there's that conditional subtraction before the loop starts.
The xarray test-suite is pretty good if anyone thinks they have a clearer
way to write this loop ...
