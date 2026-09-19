Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646562571DA
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815904; cv=none; b=FKSPi6QVV07G7ozrGgVIirmWeHpIqDQbAh/Q4u4TcvfQ9c04WBVctJz5fgW+5fZ+Y7pSZn74IxWMQJmvJ0IxmEmAVJNsa5OlZPOU8zjos8n8Z2ciOUxL6thE0lBsmyW+eJHlzfiUZPham9vEoeyg7QkpgrTEmr1xux3EVwaO3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815904; c=relaxed/simple;
	bh=gQDfqWyvWhhukz0RZPe3Rxu+FRVDAMr+ZZPy6EzA9hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2ThiE4zInLscv2LkQFa0ef1+NYjZG7r4Tz+wwEHj7Jj3OP77R4yoy33YsVo4pfZWRh782E5Z0jUQex6atTPF/91z4L6sKNoL0xkbMRIB6JVJPyEPNno6bnyKZcFCRLmNr2mE4oc/+rHN77fCNQifRUlRcUmUYEv6LDFFQFASyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIKZrqxj; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIKZrqxj"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ee4cfso820351f8f.2
        for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815899; x=1790420699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7rwy3osRntuCmj5MLCO/i0SriZXb6Zy0hh2IOAi6LGs=;
        b=aIKZrqxjF4VPN1406UeZ5bCtjM0v7OATVattud/Vgqfpi6VI5CN4dIoxiRwXGqvccH
         JcbdKdV83LLv3hndd3GQaMKJ2V8q5XmwYEZJaIaAlrnpRg52hjnRkvxkIiQokSlkBVOb
         RYUdGliBMWg1LOorOB0MG9VsFyRTKmLXLCf0xDJELBBsUMxpiBJIccrbrsbRD1N6WxPF
         rwZzN7Y2gVQwIB93QWEDzJ3le3YoYEVk+4jEuiiXOaApfcSTH6jOBIMPnsUmEkd+izLD
         IJSfVghYfk8of+6CG8ToupnlUn9CaERhykWxJ1PbRaWCgjIJ5VWvA5124A9grCHwrhZA
         aAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815899; x=1790420699;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rwy3osRntuCmj5MLCO/i0SriZXb6Zy0hh2IOAi6LGs=;
        b=N0qCnAw8TPHTHKkEvtd9DaBKp1mTHAv/t8uQcQpz1okoATtz45gA0QFd89dkV9UYOr
         8ni/N0XHfv5BvRDOeXTQo7ttspENCcmSLVo6Ey4W1YXc5rLMK1S85iK7Zhut7ybfZRm6
         wruoVsXO2fJy6FYdJxTgvOlrNjSEuF7iJa3HuAnxO0XKq1JOn/WoRMIIq8iR3pVBXTmk
         LLNKKY/aftxQLxrv9ALv6FELevXWjVBEj/OaGHS3EBFfCeh7A0COPkBBzDkpmhIHLFKA
         ED727G83Y9l4tO21BntMMLuAUCcPZIVm+hORJM1VqDrXfhXTeMBzCkHPsckZUGk+8f6+
         37uA==
X-Forwarded-Encrypted: i=1; AKwUvBx34n1SgZZqilUJICJpWcMyXcZa01iAgeRym+nmjxgCKsPu85/XEFbBWTP7UY/miwSh3fax5AT8rWW1Eo0YWmk=@vger.kernel.org
X-Gm-Message-State: AFuF++lYb9ZftXivZxg/5Cq5noc8ZAcJw8TlQDOE3hQiBDeGYuCshv3z
	JpMyIP/VoLrjPmdb+kmi+zBrnuIDYmFj/wLpY0FrfAYhAp3qeARQBldB
