Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695B4A64DF
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148408; cv=none; b=aKBjkPC7evUXI8zsswrkXy1XzG7gt4DSfo9957Z//odqQxtLMVX69MpQ+1YvFCr31xolj8C8ABdEwGC+CsmUIsRajnXxyjY6gujxce6g1aMWNhtgVHqIadtFkOiRWQzG8dcTQzKw8VbITzG3VHCmKDirHt1T6SVZb/Ig1YjyOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148408; c=relaxed/simple;
	bh=EZahxDDGmgltKd5bOAMzwsyPw10S4QBBNVqGiejnavY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd5IvEJ9XOshcq/nTqpHDL9XktXiaCiIBIgZyU2eaUcy2rsDbC5Wrp0KLnfRal7V6tYhsjho/Rxwc/Pi75zj8hKD8GLHoZTOmmqcdsVYZjmMbb3YHJFJNeZM6cp0RyO2U3vsRApw/IY+WnoZw54IDw2LGanCSyXNKyohWzRJ2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUxxZEn/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUxxZEn/"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8690079f2c1so1152633b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789148400; x=1789753200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wl3IKortcFpGKddT3RAr007iJEhPfwcrwYUS/tqDJm4=;
        b=kUxxZEn/Ef8EkoRNzk5Z2YdaGcXQU1rxTbkkImdQmN1IpSluq1Ie1ulA3snABdxKy4
         Oo1fXhxRvqirvmKTWxDJ5xzrXcbfx706olRk356EzwjSLfAbdrqLndwfzpw2jaxa6bXr
         5PQxLWjyXaqn1ZdA/oxK6Wuhgo/P7CD20vuMgl2ow3bRXVAOaoJ1gFtAX+1jKtr8FVm3
         dzqbJDQ6+Egpx6EX/jyKjA9Ij2XeVKc1VxlPo5xgX7gX1IkRRwmSSYaC+jiXoy1dozKw
         tA2T8y1GfhTD+9DA+gIWTOANPeNwhIzzdA8N4IrGjPacBQ2jKndgJykuu7VxJiGA0ko5
         02Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148400; x=1789753200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wl3IKortcFpGKddT3RAr007iJEhPfwcrwYUS/tqDJm4=;
        b=UiXYpCVwgTgnMyuo1IK9OuRN0YgqDRgT/T+28BNTEHH29hPCFOiTMMXVVmmZAb3Tvz
         taA3MfaXYmh+xDkEiuPqCj9+WxYgfJMiJI1DojpTy/XbhnAFEp9cS7if3lLicnhRhwkt
         tL97dTt5c3e77du9CIzYAo0Y24TAdo8w7OUD2grDX6ewl5S+EWrD5q1j/8o/Z8MkmIg4
         1OQDfDjc9g2km8odIV6jgQXH9bRGixm57xszwhXQQjfjPyFq+68BsVjeyeUpiq+qRh+y
         Y/It72OrVgSBPzFfkgu40XU1gffzr0wADnU7yg3XCY9/H9fd3P0wcW+AeE9xRARWRxQI
         Iglw==
X-Forwarded-Encrypted: i=1; AKwUvByqX+U89NicqIBU6RbNg7o7HDNxeVrPgw9CUsI0kWBzSFHbmDW8byCx9+QQVHvj5mNP/has31cT+L+Wd0SnFe8=@vger.kernel.org
X-Gm-Message-State: AFuF++kyvI7OSMxByI3OzNr8NlblBshju6nPexHMIynppX4anF7QlesY
	KwwIU3ovXS7Z6BqKAt9y8SGV41smvE5kAdwCES0FrJWJlX1yBPpK/Kww
X-Gm-Gg: AYBFou04UQBpVA514eKpLq1sOHHaD4T4vXaSRv2X+ybLFsMHFu8tpgsHGUGBge1yr6h
	le/emFDKHagJDY7XI0xdHmypuO86Bfr/6N2JNHiNVcMAZQs8u+9CLXB+HrFMSp47qbNHGe3zmLx
	lLREzc6h+O8oGzOxH7OIiwzKaQMk9bvr+JZWND2/cDcy/jyo0vDth/fkbjK44L4O9+h9QX+PAXT
	iESeEHUfjtmR9Drm392UVISFn+KS8bThsxbd9LqyAbGGtP+xStndpovR2ji/rL3wPwBRPqqjhD0
	9hdX//wchjwVJSdjLgqtB8P9j71vvMZl0CUTKlsoPqUTOWgcsfZzV+XCOA4fHjZFkev9PuxYrXh
	8/G8mrLBbvI4YdqjraX8+1BuyOQtgpQcfHzFxRx0t15h3zWwKbdFfBksQGjTRA5FGKSa8AEWDS8
	KB+yoIQg0cOYA+F+PJ5wUHKxfXcN/1ZMVYw15SQxaywLoE2/JDyLuUmXSLwdx2hipmoN/ds0/CF
	lc0wM1WRg9k83n5QTFCJ1IsKnDihwpP8Mby4uZTE9OmYg==
