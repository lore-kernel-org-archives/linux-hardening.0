Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531322A4FC
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258991; cv=none; b=KHokP/d3n5BU4ga2wuY1N2GaLzt8PK58e95lh97lyYsteUjm+pbGG2Fbcgiw0UdGkGiOXLtIBRGq8VO+Ew4H2qRXHY4RPxGmp8IZHeiY/Bis7CZi/2t4RG9Kd+F3l3mb11SZiIxRq3NeFkBLpHZ8SqOzL0ussFOIXV0KLzmlQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258991; c=relaxed/simple;
	bh=xZkOPXCIRdSZAx9SJK5eN9HdiBC+/orEbq8QkucfCtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDbjT8h52ZOZxp7XkREdVPgaDaoLZ30EiUkQl2kl2JB7K8qNK5jrPT9X2rUag6OBX1ijosgBgBt0/pCOS/E9CDqLf0HZqUMZ0UlO24VQ/tESXTCR4aT5qPrTVE82fHYUBhvHF7PNUP548GmsJAGTQnlYn1jAr8GReOu37oYG2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4ziwlIM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4ziwlIM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso40948405e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768258988; x=1768863788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRWaHHKt6PhH1VQF5Sj58s1toZVOW1aFddwms70jGV0=;
        b=A4ziwlIMU09Uxip/+BglP9T+rihoA8FGdxDrRlEFGX0wxH3J9KIoaMJlWcZEDM5ei1
         /RjrSG/YxtrP0JXjn0NSyCkcNDQq9DHB72vxe9pJu99U9Vp9ogLTbBWmCgZyNxAbWgtf
         ZuPQMwVzL/PZXu+YDa/CvIhQGbqoN9mMJ2Aw2dniDTjueSno7dyucBvjDQ6jB1NkW0ds
         b8KK/UDQW977jyQyrvudAUTAhaxSoR1iCkGOlJoJMnYykx87sRmCENJIJ55OZuSrQkAJ
         Slz3i8bxIs3Lk3etVByEQYUQxlRthG+Zfzs09WthxOSUT05K1RmUuMRTc1V/n41G6MnE
         LxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258988; x=1768863788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRWaHHKt6PhH1VQF5Sj58s1toZVOW1aFddwms70jGV0=;
        b=vK8CWzsXo6VEF0IPzSmsOv9oKM7pr0WNOhnnird4HzLnU2xYwi919xWFzIYd52EqzY
         kAMWJPE8PPRcOFN/SbwhMzMC3fn9zCNwuYF2H63+sdEET4spO2In7LzdRNoRyhqMQ4hj
         Dq09zSWg3T+N4hShxZu1SexlyqRHy8F7QlTP0WBaYzGGazWGpw+CxYLqjLzxu7WAWgUe
         LLDoBr319mh1a2DTPSqBk6BtHvXp3Dzxa+OoUwe/DAiTezKbcvl4vaVgY/cxuTVqQ8kY
         83fHdiXPylbrjcqqEKv1IT2JNx6gaYzeWiR/F1qUnlNXYwO9SHePEQ1JwyW5LEp3IviM
         angw==
X-Forwarded-Encrypted: i=1; AJvYcCVf1o7aRkaOwOYO3HUC7H7A/VQGQ+S8aUawh6gII0sDg8WegGO51QLhKZ6DStjplp9C0MjqBbqExDEVjTqKbso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYEFAuAdAW1fRuPws4YN6oJwyH4ePYnyk5WiPXFHoTvYzDw4b
	YOefCJAucaNoX+0tlUWxGYA+8o3JlKCFloiLoMsforz6xzMkm4GzYO90
X-Gm-Gg: AY/fxX5IPlCTVEMh1YFwG9D6DI9Jf/EwLu9auVVlo17Vhx3Wgv0+Pc1Ax6wofFzCySV
	tPUr4Nb5G6OUdwD6lDUR0Zztp09uTJ/Br5istJJgkMsWdc5T225W9IkABvweFeMe7QJ/rYVG/At
	1NkF3uxTi8FYOynOcxSGz8YILyahYFTccCK10cJxRJ8fxlmlmiSxtFmywnlokPVyv3ZEVqHB5oi
	ucU3Wtb7TB3c9Uj0Gz6Y9UOFNCH4ToUjXSWhWHea5Ai29O6KDHbS+wYQIGUqaPwLj/EW5YqGl0m
	X82qH7Z0YzXqzISjqby8t7pqh+AJ+VdtLtinpP/gaPmUgk3pGDjwxfcC2BuegIKS/YqP2AMbO1P
	xRyiCcLXyw4SPrqyXQqps0I051ZlVL2Jm8eAJQOtEkhGfssTPv9blAEBK6DXUJBJdtA7SKmwAIG
	jWwRQjTF9Qaf51IsVHQ8xQQ9z2lOC3EU4k0Uz95zrWYNp85v2QDy7mC+6xPLLnrkA=
