Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084F346E7A;
	Thu,  3 Sep 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471969; cv=none; b=RP3KDRn0epgCO0Hye0uXD2QbxLAfI5j/ZAArdXOXZMxVIQadLOBCPYPj2h5DvsCELBS1NBqZ0ADD3wHezE4h+PYKBGkTIDMza8DrUrBHmunmHVn5yb6HGXqPePjQNNAEXN8+AvKyFaC8q1+O/ufAWcybsqSW/q3/mrR3T2Y5v3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471969; c=relaxed/simple;
	bh=AknEEH+P4TEMBwYnHymrT9XzHKSStasLV5YHCt6/VTA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SpAGqudzY0YBDLYRYJXN5qdj+y6yrsFP+k1vRxYGoq3uKzVhdqxv9WNLS9mpCUhIqExHhBI/LK3lhBsYv4FWQmfoDfnJS6rkvv1Nwiv/K0DkeuxT0IBSKlJfQnFagEj4DJps6NGKtjzofw+yiD5CHioHwDTQFhdNt+CTvLEtnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdrjTwGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdrjTwGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A726A1F00A3E;
	Thu,  3 Sep 2026 21:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471967;
	bh=uNvXtnNE14d/D7gYKtxotrZkv4zcRH+EefL0YIohoVc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UdrjTwGGfTlPK4e0M9jRAc+eRJJlcdZivgdB2WTNkzoNCTNTTMyM9LHS6ZBo0t58q
	 Odxip322NuAYbRoBXUhmrQdKSgsInzqai9s+SwDANxJoTlFOmsluekwhpwyR6iOkhd
	 xThWSRi0FX/A4trE3oAUeBATv4OZpCm8IBAVR8Y951Djb5EWnV7aPAwTRBYewqGvER
	 LVryF7lc0FXJc9FYT7kH0MmhAU8kIGL+BC7UibiLHlhgurp/BfjATy0wcR1kivyzL+
	 S4g7Te0PYDDWsqx5EZnXiEU+w+k8yjzl1usmdGjq4ZRuALJ3MjjprNIaUWOLlC2382
	 mn4DActzjy5PQ==
Subject: Re: [6/7] net: mctp: usblib: Add initial kunit tx tests
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 03 Sep 2026 21:46:06 +0000
Message-ID: <178847196623.3394541.7518295085266187778@kernel.org>
In-Reply-To:
 <20260831-dev-mctp-usb-lib-test-v1-6-79699bf67a18@codeconstruct.com.au>
References:
 <20260831-dev-mctp-usb-lib-test-v1-6-79699bf67a18@codeconstruct.com.au>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 1

- [High] Use-after-free / double-free: the model ->send() hook
  mctp_usblib_test_tx_send() calls mctp_usblib_tx_send_complete()…
- [Medium] mctp_usblib_test_tx_init() accepts a `bool span` parameter but
  discards it, passing the literal `true` to mctp_usblib_tx_init()…
- [Medium] static_assert(!sends[ARRAY_SIZE(sends) - 1].more, ...) at
  drivers/net/mctp/mctp-usblib-test.c:822 reads an element of `sends[]`,…
- [Medium] The test comment on mctp_usblib_test_tx_multi_push() claims it
  tests "multiple packets in the same transfer, followed by one that…
- [Low] mctp_usblib_test_init_skb() (drivers/net/mctp/mctp-usblib-
  test.c:134-135) assigns skb->len = length and memcpy()s into skb->data…

--

Thanks for the patch. A few questions about the new test code below.

net: mctp: usblib: Add initial kunit tx tests

Adds three KUnit cases for the mctp-usblib transmit path: a spanning
transfer that should succeed, the behaviour when ops.send() fails, and a
sequence of pushes ending in a large packet. The tests drive
mctp_usblib_tx_push() with a model ops.send() that captures each outgoing
transfer into a list for later comparison.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 772484df32a7..7dc382caffc1 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c

