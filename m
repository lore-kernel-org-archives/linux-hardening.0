Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40C20DD51;
	Thu,  3 Sep 2026 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471966; cv=none; b=DFtuyXBK/nyeV4XfGVxEat3SAzSV6bMkNEhAVLD7yUF4r3lLXT+yqsAiRUcz8U81w6gI7sWolA6XwJFX1Nr0sFmqj7EvdgXATJW13IYYy/lrSAbGhe92FW+nO+HyKd7eRwnPdsXdf0LSpyeo1Ql2sN0XDRiXFRNh4lnJDQg8Z9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471966; c=relaxed/simple;
	bh=Ged1OvuCOT5wAKN5s3gjyhDlcfBNlHtzOGoFGEkWcO4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZQ9yDapDJ47wKYwPqSz0CQuUgErZ+UcEfLtXXahD11XKdPihB4X/Wz1NozbFC/2Q6HaGmMAzuVkw8OMXvguHaXootdZ2GF5CmiunNOHxMIWiiI2eiih6YLO386nRdQkuPAcpU52nZlOfQ/UzarHq+BRHrz+9Sdl9kSrkHXqK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjIMxOc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjIMxOc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA301F000E9;
	Thu,  3 Sep 2026 21:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471964;
	bh=uGAVaeP0W8LvN/PN6xnor0NvE26XFUvUHT3W2tP0h5Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CjIMxOc1QnxYh/iZPFBY92Rvrj7P7CFMyondjkKH/Gp0OjPabi1F1grBwGyvdOytB
	 7RakNaZaW+H53ohS/zB0rnj7guYCHhd6qU/TdZ8Mk3GfiYwyA2s8qv3qzDTQWGx9U/
	 HQJZPC2XAoFWhzutBao25MZDNPhhKRzSVFDAw6729ba1vqbUeLb3iy5j0XJRrF9QN0
	 JBaa7ap2uLDFycSmDn2tOtUhLx/W6Nwo5I3fnccYaQ5UJ6962OhhmFH2svWcy9Z/vI
	 sdcAJs6okkmvg+fzxjsF6S2fUWNAc7ZyAnnKJSyeDj06AeITPWy+7tsJEON6c8aFVU
	 ZV9P2dONFxyjA==
Subject: Re: [2/7] net: mctp: usblib: Add test for splits inside headers
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 03 Sep 2026 21:46:03 +0000
Message-ID: <178847196367.3394541.6002836106059762076@kernel.org>
In-Reply-To:
 <20260831-dev-mctp-usb-lib-test-v1-2-79699bf67a18@codeconstruct.com.au>
