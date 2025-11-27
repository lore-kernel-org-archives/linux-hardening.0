Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13642320CC9
	for <linux-hardening@vger.kernel.org>; Thu, 27 Nov 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238307; cv=none; b=uyQwBZ0yx8ymNkhfAniECVzxwclrB4nzlPU5AeufpEArlqidKAG7f29Lp1Ou2qlToefFGDeK7O98Hdr3BExWEeKvTD6DnNQVTz/fnC5zK7zJSK7kf9OwFcaZ/YxfrvjL6TamKV/sI5Ct5fZPs+yJ1Aw2pNkj9fHaBmlpjDdridY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238307; c=relaxed/simple;
	bh=7fxrFSjsyB06XiWWgUMwd7bxllC8RvWrYDzFAhylcsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSu7qzPL0512WG4csm/o73wZamkkQ2v1XFivNB0ffsBSK3QCSarM2M5XcJ3GahbIGyd8sK4rUlxD3sklKKXqcLr1H5VHzl3kKiwHFviizFbgfP4gTx3nuPCyXWzI/JUDv54+2zC9xTD4m6B/9EipQz4KAQNK7Lppw1GZT+sOyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=gleEvVb8; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="gleEvVb8"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOYyT-00CLre-Mf; Thu, 27 Nov 2025 11:11:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=b+HGqQCZc4eTZBJ9S6jotkuvef/+Q9e4UGutZNIsM0k=; b=gleEvVb8YL3YCbwWkElFc3dyIE
	Bho6Zzifao6+XVQ3u1y7HfFoL9IPTQCfi2OP1SBZ4fITVbrZMZigVd0zXUH+3ZiLR0l+UQMI1KbG4
	RS1qbgRTzKI8Pi2TYR0gdURbDV9pGjFFSOiQSCwYUOpWAvxs/bO6zYJ0O6qbqPcNvw+5MOfy6aEuk
	oK8g6jUlfFxnXfxox9tj3xmLKyL5zSe2lct3Wv5Dxg45KTZKwqK921Fe76eROzzxjp8ijCmSDWuZj
	wTBIoy8WPAoPbkc87rEm3oRsPfRhtBA0kJ2/7fZkMA6ud3wE1maTh26BupWtyiphT+44azPZXnePY
	SJD/cZVg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOYyS-0005Hs-Ie; Thu, 27 Nov 2025 11:11:40 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOYyK-00FsJI-6T; Thu, 27 Nov 2025 11:11:32 +0100
Date: Thu, 27 Nov 2025 10:11:29 +0000
From: david laight <david.laight@runbox.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Kees Cook
 <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Will Deacon
 <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC/RFT PATCH 3/6] random: Use u32 to keep track of batched
 entropy generation
Message-ID: <20251127101129.204c6c5a@pumpkin>
In-Reply-To: <20251127092226.1439196-11-ardb+git@google.com>
References: <20251127092226.1439196-8-ardb+git@google.com>
	<20251127092226.1439196-11-ardb+git@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 10:22:30 +0100
Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The batched entropy containers each have a generation field, to keep
> track of the base_crng generation from which it was last reseeded.
> 
> This use case does not require all bits of the unsigned long to be
> stored: storing only 32 bits is sufficient to determine whether or not
> we're at most 4 billion generations behind, which seems ample.
> 
> So use an unsigned int instead: this will allow a future patch to treat
> the generation and position as a single 64-bit quantity, which can be
> used locklessly in a compare-and-exchange() operation.

Probably best to use a u32.
While it will always(?) be the same as 'unsigned int' it is more
descriptive.

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/char/random.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index b8b24b6ed3fe..0e04bc60d034 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -507,7 +507,7 @@ struct batch_ ##type {								\
>  	 */									\
>  	type entropy[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(type))];		\
>  	local_lock_t lock;							\
> -	unsigned long generation;						\
> +	unsigned int generation;						\
>  	unsigned int position;							\
>  };										\
>  										\
> @@ -521,7 +521,7 @@ type get_random_ ##type(void)							\
>  	type ret;								\
>  	unsigned long flags;							\
>  	struct batch_ ##type *batch;						\
> -	unsigned long next_gen;							\
> +	unsigned int next_gen;							\
>  										\
>  	warn_unseeded_randomness();						\
>  										\
> @@ -533,7 +533,7 @@ type get_random_ ##type(void)							\
>  	local_lock_irqsave(&batched_entropy_ ##type.lock, flags);		\
>  	batch = raw_cpu_ptr(&batched_entropy_##type);				\
>  										\
> -	next_gen = READ_ONCE(base_crng.generation);				\
> +	next_gen = (unsigned int)READ_ONCE(base_crng.generation);		\

Isn't that cast pointless?

	David

>  	if (batch->position >= ARRAY_SIZE(batch->entropy) ||			\
>  	    next_gen != batch->generation) {					\
>  		_get_random_bytes(batch->entropy, sizeof(batch->entropy));	\

