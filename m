Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741573A4F2F;
	Wed,  9 Sep 2026 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932613; cv=none; b=l0zow9OA86O0gETCbDArVXueAVEgLnn+JORxIJbrh25YizqwhanIK6DfGNgOCdF1Aw7do3Xz9t+Dmh1UjrecYBsFnD//vsJyM4EwxgH+lsoMcvGFnFLnQ+vakrfgj8vDAqBfqxljQNH+elk2QA+/R9iEA6BKuXS64Vorg1DD3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932613; c=relaxed/simple;
	bh=U7YIk8RrK1ZZAvSrYluqSOisC29WjVIT8ZVlRSOD4UQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cH6M/5vQ2+aSNgFpQBzEkpFt/3txb3r8ZjEPsx5UJ4mulIGWO2KjcAnwq/JyaVjK2QaTUaa/LrLbLaa1GXfrg9AwBDMpVvwhVenDQWKb49ahz7Jx0HPx8kv5zx8vuXKcreqbtA2V7RY2lhBjsEsyDsUVWcUILJ0Bn1nS0MVI068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrz2QuK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrz2QuK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E2B1F00A3D;
	Wed,  9 Sep 2026 05:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932605;
	bh=NYko44nI9GsHQK8N8wxewUqZ0WKyYmC6xt2/P9uZEqA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mrz2QuK8LJvHL7eQJBwEKTb0ya7lESjbjCWHoGx40QshQGz/wW//1o1pewPI38UQJ
	 rYdVlSE1U/8iPo6A58rilYLiZG8+AW+5BwJFcjeCa0kfzqOW1XRV0CaARva9hyqqOX
	 5RXIxy47ts9Y5vaHsOHjyaVfu5WgiYNlAnfwQAVn5PTerB7/j5MXWm3JyJUTpiuy5Y
	 uniufGZpSCeNitTHdyP04Qu882hYK8ou4cc+wF4BGXq/JOaKcd40i464x+ZlXj+8V0
	 3V5oPs/LC7l5ml4PPqYAJuNtw7Xe7YJdDA6BdfyF20PTNHR5qHYtnafyt9NsJYuWAe
	 LtytEaif+lVIA==
Subject:
 Re: [PATCH net-next v2 6/7] net: mctp: usblib: Add initial kunit tx tests
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 09 Sep 2026 05:43:24 +0000
Message-ID: <178893260401.219967.13741401547777040850@kernel.org>
In-Reply-To:
 <20260903-dev-mctp-usb-lib-test-v2-6-313cf15e0b56@codeconstruct.com.au>
References:
 <20260903-dev-mctp-usb-lib-test-v2-6-313cf15e0b56@codeconstruct.com.au>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2

- [High] Hard compile error: `static_assert(!sends[ARRAY_SIZE(sends) -
  1].more, ...)` in mctp_usblib_test_tx_multi_push()…
- [Low] mctp_usblib_test_tx_multi_push() (drivers/net/mctp/mctp-usblib-
  test.c:796-869) is documented as "Test sending multiple packets in the…
- [Low] mctp_usblib_test_tx_send() (drivers/net/mctp/mctp-usblib-
  test.c:39-59) calls mctp_usblib_tx_send_complete(tx_ctx, ndev, true)…

--

net: mctp: usblib: Add initial kunit tx tests

This adds KUnit coverage for the mctp-usblib transmit path: a spanning
transfer that is expected to succeed, the failure paths when ops->send
returns an error, and a sequence of larger pushes. The tests record each
->send() call in a list and compare the resulting bytes against the
expected MCTP-over-USB headers and payload.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 64c758013854..73bda4745433 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c

[ ... ]

> @@ -24,9 +32,104 @@ struct mctp_usblib_test_dev {
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
> +
> +	ctx = mctp_usblib_tx_ctx_priv(tx_ctx);
> +	ndev = ctx->dev->ndev;
> +
> +	new_node = kzalloc_flex(*new_node, data, len, GFP_KERNEL);
> +	if (!new_node)
> +		return -ENOMEM;
> +
> +	new_node->length = len;
> +	memcpy(new_node->data, data, len);
> +	list_add_tail(&new_node->list, &ctx->tx_xfers);
> +
> +	mctp_usblib_tx_send_complete(tx_ctx, ndev, true);
> +	return 0;
> +}

[Severity: Low]

Is completing the transfer inline here consistent with the documented
ops->send contract?

include/linux/usb/mctp-usb.h says, for struct mctp_usblib_tx_ops::send:

	/* Start a USB TX for @data. On returning success, the implementation
	 * must arrange for mctp_usblib_tx_send_complete() to be called at some
	 * later point (eg., on urb completion).
	 */

