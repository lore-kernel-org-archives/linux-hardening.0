Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183325;
	b=AgON+/B0AIciwBqXPrl4KJirGoiyG65oSveyHxfM0ejL/5PNeYFNzOZWy1ywj7j7HEbA
	 /C1rvO9y+qXRU74iGhEO6d8WnrrzpGjeQkr8qjQ+pgyjk4VIrAwFEtkftEmx1BxrBhz2q
	 qo8Pg/5KQNrGx51ogM6t89fL74fEXzdA6hmRnK0BaIPlLkN4ZvDA/gQrv3Fbj3QqkAs+d
	 q8yHG2KJhlPede+dLL1SD18hdUKK3ZDGEuVn/DXaFDxa17IGPbQzafFpgou0466OrkJp6
	 2Nyz1H6kmApUBEEIas3rQpbrHGdBXZRz3GaMHe/+t5OhsJ6Gvn5g/FzDDYaYLqUP4qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qjFQvOSN/xEWYiaNWNXazpqWkeGzMcxSM7MbYU6r+yA=;
	b=BXjNXppwt7szVBTV4nAkF6cHpDH31Z44E41lE5wYrPBKcWnc0uVAnJiHbU8jPO3dw2vS
	 7On1mp/Bc46Vu1vPxdZhkyUJpv/XZG2bFND268mGb+Q5l0Yyzp/HoaHzi7QF58tWPH7jv
	 yhea3y0didyWCrXNnGKKwPQuy9OiQY/rlviRP0dLoHuHOC5Nd9H3V2Zu5Twwgmbv+YMTD
	 nJpUHCypacXxgB9RbI/1mLxmAiyEMGZEHtxJfiDU3jpE4pKDRhL1jmQ2+vMHRZ3eyxlK1
	 5G4CAqrCVCm5BYdy4SmIT123+vRtmlTNwJ53gT8oypmV+yd5Fmzfa9YcKKrsvxuuvPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WY03zP/U";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BC606A335
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 14:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B79BC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WY03zP/U
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso6571155e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795183323; x=1795788123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjFQvOSN/xEWYiaNWNXazpqWkeGzMcxSM7MbYU6r+yA=;
        b=WY03zP/U/iRMcar3MrGbznVBrxNdkGOI+mBRX7Y0s08boR+1aqpvXBO1eCRZTtoPs9
         ZoPDRCgAVYI9NKsmc0jP6O3Q8+m2528uEPn4nekCX78RE0ZweApuvhLxmhfzd51dheFx
         Rr4bpkLdS3fssMMQiaM7+5iMH/heFkruk0dRgHNQugVtBOsqEdk5UbHCqrTjxI22uGeb
         2qWyCc25jIfmlULiTr1U1rLolTOQCSfSdIKENpjRzeQzdob3P90fidAKwRVAVUuwNwyN
         IJC5Q1pE6j1ecwuhi65ucUyku4uDO4O0GRg1805Dol5W/aLJA5gak79Jx5+1pwNk7t2J
         uDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183323; x=1795788123;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjFQvOSN/xEWYiaNWNXazpqWkeGzMcxSM7MbYU6r+yA=;
        b=CxnbDxx2MOS6e/oCdVWXFf4ldLRoi85LGtoR4gNyryjlqMEjtIUe+e//jMF7C5VZ3p
         4vcRv8tmrl9yZJXowKOMhs6L2W4WDt/pHSmwQ+G6sJN70SukUKhYIEmam+1vQ+m765ls
         Edq1kstT50/DcE0Go5GsBNkVNCMSeEXqp9ZO5ezeTcwaRbvq110k5mE2A3UOn7FaI9ps
         O23Pk1KjTgbj2/9dFJvwWPg6HFXIOtwmpoWlO7TdtgZ4mcyjYuaMOalFbTzRLFXxFkuV
         0F7+H6APYP1XGXpsQSu2rptGeZsrvh8RDcaOtbtS2pzzt7Qi0XWV7BS6OjFYoQP6JGIG
         5R/A==
X-Forwarded-Encrypted: i=1; AL+hErGbGLGh/zZcMgVNYmIFZVtur4t3vv+TWiBL3V+SIDajp7kCPfo3Em3pfCGi8HQ7yJ01Pz9leioWQeDu39wb0BM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/5UhaaS8rJPysVgwkfjHtxRH1xTzz32Fzwmpolr4yJnweh7QF
	LsVu/n4ncJMKeowgPhLSvw1rUHhXCYVLPSq8z54tYLVBNx2mN3TPCr+A
X-Gm-Gg: AYBFou1BEyckfJbraG7an7ojr0WfS+SyYdcE2qnn7pqDFQsrRg5bI8dfl4Ro8YsZee0
	0shBuYK7BKS0QPq4Y+w/gDXMOujqofgTkDhM1yw/EKHLQqyKlhZWjzoPZEOG3gXLOSvcskFl6Lp
	hPWGCIYOPQoPY3skiFOs2US4ittJQLVEtjjNquNM9fxgeKzB0dV4hJdWN6tjEKox5ql1uwOsbO2
	nYIf5ZQ1nRkKknXC/G8oEcMLWeKbeXUp7wHUKUnVXRBF8OF18egy4+c0abusMWjssHRRZlEZB0c
	7qztSnRwjuiMdB4XV85r8fL/IKCIS+R5w/EBfHmJWZ5qxngVZo3O6mLUzrxlzfHNW5sSdLrbQlk
	XJqZv0F1ybBPgpNV8HwHc/J2zG8L7v9fD/87sJNGeFk2IvCRAzfFmgN+cj5gwxsmvOX1hJy6Sfk
	9GPoe7EY5/FmUs/0G/cDXs75zk0klNUwJeAmoOe2gz+1y+uXo9WhAQBX+k2eIZRTvYGx4YLk7ER
	XkJIsNrxLaZDS3PnbfyxuRyYAA6zySqkKUbKd3B0Ny/Qzn4HlcIS4UIu0YbiMQfeVFxJHcK4ARR
	1Cq0hYudCbr9nzZauemp13tNIZg4jfQiduqal3Kb5Cj2iPA6QNBHm7P1GN6xwzg6EA==