X-Gm-Gg: AYBFou2CiOCjiAFQo/zwkrmHa7NxCVd6ltkl0RRH0kgFbJ4ZzmCgioc0YK8Yf2PZ9Tc
	LfMPKX7HXBSplL1DRdBAIWgD8eQqeZHa1yq+jpLgm+sgJOXmrVuA9FtbCm0tb/aAwYOtXeoH0qe
	5tUZ9SFqXy9/HlrsIL+GkOrYWO53oki9RbDs373QMLryiEi+j3Rt9FEPycJq5KMujoEshvFiODy
	5FZ/C/KdlvQAvKXhIqW3K7amiSGkA8yFcFMdbh+pfvawF+MbFEyxxBTIwJKhrMmTXiOwjPhNyup
	sSIvux+td/Y66mNDrCzRZ5LpJWRIGHNeDCMxezc/xfGLX0PL5oJfUZe8QqRP373ZjDl1Y9eL2zm
	/vwtCdQWmRHzl90DUUTK+hWgdEyHGScRyeEQ8HB72YV+UVUnd+py9pDJd+0TQoaL6l+/mzpLYvq
	EV2pGSDdeAJpIXgwLM7VUSygOtJt0jPJzg0bBgvy9e46om3WFGlXvewebnyF6o35D8g52tTpbiL
	Tx9FMGPMgN8y3A3r9gKKviEpl2kfSdF5559
X-Received: by 2002:a5d:5d02:0:b0:485:8ee5:5ffa with SMTP id ffacd0b85a97d-4871e36b1c7mr7900927f8f.38.1789815898629;
        Sat, 19 Sep 2026 04:04:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724460767sm6267511f8f.13.2026.09.19.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:04:58 -0700 (PDT)
Date: Sat, 19 Sep 2026 12:04:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, Kees
 Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v3 3/5] slab: handle ERR_PTR values in kfree and
 hardened usercopy
Message-ID: <20260919120456.5575e0a4@pumpkin>
In-Reply-To: <20260903203720.63689-4-kmehltretter@gmail.com>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
	<20260903203720.63689-4-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 22:37:18 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> Passing an ERR_PTR to kfree() currently reaches virt_to_page() and may
> fault. Warn and return instead, leaving the bad caller visible without
> using the pointer as allocator metadata.
> 
> Also reject ERR_PTR values in hardened usercopy. Keep both checks
> separate from ZERO_OR_NULL_PTR(), whose exact matching is required by
> krealloc().
> 
> Link: https://lore.kernel.org/r/CAG48ez05QVn6_gQ2TBrRa1a_DWQoaSSYubUsu5YMWxx-gqMijQ@mail.gmail.com
> Link: https://lore.kernel.org/r/202608111716.0FA9DB17@keescook
> Link: https://github.com/KSPP/linux/issues/93
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  mm/slub.c     | 3 +++
>  mm/usercopy.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f9b56cb439e7..027b44dd7f07 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6780,6 +6780,9 @@ void kfree(const void *object)
>  	if (unlikely(ZERO_OR_NULL_PTR(object)))
>  		return;
>  
> +	if (WARN_ON(IS_ERR(object)))
> +		return;
> +

Since kfree isn't usually called with NULL it is likely to be better to
have a initial single check for all the error cases.
Something like:
	if (unlikely((unsigned long)object + MAX_ERRNO <= MAX_ERRNO + ZERO_SIZE_PTR) {
		WARN_ON(!ZERO_OR_NULL_PTR(object))
		return;
	}

Although is would save a lot of code elsewhere if kfree(-errno) were valid.

David

>  	page = virt_to_page(object);
>  	slab = page_slab(page);
>  	if (!slab) {
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 5de7a518b1b1..c8d8703544c6 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -157,6 +157,9 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
>  	/* Reject if NULL or ZERO-allocation. */
>  	if (ZERO_OR_NULL_PTR(ptr))
>  		usercopy_abort("null address", NULL, to_user, ptr, n);
> +
> +	if (IS_ERR_VALUE(ptr))
> +		usercopy_abort("ERR_PTR", NULL, to_user, ptr, n);
>  }
>  
>  static inline void check_heap_object(const void *ptr, unsigned long n,

