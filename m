Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46522EEE60;
	Tue, 13 Oct 2026 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882372; cv=none; b=gfnPM7hK1Pek609Vhs462XfW7kFhtUbOSd2W5Xb1RTM/S4o4Cqj7ONcgxoiozKrlhRe6oKzk2NJrurV4CavR2EDX6UIeZAwXs8hoQ4AjIXJwquPWXn6tYDfyd21utwRcwzBl/ZVNqvXVHseSEvOqI+BsQgdo4+2I2+KPwO8L7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882372; c=relaxed/simple;
	bh=f3YbRRpgLvGIDJhlgxW1hH5ooXnf+mjazscQxi2bxXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BJrvMtVssCWfUuMpBFobCu+a1IeSPkeeEwbo8Zh27u35IGngqC/P6HJIkzcWCBfyRq2UOtWk04Xw6hdJLLyZXfS9Ql3/Vg8EU/i/L3DaQjH7aSlvNnIerE0l433hOS4U3oDK4OmKLSZy5FeqLj0vx6ZSG0uLkUTx7I62pVsv3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=f3oR+A+z; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="f3oR+A+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791882368;
	bh=r8qCmCeihUM0ETfYMNS7MCtzzdS2TGMfG+CaacKLVOc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f3oR+A+zo3fu9nRTCehlMftKh6WUfYtiigQLng4cuZSoJFyjUKlbg+TmoKGpu12N9
	 n+LZR2GyVT6R06Tq8/XgmlqkGtR7At9Nj9A2Qqf6e9KLEDKCyWySE+GHXzxCrayVZM
	 08+l+xt/ATPvU7OLUglxK15t8Ah1mYSy3kYUrj4SWjKgX8rCDZdKs2rMAEVgy6yrWm
	 J+tyx8ycZTbdwHl5Mo7kEiLTbFMuY31+MDj6wNVKJ2qFxdHlR4GKCZ1deQMbOVViFm
	 cD7jCS7pvC7kJ8w3hEjWGfRCHRkOId8y98mgoVuvl0o3g8N0L69vdVB9CODfRbewWc
	 ji9dUCj0sw7OA==
Received: from [192.168.72.170] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 02AE06FB39;
	Tue, 13 Oct 2026 17:06:06 +0800 (AWST)
Message-ID: <09f81599d3272e23fb4cffbbff669021d9c9b204.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 7/7] net: mctp: usblib: Add test for failing
 append
From: James Lee <james@codeconstruct.com.au>
To: netdev-bot+sashiko@kernel.org
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, 	davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, 	kees@kernel.org,
 gustavoars@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Tue, 13 Oct 2026 17:06:06 +0800
In-Reply-To: <178893260523.219967.7691706807394215121@kernel.org>
References: 
	<20260903-dev-mctp-usb-lib-test-v2-7-313cf15e0b56@codeconstruct.com.au>
	 <178893260523.219967.7691706807394215121@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> [Severity: Low]
> This isn't a bug, but len =3D 200 and the loop count of 3 below
> silently
> encode a dependency on MCTP_USB_1_0_XFER_SIZE (512) and MCTP_USB_BTU,
> without referencing either constant.
>=20
> I traced the intended path and it does run today with span=3Dfalse:
> each skb
> becomes 204 bytes after mctp_usblib_tx_skb_prepare() pushes the 4-
> byte
> header, push 1 creates the 512-byte ctx, push 2 appends (len 408,
> avail
> 104), and push 3 hits mctp_usblib_tx_append():
>=20
> 	if (mctp_usblib_tx_avail(ctx) < skb->len)
> 		return -ENOBUFS;
>=20
> with avail 104 < skb->len 204.
>=20
> Could len and the iteration count be derived from
> MCTP_USB_1_0_XFER_SIZE / MCTP_USB_BTU instead, so the case keeps
> hitting
> the append-failure branch if those change?
>=20
> Also, would tx_overflow be better named after the append failure the
> commit subject describes?
>=20
Valid catch, will rename and remove the magic constants.

