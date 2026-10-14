Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A63B47DD
	for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981491; cv=none; b=N4gMyqDPvpyU+IfRvNpS1uZG5bj2z7NiYB5yXfr75p0isBD+l88kzkyi0FuAGGeFdTxUPXPId0rmmgM36hswWI4i/IP+BL2A6Vi9lncCC6rn6Vhdq0xyL4TwGMsC4mJcNSrxzTmDZCXi9RHjzHxnIB/lp+WO9Il3c5Ds0rKvGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981491; c=relaxed/simple;
	bh=imqDUGmr65GUF1T+o7984DBFaghgFubjK8p2xLCv7nM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xp1BUmcDFpHRC4/YOwfy5MuJbZ87+RE3nvxMGkO5uS6KPuReg353ulf9ejHKSpH3FAtCebtTSd6n2qAXzkXHnv1Zh37tKFXz+PtbkvYfTar54UolR1DVBARu/3c9emx1vmsHBdjhYl7whAFhgC5n51bP5kaKaJoiGjuWYYtcP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cioc8i14; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cioc8i14"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso270370f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Oct 2026 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791981487; x=1792586287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JOBDQN5H1feIqCOwoVj/nHLz9ur/yVVbcQeV5sIjhlg=;
        b=Cioc8i14Fg1oB8+QhPAZpxw+jovCOpFTXIKEAsxb4oqywI41BkEiIv5k8pul3wGasI
         E8+3pPdMHjehJgooJlQ14NciAzRjQbuiv0XliH/idgh5fiM7q1Tz9kMi6eRuCIGG4iqv
         lwaLlY7r9HSxzWsjSwJyoCIN1HC/JnpEz003G8qIojwAoEKZpHb8rK7Oou+dWlS4wYcH
         PEYf5wPQVXIhUYQGnG0nLiPR7PGdzkIVG/sWYrUji+KkJkZsCARxWV3tWHtOql6i4gK1
         SSEgNfDx/ReZ+eB5NyyPU8HzXioEKlZNizOCOIhQ5GFUzuvmDolLW/CMJzgFzsTOtFq7
         K5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981487; x=1792586287;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOBDQN5H1feIqCOwoVj/nHLz9ur/yVVbcQeV5sIjhlg=;
        b=XNyqy/pCcLFa8mdp8bT1X3pLecGT+KgcMLlWp6pydhDMFnjgmsQb+gUvtO/iDvfKS9
         jfWyKkLuKZHatm6I+4H1SBAZFB2MnZGHSvLpqWRY33LTP0nBzqC5lk+HzPm5nsX40IxY
         aO/EqvWwbNm90/0qk/X6dycUnYTiYzZayL6JAAxJCZsv74F/w9LvHbC0BZGmC0v3lIea
         C6laBlndMAP1oK47i4YTrFQIC72yc1qi/Lcr/xEy76Nvz8IITA4U8Tvp1WN7zzOclkNq
         U+kDVqyWeKNlE74VXvYIa2q4BypJkXb0/ZOby+ExqaedmWwOTa5PKoM6ZvjZWRtHhRJH
         shXw==
X-Forwarded-Encrypted: i=1; AKwUvBwd91gv384TJyT+Om6Qj30JFytK0rdK3IBzrB0ztkA+nlTrR/NlTaXji3rNTCRGRMLXJ1h4C5LYQalqgYx0eL0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0PoTLhvI2JdZpkTKGrPsxps/KdB5eEyhTvXdyUqjSpQHGEor2
	u0lJUrRkVoyBmkARC1U6ga8bKCXmx55tF2T3lNddNLNC+69xp9vKmEza6MhoEsdh
X-Gm-Gg: AYBFou3NPCc7y9N9FOCpkvZyvfW3gtHO8uCco6/iYLbOkGzVOMn56YpX1psAGZFtu8k
	59l+PNaaPlNrtrzkNimFVmXUegwnl3H2Y8lJ6jH8sqclq5MxZOxu72IZFVuMHTF7kZTjhyrlEXu
	lVzCOLZd1kZsrnBz4md4vvNjryYLvmj0u2Naowuu5a9o/FUQhyAAV7tNHx/PQXfXzozbSi+9Wma
	3939IJMQKaIkdAw32LzHeomHQKtYk36MMiUO3vrkK0CydrZ05RIOTzS1FIQGUE7Hhlfqyv0uCc7
	ZBWfsYQJ99pzrY9Csw8F2AElYTPqIhsFN838Y8t9gT0Ln2Qc+rU9HYxlJvZZ8fegMyuVSWIvEpH
	axqDMG48+5Bi1snScqE0dNQ/jYtAqVOOFpQiSrs2GLEaHddpherTC8zfSN21kgm9+teZzHqZqZQ
	LTcdF6keszm60DMq6IzkNo9MQwSjcpzZke2pb6rrFtWprtFlKuB8QrxuPKTI7nfLK9RrHix1jOt
	q9wOnW3rePWXYXFN12g8tNbbIRacNPyvTqX
X-Received: by 2002:a05:6000:454c:b0:48c:69ba:77d2 with SMTP id ffacd0b85a97d-48dba77d170mr22270118f8f.4.1791981486598;
        Wed, 14 Oct 2026 05:38:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc4ebbsm11395288f8f.45.2026.10.14.05.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:38:06 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:38:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Match arithmetic in both parts of
 __builtin_choose_expr
Message-ID: <20261014133805.47afdb0b@pumpkin>
In-Reply-To: <20261013203146.387344-1-morbo@google.com>
References: <20261012205919.4012405-1-morbo@google.com>
	<20261013203146.387344-1-morbo@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 20:31:46 +0000
Bill Wendling <morbo@google.com> wrote:

> The two parts of '__builtin_choose_expr()' had different arithmetic
> expressions. This patch corrects it so that both parts calculate:
> 
>   COUNT * sizeof(*MEMBER) + __must_be_array(MEMBER)
> 
> In practice, '__must_be_array' is meant to assert if 'MEMBER' isn't an
> array and return '0' otherwise. However, symmetry is less prone to
> subtle errors (and far more satisfying).
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v2: Don't use 'size_add', which just adds more complicated macro cruft to the
>     expression. Instead, just adjust the parentheses.
> ---
>  include/linux/overflow.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index a8cb6319b4fb..d0f04436343e 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -418,7 +418,7 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>  #define flex_array_size(p, member, count)				\
>  	__builtin_choose_expr(__is_constexpr(count),			\
>  		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
> -		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
> +		size_mul(count, sizeof(*(p)->member)) + __must_be_array((p)->member))

Why does this use __builtin_choose_expr().
The types of the two expressions are the same so it might as well use ?:

Also doesn't this optimisation apply to all uses of size_mul() (aka saturating_mul()).
Presumably relying on the compiler to report the compilation time numeric overflow.

David

>  
>  /**
>   * struct_size() - Calculate size of structure with trailing flexible array.

