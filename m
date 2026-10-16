Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A44CF472;
	Fri, 16 Oct 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177176; cv=none; b=X61i4IrGs3tCRfQXnvp185d8RVmMmzZabncqejpVbeOQzxiBvI4cqwtWWijaBK2MFgIVDghHnuWoFhxUxyhFZAlTZa1K0Zyb+nyatuxqJVS9tA1sxdwqJzen0zEDVIAbvLaAvZFFQAaZES2DhWPbRP4RdMzQegQCZON+FaKPSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177176; c=relaxed/simple;
	bh=SE82WtkxD3iMdt4TLzkrPp58zTT3Uoo24ydLK7unotc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIoXgClcU92Ogi1oKjXPBq+sjIqk208UypZeFlL2ng37L74j7JH+AuV0EPO38A8H/k/HoaS7Frrcvct/5foT1wZ8najcefmDUqX6Kpy8i1kaMsVnMr7HuCdZ3d/iuOJAVTbz1Bzn+CPvOVuaM4oVO5WKWM/uWQSY2kvGX8LzxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=CZBAcBoy; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="CZBAcBoy"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 30267120586;
	Fri, 16 Oct 2026 18:59:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id F257E20028;
	Fri, 16 Oct 2026 18:59:29 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:59:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, David Gow
 <david@davidgow.net>, Petr Mladek <pmladek@suse.com>, Shuvam Pandey
 <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/12] seq_buf: Add seq_buf_strlen()
Message-ID: <20261016145928.16eddc9a@gandalf.local.home>
In-Reply-To: <20261005155708.1471260-6-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
	<20261005155708.1471260-6-kees@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F257E20028
X-Stat-Signature: pn89tsdk89oswkg9hhfch9dzzz9efmqc
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19rM5BHcFbIDbfBveOEFcLCv0s8HJ12Psg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=1dTGUFc0EtUl6CNZDkfh979idcveQZZ2w972/BGTg9o=; b=CZBAcBoyDEL+RCdPjPB8LTyEpnojqVlqJqE+sUmr440ixuLEDvM0u9y3lLAAdquDiT4Epc5XBANEEybXGl5a+dF22u6wRFYCcEan/ulw1DSG73VFFDiKjq/niZRG8KX0Q0OeKJ6Vtb4NkVl/WMPf0UnhCfzkTi6PNCiF+sbNRWA=
X-HE-Tag: 1792177169-774896
X-HE-Meta: U2FsdGVkX1+hs7lnJJHpMaq0WD/JvacbezNNRBX2KjBKdPbzNlxpfKUuVZysSmN729MJqDlw1dXF27PQTgBhQ7UX/IAldjOqkDuN1iFuE3mqWw/KRMw608J5NeRSbftuknunEBo72NtmwwraGa7A4dldNfNpCuQpVhFgb8nniUgQHedpp7i/v2m4R9uYFHmo8/UP1XXwSahH5T241g+Gn6v3K8QCYWaeNvrGXE3r7UarV3mWD60bhMOiSzgLTa4V/tP9VdtE3brJ4gpVW7ylYfnZw4c6JrOaT6lHbf+CTNU1IOxxTYpvV5wx431bGN8oyGid/stTbLy0qZRnAOmyvUNbQxZXTCZv

On Mon,  5 Oct 2026 08:56:56 -0700
Kees Cook <kees@kernel.org> wrote:

> +/*
> + * NUL-terminate the buffer in @s: directly after the data when there is
> + * room for it, otherwise in the last byte of the buffer. @s->size must not
> + * be zero.
> + *
> + * Returns: the offset of the NUL.
> + */
> +static inline size_t __seq_buf_terminate(struct seq_buf *s)
> +{
> +	size_t end;
> +
> +	if (seq_buf_buffer_left(s))
> +		end = s->len;
> +	else
> +		end = s->size - 1;
> +
> +	s->buffer[end] = 0;

Hmm, I just realized that this could inadvertently overflow the buffer. If
len == size, it may not be overflowed. If using seq_buf_putmem() and
filling the entire buffer, calling this would force an overflow as we just
truncated the last byte.

> +
> +	return end;
> +}
> +
>  /**
>   * seq_buf_str - get NUL-terminated C string from seq_buf
>   * @s: the seq_buf handle
> @@ -98,7 +119,14 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>   *
>   * Note, if this is called when the buffer has overflowed, then
>   * the last byte of the buffer is zeroed, and the len will still
> - * point passed it.
> + * point passed it. The same happens when the buffer is exactly
> + * full: the NUL takes the place of the last byte written, which is
> + * lost, though seq_buf_used() still counts it.
> + *
> + * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
> + * is returned instead of writing to @s->buffer. Any other seq_buf
> + * returns @s->buffer, even when it holds an empty string, so callers
> + * always get their own buffer back.
>   *
>   * After this function is called, s->buffer is safe to use
>   * in string operations.
> @@ -107,17 +135,44 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>   */
>  static inline const char *seq_buf_str(struct seq_buf *s)
>  {
> -	if (WARN_ON(s->size == 0))
> +	if (s->size == 0)
>  		return "";
>  
> -	if (seq_buf_buffer_left(s))
> -		s->buffer[s->len] = 0;
> -	else
> -		s->buffer[s->size - 1] = 0;
> +	__seq_buf_terminate(s);
>  
>  	return s->buffer;
>  }
>  
> +/**
> + * seq_buf_strlen - get the length of the NUL-terminated C string in seq_buf

Hmm,

I don't really like the way this modifies the string, as the request is
just to return the string length.

Just like the above, this could cause an inadvertent overflow.

I could envision a use case where we want to use the entire buffer and do
not expect it to be nul terminated. And this function could be used to get
the length to print. That is, it may want to use the entire length.

Having "strlen()" modify the string just seems wrong to me.

Is it really needed? If the user wants to make sure the string is
terminated, it should use the next patch's "seq_buf_terminate()".

And we need to update it so that if seq_buf_terminate() causes a
truncation, it needs to set that it overflowed.

-- Steve


> + * @s: the seq_buf handle
> + *
> + * This makes sure that the buffer in @s is NUL-terminated, exactly as
> + * seq_buf_str() does, and returns the length of the resulting string
> + * without walking it. Unlike seq_buf_used(), this does not count the byte
> + * given up to the NUL when the buffer is full or has overflowed. When the
> + * buffer is exactly full, that byte is the last one written, and calling
> + * either function loses it.
> + *
> + * A zero-sized seq_buf holds no string, so 0 is returned without writing
> + * to @s->buffer, matching what seq_buf_str() returns for one.
> + *
> + * After this function is called, s->buffer is safe to use
> + * in string operations.
> + *
> + * Returns: the offset of the NUL that terminates @s->buffer. That is the
> + * length of the string unless an earlier NUL is in the way, either one the
> + * data written to @s carried itself, or one seq_buf_set_overflow() left
> + * behind when it cleared what no writer had claimed.
> + */
> +static inline size_t seq_buf_strlen(struct seq_buf *s)
> +{
> +	if (s->size == 0)
> +		return 0;
> +
> +	return __seq_buf_terminate(s);
> +}
> +
>  /**
>   * seq_buf_get_buf - get buffer to write arbitrary data to
>   * @s: the seq_buf handle
