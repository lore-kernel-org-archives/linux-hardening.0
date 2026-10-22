Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692393;
	b=1p5FyrFHOBBLh/xbkylJxwlNPRdO+MsxKzoErPmiBdTKtWSlJFdkseLaAMu+MQtNJ6bm
	 FWrlGrGjd0ewFXhPP03boFHwc531NgeYbgTlK8Jc8Shv2uTVR3Lplw/mJ8mdQ+kO/31SZ
	 lDpdGO9hIT67exjxes35/MIjUUYa40RrwUrU47y12y3XLdJiR8d9kgYTTlG5s6qOjLqlB
	 hyQUlyfEhQD+2Y1O/clDJDrQcR+jKxoFshRrTadH6sCHCCYzRtOAWoAxVyDLm45ID0X/L
	 EFOgjEwb11t8RlemX+0gruInxMUnizpehovpGdJ5hKef+fp6La6XBkB+S+jW7U7AuQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692393;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Yer8ubWHNy/lk45efo9R29z8i1PYgjz6ECbWxwFT1Cc=;
	b=A5dGlmMH18ySEqpQNF74SjAWLZcIL+vlWL1D7/B8Qx7ZzljnfTP/cxef6c1k9YDyH/QB
	 +Mj8Xto5zMNhcVknjn7vXJntKDxsOhoeSXAoZ8woVyUQsjSonBgrCUA1dqkt1+sPr9shC
	 K1s6kuBEWNw1meZXhpzWlCD1jx/IpLLJl1AH1g72/8SmkZ3WYUS6l6lhZoFT7CccGBekd
	 R0VxQn1Trp4HdFYLhqSQyc0RiSzfIDOqGVIuCfaLiwa/pgro7++aVko+NIbKBqW/jc95r
	 C8BrDx4cKwKm1QWjfgZgbEzgX7MPwG82pL8LeaclJQYNy5LaiyDhMgQMm07MCTyiYFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMHkI0FQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7982606A31A;
	Thu, 22 Oct 2026 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMHkI0FQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5FB1F01825;
	Thu, 22 Oct 2026 18:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792692392;
	bh=Yer8ubWHNy/lk45efo9R29z8i1PYgjz6ECbWxwFT1Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RMHkI0FQgzO7BqMvQqqkHN1EI6E+LTsLJtVis45l5kv6vSsRwUWCN7I5rhEO135ag
	 7QFQJxB3x+co1bNe/ccs9+Etyiw6rvPUCPLTYbKzU3P0vqYzw5JeoNaH2x2VAVJ7EC
	 KqQQl6FmgmY8izVY7rl4MbZeaFEx1jZTnmmiHKp/lj1tTil3V9INjRBb70XdPRNCjY
	 kg42qpwP/yEahDooBakrq/U2IHLMFLUUgtG0SCN9lLjYfiTHykyXrlzOmBJ+f9YEJk
	 BIEsKboa0ILC/+k/bxMQy+RWyhIyP6VKvtvhza++m8n+5eaizFpS1kXEr4sCPb3Qr2
	 R93w+Xaljxx/w==
Date: Thu, 22 Oct 2026 11:06:32 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bill Wendling <morbo@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <202610221058.C5626C5172@keescook>
References: <20261005155653.late.426-kees@kernel.org>
 <20261005155708.1471260-6-kees@kernel.org>
 <20261016145928.16eddc9a@gandalf.local.home>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016145928.16eddc9a@gandalf.local.home>

On Fri, Oct 16, 2026 at 02:59:28PM -0400, Steven Rostedt wrote:
> On Mon,  5 Oct 2026 08:56:56 -0700
> Kees Cook <kees@kernel.org> wrote:
> 
> > +/*
> > + * NUL-terminate the buffer in @s: directly after the data when there is
> > + * room for it, otherwise in the last byte of the buffer. @s->size must not
> > + * be zero.
> > + *
> > + * Returns: the offset of the NUL.
> > + */
> > +static inline size_t __seq_buf_terminate(struct seq_buf *s)
> > +{
> > +	size_t end;
> > +
> > +	if (seq_buf_buffer_left(s))
> > +		end = s->len;
> > +	else
> > +		end = s->size - 1;
> > +
> > +	s->buffer[end] = 0;
> 
> Hmm, I just realized that this could inadvertently overflow the buffer. If
> len == size, it may not be overflowed. If using seq_buf_putmem() and
> filling the entire buffer, calling this would force an overflow as we just
> truncated the last byte.

Hm, yes. So the "else" branch needs to include:

	s->len = s->size + 1;

> 
> > +
> > +	return end;
> > +}
> > +
> >  /**
> >   * seq_buf_str - get NUL-terminated C string from seq_buf
> >   * @s: the seq_buf handle
> > @@ -98,7 +119,14 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
> >   *
> >   * Note, if this is called when the buffer has overflowed, then
> >   * the last byte of the buffer is zeroed, and the len will still
> > - * point passed it.
> > + * point passed it. The same happens when the buffer is exactly
> > + * full: the NUL takes the place of the last byte written, which is
> > + * lost, though seq_buf_used() still counts it.
> > + *
> > + * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
> > + * is returned instead of writing to @s->buffer. Any other seq_buf
> > + * returns @s->buffer, even when it holds an empty string, so callers
> > + * always get their own buffer back.
> >   *
> >   * After this function is called, s->buffer is safe to use
> >   * in string operations.
> > @@ -107,17 +135,44 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
> >   */
> >  static inline const char *seq_buf_str(struct seq_buf *s)
> >  {
> > -	if (WARN_ON(s->size == 0))
> > +	if (s->size == 0)
> >  		return "";
> >  
> > -	if (seq_buf_buffer_left(s))
> > -		s->buffer[s->len] = 0;
> > -	else
> > -		s->buffer[s->size - 1] = 0;
> > +	__seq_buf_terminate(s);
> >  
> >  	return s->buffer;
> >  }
> >  
> > +/**
> > + * seq_buf_strlen - get the length of the NUL-terminated C string in seq_buf
> 
> Hmm,
> 
> I don't really like the way this modifies the string, as the request is
> just to return the string length.
> 
> Just like the above, this could cause an inadvertent overflow.
> 
> I could envision a use case where we want to use the entire buffer and do
> not expect it to be nul terminated. And this function could be used to get
> the length to print. That is, it may want to use the entire length.

Non-C String users would be using seq_buf_used(), not seq_buf_strlen().

> 
> Having "strlen()" modify the string just seems wrong to me.

No, this is absolutely required. It's nonsensical to work on a C String
without termination. (And it's the entire purpose of this series...)

> Is it really needed? If the user wants to make sure the string is
> terminated, it should use the next patch's "seq_buf_terminate()".

The ergonomics on this are very bad. I explicitly don't want to leave a
foot-gun around for this. :) (i.e. require all C String users also
remember to terminate it first; the whole point of the API is to have
the string always be safe.)

> And we need to update it so that if seq_buf_terminate() causes a
> truncation, it needs to set that it overflowed.

That I agree with. I will send a patch on top of the series since this
has been in -next for a while and the merge window is here now. :P

-- 
Kees Cook
