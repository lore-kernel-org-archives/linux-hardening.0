Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CA46F497
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463748; cv=none; b=DqtKQiavCiHWRl4YRzjMDGBRJPGIxnfTFNRsNTcNmIFHgQ1Q+GBIp0P+KoWZ4MPZaouADzKMDBzjiICiR8RfhQX+P99Xebhi4/JKERp+qLLZOTqQ1JsGJig0hA2oPZN/WVhJ0YibhhheQsuMznbVwQKFGMj9p5KX0E88i2/t7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463748; c=relaxed/simple;
	bh=EmGj/TYa9cvf9jUjTZ/nRlWvKu/6pQ6qezCBwlaGwXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZTaCCJmiZRhE2UUO1JL05B1QLEsmXeCxfb0BUN9GKiMHg/P7qUV7jDPzyLiLN4OdMQV7ZgdNJirjy36WDdBLvkBtjP7pyhn/ityxtpp/hduZd0moFh6VFrSczDGPfNgzRubiMfyrXUq9O8cLmj7fvp3Cn76HV0qK1uy6BFbbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc6OsMVy; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc6OsMVy"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f05ffcso293495ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 02:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463746; x=1790068546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KyTzZj9bu9m6y51EDmw17tS/R3K9wAgV1FMAvLd0wJ0=;
        b=kc6OsMVycQ7iZOSO9GlXWurDyYsmU3T86/G2VsCSnP8XnTzQ6Po1urUzAzsWAILgfO
         Te160Nh8FQ43Wc5VgnG36h39TvIv+x4rXJA7tdHztpr9I9BC2a6cLyKhVw/wF2fId8yj
         VabC9CCGhMdrGN7+U0LvvIZ2xyrh0CpM78nMr+xVBya0Qq9xQI+U8Qv1EDOb0q71rVMV
         ZOY2VPdoJ+U0S+oi6Lej66sj4QljXH9NFrt35FW0mbe+Wl/8P6fca1A7ZXPZJaRGvUgq
         G25l2VL/VrHibI3dmRwF+Wb+5buSaJY3hB5UrN8si0AhmUK+1X21VsGPfKM5UclDOCmm
         QB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463746; x=1790068546;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyTzZj9bu9m6y51EDmw17tS/R3K9wAgV1FMAvLd0wJ0=;
        b=Bd10ADEqcSo7W85qEgfAryplz+nEEyzrYNd4xLqJp8owyKOARaL7tfKIvhOwqijxGg
         dGLUo3VEj23bcQ7g+EpOsMKohXO9wrfS3q3GDBHUvwnEqZbKNJi6XHeZtOEiCmaz/BMn
         FhhuQspObv5HFK69J3a+L8e1033eqUk5ptq8L9fFObnWlaX0ZLhaT649+o6LQFXLexfM
         hs6owJeCMoclmcbSsNWW9zrw44UKqu0y16ptoD7Xw4k6qjlzwxXVkG98EGXFd4Q4njhj
         Rq2AMV4YfX1jdnjmAF7fMijTsDo/luNCPyyK4cBu4YAZwrRC94se+wumle4JQSt8RY6Z
         7QRg==
X-Forwarded-Encrypted: i=1; AKwUvBwwOevLuFXmJRbaGl7QCGfYGKtgwHRX2Ipj8CYwMV3vVTFcXPtZAtGU6GULLCfB8oYKXN9Ru5QWK94W4/YcZGA=@vger.kernel.org
X-Gm-Message-State: AFuF++l6rJlgjOlyiW+UKg83dX3xcbn7VXR1DOPMQ6AZwJ/vhno5eE8S
	XFCABGeMgBZ3HBU0S90yBiKmzX4sSIXmY8I9DggoDbHzAXgoLsi6qhy1
X-Gm-Gg: AYBFou0ePiFVjfPx15YGD6rwUFnewyaM7bymrkpM7f+VBTV4MUNBdR6IwIfV+CQJJPl
	dxdf/fAJk6DQhgNflBRCr373W8K7vpT7WxrFXoe0hkFaTraJG6fFTQh0sA3Ew2N1nX/7DBpwaP7
	BCR/zc4WlUTwzlfIBVJrqt+6Xl5GZf01xknbDFAjAKnrXLlZI+vIktiS6YfBWzD1WRJUGWAy5Ee
	n5Wk2+thzfFUdUKmF3NhUjRjiCRzLrylkBz4kdT2jGfd7ATpMOXFGocm51XBLTRyJxTsU6iHBal
	cswzetl6eFbQqVg0KpaX/HibTBGWw18SI2s/98XrV6faezsViYQcsS6OXJJ/9nIxACcFLC0BPkM
	k23DNnx6XoF2YhFmrOc2Zm1wJEbX40e7moF+egfPcQz0GJTCBUeS9EYsyNurIrwngRQ+TIxGkt8
	kgskZymr3og9S6xkM4UNcVN6qhwv9JBp6puga1UhNOSvC2Zl866RDttymifS02bMBmFYY11sIVW
	iV+j7qTMTimKVfxwGpWcyn8fpTv5tOqGfAprCiB1EU=