X-Google-Smtp-Source: AGHT+IGSivVyFTxneB87aCQkJONNB7LVvg4lx7QX43oTnxdJrYtfU1jnpmMQVmNUwyepeNv0k7k+rg==
X-Received: by 2002:a05:600c:a03:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-47d8e56625cmr174793975e9.3.1768258988453;
        Mon, 12 Jan 2026 15:03:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm370626565e9.11.2026.01.12.15.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:03:08 -0800 (PST)
Date: Mon, 12 Jan 2026 23:03:06 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fortify: Use C arithmetic not FIELD_xxx() in
 FORTIFY_REASON defines
Message-ID: <20260112230306.7cf878b1@pumpkin>
In-Reply-To: <202601121415.CEB3C024@keescook>
References: <20251214125857.3308-1-david.laight.linux@gmail.com>
	<202601121415.CEB3C024@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 14:18:56 -0800
Kees Cook <kees@kernel.org> wrote:

> On Sun, Dec 14, 2025 at 12:58:57PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > FIELD_GET() and FIELD_PREP() are mainly useful for hardware register
> > accesses, but here they are being used for some very simple oprations.
> > 
> > This wouldn't matter much, but they contain a lot of compile-time
> > checks (that really aren't needed here) that bloat the expansion
> > of FIELD_GET(GENMASK(7, 1), func) to over 18KB.
> > Even with the 'bloat reduced' FIELD_GET/PREP they are still hundreds of
> > characters.
> > 
> > Replace FIELD_GET(BIT(0), r) with ((r) & 1), FIELD_GET(GENMASK(7, 1), r) with
> > (r) >> 1), and (FIELD_PREP(BIT(0), write) | FIELD_PREP(GENMASK(7, 1), func))
> > with ((func) << 1 | (write)).
> > 
> > The generated code is the same, but it makes the .c file less obfuctaced,
> > the .i file much easier to read, and should marginally decrease compilation
> > time.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > 
> > Note that changing 'const u8 reason' to 'const unsigned int reason' generates
> > better code - in this case removing 2 instructions (one in each of the called
> > functions).
> > 
> >  include/linux/fortify-string.h | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index b3b53f8c1b28..171982e53c9a 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -2,7 +2,6 @@
> >  #ifndef _LINUX_FORTIFY_STRING_H_
> >  #define _LINUX_FORTIFY_STRING_H_
> >  
> > -#include <linux/bitfield.h>
> >  #include <linux/bug.h>
> >  #include <linux/const.h>
> >  #include <linux/limits.h>
> > @@ -10,10 +9,9 @@
> >  #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
> >  #define __RENAME(x) __asm__(#x)
> >  
> > -#define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
> > -#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
> > -#define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
> > -					 FIELD_PREP(GENMASK(7, 1), func))
> > +#define FORTIFY_REASON_DIR(r)		((r) & 1)
> > +#define FORTIFY_REASON_FUNC(r)		((r) >> 1)  
> 
> Sure, we can do this. I agree, the preprocessor gunk is huge currently.
> For the above, how about keeping with the original logic and use:
> 
> #define FORTIFY_REASON_FUNC(r)			(((r) & 0xF) >> 1)

I think you mean 0xFF (and below) to match the old code.
But since your 'r' is 'u8' (but see below) the mask should be discarded
by the compiler anyway.

> > +#define FORTIFY_REASON(func, write)	((func) << 1 | (write))  
> 
> and:
> 
> > +#define FORTIFY_REASON(func, write)	((func) << 1 | (write))  
> 
> #define FORTIFY_REASON(func, write)	(((func) << 1 | ((write) & 1)) & 0xF)

'write' is always a constant 0 or 1, and you are writing it to a u8
(which will mask with 0xff anyway).
So you are adding code that just makes it more difficult to read.

> 
> so we're always getting processing a u8?

IIRC that is just passed as a function parameter, not stored in a structure?
If so there isn't any such beast as a 'u8'.
It will always be passed exactly the same way an int is passed.
So the parameter might as well be a u32 (the code might shrink).
By saying it is a u8 you just force the compiler to mask any (non-constant)
calculated value to 8 bits after writing it to the register that holds
the value (and on the function parameter).
All the arithmetic is done after promoting the u8 to 'signed int'.
You won't see the 'gory details' on x86, it and m68k are the only cpu
that have 8/16 bit registers (as part of the 32bit ones).

ISTR there is a check that FUNC isn't too big (because there are no where
near 127 of them), that will pick up any 'accidental garbage' before it
breaks badly - no need to mask the values to 8 bits at all.

	David

> 
> -Kees
> 

