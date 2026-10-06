Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9B3C9EE8;
	Tue,  6 Oct 2026 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322018; cv=none; b=l4fMODAksLK98fL0Kgf0B2E+QD7Pa0PHqMForgD9FR+zPAaiWWwjgBF8fmEjYWWwb5KfT9yTCmSQ/e8CWzGhnYgGd4qB45WA1dj/2ki4APGeZI2ZaCAMnaClHt20dfFOTjZiD1V8lsoeuSp0VRugG5CF99y+8GWH8yt2XUyHnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322018; c=relaxed/simple;
	bh=RBxZcz13HqusDPqdjZYgXjoEUV06YdseznW3ECZNhao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIxjyvFHg1dB9amNt4KSnBIQH+rjQ0D8NP/nR6Xklwmki4CFurGv0V+XLXbBjpnymnbM96K82MvRSg8pktxYjWyzc33Fg2X7jw+krX6LH/Q4uQi6v+SqB719wIm+gf+u5DPp8BhwHVlYL0rVvgDdOPO7/BAGYZkHHIdkvP9lJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5sfc6Ho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5sfc6Ho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6AA1F0089B;
	Tue,  6 Oct 2026 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322017;
	bh=1z0CWMIG8Xx75tW81lbRapcaTaUwf83e8p6ttT8hVAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U5sfc6HoK1Bu8Uuz4xGuQyeHb4Y4vtkN2ODahZPkqE5tAscoKBI8oYUQbnJ2eu3VA
	 9g93IZ7QGd/VR3Xi5PzybOArRdPhW2ppDMEKKoAwpimoDgC/G/61eBvGLJx0trfghU
	 DxRhR52S4TzBizBDztTA/PTyvpv2+Pr4TAloR3RWoSqETTfn0vPectX2nGPoGH1gWR
	 jqS6UR3to7XWzVVl0wVn3L5LiB936ZxlrI4ELdvOsNYfr0bJhoRIxq1mGPRDO3AVo6
	 LKgBtvMZfMwNTENp96dzGlo2rHltI5waKmOI21dr/Gv8UHvp2HqjESFGtXaQB5zZCi
	 f7r4kDyW3NRLg==
Date: Tue, 6 Oct 2026 14:26:56 -0700
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Bill Wendling <morbo@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <david@davidgow.net>, Jiri Kosina <jikos@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 05/12] seq_buf: Clear what a writer did not claim when
 a seq_buf overflows
Message-ID: <20261006212552.51e0c3-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-5-kees@kernel.org>
 <20261005195926.09e240d9@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005195926.09e240d9@pumpkin>

On Mon, Oct 05, 2026 at 07:59:26PM +0100, David Laight wrote:
> >  static inline void
> >  seq_buf_set_overflow(struct seq_buf *s)
> >  {
> > +	if (s->len < s->size)
> > +		memset(s->buffer + s->len, 0, s->size - s->len);
>
> What is the performance impact of zeroing the buffer?

Overflow is never a fast path: it happens at most once per seq_buf
(after that len > size, so the memset is skipped), and it is already a
failure the caller has to handle.

It is also usually zero bytes. printf, bprintf, puts, putmem, and putc
all fill to the end before overflowing, so len == size and there is
nothing to clear. Only a writer handed the tail by seq_buf_get_buf()
that then gives up leaves anything behind (seq_buf_path() with d_path(),
or landlock's string_escape_mem()), and then the clear covers only the
space that writer was given, which it may have partly filled.

> I don't think it would be a good idea to be zeroing the buffer on entry
> either (I've not looked to see it that happens - but there will be PAGE_SIZE
> buffers (maybe 64k) that get a a small number of characters written to them).

Agreed, and it doesn't: seq_buf_init() writes a single NUL.

> Writing a single '\0' really ought to be enough.

It would be for seq_buf_str(), but once a seq_buf has overflowed,
seq_buf_used() reports the whole buffer, and seq_buf_print_seq() and
seq_buf_to_user() copy that many bytes. Whatever followed the NUL (the
path fragment d_path() left at the end, say) would still reach the
seq_file or userspace.

-Kees

-- 
Kees Cook