X-Received: by 2002:a17:903:3b86:b0:2cf:9347:f445 with SMTP id d9443c01a7336-2dd83851a2emr4167135ad.10.1789463745776;
        Tue, 15 Sep 2026 02:15:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd4a7f17ecsm47233025ad.14.2026.09.15.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:15:45 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:45:34 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kees@kernel.org, ritesh.list@gmail.com, amachhiw@linux.ibm.com, 
	mahesh@linux.ibm.com, nikhilks@linux.ibm.com, robh@kernel.org, sayalip@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V2] powerpc/kasan: require memintrinsic prefix support
 for KASAN
Message-ID: <aqkMYJXu7mV40baM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260911180536.3234640-2-mkchauras@gmail.com>
 <508afce0-d479-46f3-a2af-d7e6cdb65232@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508afce0-d479-46f3-a2af-d7e6cdb65232@kernel.org>

> > - cputable.c, prom_init.c: the original comments said "use memcpy() so
> >    GCC emits __memcpy() under KASAN". The real reason is that these run
> >    pre-relocation: the destination pointer is PTRRELOC-adjusted to its
> >    current physical address, and the kernel is loaded at a different
> >    address than it was linked at. A struct assignment (*t = *s) may cause
> >    the compiler to emit an implicit memcpy() call that resolves through
> >    the unrelocated virtual symbol address -- before the MMU mapping is set
> >    up -- jumping to garbage. An explicit memcpy(t, ...) uses the already-
> >    corrected pointer and is safe. Update the comments accordingly.
> 
> Nope, see my other email.
> 
Got it. I'll remove this.
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 6f6801da9dc1..233b5c650d1e 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -36,8 +36,12 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
> >   	t = PTRRELOC(t);
> >   	/*
> > -	 * use memcpy() instead of *t = *s so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > +	 * Use memcpy() instead of *t = *s because t is a PTRRELOC-adjusted
> > +	 * pointer and this code runs before the MMU mapping is established.
> > +	 * A struct assignment is a compiler-generated aggregate copy whose
> > +	 * implementation is not under our control in relocation-sensitive code;
> > +	 * memcpy() ensures the adjusted pointer is explicitly passed to the
> > +	 * copy routine.
> 
> This comment is wrong, see my response to your explanation. I think the
> comment should be removed completely, now it is possible to use *t = *s
> without any issue again.
> 
> 
yeah i'll fix this.
> >   	 */
> >   	memcpy(t, s, sizeof(*t));
> > @@ -55,7 +59,11 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
> >   	/*
> >   	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
> > -	 * so that GCC replaces it by __memcpy() when KASAN is active
> > +	 * because t is a PTRRELOC-adjusted pointer and this code runs before
> > +	 * the MMU mapping is established. A struct assignment is a
> > +	 * compiler-generated aggregate copy whose implementation is not under
> > +	 * our control in relocation-sensitive code; memcpy() ensures the
> > +	 * adjusted pointer is explicitly passed to the copy routine.
> 
> Same
> 
Sure.
> >   	 */
> >   	memcpy(t, s, sizeof(*t));
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index eb9f556b0937..d6d7f1ede319 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -1363,10 +1363,12 @@ static void __init prom_check_platform_support(void)
> >   				       "ibm,arch-vec-5-platform-support");
> >   	/*
> > -	 * First copy the architecture vec template
> > -	 *
> > -	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
> > -	 * by __memcpy() when KASAN is active
> > +	 * First copy the architecture vec template. Use memcpy() instead of
> > +	 * a struct assignment because this code runs before the MMU mapping
> > +	 * is established. A struct assignment is a compiler-generated
> > +	 * aggregate copy whose implementation is not under our control in
> > +	 * relocation-sensitive code; memcpy() ensures the adjusted pointer
> > +	 * is explicitly passed to the copy routine.
> 
> Same.
> 
Sure.
> >   	 */
> >   	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
> >   	       sizeof(ibm_architecture_vec));
> 
