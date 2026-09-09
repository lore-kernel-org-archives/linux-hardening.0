Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFE3438BF;
	Wed,  9 Sep 2026 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932603; cv=none; b=qXSxTs92vW4cnq/BZ8tRFsTtFIL9wlclu/e0/sRY8c8R8/KTBSZ6K7i+qV/7py7cahHfPyGooIjxqlV+Trbxh2H/o85SX3O8IKHZDgGaHbRSJBVlLZ6ure9uQ4Wn4ZE2Bx0byaPh+XkG+XKdBpVziQyOty63cjLo465LP1q6sCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932603; c=relaxed/simple;
	bh=PgY6h7AnqegVySeNOOexxbIH1mEDVagQXoqZerMDIO8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etGdTe0nyx21re7zUQ9u0ggOo+Bfc9eDLJMJlx6k+ZOkAns0sdFBrOt3qu5m6UmusJSWjCaQHxB6M4sQ2nof4mm2pHhpFjnipEE8qtczcXSB59PS6DcijRUK7UPL0JBtgwF90xVSPIcH00G5mdcb7+Oro9I895YDAZs+/zTR7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8Aw2Kfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8Aw2Kfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849F91F00A3D;
	Wed,  9 Sep 2026 05:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932601;
	bh=fBqh/2Hnu5JZKIJZ8usw3nw4pvPYF6t7qMoUSFjW7q0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b8Aw2KfepEbRYXXwRERTt16HJDTDZXvpXceR+9cl1cI+wClJk1cwfJtHQSlX/H5WF
	 IloUuiBjxDjw1+Rc2fAgISVOmJwCu5vdVARmVN0W3HGJBA5V0AC9JTZu7uAoG6u7EC
	 W4r8dmoZleaJp930eNIkKjlhRjhflYzGNU1FsvxavR0q8z3vrLCHsZ02CF9aziCDEp
	 hKP9VqrI5CXalt55T0W00JWZJvfnJRYfo0G8ma/xmFaDzv6QyvSaj88Ve0P8TH2rKV
	 ANbD3zUGA6DZjszCrZK7xUrZ0GqK6kRz6FCp/xK/LesZ4goEb7Cw6gJwdtCx+raAsc
	 xNknVlpFSuysA==
Subject: Re: [PATCH net-next v2 2/7] net: mctp: usblib: Add test for splits
 inside headers
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 09 Sep 2026 05:43:20 +0000
Message-ID: <178893260008.219967.13546498074867789571@kernel.org>
In-Reply-To:
 <20260903-dev-mctp-usb-lib-test-v2-2-313cf15e0b56@codeconstruct.com.au>
References:
 <20260903-dev-mctp-usb-lib-test-v2-2-313cf15e0b56@codeconstruct.com.au>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 2

- [High] mctp_usblib_test_rx_split_header() releases the received sk_buff
  with kfree(skb) instead of kfree_skb()/consume_skb()…
- [Low] mctp_usblib_test_rx_header_splits() declares `size_t i;`
  (drivers/net/mctp/mctp-usblib-test.c:445) but never reads or writes it…