[ ... ]

> @@ -24,9 +32,110 @@ struct mctp_usblib_test_dev {
>  
>  struct mctp_usblib_test_ctx {
>  	struct mctp_usblib_test_dev *dev;
> +	struct list_head tx_xfers;
>  	struct mctp_route rt;
>  };
>  
> +static int mctp_usblib_test_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
> +				    void *data, size_t len)
> +{
> +	struct mctp_usblib_test_ctx *ctx;
> +	struct tx_buff *new_node;
> +	struct net_device *ndev;
> +	int rc;
> +
> +	ctx = mctp_usblib_tx_ctx_priv(tx_ctx);
> +	ndev = ctx->dev->ndev;
> +	rc = 0;
> +
> +	new_node = kzalloc_flex(*new_node, data, len, GFP_KERNEL);
> +	if (!new_node) {
> +		rc = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	new_node->length = len;
> +	memcpy(&new_node->data, data, len);
> +	list_add_tail(&new_node->list, &ctx->tx_xfers);
> +
> +exit:
> +	mctp_usblib_tx_send_complete(tx_ctx, ndev, rc == 0);
> +	return rc;
> +}

[Severity: High]
Can the kzalloc_flex() failure path here free the tx context twice?

On allocation failure this goes to exit:, which still calls
mctp_usblib_tx_send_complete(), and then returns -ENOMEM.
mctp_usblib_tx_send_complete() drops the context:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_send_complete() {
	mctp_usblib_tx_stats_update(tx_ctx, dev, ok);
	mctp_usblib_tx_ctx_free(tx_ctx, reason);
}

and mctp_usblib_tx_ctx_free() dequeues/frees every skb and kfree()s ctx.

But the non-zero return makes mctp_usblib_tx_push() believe it still owns
the context, at both of its send sites:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_push() {
	...
	rc = mctp_usblib_tx_send(ctx);
	if (rc) {
		mctp_usblib_tx_stats_update(ctx, dev, false);
		mctp_usblib_tx_ctx_free(ctx, reason);
	}
	...
}

That reads ctx->skbs.qlen and ctx->len after the free, then runs
__skb_dequeue() on the freed list head and kfree()s ctx a second time.

The header documents the contract as completion being owed only for a
successful send:

include/linux/usb/mctp-usb.h:
	/* Start a USB TX for @data. On returning success, the implementation
	 * must arrange for mctp_usblib_tx_send_complete() to be called at some
	 * later point (eg., on urb completion).
	 */

and the real driver mctp_usb_tx_send() follows it by returning rc from
usb_submit_urb() without calling send_complete(). Should the exit: path
only call mctp_usblib_tx_send_complete() when rc == 0?

The trigger is a NULL return from the kzalloc_flex(), which becomes
deterministic under slab fault injection (CONFIG_FAILSLAB), a config often
combined with KUnit runs.

> +
> +static int mctp_usblib_test_tx_send_fail(struct mctp_usblib_tx_ctx *tx_ctx,
> +					 void *data, size_t len)
> +{
> +	return -ENOMEM;
> +}
> +
> +static u8 *mctp_usblib_test_flatten_tx_buff(struct kunit *test,
> +					    struct list_head *in,
> +					    size_t *length_out)
> +{
> +	struct tx_buff *pos;
> +	size_t length;
> +	u8 *buf, *tail;
> +
> +	KUNIT_ASSERT_TRUE(test, length_out);
> +	KUNIT_ASSERT_TRUE(test, in);
> +
> +	length = 0;
> +	list_for_each_entry(pos, in, list)
> +		length = size_add(length, pos->length);
> +
> +	KUNIT_ASSERT_NE(test, length, 0);
> +	KUNIT_ASSERT_NE(test, length, SIZE_MAX);
> +
> +	buf = kunit_kzalloc(test, length, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, buf);
> +
> +	tail = buf;
> +	list_for_each_entry(pos, in, list) {
> +		memcpy(tail, pos->data, pos->length);
> +		tail += pos->length;
> +	}
> +
> +	*length_out = length;
> +	return buf;
> +}

[ ... ]

> +static struct sk_buff *mctp_usblib_test_init_skb(struct kunit *test,
> +						 unsigned int length,
> +						 struct net_device *ndev,
> +						 void *data)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = __netdev_alloc_skb(ndev, length, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, skb);
> +
> +	skb->len = length;
> +	memcpy(skb->data, data, length);
> +	return skb;
> +}

