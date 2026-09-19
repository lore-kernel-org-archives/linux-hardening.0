Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD320459A;
	Sat, 19 Sep 2026 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803636; cv=none; b=NegYKHKn86rIcIG7cSRqn61lB+0Ro7jClCp23q27o0fXtll795pnI9/MyzbxZ+DXcaedGj4rNM8eJMp8sAo//uE3xFQ4jPsn8+C/UEBWXWT0SEZh60BNYfMtU9B8Gh3ETcGEBpND8r9TE3MRehdQqfYp057NkFqeDV87qZplQWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803636; c=relaxed/simple;
	bh=b4XC8pFgy8SibqxRo3KvVP+Sdv2BadX3pNjx7kdwo7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3qpr1/SKqOuleHus6VQjFVUrqSRgpasPoBtLOzrRfgIfLMq3VcIe5C8pAY4s5vN9o6sEY6NAboy0u4+oB7F6ylS68XkXeifiELK8jF02ejRC5kRIzHsofiBOcUsz/+2NzzuPuceKqKgARcpI0c0EwNX8vsUsvJQJdQIeiCQL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5wB9UTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5wB9UTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16D71F000FF;
	Sat, 19 Sep 2026 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789803634;
	bh=32KnHzix0FAuLtDQVWZ5aYpDZe4kSLHNqUlOA7Y6dsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J5wB9UTUBuANbFeZjFW9/QsfXaf4yrVCQ2/7Rj8jX4um/IY1bHHsaX3v4t7dUVOTW
	 2QyeQGJGwZRPdMT9jygu/9z5SkZnpRW2U5rr2MToE4BalX+VDiON+WWjaLyQndeacI
	 enLsiUV6ROr6gBoCpVwfyMwKdrKl5mi93bm9UOZ8=
Date: Sat, 19 Sep 2026 08:38:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Message-ID: <2026091953-cherub-empty-ef35@gregkh>
References: <20260919002658.stay.929-kees@kernel.org>
 <20260919002714.4060307-5-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919002714.4060307-5-kees@kernel.org>

On Fri, Sep 18, 2026 at 05:27:03PM -0700, Kees Cook wrote:
> +/**
> + * seq_buf_strlen - get the length of the NUL-terminated C string in seq_buf
> + * @s: the seq_buf handle
> + *
> + * This makes sure that the buffer in @s is NUL-terminated, exactly as
> + * seq_buf_str() does, and returns the length of the resulting string
> + * without walking it. Unlike seq_buf_used(), this does not count the byte
> + * given up to the NUL when the buffer is full or has overflowed. When the
> + * buffer is exactly full, that byte is the last one written, and calling
> + * either function loses it.
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
> +	if (WARN_ON(s->size == 0))
> +		return 0;

Why WARN_ON()?  Are you wanting to just mint new CVEs with this code
path, do we not give out enough already?  :)

I can see returning 0, if it's empty, but isn't that a valid check for
people to wish to know at times?  Why crash the box?  (remember about
panic-on-warn being enabled in a few billion Linux instances...)

thanks,

greg k-h
