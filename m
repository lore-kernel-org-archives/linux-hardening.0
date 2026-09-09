Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32A38E8BD;
	Wed,  9 Sep 2026 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932615; cv=none; b=HARHAr5cLc1afiMLln/PKj/echpiTBklSmqRa1bur2RlatlyCYVc3vBWS2KrxSsuQCGuGvUqgGTgeWmFlsCeBrcsobvNtQzzXxWuKjR+G/8RP5Q537fAWTNqlLNh0P2ovye8U3KOL9e5Bi55XrF/QTIjrInuWAohY3xsjK4AnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932615; c=relaxed/simple;
	bh=nbp3vJ9M6dnWV+9Gt8heBSp2MC4MZZYdhYahrYt+ZCg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifplJ7wQRVpGAybWbfYhwkQNr3bEO5irXj9uNExk5EHq2s/kcdUu/xvjn59jCujBja6Px2nezXyIrmUTYbWpd4PqAlnDTZYW7e5Ep8BVx0AK7I0Mq1ULYZlZ8l5h1UO87pwhP+en8Y5MZNTUYjl8Cp8mR/7iXPvfr2gu7gxtp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBuMSeWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBuMSeWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F31F00A3A;
	Wed,  9 Sep 2026 05:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788932606;
	bh=SrgUySBHJx3FdRjq/ffjjyZVSlvYV7wHdbXU/tg5FZI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HBuMSeWmh6PBXW7VjBfK/9JUDy7xkpO5OWRZwmnZz6heIG5n4RyKCRANWZapXX9P+
	 MAuWBMnjXWIFeGq76JR4FybMAzgZ+8JO+kigNFCjZt1JsAYPdQBGOhJ6miyYERHm2O
	 bSOpaoepZD/tw70BWdnhuYHnLAoNxBSFlvE8hHeE/BSSakTCwq7OP2CG7TQm0rJtz6
	 srRmjrv6ZAa1Up6IyIGjzEkLBJUaZl3PWJFFKWncPgWhp6T260grT2l8Je2kp+Js4k
	 mWY5kXhi2bMbfSLm4chO++f1+RJjirEMAFPwCf57vTpfRh8R4UAorS5YGWzOce2lGv
	 gxKd3FMjZJH1w==
Subject:
 Re: [PATCH net-next v2 7/7] net: mctp: usblib: Add test for failing append
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 09 Sep 2026 05:43:25 +0000
Message-ID: <178893260523.219967.7691706807394215121@kernel.org>
In-Reply-To:
 <20260903-dev-mctp-usb-lib-test-v2-7-313cf15e0b56@codeconstruct.com.au>