X-Received: by 2002:a05:600c:b8a:b0:4bb:7007:4a5a with SMTP id 5b1f17b1804b1-4bb88817772mr71755705e9.23.1795183322969;
        Fri, 20 Nov 2026 06:02:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c248b75sm6021278f8f.54.2026.11.20.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:02:02 -0800 (PST)
Date: Fri, 20 Nov 2026 14:02:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, kees@kernel.org,
 hpa@zytor.com, gustavoars@kernel.org, ardb@kernel.org, hca@linux.ibm.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, riel@surriel.com,
 shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com,
 atish.patra@linux.dev, dgreid@meta.com
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack
 fills
Message-ID: <20261120140200.53ec2557@pumpkin>
In-Reply-To: <20261120104534.GO2668564@noisy.programming.kicks-ass.net>
References: <20261119213147.1094488-1-usama.arif@linux.dev>
	<20261119213147.1094488-3-usama.arif@linux.dev>
	<20261120104534.GO2668564@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 11:45:34 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 19, 2026 at 01:31:08PM -0800, Usama Arif wrote:
> > +#ifdef CONFIG_X86_64
> > +#define __stackleak_poison __stackleak_poison
> > +static __always_inline void __stackleak_poison(unsigned long erase_low,
> > +					       unsigned long erase_high,
> > +					       unsigned long poison)
> > +{
> > +	unsigned long count;
> > +
> > +	/* Short spans do not amortize the startup cost of REP STOSQ. */
> > +	if (erase_high <= erase_low + 512) {
> > +		while (erase_low < erase_high) {
> > +			*(unsigned long *)erase_low = poison;
> > +			erase_low += sizeof(unsigned long);
> > +		}
> > +		return;
> > +	}
> > +
> > +	count = (erase_high - erase_low) / sizeof(unsigned long);
> > +	asm volatile("rep stosq"
> > +		     : "+D" (erase_low), "+c" (count)
> > +		     : "a" (poison)
> > +		     : "memory");
> > +}
> > +#endif  
> 
> Gemini seems to suggest 16-32 words would be sufficient to amortize the
> REP STOS setup.

That really does sound like wishful thinking.
Especially if you go back a few generations on the cpu architecture.

> It was also adamant I try and unroll that earlier loop.
> 
> How about something like so, does that make sense? Also, I suppose we
> should make memset64() __always_inline if we use it here. I'm not at all
> sold on the unroll here, the asm is pretty horrid for what it does.
> 
> ---
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -28,6 +28,7 @@ struct vm86;
>  #include <asm/vmxfeatures.h>
>  #include <asm/vdso/processor.h>
>  #include <asm/shstk.h>
> +#include <asm/string.h>
>  
>  #include <linux/personality.h>
>  #include <linux/cache.h>
> @@ -580,6 +581,33 @@ static __always_inline bool on_thread_st
>  			       current_stack_pointer) < THREAD_SIZE;
>  }
>  
> +#ifdef CONFIG_X86_64
> +#define __stackleak_poison __stackleak_poison
> +static __always_inline void __stackleak_poison(unsigned long erase_low,
> +					       unsigned long erase_high,
> +					       unsigned long poison)
> +{
> +	unsigned long count = (erase_high - erase_low) / sizeof(unsigned long);
> +
> +	/* Amortize the startup cost of REP STOSQ. */
> +	if (count < 32) {
> +		unsigned long *ptr = (unsigned long *)erase_low;
> +
> +		while (count) {
> +			switch ((count-1) % 4) {
> +			case 3: ptr[--count] = poison; fallthrough;
> +			case 2: ptr[--count] = poison; fallthrough;
> +			case 1: ptr[--count] = poison; fallthrough;
> +			case 0: ptr[--count] = poison; break;
> +			}
> +		}

That looks horrid to me.
You want as few instructions (especially conditionals) inside the
loop as possible.
The Intel cpu will execute a two clock loop and the later ones will
do two writes per clock
(zen5 will execute a one clock loop and do two writes/clock).
So you want a loop with just 4 writes and the loop control code.
The 'pointer add' just needs to execute at the same time as some
of the stores - to avoid lengthening the register dependency chain.

For this code, can the length be a multiple of 32?
Also on some cpu the 'rep stos' might be twice as fast (per byte) if
the destination in 64 byte aligned - true for 'rep movsb'.

David


> +		return;
> +	}
> +
> +	memset64((void *)erase_low, poison, count);
> +}
> +#endif
> +
>  #ifdef CONFIG_PARAVIRT_XXL
>  #include <asm/paravirt.h>
>  #else
> 

