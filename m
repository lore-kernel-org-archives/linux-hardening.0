Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F42DB78C;
	Wed,  9 Sep 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932601; cv=none; b=WBtsriIC4Y2/ahqdUmhTLhaX0G8I/Uc/Digi7c5BJQzAUABYMBghFijq1LOl87B/OOl3kYa9bdJzKcsHabt7Tj6emzZja8+RUBqgi+eZ+BG1FfgAlLMsq3vI8kOmKrf4K3QovDOILAlCA/LU6e6HjkieaayJV+bbP3V2gjLUbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932601; c=relaxed/simple;
	bh=u9Sm8jPI4+Fwj1M3ncBHH2tQ7kcqsX+JkFd7lWPCCyY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u25a6qmk8GbkHCu8EPFt/9tWSreotjwhgWVY5hnp8YxJ1OmSDQPepc6jTwvf0xGaHhPvHLGibP3NTk9PaSTBrLA5wd9f7Hqv6+DiFxUQXv6KM22dvv3Kawu86oskVooQf0W/VAa9S5Iw2BPUucy16nHKEiUPoOM0KgdT3KsRptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiMzUH1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiMzUH1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EE21F00A3A;
	Wed,  9 Sep 2026 05:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932599;
	bh=eqpQ69w02D0+WhW3Ec1YD7jRQ68DlaztQhqmKUMxU9g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fiMzUH1iv0v/XzmIq3X5si6CrSI/6NTpT4RYSkzjtG+SrWuuvUuQxSfd2eRbvuQ2j
	 C7yqnBIytFyihjxWFjiN0X+DP97TnfxnMbwpreVdClWElsUfBmLEprZ9s2Lurhnvjs
	 d6hRrF2YgFbm9J+o+D7zWbFvqBUvK8SvFIg+4gzHdxhDD1OlkATkDsk8pTvg3ky20Z
	 N/plnaSjSz2DT9ayMCNdg2zJX7E+/4aTnvsB4HN7LC60qoDWcn8XRki3ApkkqgHrHQ
	 J+lrMGSJS4F+o/t30Xr+m/EVz9x53FDwTaQ9AqmQ+As8e+gyLx97e3P/67eTHE0CwU
	 6sRH8j4yV3bXg==
Subject: Re: [PATCH net-next v2 1/7] net: mctp: usblib: Add to parameterized
 kunit tests.
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 09 Sep 2026 05:43:18 +0000
Message-ID: <178893259873.219967.11550957902353874236@kernel.org>
In-Reply-To:
 <20260903-dev-mctp-usb-lib-test-v2-1-313cf15e0b56@codeconstruct.com.au>
References:
 <20260903-dev-mctp-usb-lib-test-v2-1-313cf15e0b56@codeconstruct.com.au>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The new/modified worst-case span parameters ("1p5x-split" line
  390, "2p2x-large-split" line 396, "3p3x-large-split" line 400) are…

--

net: mctp: usblib: Add to parameterized kunit tests.

Adds three worst-case entries to the mctp_usblib_test_pkt_spans[] table: a
single packet split over five transfers on and between the headers, and two
large-packet cases that split at the worst case for buffer allocation. The
existing "2p2x-large-split" entry is also adjusted so the trailing span is a
single byte.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 9df401a914ff..4c27307900fb 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c
> @@ -386,12 +386,18 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
>  	{ "1p2x-split-mctphdr", 1, { 16 }, 2, { 6, 10 } },
>  	/* Single packet split over 3 transfers, middle entirely continuation */
>  	{ "1p3x-split", 1, { 12 }, 3, { 4, 4, 4 } },
> +	/* A packet split over 5 transfers, splitting on and between each header. */
> +	{ "1p5x-split", 1, { 12 }, 5, { 3, 1, 1, 3, 4}},
>  	/* Max-sized single transfer */
>  	{ "1p1x-large", 1, { 8191 }, 1, { 8191 } },
>  	/* Two large packets, split at the worst-case for allocation, with a
>  	 * single byte continuing the span
>  	 */
> -	{ "2p2x-large-split", 2, { 8190, 8190 }, 2, { 8191, 8189 } },
> +	{ "2p2x-large-split", 2, { 8190, 8191 }, 2, { 8191, 8190 } },
> +	/* Three large packets, split at the worst-case for allocation,
> +	 * with a single byte continuing each span
> +	 */
> +	{ "3p3x-large-split", 3, { 8190, 8191, 8191 }, 3, { 8191, 8191, 8190 } },
>  };

[Severity: Low]
Can these new worst-case vectors actually detect a misplaced payload?

The consumer, mctp_usblib_test_rx_pkt_span(), only makes two checks after
feeding all the transfers:

	/* check received packets */
	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, pkt_span->n_pkts);
	for (i = 0; ; i++) {
		...
		if (i < pkt_span->n_pkts)
			KUNIT_EXPECT_EQ(test, skb->len, pkt_span->pkts[i] - 4);

The bytes of each reassembled skb are never compared against pktbuf.

The payload is also indistinguishable, since mctp_usblib_test_init_pkt()
zero-fills everything after the 8-byte header:

	memcpy(data, &hdr, min(len, sizeof(hdr)));
	if (len > sizeof(hdr))
		memset(data + sizeof(hdr), 0, len - sizeof(hdr));

So a reassembly bug that keeps the USB/MCTP headers where the library expects
them but places payload bytes at the wrong offset would still yield the
expected qlen and skb->len, and these cases would pass.

That matters most for the two "large-split" entries, which exist to exercise
the compaction path in mctp_usblib_rx_prepare():

	skb2 = skb_copy_expand(skb, 0, len, gfp);
	if (!skb2)
		return -ENOMEM;
	dev_kfree_skb_any(skb);
	skb = skb2;
	...
	*bufp = skb_tail_pointer(skb);

A wrong copy or wrong returned write offset there is precisely a payload
placement error the current assertions cannot see.

Would it be worth giving each packet a distinguishable byte pattern in
mctp_usblib_test_init_pkt() and comparing the dequeued skbs against pktbuf
with skb_copy_bits() and KUNIT_EXPECT_MEMEQ, so these vectors validate
reassembly rather than only span accounting?

For reference, this gap remains at the end of the series (as of 7b7c42135cec
the rx span test still asserts only qlen and skb->len; only the newly added
tx tests use KUNIT_EXPECT_MEMEQ).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56%40codeconstruct.com.au
