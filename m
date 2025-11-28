Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F430C60E
	for <linux-hardening@vger.kernel.org>; Fri, 28 Nov 2025 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764328420; cv=none; b=RXKvzKiT+mH2XOafOJNn/j/j9a+N6t/XMi6hMpQNepuBF2HbPNjWJeGcggN540jJtQK/fj5Y57rIBVtA2UWjCkA8x9IdPCFG4/d9CAWskQUkF7UT+YDieiC3PmYuhxxl6DXHNRHY41PkuYneuFsoK+kj1NNCpX6km3xA0e9t5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764328420; c=relaxed/simple;
	bh=c1Mq0WGUzy4hzagD/FlZvIKEgqRHU2A2kr1hottWSs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVugl3hEmu87LNGFaS+iotaW0BBekNEAFfFOItRvSf1M9+YVAB0McrpUmmWYhsZGvilTRSy6HxBLL/bx319azWuCTYdaFYAcU9neFDUnHb8wB39WZ7+yET1qAC3rvBzazhH65dAf2JIauEnM2Nc7vc1FEG0uMnHr7tD8tdSU17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=IYm3uWpR; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="IYm3uWpR"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOwPu-00FYmE-PY; Fri, 28 Nov 2025 12:13:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=MwtFy12k7pcBtaBx7XCC7zsQfGXj2p1ui+rmNS8beZM=; b=IYm3uWpRmXV7UHhqz5wm5BUjq6
	17pwTdumu1ocLPSW1uNg4VOxp2lhbAvxGGL5rqAcIn5Jdj55SEis8SxHXIrmFuelaQwKSX9AuyLYa
	anAYbIfRmq+dZnxJ40adwB11kMZri7kQGksdsUKP/BZoc1lHHZjbtin097Qa+tPgerQY2q/96gQRe
	0HD/36PrsaBbvFZYsNHGy8+EmpiDCcZz1kiwe3kRU1cuQEAh8MGCqUCnzeeo9rmvUdIbhDwk0mCn2
	N7crtj9XFUhYNEVx5+9vwYK+v9RfcclTBD23Ym0yMGpRcp8+h5G65W9BsV4AwDfg0MxVi81wzVlAQ
	ioH1Qmxw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOwPt-0004jg-Qx; Fri, 28 Nov 2025 12:13:33 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOwPr-000RyT-Ab; Fri, 28 Nov 2025 12:13:31 +0100
Date: Fri, 28 Nov 2025 11:13:28 +0000
From: david laight <david.laight@runbox.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Kees Cook
 <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Will Deacon
 <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC/RFT PATCH 5/6] random: Plug race in preceding patch
Message-ID: <20251128111328.68354182@pumpkin>
In-Reply-To: <20251127092226.1439196-13-ardb+git@google.com>
References: <20251127092226.1439196-8-ardb+git@google.com>
	<20251127092226.1439196-13-ardb+git@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 10:22:32 +0100
Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The lockless get_random_uXX() reads the next value from the linear
> buffer and then overwrites it with a 0x0 value. This is racy, as the
> code might be re-entered by an interrupt handler, and so the store might
> redundantly wipe the location accessed by the interrupt context rather
> than the interrupted context.

Is overwriting the used value even useful?
If someone manages to read the 'last' value, then they can equally read
the 'next' one - which is likely to be just as useful.
Moreover the zeros tell anyone who has managed the access the buffer
which entry will be used next - without having to find 'batch->position'.

There is probably more to gain from putting the control data in a
completely different piece of memory from the buffer.

	David

> 
> To plug this race, wipe the preceding location when reading the next
> value from the linear buffer. Given that the position is always non-zero
> outside of the critical section, this is guaranteed to be safe, and
> ensures that the produced values are always wiped from the buffer.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/char/random.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 71bd74871540..e8ba460c5c9c 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -547,6 +547,7 @@ type get_random_ ##type(void)							\
>  	next = (u64)next_gen << 32;						\
>  	if (likely(batch->position < ARRAY_SIZE(batch->entropy))) {		\
>  		next |=	batch->position + 1; /* next-1 is bogus otherwise */	\
> +		batch->entropy[batch->position - 1] = 0;			\
>  		ret = batch->entropy[batch->position];				\
>  	}									\
>  	if (cmpxchg64_local(&batch->posgen, next, next - 1) != next - 1) {	\