>=20
> [Severity: High]
> Can this sleep with preemption disabled?=C2=A0 get_cpu_ptr() expands to
> preempt_disable() plus this_cpu_ptr(), so the whole loop runs in
> atomic
> context, and mctp_usblib_test_init_skb() allocates with GFP_KERNEL:
>=20
> drivers/net/mctp/mctp-usblib-test.c:mctp_usblib_test_init_skb() {
> 	skb =3D __netdev_alloc_skb(ndev, length, GFP_KERNEL);
> 	KUNIT_ASSERT_NOT_NULL(test, skb);
> 	...
> }
>=20
> GFP_KERNEL sets __GFP_DIRECT_RECLAIM, so __netdev_alloc_skb() takes
> the
> blocking slab path:
>=20
> net/core/skbuff.c:__netdev_alloc_skb() {
> 	if (len <=3D SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) ||
> 	=C2=A0=C2=A0=C2=A0 len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
> 	=C2=A0=C2=A0=C2=A0 (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
> 		skb =3D __alloc_skb(len, gfp_mask, SKB_ALLOC_RX,
> NUMA_NO_NODE);
> 	...
> }
>=20
> With CONFIG_DEBUG_ATOMIC_SLEEP, wouldn't the might_sleep() in the
> allocator produce a "sleeping function called from invalid context"
> splat
> every time this case runs?
>=20
> Two further consequences of the same region:
>=20
> The KUNIT_ASSERT_NOT_NULL() in mctp_usblib_test_init_skb() and the
> KUnit
> failure reporting behind KUNIT_EXPECT_EQ() also allocate with
> GFP_KERNEL,
> and the assert variant does not return:
>=20
> lib/kunit/try-catch.c:kunit_try_catch_throw() {
> 	try_catch->try_result =3D -EFAULT;
> 	kthread_exit(0);
> }
>=20
> so put_cpu_ptr() below is skipped and the thread exits still in
> atomic
> context, which kernel/exit.c reports:
>=20
> kernel/exit.c:do_exit() {
> 	if (unlikely(in_atomic())) {
> 		pr_info("note: %s[%d] exited with preempt_count
> %d\n",
> 			current->comm, task_pid_nr(current),
> 			preempt_count());
> 		preempt_count_set(PREEMPT_ENABLED);
> 	}
> 	...
> }
>=20
> mctp_usblib_tx_push() also takes a spinlock_t here:
>=20
> drivers/net/mctp/mctp-usblib.c:mctp_usblib_tx_push() {
> 	spin_lock_irqsave(&tx->lock, flags);
> 	...
> }
>=20
> On PREEMPT_RT that is a sleeping lock, so is acquiring it from an
> explicitly preempt-disabled section valid?
>=20
> Note the driver itself uses GFP_ATOMIC on this path
> (mctp_usblib_tx_ctx_create() uses kzalloc_flex(..., GFP_ATOMIC)), so
> only
> the test's own allocation is out of context.
>=20
> Since mctp_usblib_tx_stats_update() picks the counter with
> get_cpu_ptr(dev->dstats), could the skb allocation and the assertions
> move
> outside the pinned region, leaving only the counter read inside
> get_cpu_ptr()/put_cpu_ptr(), or could tx_drops be summed over
> for_each_possible_cpu() instead?
Good catch, will correct.

> [Severity: Low]
> This is the same finding as the len =3D 200 comment above: this
> aggregate
> drop count is the only oracle in the case.
>=20
> The append-failure path yields 2 drops from the detached two-skb
> context
> plus 1 from the single-skb context, but so do other paths: if the ctx
> buffer size grew, if the MCTP_USB_BTU margin in
> mctp_usblib_tx_should_send() changed so the ctx flushed after push 2,
> or
> if all three skbs fit one ctx, the append branch never runs and stats
> is
> still 3.
>=20
> Neither the number of ops.send() invocations, nor tx->cur_ctx, nor
> ctx->tx_xfers is checked here, while the neighbouring
> mctp_usblib_test_tx_failing_send() does:
>=20
> 	KUNIT_EXPECT_EQ(test, rc, 0);
> 	KUNIT_EXPECT_NULL(test, tx->cur_ctx);
> 	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->tx_xfers));
>=20
> Would checking tx_drops =3D=3D 0 after the first two pushes and counting
> the
> send attempts (2 sends carrying 2 and 1 packets) pin down the branch
> under
> test?
Fair point, will begin checking for expected behaviour between sends as
well.