- [Low] Both mctp_usblib_test_rx_complete() calls in the new helper
  discard the int return value (drivers/net/mctp/mctp-usblib-test.c:420…

Pre-existing issues:
- [Medium] The new helper reads dev->rx_pkts.qlen directly (lines 426 and
  430) and removes entries with the lock-free __skb_dequeue() (line…

--

net: mctp: usblib: Add test for splits inside headers

This adds a KUnit case, mctp_usblib_test_rx_header_splits(), that feeds a
16-byte MCTP-over-USB packet in two transfers for every split offset from 1
to 8, and drops the three parameterized span cases that covered a subset of
those offsets.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 4c27307900fb..a2ca79f61910 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c

[ ... ]

> @@ -378,12 +380,6 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
>  	{ "1p1x-complete", 1, { 8 }, 1, { 8 } },
>  	/* Two small packets combined within one transfer */
>  	{ "2p1x-combined", 2, { 8, 8 }, 1, { 16 } },
> -	/* A packet split over two transfers, at the MCTP payload */
> -	{ "1p2x-split-payload", 1, { 16 }, 2, { 8, 8 } },
> -	/* A packet split over two transfers, at the USB transport header */
> -	{ "1p2x-split-usbhdr", 1, { 16 }, 2, { 2, 14 } },
> -	/* A packet split over two transfers, at the MCTP header */
> -	{ "1p2x-split-mctphdr", 1, { 16 }, 2, { 6, 10 } },
>  	/* Single packet split over 3 transfers, middle entirely continuation */
>  	{ "1p3x-split", 1, { 12 }, 3, { 4, 4, 4 } },
>  	/* A packet split over 5 transfers, splitting on and between each header. */

[ ... ]

> @@ -403,10 +399,73 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
>  KUNIT_ARRAY_PARAM(mctp_usblib_test_rx_pkt_span, mctp_usblib_test_pkt_spans,
>  		  mctp_usblib_test_pkt_span_to_desc);
>  
> +static void mctp_usblib_test_rx_split_header(struct kunit *test, size_t offset,
> +					     struct mctp_usblib_test_dev *dev,
> +					     struct mctp_usblib_rx *rx)
> +{
> +	struct sk_buff *skb;
> +	size_t buflen, len;
> +	u8 packet[16];
> +	void *buf;
> +	int rc;
> +
> +	len = sizeof(packet);
> +	mctp_usblib_test_init_pkt(packet, len, len);
> +
> +	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen, GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +	KUNIT_ASSERT_GE(test, buflen, len);
> +
> +	memcpy(buf, packet, offset);
> +	mctp_usblib_test_rx_complete(dev->ndev, rx, offset);

[Severity: Low]

Should the return value of mctp_usblib_test_rx_complete() be checked here,
as the other call sites in this file do?

mctp_usblib_test_rx_single() and mctp_usblib_test_rx_pkt_span() both follow
each completion with:

	rc = mctp_usblib_test_rx_complete(dev->ndev, rx, len);
	KUNIT_ASSERT_EQ(test, rc, 0);

mctp_usblib_rx_complete() has err_reset paths that return -ENOMSG/-EPROTO
and also tear down the RX context:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_rx_complete() {
	...
err_reset:
	dev_kfree_skb_any(rx->skb);
	rx->skb = NULL;
	return rc;
}

If the first completion takes that path, the helper carries on: the second
mctp_usblib_rx_prepare() allocates a fresh skb, the mid-sequence
KUNIT_ASSERT_EQ(test, dev->rx_pkts.qlen, 0) still passes, the remainder of
the packet is fed at the wrong offset, and the failure only surfaces at the
later qlen check.  Doesn't that work against the stated reason for
unrolling, "so stack traces point to the invocation with the failing
length"?

Related to that, the removed cases 1p2x-split-payload, 1p2x-split-usbhdr
and 1p2x-split-mctphdr did assert rc == 0 on every transfer, so is the
commit message wording "remove parameterized tests that are now covered"
fully accurate?

The new checks also only compare skb->len against len - HDR_LEN, and never
compare the delivered bytes against packet + sizeof(struct mctp_usb_hdr).
Would a regression that corrupts bytes across the split (say the MCTP
src/flags fields around offsets 6 to 8) while leaving dest routable and the
length unchanged still pass all of the new assertions?

> +
> +	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen,
> +				    GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +	KUNIT_ASSERT_GE(test, buflen, len);
> +	KUNIT_ASSERT_EQ(test, dev->rx_pkts.qlen, 0);
> +
> +	memcpy(buf, packet + offset, len - offset);
> +	mctp_usblib_test_rx_complete(dev->ndev, rx, len - offset);
> +	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 1);
> +
> +	skb = __skb_dequeue(&dev->rx_pkts);

[Severity: Medium]

This isn't something introduced by this patch, but the reads of
dev->rx_pkts.qlen and the __skb_dequeue() here run with no lock held, while
the only producer, mctp_usblib_test_dst_output(), inserts with the locked
variant from the netif_rx/backlog delivery context:

	skb_queue_tail(&dev->rx_pkts, skb);

The existing mctp_usblib_test_rx_single() and
mctp_usblib_test_rx_pkt_span() already do the same unlocked reads, so this
is pre-existing rather than new, and delivery does appear to be synchronous
inside the local_bh_disable()/local_bh_enable() window of
mctp_usblib_test_rx_complete() in both default and PREEMPT_RT
configurations.  Would skb_dequeue() and skb_queue_len() be preferable here
anyway, so the helper does not depend on that assumption?

> +	KUNIT_EXPECT_NOT_NULL(test, skb);
> +	if (skb) {
> +		KUNIT_EXPECT_EQ(test, skb->len, len - HDR_LEN);
> +		kfree(skb);
                ^^^^^

[Severity: High]

Does this leak the skb data buffer?  kfree() releases only the struct
sk_buff itself and skips skb_release_all()/skb_free_head(), so skb->head is
never freed.

The skb reaching this queue is the one allocated in
mctp_usblib_rx_prepare():

drivers/net/mctp/mctp-usblib.c:mctp_usblib_rx_prepare() {
	...
	len = rx->span ? roundup(MCTP_USB_1_1_PKTLEN_MAX, rx->ep_pktlen)
		: MCTP_USB_1_0_XFER_SIZE;

	if (!skb) {
		skb = __netdev_alloc_skb(netdev, len, gfp);
	...
}

and with span mode that is an 8 KiB head.  On the second transfer
pkt_len == skb->len, so mctp_usblib_rx_complete() hands that same skb
onward:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_rx_complete() {
	...
		/* we have (exactly) a complete packet, RX it directly */
		if (pkt_len == skb->len) {
			mctp_usblib_rx(netdev, skb);
			rx->skb = NULL;
			break;
		}
	...
}

That gives one leaked head buffer per call, so eight per run of
mctp_usblib_test_rx_header_splits().  Every other release site in this file
uses kfree_skb() - mctp_usblib_test_rx_single(),
mctp_usblib_test_rx_pkt_span() and mctp_usblib_dev_tx() - and kfree_skb() is
NULL safe, so the "if (skb)" guard around it could be dropped as well.

The v2 changelog says "Fix sk_buff leak"; with kfree() here, is the leak
actually closed?  The same kfree() is still present at the end of the
series.

> +	}
> +}
> +
> +static void mctp_usblib_test_rx_header_splits(struct kunit *test)
> +{
> +	struct mctp_usblib_test_dev *dev;
> +	struct mctp_usblib_test_ctx *ctx;
> +	struct mctp_usblib_rx *rx;
> +	size_t i;
             ^

[Severity: Low]

This isn't a bug, but i is never used once the invocations are unrolled, so
this emits a -Wunused-variable warning and fails the build under
CONFIG_WERROR with CONFIG_MCTP_TRANSPORT_USBLIB_TEST enabled.  The
declaration is removed again by the next patch in the series, "net: mctp:
usblib: Add tests of invalid headers", so the final state of the series is
clean; could it be dropped in this patch instead to keep the series
bisectable?

> +
> +	ctx = mctp_usblib_test_init(test);
> +	rx = mctp_usblib_test_rx_init(test, true);
> +	dev = ctx->dev;
> +
> +	/* Unrolling here so stack traces point to the invocation with the
> +	 * failing length.
> +	 */
> +	mctp_usblib_test_rx_split_header(test, 1, dev, rx);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56%40codeconstruct.com.au