X-Received: by 2002:a05:6a00:28c3:b0:848:62ab:7b7 with SMTP id d2e1a72fcca58-86b3011a6efmr8754763b3a.16.1789148399726;
        Fri, 11 Sep 2026 10:39:59 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bb9ecesm1428361b3a.43.2026.09.11.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:39:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 23:09:48 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kees@kernel.org, amachhiw@linux.ibm.com, ritesh.list@gmail.com, 
	robh@kernel.org, sayalip@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org, 
	linux-hardening@vger.kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc/kasan: require memintrinsic prefix support for
 KASAN
Message-ID: <aqOrCdvUB5lFjNsS@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908064948.999530-1-mkchauras@gmail.com>
 <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3b1fa5a-c836-447f-a658-ad66183c23c5@kernel.org>

On Tue, Sep 08, 2026 at 11:59:14AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
>
[...]
> > --- a/arch/powerpc/include/asm/kasan.h
> > +++ b/arch/powerpc/include/asm/kasan.h
> > @@ -2,20 +2,17 @@
> >   #ifndef __ASM_KASAN_H
> >   #define __ASM_KASAN_H
> > -#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
> > -#define _GLOBAL_KASAN(fn)			\
> > -	_GLOBAL(fn);				\
> > -	_GLOBAL(__##fn)
> > -#define _GLOBAL_TOC_KASAN(fn)			\
> > -	_GLOBAL_TOC(fn);			\
> > -	_GLOBAL_TOC(__##fn)
> > -#define EXPORT_SYMBOL_KASAN(fn)			\
> > -	EXPORT_SYMBOL(__##fn)
> > -#else /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
> > +/*
> > + * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
> > + * enabled (see PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX in arch/powerpc/Kconfig),
> > + * so the compiler always emits __asan_mem*() at instrumented call sites and
> > + * bare mem*() inside __no_sanitize_address / noinstr code.  The old dual
> > + * entry-point trick (_GLOBAL_KASAN emitting both memset and __memset) is
> > + * therefore never needed.
> > + */
> 
> This explanation belongs to the commit message not to the source code.
> 
Hey Christophe,

Sure i'll move this and rest ahead.

[...]
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 6f6801da9dc1..44115f904c2c 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> >   	t = PTRRELOC(t);
> >   	/*
> > -	 * use memcpy() instead of *t = *s so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > +	 * use memcpy() instead of *t = *s so that the compiler replaces it
> > +	 * by __asan_memcpy() when KASAN is active
> >   	 */
> 
> Does the initial problem still exist with the new __asan_memcpy() approach ?
> If not the comment should be removed.
> 
Hey Christophe,

Thanks for pointing it out, i took a deeper look into this, here's my
understanding on it.

On PowerPC during very early boot the kernel is loaded by the
bootloader/firmware at some physical address, but the kernel was linked
expecting it to run at KERNELBASE(virtual address like
0xc000000000000000). The MMU mapping that makes that virtual address
valid hasn't been set up yet. So far for a window of early boot, code is
executing at the physical load address while all symbol addresses in the
binary refer to the virtual linked address. reloc_offset() computes the
gap between these two and PTRRELOC applies it to any pointer.

So PTRRELOC(&the_cpu_spec) gives the physical address where the struct
actually lives in memory right now, not where the linker thinks it lives.

Why *t = *s would be wrong?

In set_cur_cpu_spec:

struct cpu_spec *t = &the_cpu_spec;  // linked (virtual) address
t = PTRRELOC(t);                     // physical address — where it actually is
memcpy(t, s, sizeof(*t));            // copy into the right place

If you wrote *t = *s instead, the compiler generates a struct assignment.
For a large struct like cpu_spec, GCC is free to implement that however
it likes — including emitting a call to memcpy(). But crucially, a 
compiler-generated memcpy call resolves through the GOT/PLT or direct
symbol — which points to the linked virtual address of memcpy, not the
physical address. At this point in boot, calling through the wrong
address would jump to garbage or an unmapped page.

memcpy(t, s, sizeof(*t)) written explicitly is different: t is already
the corrected physical address, s points into the cpu_specs table which
has also been PTRRELOC'd. The explicit call goes through the normal
early-boot call mechanism which is safe.

The original comment said:

"use memcpy() instead of *t = *s so that GCC replaces it by __memcpy()
when KASAN is active"

This was added because under the old KASAN scheme
(!CC_HAS_KASAN_MEMINTRINSIC_PREFIX), KASAN overrode the memset/memcpy
linker symbols globally with C wrappers that called kasan_check_range().
If the compiler turned *t = *s into an implicit memcpy(), that would hit
the KASAN wrapper — calling kasan_check_range() at a point in early boot
where the KASAN shadow isn't mapped yet, causing a crash.

Writing memcpy(t, s, sizeof(*t)) explicitly made GCC emit __memcpy()
(the raw assembly alias exposed by _GLOBAL_KASAN) instead of the
KASAN-wrapped memcpy(), bypassing the shadow check.

That was the secondary reason. The primary reason that t is a
PTRRELOC-adjusted physical pointer and the copy must go through it
correctly was never stated.

So the KASAN comment is not required but i think we still need to state
why memcpy is required. For PTRRELOC adjustment, comment should reflect
that.

I'll update the comment and commit message and send out a new version.

Regards,
Mukesh