References:
 <20260831-dev-mctp-usb-lib-test-v1-2-79699bf67a18@codeconstruct.com.au>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] SKB leak in the new helper
  `mctp_usblib_test_rx_split_header()` (drivers/net/mctp/mctp-usblib-…
- [Medium] `mctp_usblib_test_rx_split_header()` calls the driver's
  completion entry point `mctp_usblib_rx_complete()` directly…
- [Low] Unused local variable `size_t i;` in the newly added
  `mctp_usblib_test_rx_header_splits()` (drivers/net/mctp/mctp-usblib-…

--

net: mctp: usblib: Add test for splits inside headers

Adds a new KUnit case, mctp_usblib_test_rx_header_splits(), which walks a
helper across every byte offset where a 16-byte packet's headers can be
split between two transfers, and drops the three parameterized span entries
that covered a subset of those cases.

A few questions about the new test below.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 4c27307900fb..1a6dd6d10daa 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c

[ ... ]

> @@ -403,10 +399,71 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
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
> +	mctp_usblib_rx_complete(dev->ndev, rx, offset);

[Severity: Medium]
Should these two calls go through the mctp_usblib_test_rx_complete()
wrapper rather than calling mctp_usblib_rx_complete() directly?

The wrapper in this same file exists specifically to provide the calling
context the driver expects:

  /* Wrappers for usblib's rx_complete callback, which is intended to be called
   * from atomic context
   */
  static int mctp_usblib_test_rx_complete(struct net_device *netdev,
                                          struct mctp_usblib_rx *rx, size_t len)
  {
          local_bh_disable();
          rc = mctp_usblib_rx_complete(netdev, rx, len);
          local_bh_enable();
          return rc;
  }

mctp_usblib_test_rx_single() and mctp_usblib_test_rx_pkt_span() both use it,
but mctp_usblib_test_rx_split_header() calls the raw entry point from
preemptible kunit process context.

The delivery path starts with a per-CPU pointer fetch in
drivers/net/mctp/mctp-usblib.c:

  static void mctp_usblib_rx(struct net_device *netdev, struct sk_buff *skb)
  {
          struct pcpu_dstats *dstats = this_cpu_ptr(netdev->dstats);
          ...
          flags = u64_stats_update_begin_irqsave(&dstats->syncp);

Can this produce a "BUG: using smp_processor_id() in preemptible code"
splat on a CONFIG_DEBUG_PREEMPT build, given this_cpu_ptr() resolves
through my_cpu_offset/smp_processor_id() there? The same this_cpu_ptr()
pattern is in the drop path used when a header is rejected.

Separately, with preemption enabled between the this_cpu_ptr() and the
u64_stats_update_begin_irqsave(), can the task migrate and leave two
contexts writing the same per-CPU dstats syncp?

Also, both of these calls discard the return code, unlike every other
mctp_usblib_rx_complete() call site in the file which does
KUNIT_ASSERT_EQ(test, rc, 0). Was dropping the check intentional?

> +
> +	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen,
> +				    GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +	KUNIT_ASSERT_GE(test, buflen, len);
> +	KUNIT_ASSERT_EQ(test, dev->rx_pkts.qlen, 0);
> +
> +	memcpy(buf, packet + offset, len - offset);
> +	mctp_usblib_rx_complete(dev->ndev, rx, len - offset);
> +	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 1);
> +
> +	skb = __skb_dequeue(&dev->rx_pkts);
> +	KUNIT_EXPECT_NOT_NULL(test, skb);
> +	if (skb)
> +		KUNIT_EXPECT_EQ(test, skb->len, len - HDR_LEN);
> +}

[Severity: Medium]
Does this helper leak the dequeued skb?

The skb is unlinked from dev->rx_pkts by __skb_dequeue() and the function
returns without a kfree_skb(). The teardown action only purges the queue:

  static void mctp_usblib_test_dev_action(void *data)
  {
          struct mctp_usblib_test_dev *dev = data;

          skb_queue_purge(&dev->rx_pkts);

so once the skb has been dequeued it is no longer reachable from there.

The two existing tests free it after dequeue:

  skb = __skb_dequeue(&dev->rx_pkts);
  ...
  kfree_skb(skb);

Since mctp_usblib_test_rx_header_splits() calls this helper eight times,
does that leak eight skbs plus their linear data areas per run of the
suite? This looks like it is still missing at the end of the series.

> +
> +static void mctp_usblib_test_rx_header_splits(struct kunit *test)
> +{
> +	struct mctp_usblib_test_dev *dev;
> +	struct mctp_usblib_test_ctx *ctx;
> +	struct mctp_usblib_rx *rx;
> +	size_t i;

[Severity: Low]
This isn't a bug, but i is never referenced in the unrolled body below, so
this should warn with -Wunused-variable when the KUnit module is built at
this commit.

The declaration does get removed by the following patch in the series,
"net: mctp: usblib: Add tests of invalid headers"
(49a493a0ed5d5a9d6a79967c53761c7a58c76c67), and it is absent at the tip of
the series, so this is only visible when bisecting through this commit.
Could it be dropped here instead?

> +
> +	ctx = mctp_usblib_test_init(test);
> +	rx = mctp_usblib_test_rx_init(test, true);
> +	dev = ctx->dev;
> +
> +	/* Unrolling here so stack traces point to the invocation with the
> +	 * failing length.
> +	 */
> +	mctp_usblib_test_rx_split_header(test, 1, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 2, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 3, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 4, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 5, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 6, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 7, dev, rx);
> +	mctp_usblib_test_rx_split_header(test, 8, dev, rx);
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18%40codeconstruct.com.au