[Severity: Low]
Would skb_put_data(skb, data, length) be preferable here?

After __netdev_alloc_skb() the tail pointer equals skb->data and skb->len
is 0. Setting skb->len directly leaves skb->len != skb_tail_pointer(skb) -
skb->data, so skb_tailroom() over-reports by length and the skb_put() tail
check is bypassed for every skb the three new tx tests hand to
mctp_usblib_tx_push().

I traced the current path and it happens to survive: the 4 bytes of header
room needed by mctp_usblib_tx_skb_prepare() are already covered by
NET_SKB_PAD so pskb_expand_head() is never reached, and
mctp_usblib_tx_send() copies using skb_headlen()/skb->data rather than the
tail pointer. So there is no out-of-bounds access today, but the skbs do
not model what the networking core hands to ndo_start_xmit, and anything
later added on this path that uses skb_tail_pointer(), skb_tailroom() or
pskb_expand_head() would silently see zero-length payload.

[ ... ]

> @@ -227,6 +340,32 @@ static int mctp_usblib_test_rx_complete(struct net_device *netdev,
>  	return rc;
>  }
>  
> +static void action_tx_fini(void *data)
> +{
> +	struct mctp_usblib_tx *tx = data;
> +
> +	mctp_usblib_tx_fini(tx);
> +	kfree(tx);
> +}
> +
> +static struct mctp_usblib_tx *
> +mctp_usblib_test_tx_init(struct kunit *test,
> +			 const struct mctp_usblib_tx_ops *ops,
> +			 void *priv, bool span)
> +{
> +	struct mctp_usblib_tx *tx;
> +	int rc;
> +
> +	tx = kzalloc_obj(*tx);
> +	KUNIT_ASSERT_NOT_NULL(test, tx);
> +	rc = kunit_add_action_or_reset(test, action_tx_fini, tx);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +
> +	mctp_usblib_tx_init(tx, ops, priv, true);
> +
> +	return tx;
> +}

[Severity: Medium]
Should this pass span rather than the literal true?

As written the span parameter is unused, so mctp_usblib_test_tx_failing_send()
below, which calls mctp_usblib_test_tx_init(test, &ops, ctx, false), still
gets a spanning tx engine.

