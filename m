Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389989;
	b=nbC1hZgdDeaYoyHeH/TdjC5mnoy1cJubx5oC2SxEHi83uSNLdC2W51LZoOAXriXHzZ+6
	 jA051VxGOVyEZDkn2pFYUhFJ9R9YkZsdc837H4BoCUySTZvFw9X37qM5HnJw3hDrx6s85
	 rJKpIHPVYKPlISRQf/0pQv7Lv6+zUgf+k+Kr6A1hdi+oj1D6XG9i5JTKw7+RFaqczMf5Q
	 PfG06jbzNkiXIS+Wynm+p0KwuHKvmNrI25lJ+VClTrN00k5todQum/y8LLdpivruEX/wT
	 h/WaxAaOd8SV9upCVbLk1SDma4SrIP0SXHrVWkZLTHMI7Pf5eM9j/EEXGRoH5nSJigw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389989;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=p5kxFp8WQmj1NKZO9AXpN42qfE8cadxIMzlm0EeJezk=;
	b=jJOHtQFY7P8+GwV3TfDSsW9FW1sXBSxog0L6NedFrEFdcFBc55zJXRRLrKb34LSH4qhz
	 bj3B1+qP35Z42E31Xn6c/EydyyF/9s86Y7DcBvsK0hzXWT3uJpQRhZ2oKyXn6ESr9qqu+
	 4YPSg9FhnCgPa+4uI0p7fEBV95tLy3UjLTa1iAWuEYzo14ViwRVLb0XvZXGRajPbvoRV2
	 kSJkAmi+xgZoSWQTPZSD0rr2slV45PvkrbmT+bcADyD7tX0WT0q8FijiS91zHd4mG3tkP
	 NzQ9Km/7aoDtU+9CuaRT9JoCaO74wRVNZ+TpaRX4K0gq+tLh664K/mGXBFaW4NQJB8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=cGLX5SjB;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76659606A320;
	Fri, 30 Oct 2026 19:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76659606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=cGLX5SjB
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1BB041607F2;
	Fri, 30 Oct 2026 19:53:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id E6E1A20016;
	Fri, 30 Oct 2026 19:53:03 +0000 (UTC)
Date: Fri, 30 Oct 2026 15:53:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bill Wendling <morbo@google.com>, Petr
 Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Shuvam
 Pandey <shuvampandey1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <20261030155302.6d69a571@gandalf.local.home>
In-Reply-To: <20261030192049.stay.397-kees@kernel.org>
References: <20261030192049.stay.397-kees@kernel.org>
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
X-Stat-Signature: 7nuc84ptuxhjrp9ana4u6brxwujhip81
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E6E1A20016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18zfwm1MxBD5mQUeCpUvgbuLMxw0Vitosc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=p5kxFp8WQmj1NKZO9AXpN42qfE8cadxIMzlm0EeJezk=; b=cGLX5SjB+hPpvyQfCs9fJL4BrD18TTB97Mh+mCnYTivUM4r5Uxd0Ne/MftNQPwCJPJOyBIJFY0nOtsaRyNkr124NFoXFE4GCwCmzOMFgxFq78ZZms3j/5XyTiSb+wGtyG54OUlsE+op7oROQQqbRSdbdqn+26QMAjAHxwU8mGYs=
X-HE-Tag: 1793389983-472225
X-HE-Meta: U2FsdGVkX19l2EpssRwRHCn+7bR1CPVwMzJvd9uSG9k25pvmz179R3uqIoWAtr+ACK7BGYImQ4rselfNX91hKtsgMofDaTfIprsB2pSFbSYdCiKIFfP+L6Qd/ctZIlXhVqzubc+it0qX13b05XUs6sSlk2wq/86b7PeAwTiv4pJRkvennlHDZhBwsq6Ow2qWQAitm9CkM995+eozlUkIxVOgGC9D3Zuh8XemE9IZEy/ESacmXRg3LdjHAVCMwqRfVkkBmqciKICRnZbBoc+/wrBHORdyRS9U38sCQmoNjzOENScCsEriRj752I7Ze21IPvV0b+cKU92rkCtPkpUK2qbBcfXoA71s

On Fri, 30 Oct 2026 12:20:54 -0700
Kees Cook <kees@kernel.org> wrote:

> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index f006f2654e4c..1b38c3844e96 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -128,8 +128,9 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
>  
>  /*
>   * NUL-terminate the buffer in @s: directly after the data when there is
> - * room for it, otherwise in the last byte of the buffer. @s->size must not
> - * be zero.
> + * room for it, otherwise in the last byte of the buffer, which marks @s as
> + * overflowed. Data that already ends in a NUL is left as it is, and @s is
> + * not marked. @s->size must not be zero.

Hmm, "left as is" I think sounds better than "left as it is". But either
way, I think the ", and @s is not marked" can be removed as saying the data
is left as is, already covers that.

>   *
>   * Returns: the offset of the NUL.
>   */
> @@ -137,10 +138,20 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
>  {
>  	size_t end;
>  
> -	if (seq_buf_buffer_left(s))
> +	if (seq_buf_buffer_left(s)) {
> +		if (s->len && !s->buffer[s->len - 1])
> +			return s->len - 1;
>  		end = s->len;
> -	else
> +	} else {
>  		end = s->size - 1;
> +		if (!s->buffer[end])
> +			return end;
> +		/*
> +		 * About to overwrite a written byte in the last position
> +		 * in the buffer, so it must be considered overflowed now.

Have you been reading software requirement specs? The "must" seems a bit
excessive ;-)

How about just:

		* The last byte of data has been overwritten by a NUL
		* character, so mark the seq_buf as overflowed.


> +		 */
> +		seq_buf_set_overflow(s);
> +	}
>  
>  	s->buffer[end] = 0;
>  
> @@ -158,7 +169,9 @@ static inline size_t __seq_buf_terminate(struct seq_buf *s)
>   * the last byte of the buffer is zeroed, and the len will still
>   * point passed it. The same happens when the buffer is exactly
>   * full: the NUL takes the place of the last byte written, which is
> - * lost, though seq_buf_used() still counts it.
> + * lost, so @s is marked as overflowed, though seq_buf_used() still
> + * counts that byte. When that byte is a NUL already, nothing is lost
> + * and @s is left as it is.

Hmm, "as it is" or "as is", whichever. Maybe it's a colloquialism for me.

>   *
>   * A zero-sized seq_buf has nowhere to put a NUL, so the empty string
>   * is returned instead of writing to @s->buffer. Any other seq_buf
> @@ -189,7 +202,9 @@ static inline const char *seq_buf_str(struct seq_buf *s)
>   * without walking it. Unlike seq_buf_used(), this does not count the byte
>   * given up to the NUL when the buffer is full or has overflowed. When the
>   * buffer is exactly full, that byte is the last one written, and calling
> - * either function loses it.
> + * either function loses it and marks @s as overflowed, unless it is a NUL
> + * itself. Data that ends in a NUL is already terminated, so its length
> + * does not count that NUL.
>   *
>   * A zero-sized seq_buf holds no string, so 0 is returned without writing
>   * to @s->buffer, matching what seq_buf_str() returns for one.
> diff --git a/lib/tests/seq_buf_kunit.c b/lib/tests/seq_buf_kunit.c
> index fc53e9ef844c..7f9cd5855922 100644
> --- a/lib/tests/seq_buf_kunit.c
> +++ b/lib/tests/seq_buf_kunit.c
> @@ -504,13 +504,13 @@ static void seq_buf_do_printk_test(struct kunit *test)
>  	seq_buf_putc(&s, '!');
>  	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&s));
>  	KUNIT_ASSERT_EQ(test, seq_buf_used(&s), 8);
> -	KUNIT_ASSERT_EQ(test, strlen(seq_buf_str(&s)), 7);
>  
>  	seq_buf_printk_run(&capture, &s);
>  
>  	/* The one line that was written, and nothing after it. */
>  	KUNIT_EXPECT_EQ(test, seq_buf_printk_marked, 1);
>  	KUNIT_EXPECT_EQ(test, seq_buf_printk_empty, 0);
> +	KUNIT_EXPECT_EQ(test, strlen(seq_buf_str(&s)), 7);
>  
>  	/* Check that lines without a trailing newline are shown. */
>  	seq_buf_puts(&t, SEQ_BUF_PRINTK_MARKER "\n" SEQ_BUF_PRINTK_MARKER);
> @@ -630,7 +630,8 @@ static void seq_buf_strlen_full_test(struct kunit *test)
>  	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
>  	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
>  	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&s), 3);
> -	/* seq_buf_strlen() terminates the buffer by itself. */
> +	/* seq_buf_strlen() terminates the buffer by itself, losing the 'd'. */
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
>  	KUNIT_EXPECT_EQ(test, s.buffer[3], '\0');
>  	KUNIT_EXPECT_EQ(test, strnlen(s.buffer, s.size), 3);
>  	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> @@ -649,6 +650,7 @@ static void seq_buf_strlen_full_test(struct kunit *test)
>  	seq_buf_commit(&t, len);
>  	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&t));
>  	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 7);
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
>  	KUNIT_EXPECT_EQ(test, t.buffer[7], '\0');
>  	KUNIT_EXPECT_EQ(test, strnlen(t.buffer, t.size), 7);
>  	KUNIT_EXPECT_STREQ(test, seq_buf_str(&t), "zzzzzzz");
> @@ -735,6 +737,82 @@ static void seq_buf_terminate_test(struct kunit *test)
>  	KUNIT_EXPECT_STREQ(test, buf, "untouched");
>  }
>  
> +static void seq_buf_terminate_full_test(struct kunit *test)
> +{
> +	DECLARE_SEQ_BUF(s, 4);
> +	DECLARE_SEQ_BUF(t, 4);
> +	DECLARE_SEQ_BUF(u, 4);
> +	DECLARE_SEQ_BUF(v, 4);
> +
> +	/*
> +	 * Terminating a buffer that is exactly full puts the NUL over the
> +	 * last byte written, so what it holds is truncated, and each of
> +	 * seq_buf_str(), seq_buf_strlen() and seq_buf_terminate() must mark
> +	 * it overflowed.
> +	 */
> +	seq_buf_putmem(&s, "abcd", 4);
> +	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&s));
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&s));
> +	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
> +	/* The NUL must not be popped in place of the 'd' it replaced. */
> +	KUNIT_EXPECT_EQ(test, seq_buf_pop(&s), -1);
> +
> +	seq_buf_putmem(&t, "abcd", 4);
> +	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&t));
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 3);
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&t));
> +
> +	seq_buf_putmem(&u, "abcd", 4);
> +	KUNIT_ASSERT_FALSE(test, seq_buf_has_overflowed(&u));
> +	seq_buf_terminate(&u);
> +	KUNIT_EXPECT_TRUE(test, seq_buf_has_overflowed(&u));
> +	KUNIT_EXPECT_STREQ(test, u.buffer, "abc");
> +
> +	/* With room left for the NUL, nothing is lost. */
> +	seq_buf_putmem(&v, "abc", 3);
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&v), "abc");
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&v), 3);
> +	seq_buf_terminate(&v);
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&v));
> +	KUNIT_EXPECT_EQ(test, seq_buf_pop(&v), 'c');
> +}
> +
> +static void seq_buf_terminate_written_nul_test(struct kunit *test)
> +{
> +	DECLARE_SEQ_BUF(s, 4);
> +	DECLARE_SEQ_BUF(t, 4);
> +	DECLARE_SEQ_BUF(u, 4);
> +	DECLARE_SEQ_BUF(v, 8);
> +
> +	/*
> +	 * A buffer filled exactly by data that ends in its own NUL is
> +	 * already terminated, so nothing written is lost, and none of
> +	 * seq_buf_str(), seq_buf_strlen() and seq_buf_terminate() may mark
> +	 * it overflowed.
> +	 */
> +	seq_buf_putmem(&s, "abc", 4);
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&s), "abc");
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&s));
> +	KUNIT_EXPECT_EQ(test, seq_buf_used(&s), 4);
> +
> +	seq_buf_putmem(&t, "abc", 4);
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&t), 3);
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&t));
> +
> +	seq_buf_putmem(&u, "abc", 4);
> +	seq_buf_terminate(&u);
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&u));
> +	KUNIT_EXPECT_STREQ(test, u.buffer, "abc");
> +
> +	/* With room left, the length still ends at the NUL that was written. */
> +	seq_buf_putmem(&v, "abc", 4);
> +	KUNIT_EXPECT_EQ(test, seq_buf_strlen(&v), 3);
> +	KUNIT_EXPECT_STREQ(test, seq_buf_str(&v), "abc");
> +	KUNIT_EXPECT_FALSE(test, seq_buf_has_overflowed(&v));
> +	KUNIT_EXPECT_EQ(test, seq_buf_used(&v), 4);
> +}
> +
>  static struct kunit_case seq_buf_test_cases[] = {
>  	KUNIT_CASE(seq_buf_init_test),
>  	KUNIT_CASE(seq_buf_init_append_test),
> @@ -760,6 +838,8 @@ static struct kunit_case seq_buf_test_cases[] = {
>  	KUNIT_CASE(seq_buf_strlen_embedded_nul_test),
>  	KUNIT_CASE(seq_buf_strlen_zero_size_test),
>  	KUNIT_CASE(seq_buf_terminate_test),
> +	KUNIT_CASE(seq_buf_terminate_full_test),
> +	KUNIT_CASE(seq_buf_terminate_written_nul_test),
>  	KUNIT_CASE(seq_buf_do_printk_test),
>  	{}
>  };

Rest looks good.

-- Steve
