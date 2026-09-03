Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F033A9D6;
	Thu,  3 Sep 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471979; cv=none; b=EXEdwBMFAcwXzeECfYl93+FqxKOe1uVIQ8T3XA9k42FDmRn3Jf06QQ9NgX1wQYzgrnKfdVYoAaC41wTyNZjAgtnZTmZnA5PNqCBsAOYNUKl1sOmqmpc7es4b63YMFv9zprEfWd2SZwg5r0S9AlK+4IVyE9b9toRVeTo7/LpyRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471979; c=relaxed/simple;
	bh=FL0po3/kGDnNaMBSZex9evui9guRyTQFM91KmLxLBP4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIWbMV978Hj60o0SIbwJ7slCijp4BTVILM1uwzYt4R4jCFb4GXpaPiMvArenmKEJEorj6o7JsaMkg7axRLubM5P8+9bG57fbHTR6xYAGmf2V5CrNN9Kzy/W/6BuHsXjCqIvM+hlYKhZra6J5PLrlbhWtQmZphZGeCuBCWfLzVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOjJibaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOjJibaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024C91F000E9;
	Thu,  3 Sep 2026 21:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788471968;
	bh=NRTKQWi3/W8mDGAV511J1aM3BxwR5Rvi2GawTznPE3k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OOjJibaFLUqzB79WckYZbOXP9hFvymKYptxLV1GvyU5I21qhxR0+H0IB91mMLGtKn
	 w1kq9j0HSlBvq91AJqkJ1qRLBdyP6aw9rev9sfARz5owCNSzWm+HjAnfTJnGsaGQ6u
	 WJmQhIp8d1qhBNopMThYKJQPb5saZ9z0pi9+es+Yc/unntXgaDBJevzV8ikK+KjhZZ
	 j46w80cfeiUm7/I2j4cx961NgoZyRnHky6L56Wy0aVHMVyMdUYNc3TQ4YA12WW1GmI
	 bKOt5+UrG23Aa8w+NFdji6LpHyLChIS/v7CcJP3cvF8dO+85h7+TfmagjyFEMvhjWc
	 IalXGPp/As77Q==
Subject: Re: [7/7] net: mctp: usblib: Add test for failing append
From: netdev-bot+sashiko@kernel.org
To: james@codeconstruct.com.au
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 03 Sep 2026 21:46:07 +0000
Message-ID: <178847196753.3394541.3220481383964170252@kernel.org>
In-Reply-To:
 <20260831-dev-mctp-usb-lib-test-v1-7-79699bf67a18@codeconstruct.com.au>
References:
 <20260831-dev-mctp-usb-lib-test-v1-7-79699bf67a18@codeconstruct.com.au>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] The new KUnit test `mctp_usblib_test_tx_overflow()`
  (drivers/net/mctp/mctp-usblib-test.c) does not exercise the append-…
- [Medium] Preempt-count leak in the new test:
  `mctp_usblib_test_tx_overflow()` calls `dstats =…
- [Medium] `mctp_usblib_test_tx_overflow()` verifies the drop accounting
  by reading `tx_drops` from only one CPU's per-CPU `pcpu_dstats` — the…
- [Low] The patch adds `#include "linux/percpu-defs.h"` at
  drivers/net/mctp/mctp-usblib-test.c:9 — a quoted (local-path) include…

--

net: mctp: usblib: Add test for failing append

Adds a KUnit case, mctp_usblib_test_tx_overflow(), which pushes three
200-byte packets through mctp_usblib_tx_push() with a failing send op and
then checks that tx_drops was incremented three times.  A few questions
about the new test below.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> index 7dc382caffc1..b3a2cc5cbd99 100644
> --- a/drivers/net/mctp/mctp-usblib-test.c
> +++ b/drivers/net/mctp/mctp-usblib-test.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2026 Code Construct Pty Ltd
>   */
>  
> +#include "linux/percpu-defs.h"

[Severity: Low]
This isn't a bug, but is this include intentional?  It uses the quoted
form for a kernel header and sits ahead of the sorted <linux/...> block,
and it appears redundant: the file already includes <linux/netdevice.h>,
which pulls in <linux/percpu.h> and therefore percpu-defs.h, and which is
where struct pcpu_dstats comes from.  Could it be dropped, or at least
switched to the angle-bracket form in the sorted position?  The commit
message doesn't mention this hunk.

>  #include <linux/array_size.h>
>  #include <uapi/linux/netdevice.h>
>  #include <linux/netdevice.h>

[ ... ]