References:
 <20260903-dev-mctp-usb-lib-test-v2-7-313cf15e0b56@codeconstruct.com.au>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] drivers/net/mctp/mctp-usblib-
  test.c:mctp_usblib_test_tx_overflow() disables preemption with `dstats…
- [Low] The oracle of the new mctp_usblib_test_tx_overflow()
  (drivers/net/mctp/mctp-usblib-test.c:869-908) is a single aggregate…

--

net: mctp: usblib: Add test for failing append

Adds a KUnit case, mctp_usblib_test_tx_overflow(), to the mctp-usblib
test suite that pushes three 200-byte packets through
mctp_usblib_tx_push() with a failing send op, then checks that the
per-CPU tx_drops counter reached 3.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 73bda4745433..25eac80db3e2 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c
> @@ -867,6 +867,47 @@ static void mctp_usblib_test_tx_multi_push(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(sends));
>  }
>  
> +static void mctp_usblib_test_tx_overflow(struct kunit *test)
> +{
> +	struct mctp_usblib_test_ctx *ctx;
> +	struct mctp_usblib_tx_ops ops;
> +	struct pcpu_dstats *dstats;
> +	struct mctp_usblib_tx *tx;
> +	struct net_device *ndev;
> +	struct sk_buff *skb;
> +	unsigned int start;
> +	size_t len, i;
> +	u64 stats;
> +	u8 *buf;
> +	int rc;
> +
> +	len = 200;

[Severity: Low]
This isn't a bug, but len = 200 and the loop count of 3 below silently
encode a dependency on MCTP_USB_1_0_XFER_SIZE (512) and MCTP_USB_BTU,
without referencing either constant.

I traced the intended path and it does run today with span=false: each skb
becomes 204 bytes after mctp_usblib_tx_skb_prepare() pushes the 4-byte
header, push 1 creates the 512-byte ctx, push 2 appends (len 408, avail
104), and push 3 hits mctp_usblib_tx_append():

	if (mctp_usblib_tx_avail(ctx) < skb->len)
		return -ENOBUFS;

with avail 104 < skb->len 204.

Could len and the iteration count be derived from
MCTP_USB_1_0_XFER_SIZE / MCTP_USB_BTU instead, so the case keeps hitting
the append-failure branch if those change?

Also, would tx_overflow be better named after the append failure the
commit subject describes?

> +
> +	ctx = mctp_usblib_test_init(test);
> +	ndev = ctx->dev->ndev;
> +
> +	ops.send = mctp_usblib_test_tx_send_fail;
> +
> +	tx = mctp_usblib_test_tx_init(test, &ops, ctx, false);
> +	buf = mctp_usblib_test_init_buf(test, len);
> +
> +	dstats = get_cpu_ptr(ndev->dstats);
> +	for (i = 0; i < 3; i++) {
> +		skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
> +
> +		rc = mctp_usblib_tx_push(ndev, tx, skb, i != 2);
> +		KUNIT_EXPECT_EQ(test, rc, 0);
> +	}

[Severity: High]
Can this sleep with preemption disabled?  get_cpu_ptr() expands to
preempt_disable() plus this_cpu_ptr(), so the whole loop runs in atomic
context, and mctp_usblib_test_init_skb() allocates with GFP_KERNEL:

drivers/net/mctp/mctp-usblib-test.c:mctp_usblib_test_init_skb() {
	skb = __netdev_alloc_skb(ndev, length, GFP_KERNEL);
	KUNIT_ASSERT_NOT_NULL(test, skb);
	...
}

GFP_KERNEL sets __GFP_DIRECT_RECLAIM, so __netdev_alloc_skb() takes the
blocking slab path:

net/core/skbuff.c:__netdev_alloc_skb() {
	if (len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
	...
}

With CONFIG_DEBUG_ATOMIC_SLEEP, wouldn't the might_sleep() in the
allocator produce a "sleeping function called from invalid context" splat
every time this case runs?

Two further consequences of the same region:

The KUNIT_ASSERT_NOT_NULL() in mctp_usblib_test_init_skb() and the KUnit
failure reporting behind KUNIT_EXPECT_EQ() also allocate with GFP_KERNEL,
and the assert variant does not return:

lib/kunit/try-catch.c:kunit_try_catch_throw() {
	try_catch->try_result = -EFAULT;
	kthread_exit(0);
}

so put_cpu_ptr() below is skipped and the thread exits still in atomic
context, which kernel/exit.c reports:

kernel/exit.c:do_exit() {
	if (unlikely(in_atomic())) {
		pr_info("note: %s[%d] exited with preempt_count %d\n",
			current->comm, task_pid_nr(current),
			preempt_count());
		preempt_count_set(PREEMPT_ENABLED);
	}
	...
}

mctp_usblib_tx_push() also takes a spinlock_t here:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_push() {
	spin_lock_irqsave(&tx->lock, flags);
	...
}

On PREEMPT_RT that is a sleeping lock, so is acquiring it from an
explicitly preempt-disabled section valid?

Note the driver itself uses GFP_ATOMIC on this path
(mctp_usblib_tx_ctx_create() uses kzalloc_flex(..., GFP_ATOMIC)), so only
the test's own allocation is out of context.

Since mctp_usblib_tx_stats_update() picks the counter with
get_cpu_ptr(dev->dstats), could the skb allocation and the assertions move
outside the pinned region, leaving only the counter read inside
get_cpu_ptr()/put_cpu_ptr(), or could tx_drops be summed over
for_each_possible_cpu() instead?

> +
> +	do {
> +		start = u64_stats_fetch_begin(&dstats->syncp);
> +		stats = u64_stats_read(&dstats->tx_drops);
> +	} while (u64_stats_fetch_retry(&dstats->syncp, start));
> +	put_cpu_ptr(dstats);
> +
> +	KUNIT_EXPECT_EQ(test, stats, 3);

[Severity: Low]
This is the same finding as the len = 200 comment above: this aggregate
drop count is the only oracle in the case.

The append-failure path yields 2 drops from the detached two-skb context
plus 1 from the single-skb context, but so do other paths: if the ctx
buffer size grew, if the MCTP_USB_BTU margin in
mctp_usblib_tx_should_send() changed so the ctx flushed after push 2, or
if all three skbs fit one ctx, the append branch never runs and stats is
still 3.

Neither the number of ops.send() invocations, nor tx->cur_ctx, nor
ctx->tx_xfers is checked here, while the neighbouring
mctp_usblib_test_tx_failing_send() does:

	KUNIT_EXPECT_EQ(test, rc, 0);
	KUNIT_EXPECT_NULL(test, tx->cur_ctx);
	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->tx_xfers));

Would checking tx_drops == 0 after the first two pushes and counting the
send attempts (2 sends carrying 2 and 1 packets) pin down the branch under
test?

> +}
> +
>  static struct kunit_case mctp_usblib_test_cases[] = {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56%40codeconstruct.com.au
