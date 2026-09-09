Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B438F249;
	Wed,  9 Sep 2026 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932605; cv=none; b=BWI6zrwLEBy/uolxt9Gpte2iez4xAqAQ9ErSrOoSFIESBM1ccXjJX9+En46gEkkTB5RZxFkYsRExiOHaAmUtt2zfeMr488TV9v+e2Xducj5Bh6Tg15FuBabzCzJeyWghSwiFFaev56m5ccjJX756SyRW70Xz1te441xEm+qIEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932605; c=relaxed/simple;
	bh=6Thpo077j8+U5grBXywKG1vZ7W7Lb6IIXQFJTqCbVC0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GjRZjXQ+BZD3qO0zmC41fZ0Sc62LwppZembXgrluRLW4Z7himC4GbdkuAkq4D1kMr0VZsyVEakdCC5xeVP8S4fK0dCGlziw2FwalOLCGPYNS05xRUYO0bXiQytRxz60NtUCjn9sx4FrGwm2LxGWld7iMBMP1WwHjgjI4EnASL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1G9xAFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1G9xAFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBB61F00A3A;
	Wed,  9 Sep 2026 05:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932602;
	bh=5R1+U1/B6io2QtNl1MSQd8d4706jjcfSA4Sxi4Hdx5M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U1G9xAFH3bUWWTPmbCHStQniHqVQhsXlcGPZepoVVZoGiY20eRkVYDqAFKSU1Tfbt
	 xNTcICQxHNxNmL5TFYaGxhINCJOCeD6SOplUC0KXS28xi9zA4uKhJ9ZYBob/ilwcXE
	 OILBASf2tshRmT92a6ln2E3wRRj/HRSoS0RNYjoKnD288sb26PjChLzTNVhbXkMAyF
	 jhek7xEfQg5jwbxZxTROb2wbgnWkYzHZdZKFeUvaZCObBlW1lkhy/R3i7Dd7xToFsd
	 H0JKLypFV2+lMNVzGqGvbmapU1S+mapamfs3PRPHCXXfHsW2qsY3j5NZUvjVvTlOTB
	 i+R4nC6hh652g==
Subject:
 Re: [PATCH net-next v2 3/7] net: mctp: usblib: Add tests of invalid headers
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 09 Sep 2026 05:43:21 +0000
Message-ID: <178893260140.219967.13875887125542975236@kernel.org>
In-Reply-To:
 <20260903-dev-mctp-usb-lib-test-v2-3-313cf15e0b56@codeconstruct.com.au>
References:
 <20260903-dev-mctp-usb-lib-test-v2-3-313cf15e0b56@codeconstruct.com.au>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] Kernel memory leak in the kunit test helper
  mctp_usblib_test_rx_split_header(): the sk_buff dequeued from…
- [Low] Undisclosed unrelated fixup: this patch silently removes the
  unused `size_t i;` declaration from…
- [Low] Incorrect comment and a test that does not pin the real length
  boundary.
- [Low] mctp_usblib_test_rx_invalid_dmtf_id() introduces a C99 `//`
  comment ("// Make packet DMTF ID invalid"), which checkpatch.pl…

--

net: mctp: usblib: Add tests of invalid headers

Two new kunit cases are added to the mctp-usblib test module: one feeds a
USB transport header whose length field is below the minimum, the other
corrupts the DMTF ID byte.  Both expect mctp_usblib_rx_complete() to
return -EPROTO and to drop the pending skb.

A few questions below.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index a2ca79f61910..b0266be79e94 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c
> @@ -442,7 +442,6 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
>  	struct mctp_usblib_test_dev *dev;
>  	struct mctp_usblib_test_ctx *ctx;
>  	struct mctp_usblib_rx *rx;
> -	size_t i;

[Severity: Low]
Should this removal be squashed into the previous patch of the series?  The
declaration of i in mctp_usblib_test_rx_header_splits() was added by "net:
mctp: usblib: Add test for splits inside headers", and at that commit the
function never references i because the loop is written out as eight
mctp_usblib_test_rx_split_header() calls.  Building that intermediate commit
with CONFIG_MCTP_TRANSPORT_USBLIB_TEST=y should therefore warn with
-Wunused-variable, and the commit message here only mentions the two new
invalid-header tests, not this fixup.

>  
>  	ctx = mctp_usblib_test_init(test);
>  	rx = mctp_usblib_test_rx_init(test, true);

