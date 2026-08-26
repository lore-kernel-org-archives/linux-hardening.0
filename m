Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E1413D9C
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759778; cv=none; b=CBId9T6aPZ8CRjMWD3ZBuV6x3/pkh1YGtshspi0PgdHaf3aL6HxN+wc0gKfFm9FqT9zts1TKKJfkk85qHQoht4yfoWxnN51W4wsZFyhhacZxaJrlOuua/Ix78D6w0Tq3x4MPF7Z1t4dqRitMrhE0Ng+/hrjSmcuq1prxQmz+eko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759778; c=relaxed/simple;
	bh=aPbThtVn2a5yVpmAeAy4q70n3v4x4rA1pZJ1h66SXbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X439oZH0KLoVRlO7nMavbdPzNI/kG3HVBRNNX7Gl+3h+MVRH/MCY5F2OM6qWa4flmlDl4eRwXHczVjH6s6xKYEvQGsbd3+/JqL4Z6m81zAS5xdc8VmCbzmrtq1pa/ojFD/JPWiPVZ8/5eU3XoTwlfN1DU/tJckrxooFbgvB+a2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lqdb6oz4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lqdb6oz4"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15e2dab83eso173538266b.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787759775; x=1788364575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2PawRXrBau0zB2jedd4Fn83owcrKfoiMEkW0CI97ock=;
        b=Lqdb6oz4+kc+h62O7cmLb5UwG4+wa6Afr4iaGY50YpNBts+Dnkip9y/2D0EQnOuDPU
         NqPcA4JQJmukBnwNozJ3/LKM7/BnNEEPoLII/hiZOJBh1B9eKjwghGnoJQ+BJ1pnfOpT
         H+VY+kNU7liFLaMHYPncgwOJqytCuuqhj3fRr2y9YHkSkgogmfpg+orjva+2oiqmPzpO
         R1875KY3LyXV149UNg9mlHQMSfgq2hEcsp9lDYj6k5nubPWxsiIiTkGdsUEI7gMa7y7u
         BPNnsSISa/EL9rnDpdn1yksiSGWQqKjp9pVR4hiM10hJlTSUPikzohfLRiBBwRM88JwP
         7Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759775; x=1788364575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2PawRXrBau0zB2jedd4Fn83owcrKfoiMEkW0CI97ock=;
        b=dcuflwkix5agWrJWELUBzLXvFJtXfFLnY9U+QwSasNTNFFbN9+qW0CqcNdipUQmTX6
         +goc05jQJIio+yNB8Kea/m2VTvOCanIHYe18bNrt0oOqWgNcn94c4oUW76WnbwQ+lf7/
         4vIVQ0ZDEawVRs19pVHREx+2vjpVJpEe0BTdUx6jB5UggiWLHDs9JRUGnp4FWqr6a8M9
         Z8z1xSyr/2h2vvmtCmGfFcyAgvKo6iNlyKCvrCj/ZYxnbL7itgkT/ELTCimenBGSEzv0
         sG0VZ6yIxVx47jVlKTBbEDElgIoBbYAdi1GC1kiZIprxWgW9E2pPUW5wyvU5Q7Zow4bA
         +jag==
X-Forwarded-Encrypted: i=1; AHgh+RptU9u+XJFm0PsLNuedbs0Oo1pX7F73GwqakgsceHrkx6bQB/WCpE14bbhyp3oKIk5lymZTlcVmGKjAXR3D3E0=@vger.kernel.org
X-Gm-Message-State: AFuF++mm1A0t87CnbOwqstdsUQ74ys9ltsSEjorljes8/zzOQUv4sgHf
	06u/8r+kyYadkXjikO82iS9ss1OclYsJF8mlYkg6MGfY4Cu9ep7DlhtMaFlRQgSkR5E=
X-Gm-Gg: AR+sD10+icZVHQdnafgL77DlSuvpt96qj4NtwwGhAFp0rvaw31wamLjDxmW4j6TvN6l
	+EanO9PqrkaXqvsQuudNMvy20x4G/xBIjzpEpMNrquG3mXRIKurYLvXKGagSS7DoupeqqQw0Gvw
	AwUyM2BsNCyM7q4jDJRmjm5FtgQXMzUDWKbMvygyTT55Cnvodthev7ByLbgHvHZwOmXThUzG4B1
	sH2uncTELxNARlv5W8FfXscGhgjpIvXiCJ4pFx9yko5M1IYPdfLyQHu32zZM1Z9RbrJFoRroc8W
	wXW3S/WixTqSMV56D09wjohbHlOnqiYFSdWrbueV6GLANL8OMjtco8/FkgYz/HeZWnSoAzBtuBm
	DvU0gge1Et/BncyMaGXH/NTe+bF19u7UmO3+vjQbL6CfFULZgh2YndkgWTfWcayNSxQ69LSXq7b
	/+UlnIdfTL+WLGOv+52c00I+ZSgPK26N1aQVHR9AJJD8PI8MQ3Yunl2CaUvjqAYg==
X-Received: by 2002:a17:907:3e8d:b0:c25:3553:43eb with SMTP id a640c23a62f3a-c2535534997mr66219466b.18.1787759774696;
        Wed, 26 Aug 2026 08:56:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fcdd5sm606680966b.20.2026.08.26.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:56:14 -0700 (PDT)
Date: Wed, 26 Aug 2026 17:56:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH v2 1/2] vsprintf: Don't leak pointers for %ps without
 KALLSYMS enabled
Message-ID: <ao8MnDuF9nnI9KxG@pathway.suse.cz>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821152614.2202196-2-bigeasy@linutronix.de>

On Fri 2026-08-21 17:26:13, Sebastian Andrzej Siewior wrote:
> The "%ps" format modifier prints the name of the symbol which is more
> valuable in terms of debugging and does not leak the actual pointer.
> 
> Without KALLSYMS it will leak the pointer which is not intended. The
> default policy for pointers is to print a hashed value and not to leak
> the actual pointer.
> 
> For !KALLSYMS, print "(unknown)" for any symbol resolution. If hashed
> pointer are disabled print the bare number.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  lib/vsprintf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 2bc6ef483576c..fcb63f22b1997 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1008,7 +1008,9 @@ char *symbol_string(char *buf, char *end, void *ptr,
>  
>  	return string_nocheck(buf, end, sym, spec);
>  #else
> -	return special_hex_number(buf, end, value, sizeof(void *));
> +	if (unlikely(no_hash_pointers))
> +		return special_hex_number(buf, end, value, sizeof(void *));
> +	return string_nocheck(buf, end, "(unknown)", spec);
>  #endif
>  }

My understanding was that we were going to use

	return default_pointer(buf, end, ptr, spec);

It would print the hashed pointer unless no_hash_pointers was set.
IMHO, it would make the handling of pointer values more consistent.

Best Regards,
Petr