tx->span is the only selector for the tx geometry:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_skb_prepare() {
	max_len = span ? MCTP_USB_1_1_PKTLEN_MAX : MCTP_USB_1_0_PKTLEN_MAX;

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_ctx_create() {
		sz = tx->span ? TX_SPAN_MAX : MCTP_USB_1_0_XFER_SIZE;

So the v1.0 non-spanning geometry (the 255-byte packet ceiling with
-EMSGSIZE / SKB_DROP_REASON_PKT_TOO_BIG, and the 512-byte aggregation
buffer that drives mctp_usblib_tx_append()) ends up with no coverage at
all.

This also affects the later mctp_usblib_test_tx_overflow() in the series:
with span forced true, three 204-byte transfers fit in the ~4032-byte span
buffer, so mctp_usblib_tx_append() never returns -ENOBUFS and the
append-overflow path the test is named for is not executed, though
tx_drops still reaches 3 through the send failure and the test passes.

[ ... ]

> @@ -582,6 +721,156 @@ static void mctp_usblib_test_rx_nonspanning_partial(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
>  }
>  

[ ... ]

> +static void mctp_usblib_test_tx_failing_send(struct kunit *test)
> +{

[ ... ]

> +	ops.send = mctp_usblib_test_tx_send_fail;
> +
> +	tx = mctp_usblib_test_tx_init(test, &ops, ctx, false);
> +	buf = mctp_usblib_test_init_buf(test, len);
> +	skb = mctp_usblib_test_init_skb(test, len, ndev, buf);

[ ... ]

> +/* Test sending multiple packets in the same transfer, followed by one that
> + * spans multiple subsequent transfers.
> + */
> +static void mctp_usblib_test_tx_multi_push(struct kunit *test)
> +{
> +	struct mctp_usblib_test_ctx *ctx;
> +	size_t i, max_length, tx_length;
> +	struct mctp_usblib_tx_ops ops;
> +	u8 *buf, *flat_tx, *index;
> +	struct mctp_usblib_tx *tx;
> +	struct net_device *ndev;
> +	struct sk_buff *skb;
> +	const struct {
> +		size_t len;
> +		bool more;
> +	} sends[] = {
> +		{ 1000, true  },
> +		{  500, false },
> +		{ 5000, false },
> +	};
> +	int rc;
> +
> +	static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
> +		      "The last push must claim there will be no more");

[Severity: Medium]
Does this static_assert() compile?

sends[] is a function-local array with automatic storage duration, and an
array subscript plus member access on such an object is not an integer
constant expression in C even when the array is const-qualified. Clang
reports "static assertion expression is not an integral constant
expression" and GCC reports "expression in static assertion is not
constant".

Since mctp-usblib-test.c is textually included:

drivers/net/mctp/mctp-usblib.c:
	#if IS_ENABLED(CONFIG_MCTP_TRANSPORT_USBLIB_TEST)
	#include "mctp-usblib-test.c"
	#endif

this would break the whole mctp-usblib.c translation unit whenever
CONFIG_MCTP_TRANSPORT_USBLIB_TEST=y, which is the default under
KUNIT_ALL_TESTS. Marking sends static const does not make the expression
an integer constant expression either; would a runtime
KUNIT_ASSERT_FALSE() on the last entry work instead?

> +
> +	max_length = 0;
> +	for (i = 0; i < ARRAY_SIZE(sends); i++) {
> +		if (sends[i].len > max_length)
> +			max_length = sends[i].len;
> +	}

[Severity: Medium]
Do the assertions in this test actually check the transfer boundaries the
comment describes?

mctp_usblib_test_flatten_tx_buff() concatenates every captured ops.send()
call into one contiguous buffer, and the checks below only walk that byte
stream. The number of tx_buff nodes and their individual lengths are never
examined, so a change that regroups packets into different transfers while
preserving byte order still passes.

Also, the last sends[] entry has more == false, and mctp_usblib_tx_push()
inverts that:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_push() {
	ctx = mctp_usblib_tx_ctx_create(tx, skb, !more);

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_ctx_create() {
	if (single || skb->len > TX_SPAN_MAX) {
		type = TX_SINGLE;

Tracing the three pushes: the 1000-byte push creates a TX_FLAT context and
queues, the 500-byte push appends and sends one 1508-byte transfer, and
the 5000-byte push takes TX_SINGLE and sends one 5004-byte transfer. That
is two ops.send() calls, both single transfers, so nothing "spans multiple
subsequent transfers".

The commit message says "Testing a spanning transfer that is expected to
succeed" - is that the same mismatch, or is a different meaning of
spanning intended there?

> +
> +	ctx = mctp_usblib_test_init(test);
> +	ndev = ctx->dev->ndev;
> +
> +	ops.send = mctp_usblib_test_tx_send;
> +
> +	tx = mctp_usblib_test_tx_init(test, &ops, ctx, true);
> +	buf = mctp_usblib_test_init_buf(test, max_length);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18%40codeconstruct.com.au