[Severity: Medium]
While looking at this function, does the helper it calls leak the skb data
buffer?  mctp_usblib_test_rx_split_header() ends with:

	skb = __skb_dequeue(&dev->rx_pkts);
	KUNIT_EXPECT_NOT_NULL(test, skb);
	if (skb) {
		KUNIT_EXPECT_EQ(test, skb->len, len - HDR_LEN);
		kfree(skb);
	}

kfree() returns only the struct sk_buff to the slab; skb_release_all() never
runs, so skb->head and the shinfo dataref are never freed.  The buffer comes
from mctp_usblib_rx_prepare():

	len = rx->span ? roundup(MCTP_USB_1_1_PKTLEN_MAX, rx->ep_pktlen)
		: MCTP_USB_1_0_XFER_SIZE;
	...
		skb = __netdev_alloc_skb(netdev, len, gfp);

which is roundup(8191, 512) = 8192 bytes per prepared transfer.
mctp_usblib_test_rx_header_splits() calls the helper eight times, so each run
of the case would leak around 64 KiB, and kmemleak/KASAN would attribute it
to the MCTP driver.  mctp_usblib_test_rx_single() and
mctp_usblib_test_rx_pkt_span() both use kfree_skb() here.  The helper came in
with the earlier "net: mctp: usblib: Add test for splits inside headers"
patch and is unchanged at the end of the series, so would a kfree_skb() fixup
there be appropriate?

> @@ -461,11 +460,79 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
>  	mctp_usblib_test_rx_split_header(test, 8, dev, rx);
>  }
>  
> +/* Test the submission of a packet with an impossibly small value in the
> + * header's length field. Values less than HDR_LEN are invalid.
> + */

[Severity: Low]
Is "Values less than HDR_LEN are invalid" accurate?  HDR_LEN is
sizeof(struct mctp_usb_hdr), which is 4:

include/linux/usb/mctp-usb.h:
	struct mctp_usb_hdr {
		__be16	id;
		__be16	len;
	} __packed;

but the check being exercised in mctp_usblib_rx_complete() is:

	if (pkt_len < sizeof(*hdr) + sizeof(struct mctp_hdr)) {
		netdev_dbg(netdev, "rx: invalid len %d\n", pkt_len);
		rc = -EPROTO;
		goto err_reset;
	}

so the real minimum is 8, not 4.

> +static void mctp_usblib_test_rx_short_packet(struct kunit *test)
> +{
> +	struct mctp_usblib_test_dev *dev;
> +	struct mctp_usblib_test_ctx *ctx;
> +	struct mctp_usblib_rx *rx;
> +	size_t len, buflen;
> +	u8 pktbuf[12];
> +	void *buf;
> +	int rc;
> +
> +	ctx = mctp_usblib_test_init(test);
> +	rx = mctp_usblib_test_rx_init(test, true);
> +	dev = ctx->dev;
> +
> +	len = sizeof(pktbuf);
> +	mctp_usblib_test_init_pkt(pktbuf, len, HDR_LEN - 1);

[Severity: Low]
Following on from the comment above, would pinning the actual boundary give
more coverage here?  HDR_LEN - 1 is 3, which is below both bounds, so the
4..7 range stays untested — including pkt_len == 4, where a header-only
packet would leave a zero-length MCTP packet after
skb_pull(sizeof(struct mctp_usb_hdr)) in mctp_usblib_rx().  If the driver
check were ever relaxed to the weaker bound the comment describes, this case
would still see -EPROTO and pass.  Would rejecting 7 and accepting 8 be a
better test, along with naming HDR_LEN + sizeof(struct mctp_hdr) in the
comment?

> +
> +	buflen = 0;
> +	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen, GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +	KUNIT_ASSERT_GE(test, buflen, len);
> +
> +	memcpy(buf, pktbuf, len);
> +
> +	rc = mctp_usblib_rx_complete(dev->ndev, rx, len);
> +	KUNIT_EXPECT_EQ(test, rc, -EPROTO);
> +	KUNIT_EXPECT_NULL(test, rx->skb);
> +	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
> +}

[ ... ]

> +	len = sizeof(pktbuf);
> +	mctp_usblib_test_init_pkt(pktbuf, len, len);
> +
> +	// Make packet DMTF ID invalid

[Severity: Low]
This isn't a bug, but checkpatch.pl reports "ERROR: do not use C99 //
comments" for this line in mctp_usblib_test_rx_invalid_dmtf_id().  It is the
only // comment in drivers/net/mctp/mctp-usblib-test.c, and it is still
there at the end of the series; could it be converted to /* ... */?

> +	pktbuf[1] = ~pktbuf[1];

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56%40codeconstruct.com.au
