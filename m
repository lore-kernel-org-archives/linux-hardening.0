Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279932;
	b=UnwLIiofcTMscYNexnmpba6vVMr4KO0fmAV41j2GRU6+XlXfKlPUubfYBpQ4xyyMC0Y9
	 FohIa0Y3pwS6JSpd9Zg9vS19+nKr7BsEcONg9wBRuDOzCKrXg1io8n2/M6u4SFRg25vmP
	 GyJa6dVGR/DaCwDUv4onUXI2IZxPZHPKO8/JF5tDwYbN5XRTK7mqqmZnJp/Xu6JniISYf
	 vBGCB3qFojQleX2c5x9dpZ8Zv4jydyWtH6bSYX5057BZaj2xT69uFZZvLrSvnhIdZIxx0
	 XB19vjRCFzLB1H0g2AKdL66LqKjwd+97Sfq6cBTi+UmQa1ubCaA0Pf3KYMsfUKTs4Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279932;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=+9XYDfCRrvUivoiUz7z3TeuDRVY7Fxr93i1TYt+3ZnM=;
	b=gXUR65qwIZyWbNqfvjO19hj5nO47hOsZsWfr1vQTCZtB4LBJKSTPLeZUfaAz6x/rVMzl
	 72LZAGqrZjODPMJLnruxxCUmWJij8P2axAiGL8m8RyJoJN/1C/hqdycyuQ4oRdckfBDQp
	 dM2go6XlbY61ANk+YZw7ykPL0nv/4X7nPorUiPAoZSUpWJmgFmGf+yIelVBJq7IYYkPmI
	 FIT2DMXDVj3wyWig2pbPOMsee53pWdL7WYU0Pvq2tfP1E2ltIhzUlE7ahbLP1bGmU5oaD
	 LSwKM56OwBC9VLIhEIRYeILcFiBqiHWWlXxiFqOU831RuEqfxYp9C0UCZk+MYRBASlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PLMQDWbO;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA012606A31D;
	Thu, 29 Oct 2026 13:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA012606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PLMQDWbO
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2FF93A03E6;
	Thu, 29 Oct 2026 13:18:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 0213F2002D;
	Thu, 29 Oct 2026 13:18:46 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:18:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr
 Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Shuvam
 Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <20261029091845.21464a1a@gandalf.local.home>
In-Reply-To: <auMwo_T_FsZp5UsB@devuan>
References: <20261029053250.i.220-kees@kernel.org>
	<auMwo_T_FsZp5UsB@devuan>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 0213F2002D
X-Stat-Signature: ii7jx3yqhuo5tentuhpkydyjj3ugs18y
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Ggy7flGuT3pJl4pfAFY5kwIdBw233O1A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=+9XYDfCRrvUivoiUz7z3TeuDRVY7Fxr93i1TYt+3ZnM=; b=PLMQDWbODAmt/quoHI6B3iDL39mXPgDCkjUwVSajdMkc3Nffvr+xsqTlIcaXuPQ9UnPKlcZn9NGbNbBd6v8OLxppf5gekjVObTiKF5R+rganE48CbCgaJtu3rqmSWGYP125LfrJUB1nrm8PiafoajZe/2/pP7UE41lPdt6/3Nuo=
X-HE-Tag: 1793279926-234888
X-HE-Meta: U2FsdGVkX1+kSgXyut/GEd14B1877Ubg7n1dE2PJkiUImxISYpua7RqK8Fivkp2umWdON2LVrdfM7NXACAyuNbwUi07mjcrTgDpTcZegLwpmmaRtRRyjcGMX+82Ovou4fIg8l7kEOa58f4a4PmuIbagOvQiXJOCZ9OTa3eP2RSMJ0WP0u9j9hIHw0ZUoMJ+0acXAHldHA9wjtgJHc8qOoEGKqetGylZfY4jR5nnXh+GDnmTE1LgJqRLOAnbmiNy7FCtduxMUFjXTuha26rMPxSoVvw3+2nX5JCNDlhtXDMY5Lt8BAkpAG0rB0bJCrHvdwbSnsieale42Uahj8aGr3dMQlZvLCm4o

On Thu, 29 Oct 2026 12:47:04 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> 
> This fix in theory solves the issue.  However, I wonder if this is maybe
> too late to report the overflow.  Callers normally expect the overflow
> to happen while they're performing their writes, and maybe they don't
> expect the overflow to happen at this point, so they might forget to
> test, and keep going with truncated data.

No, the overflow should be checked when they are done with the seq_buf.
Which means after they do either seq_buf_str() or seq_buf_terimnate().

> 
> How about not allowing a full buffer without a NUL terminator in the
> first place?  That is, we could report a _putmem or _putc operation that
> writes a non-zero byte to the last element in the buffer as being
> overflowed.
> 
> This would waste one byte, but would prevent users from having to expect
> a possible overflow when reading a buffer.

This only happens when the user expects the string to have a nul
terminating byte. Don't think too much into this.


> > @@ -137,10 +137,16 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
> >  {
> >  	size_t end;
> >  

Hmm, I was thinking that this should first check if the string is already
terminated with a nul byte. Why add another one if it is?

> > -	if (seq_buf_buffer_left(s))
> > +	if (seq_buf_buffer_left(s)) {

		if (s->len && !s->buffer[s->len - 1])
			return;

> >  		end = s->len;
> > -	else
> > +	} else {
> >  		end = s->size - 1;

		if (!s->buffer[end])
			return;

Otherwise this overflows the buffer even when it is already terminated.

-- Steve


> > +		/*
> > +		 * About to overwrite a written byte in the last position
> > +		 * in the buffer, so it must be considered overflowed now.
> > +		 */
> > +		seq_buf_set_overflow(s);
> > +	}
> >  
> >  	s->buffer[end] = 0;
> >  