> @@ -871,6 +872,46 @@ static void mctp_usblib_test_tx_multi_push(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(sends));
>  }
>  
> +static void mctp_usblib_test_tx_overflow(struct kunit *test)
> +{

[ ... ]

> +	len = 200;
> +
> +	ctx = mctp_usblib_test_init(test);
> +	ndev = ctx->dev->ndev;
> +
> +	ops.send = mctp_usblib_test_tx_send_fail;
> +
> +	tx = mctp_usblib_test_tx_init(test, &ops, ctx, false);

[Severity: Medium]
Does this test actually reach the append-overflow path it is named for?
The span = false argument is discarded by the helper, which hardcodes
true:

drivers/net/mctp/mctp-usblib-test.c:mctp_usblib_test_tx_init() {
	...
	mctp_usblib_tx_init(tx, ops, priv, true);
	...
}

With span forced on, mctp_usblib_tx_ctx_create() picks the large buffer:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_ctx_create() {
	...
	sz = tx->span ? TX_SPAN_MAX : MCTP_USB_1_0_XFER_SIZE;
	...
}

Each skb here is 200 bytes plus the 4-byte struct mctp_usb_hdr pushed by
mctp_usblib_tx_skb_prepare(), so 3 x 204 bytes fit in the ~4040-byte
spanning buffer and this check never fires:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_append() {
	...
	if (mctp_usblib_tx_avail(ctx) < skb->len)
		return -ENOBUFS;
	...
}

So only the single !more send at i == 2 fails, and
mctp_usblib_tx_stats_update() adds ctx->skbs.qlen == 3 in one go.

> +	buf = mctp_usblib_test_init_buf(test, len);
> +
> +	for (i = 0; i < 3; i++) {
> +		skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
> +
> +		rc = mctp_usblib_tx_push(ndev, tx, skb, i != 2);
> +		KUNIT_EXPECT_EQ(test, rc, 0);
> +	}
> +
> +	dstats = get_cpu_ptr(ndev->dstats);

[Severity: Medium]
Is the missing put_cpu_ptr() here a problem?  get_cpu_ptr() expands to
preempt_disable() plus this_cpu_ptr(), and mctp_usblib_test_tx_overflow()
returns without re-enabling preemption, so the case leaves preempt_count
elevated by one.

Two effects follow.  The KUNIT_EXPECT_EQ() below now runs in atomic
context, and on failure it reaches a sleeping allocation:

lib/kunit/test.c:kunit_fail() {
	...
	stream = kunit_alloc_string_stream(test, GFP_KERNEL);
	...
}

which gives "BUG: sleeping function called from invalid context" with
CONFIG_DEBUG_ATOMIC_SLEEP.  On the passing path the kunit try-thread exits
with preempt_count 1, so do_exit() complains and force-resets the count.

The driver pairs these calls in both of its stats helpers, e.g.:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_stats_update() {
	struct pcpu_dstats *dstats = get_cpu_ptr(dev->dstats);
	...
	put_cpu_ptr(dev->dstats);
}

Could this read use per_cpu_ptr() instead, given it does not need
preemption disabled at all?

> +	do {
> +		start = u64_stats_fetch_begin(&dstats->syncp);
> +		stats = u64_stats_read(&dstats->tx_drops);
> +	} while (u64_stats_fetch_retry(&dstats->syncp, start));
> +
> +	KUNIT_EXPECT_EQ(test, stats, 3);

[Severity: Medium]
Can this expectation fail spuriously on an SMP preemptible kernel?

The three mctp_usblib_tx_push() calls above run in the kunit try-thread
with preemption enabled and no migrate_disable(), and each writer picks
the current CPU inside its own short window:

drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_stats_single_drop() {
	struct pcpu_dstats *dstats = get_cpu_ptr(dev->dstats);
	...
	put_cpu_ptr(dev->dstats);
}

If the thread migrates between pushes, the increments are spread over
several CPUs while this code samples only one, so stats comes back below
3 and the failure looks like a driver accounting bug.  Would aggregating
over for_each_possible_cpu() (each with its own fetch_begin/retry loop),
or calling dev_get_stats(), be more robust here?

[Severity: Medium]
A related question on this assertion: both control flows produce
tx_drops == 3.  In the intended non-spanning case the third append fails
with -ENOBUFS (avail 512 - 408 = 104 < 204), the pending 2-skb context
fails to send (+2), and the new single-packet context fails to send (+1).
In the spanning case actually exercised, one context of 3 skbs fails to
send (+3).

Since the aggregate is identical, would this test still pass if the
append-failure accounting were broken?  As written it looks like it
duplicates mctp_usblib_test_tx_failing_send() rather than adding new
coverage.

> +}
> +
>  static struct kunit_case mctp_usblib_test_cases[] = {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18%40codeconstruct.com.au
