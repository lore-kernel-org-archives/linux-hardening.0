Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538B42123F;
	Fri, 16 Oct 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176236; cv=none; b=jajeNOMVWmKIe1WSOwjn4nkkeja4NFDLAJWaK5rPpXVbWo/ZSlfgTxCQa9jvpQ1hmyUwVQFOLc8QHH28YtJlpoRvZaFzsc71SB7wAOVMjx6ix4znEPQpx6wMCwwx9cW+PnBpX6eeJu7TAg+L2I3Ud7L2LQ4lPx/8sja4m0Y5oAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176236; c=relaxed/simple;
	bh=Ak2c5Tpl9zshnaZLyfIhBDvKkYTuKn4W4OpK6mgxa7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEQ/fZbUR/Em9G1+e9ajySmh1XiXBZoHgRCOBdqnJ5QlKpc42QUTyV3SYFWiZ5sTPh/RYBZX4/FxcqNKN4seKOl9lJJwRlTJvYvs20pCD7UfqmDLpiiP0L6qUIsp4XbdkV3Kkt4PXMkKYN/sXq/DKTe465CG7E/9uAQ0NqyT1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=EccIHqfG; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="EccIHqfG"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D24E6140534;
	Fri, 16 Oct 2026 18:43:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 74F7460010;
	Fri, 16 Oct 2026 18:43:50 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:43:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Bill Wendling
 <morbo@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Jiri
 Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, Shuvam Pandey
 <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 05/12] seq_buf: Clear what a writer did not claim
 when a seq_buf overflows
Message-ID: <20261016144349.412a4cbf@gandalf.local.home>
In-Reply-To: <20261006212552.51e0c3-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-5-kees@kernel.org>
	<20261005195926.09e240d9@pumpkin>
	<20261006212552.51e0c3-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jnpfudwi341r9jy6e5hrarxqqf5xmwae
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 74F7460010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19pW5plO3xqqKBJderVXovXcs3Dsc3Xr/Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=b5tZknHayHOpsUkodzmN+EEcGzSDw6BKjpwEFD9bRMc=; b=EccIHqfG2cId6XX47lGhyVdVHzOZ+OeNcgood1Yy5DsxtKUMKjcImRdbS/TtllolKpMqjExZptAN5aD8uZdDGUCFqlLNW1Y7qfaXDRIvWY85jYSe9tCLWaSmKjYOOMgkvqMcP2OZ97rZY+VP+rDrO/lgRXX3STI/ckMDp66ujpY=
X-HE-Tag: 1792176230-109148
X-HE-Meta: U2FsdGVkX18O0howf8PVArtPGEy/UhWoK+SxrtMgOU82uQo5ZbcSWY834ThVahJ3cAdCXAXMy8o15FE6camM3dpqc7VvVniXxDfbHPAnQOTk54PbGFOc/8elY/zmwQzbOZHiCQWw3w+wvozonF2Cc193hHCT52jXHU3g3YxusAD5hTXl/sM2I5NDdRebjQLYRJwL7dCQ6jRbEDhqh925gnKHrm31VXX1zGKze52iAX6x65yuG4I14u58M7EfusZxb1dT5hYFGaeS+bAwf85u99Uc5LQEFpMPeZHOYQ7LDsMmrEoR2F/7QFZrnLkpExsockxR4JjijvNjKKen6hYCJG+2AhOl8XMvthuBKjdYHUXURdNfNWJ22w==

On Tue, 6 Oct 2026 14:26:56 -0700
Kees Cook <kees@kernel.org> wrote:

> On Mon, Oct 05, 2026 at 07:59:26PM +0100, David Laight wrote:
> > >  static inline void
> > >  seq_buf_set_overflow(struct seq_buf *s)
> > >  {
> > > +	if (s->len < s->size)
> > > +		memset(s->buffer + s->len, 0, s->size - s->len);  
> >
> > What is the performance impact of zeroing the buffer?  
> 
> Overflow is never a fast path: it happens at most once per seq_buf
> (after that len > size, so the memset is skipped), and it is already a
> failure the caller has to handle.
> 
> It is also usually zero bytes. printf, bprintf, puts, putmem, and putc
> all fill to the end before overflowing, so len == size and there is
> nothing to clear. Only a writer handed the tail by seq_buf_get_buf()
> that then gives up leaves anything behind (seq_buf_path() with d_path(),
> or landlock's string_escape_mem()), and then the clear covers only the
> space that writer was given, which it may have partly filled.

Correct, overflow means we "failed" (but not critically). And when we do,
it's just remnants that need to be zero'd; so likely to be small.

> 
> > I don't think it would be a good idea to be zeroing the buffer on entry
> > either (I've not looked to see it that happens - but there will be PAGE_SIZE
> > buffers (maybe 64k) that get a a small number of characters written to them).  
> 
> Agreed, and it doesn't: seq_buf_init() writes a single NUL.
> 
> > Writing a single '\0' really ought to be enough.  
> 
> It would be for seq_buf_str(), but once a seq_buf has overflowed,
> seq_buf_used() reports the whole buffer, and seq_buf_print_seq() and
> seq_buf_to_user() copy that many bytes. Whatever followed the NUL (the
> path fragment d_path() left at the end, say) would still reach the
> seq_file or userspace.

Agreed.

-- Steve
