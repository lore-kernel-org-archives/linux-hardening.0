Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E42264D6;
	Tue, 16 Jun 2026 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569258; cv=none; b=mwEmn4jgpbXkUHKm3M4b1KYIer+5EqP0/D/q/jBcMnFhlHwm1XK2aL04OWH7uN+JO4Slw7fv98EAK6TMwNJ8Lp/KTJuRT9Y6YtvNaGqZ2fcGVtgwthR8uAsKxUV09PYPzEuihta8jD8cdNRhnP3HlD+8E39btFTSSezqrvGbJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569258; c=relaxed/simple;
	bh=wEKDV+rvEzW/GsX9IMLW4VBOK/SLwUy4xNVC6Yz+6Fs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxil4iRWyRNmAPRwhvuGgoSWpg8Qa12yFVddXeLhz+CmMEjLvnEg4+gv1wdRzcToTCvh+mh2gZPmj0601dGNhjVrqh1OLSOPHNWz0EkTJ69pUYy1U0k6NfhttKJ7ZGlHTx487YPzvPVsFBKJcNboycBV0+3OP6FMlv6ryA0fW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=eC2tXB7y; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="eC2tXB7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781569255;
	bh=wEKDV+rvEzW/GsX9IMLW4VBOK/SLwUy4xNVC6Yz+6Fs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eC2tXB7ykm3tgVwqx2hDiTZi6AmMv4ab15vLo4MTFUT6qRuH3D8uPUoLMxu6pseDj
	 ayhpOdvK88yIlEtYVIH6w7rHrMKDf3axkUigBbc+HBosT723Ta2A8jGmOgBx7WcjNJ
	 qm2zkRriO1DQtI9AWlnIelZ6QG5Oesv4RjlAR2SV5g5PdY4XUK8oVqaKsBYmpE2sQv
	 FpxD97Z10eii3z0mKAES1A/MMozfIEAd4hzf4srn9TZzrvfRTDPOT1RsCYDDL3Ajqy
	 UGzNo75MQOYg8i0DpsIa88MP5uDiLOizqalxBVm94Ie7S3oqySpD9TTDscn165ThLM
	 J8oqdA0KsRn0A==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C7BD06001B;
	Tue, 16 Jun 2026 08:20:54 +0800 (AWST)
Message-ID: <133a2533be758b1e95bb0365a90d5907c7b09ddc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Tue, 16 Jun 2026 09:50:54 +0930
In-Reply-To: <20260612190744.172638-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260612190744.172638-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-12 at 19:07 +0000, Karthikeyan KS wrote:
> put_fifo_with_discard() acts as both producer and consumer on the kfifo:
> it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
> the IRQ handler without synchronizing with snoop_file_read(), which also
> consumes via kfifo_to_user(). On SMP systems this concurrent access can
> leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clam=
p
> to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
> copy_to_user() past the kmalloc-2k backing store:
>=20
> =C2=A0 usercopy: Kernel memory exposure attempt detected from SLUB object
> =C2=A0 'kmalloc-2k' (offset 0, size 2049)!
> =C2=A0 kernel BUG at mm/usercopy.c!
> =C2=A0 Call trace:
> =C2=A0=C2=A0 usercopy_abort
> =C2=A0=C2=A0 __check_heap_object
> =C2=A0=C2=A0 __check_object_size
> =C2=A0=C2=A0 kfifo_copy_to_user
> =C2=A0=C2=A0 __kfifo_to_user
> =C2=A0=C2=A0 snoop_file_read
> =C2=A0=C2=A0 vfs_read
>=20
> Serialize kfifo access with a per-channel spinlock shared between the
> IRQ handler (producer) and the file reader (consumer).=C2=A0 Annotate @fi=
fo
> with __guarded_by(&lock) and opt the driver into context analysis so the
> compiler enforces that all fifo access holds the lock.
>=20
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc ch=
ardev")
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
> ---
> =C2=A0drivers/soc/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 38 ++++++++++++++++++------=
---
> =C2=A02 files changed, 27 insertions(+), 12 deletions(-)
>=20
> Andrew,
>=20
> Thanks for the review.
>=20
> Changes since v5:
> - Annotate @fifo with __guarded_by(&lock) instead of a comment
> - Move kfifo_initialized() check inside scoped_guard(spinlock, &chan->loc=
k)
> =C2=A0 in put_fifo_with_discard()
> - Replace spin_lock_init() with scoped_guard(spinlock_init, &channel->loc=
k)
> =C2=A0 around kfifo_alloc() in aspeed_lpc_enable_snoop()
> - Enable CONTEXT_ANALYSIS for this driver in drivers/soc/aspeed/Makefile
>=20
> Dropped Cc: stable =E2=80=94 the fix uses cleanup.h/context-analysis idio=
ms absent
> from LTS; I'll send adapted backports to stable@ once this is in mainline=
.
>=20
> Tested on ast2600-evb (QEMU):=C2=A0
>=20

Can you describe the specific steps you used to test this under qemu?
I'm interested in reproducing your efforts here.

Andrew
