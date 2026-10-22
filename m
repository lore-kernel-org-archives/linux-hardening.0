Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702427;
	b=i8/dYfQGjxzqgGL+pgMf3WU/8OAiC2hGHEazw4w3jH2Q4iH60v5kSJCGGx6KFaz1Yt6z
	 DkSwmSjJCHax7zUrGnOWTYq79cGw2QgtF6S0BLOslzJFK7F+/rv//tB+IRi5iT8pcACxP
	 ZnmlJhTtJaahFs3Ar5ztSQCE6EWlB7iKkPWpMoWUhKZIWt7U4TE8Mpw2VXdMPvZuNZg8e
	 i3kLcPEiXmCBdov+IgEyQqC24QBqwXR3Ep7McDOCEyAUoowoWmTHzMJdHmXrEYi18nBaJ
	 L6VQVqYycvzNZwSCW7l9Dnsk45BFhAuuNj8W5aX7GHhzu0ROWwvQ48IV0y+TJjh4F1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702427;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=mQjVuzb1/ppGtpvK3P8ELxGZQm6eXc6OPqUh5D7uJdg=;
	b=MWhawvKsXZ+Le7pw0iDi5QlXE28XXStxxu6uHxPm/S4qYDpfQ6IeqMWvpfAsgUJBYNr9
	 Z7BxhR7Pd/fc3V8AMOQ9UqXwPfrA59xjRmcPoS25XwGYggh1EByH6gmvNYUexHhFkulAC
	 LXe366HyaL2m/T4ZZUOD+5mCvdHtPZzML6opBD5rGGWns82jL/DANOFnOCe9G1RbZxfQd
	 MwlTib7ACHb0z2G4qued1iZjStimkmocqN99yDAP5qwBrtSN5Kdu0Z38JGot7DR0cIG73
	 fcDmH2ml55h/qlBrQZD8VdvRZtDRa6MTQiB2Py1HnUVji9/7DBC0FaJCZ+hk+lQId1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=DGjxdF7x;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5897606A319;
	Thu, 22 Oct 2026 20:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5897606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=DGjxdF7x
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D77D8A78FC;
	Thu, 22 Oct 2026 20:53:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 89DD18000E;
	Thu, 22 Oct 2026 20:53:37 +0000 (UTC)
Date: Thu, 22 Oct 2026 16:53:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Gow <david@davidgow.net>, Petr
 Mladek <pmladek@suse.com>, Shuvam Pandey <shuvampandey1@gmail.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <20261022165336.3100a5be@gandalf.local.home>
In-Reply-To: <atpyCU3fDyU95hbY@debian>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-6-kees@kernel.org>
	<20261016145928.16eddc9a@gandalf.local.home>
	<202610221058.C5626C5172@keescook>
	<atpmAQ932J3_8IvJ@debian>
	<20261022155726.7f20c4cb@gandalf.local.home>
	<atptYsHyS6YGtzPV@debian>
	<20261022162000.18aa4162@gandalf.local.home>
	<atpyCU3fDyU95hbY@debian>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 89DD18000E
X-Stat-Signature: e3zcrciaahepohnd8bwhgbwpqr1xm7z1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ehAJFysVrxrSXVnagrmOUwNFzCDmggN8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mQjVuzb1/ppGtpvK3P8ELxGZQm6eXc6OPqUh5D7uJdg=; b=DGjxdF7xZ8us3s/XmpfqyfBKArNugJ0yae+fRnOXGhT+ZJbzOWuSC9C0MiA6HGLLdC5Zl+fvwdJh1ALnsDVtgArQl9QtPXfjRImyk7FESju2kUNXcyqTQCSKKaGCZ8FuG4qdO5MMNKa1ZpQxQ5loeJp8sBJDNefmOdv5obwiKoI=
X-HE-Tag: 1792702417-726029
X-HE-Meta: U2FsdGVkX1/7qo9H3VOZWiT76OrpxlDNhstfzpILz+eyXPsnf+BsdappRpV/FYC+L5vZ3fG9uGRth+GEjNbGEddnIyQkVdyqYQ+GBwFzSr8GrcM0GGZNGfh8dLTG7M9TdDmT/YNMOakP0wP/90bhoShrKqElw8DfqxHHDV+BHDMFJe9/sOf8TpKS46mnAirFSenVbOU0ReP8GS9HTn3QICygSrCUXVJefGG5Su6p/9LgPnqMxNHQU7mxE48zyGj76WaCdkNAieIqu/c5rlyGxYkadZ/5hzvUccaeKDAxDTxHMQWOSX/654g7cUaDzRQp78yPPaNUX/LJGDBj5ueu7I/xLycuhuSJ

On Thu, 22 Oct 2026 22:38:03 +0200
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> No, it doesn't lose data.  My proposal is to have this:
> 
> 	struct my_seq_buf {
> 		// .buffer points to the start of the buffer
> 		char  *buffer;
> 
> 		/* .p points to the current position.  This is the last
> 		 * '\0' that has been written to the buffer.  On
> 		 * truncation, it is a NULL pointer.
> 		 */
> 		char  *p;
> 
> 		/* .end always holds ARRAY_END(buffer).  It is a pointer
> 		 * one-past-the-last character in the buffer.
> 		 */
> 		char  *end;
> 	};
> 
> This would be initialized as (of course, wrapper in static inline
> functions as needed) this:
> 
> 	char            buf[100];
> 	struct seq_buf  b;
> 
> 	b.buffer = buf;
> 	b.p = buf;
> 	b.end = ARRAY_END(buf);
> 
> Then, you would write to it as:
> 
> 	b.p = stpecpy(b.p, b.end, "foo");
> 	b.p = stpecpy(b.p, b.end, "bar");
> 	...
> 	b.p = stpecpy(b.p, b.end, "baz");
> 	if (b.p == NULL)
> 		goto fail;
> 
> Then, at some point, you might want to initialize a new buffer out of
> the remainings of it:
> 
> 	struct seq_buf  b2;
> 
> 	if (b.p == NULL)
> 		goto fail;
> 	b2.start = b.p;
> 	b2.p = b.p;
> 	b2.end = b.end;
> 
> See how simple this becomes?  (So much that you may doubt the necessity
> of the set of APIs at all, but they don't hurt much either.)

I rather not increase its size. It is embedded in the trace_seq.

Yes the seq_buf code can be complex, but it's in one location where it can
be highly tested and verified. The point of seq_buf is to do the complexity
so that other places in the kernel doesn't need to.

-- Steve