mctp_usblib_test_tx_send() instead calls mctp_usblib_tx_send_complete()
(which runs mctp_usblib_tx_stats_update() and mctp_usblib_tx_ctx_free())
and then returns 0, so the tx context is already freed at the point
success is reported.  The only in-tree implementer,
mctp_usb_out_complete() in drivers/net/mctp/mctp-usb.c, completes
asynchronously from URB completion.

Nothing breaks today: mctp_usblib_tx_send() reads ctx->tx->ops.send, buf
and ctx->len before the call and only returns the result, and both send
sites in mctp_usblib_tx_push() touch the context afterwards only under
if (rc).  But if the library ever legitimately inspects the context after
a successful ->send(), this harness would report it as a KASAN
use-after-free in the test rather than a driver bug.

Would it be better to either record the context and complete it after the
push returns, or to relax the header comment to explicitly allow
synchronous completion?

[ ... ]

> +static u8 *mctp_usblib_test_flatten_tx_buff(struct kunit *test,
> +					    struct list_head *in,
> +					    size_t *length_out)
> +{
[ ... ]
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

> @@ -584,6 +717,156 @@ static void mctp_usblib_test_rx_nonspanning_partial(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
>  }
>  
> +static void mctp_usblib_test_tx_pkt_span(struct kunit *test)
> +{

[ ... ]

> +/* Test sending multiple packets in the same transfer, followed by one that
> + * spans multiple subsequent transfers.
> + */
> +static void mctp_usblib_test_tx_multi_push(struct kunit *test)
> +{

[Severity: Low]

Do the assertions in this test actually observe either of the two
properties named in the comment?

mctp_usblib_test_tx_send() records every ops->send() call as its own
tx_buff node, but mctp_usblib_test_flatten_tx_buff() concatenates all of
them into one buffer before any comparison, so the transfer count and the
transfer boundaries are discarded.  If mctp_usblib_tx_append() or
mctp_usblib_tx_should_send() regressed and the {1000, true} and
{500, false} packets each went out in their own transfer, the flattened
byte stream would be identical and the test would still pass.

For the second half of the comment, the {5000, false} entry does not span
transfers at the ops layer.  mctp_usblib_tx_push() calls
mctp_usblib_tx_ctx_create(tx, skb, single = !more), and:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_ctx_create() {
	...
	if (single || skb->len > TX_SPAN_MAX) {
		type = TX_SINGLE;
	} else {
	...
}

so with more == false (and skb->len of 5004 exceeding TX_SPAN_MAX anyway)
mctp_usblib_tx_send() issues exactly one ops->send() carrying all 5004
bytes; the library never splits one MCTP packet over several ->send()
calls.

The same naming question applies to mctp_usblib_test_tx_pkt_span(), which
also pushes with more == false and produces a single ->send(), so what it
really covers is the v1.1 13-bit length path in
mctp_usblib_tx_skb_prepare() rather than spanning.

Could the comment and the test names be reworded, and could the
per-transfer boundaries be checked instead of flattened, so the packing
behaviour is actually asserted?

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

[Severity: High]

Does this static_assert() compile?

sends[] is a block-scope object with automatic storage duration; the const
qualifier does not make a read of one of its members an integer constant
expression, which is what _Static_assert() requires.  include/linux/build_bug.h
expands static_assert() straight through:

	#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
	#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)

so gcc reports "expression in static assertion is not constant" and clang
reports "static assertion expression is not an integral constant
expression" here.

Because drivers/net/mctp/mctp-usblib.c textually includes this file:

	#if IS_ENABLED(CONFIG_MCTP_TRANSPORT_USBLIB_TEST)
	#include "mctp-usblib-test.c"
	#endif

the failure takes out the whole translation unit, so
drivers/net/mctp/mctp-usblib.o does not build whenever
CONFIG_MCTP_TRANSPORT_USBLIB_TEST is enabled, which is exactly the config
needed to run these tests.  The same static_assert is still present in
mctp_usblib_test_tx_multi_push() at the end of the series (7b7c42135cec),
so nothing later in the series fixes it.

Would BUILD_BUG_ON(), which relies on optimizer folding, or a run-time
KUNIT_ASSERT_FALSE(test, sends[ARRAY_SIZE(sends) - 1].more) express the
same invariant?

> +
> +	max_length = 0;
> +	for (i = 0; i < ARRAY_SIZE(sends); i++) {
> +		if (sends[i].len > max_length)
> +			max_length = sends[i].len;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56%40codeconstruct.com.au
