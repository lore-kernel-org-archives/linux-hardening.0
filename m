Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C91BC2A
	for <linux-hardening@vger.kernel.org>; Tue, 15 Apr 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737977; cv=none; b=KgmRgFZiSwieTrmSIVUetAhYkjtJBu/DubHtyrF4FJdmkrOwP8nJFvGVHHFpgRGEaH9th3+znFLY8wGgmKJxqou7f+XagfCo2/TwnuBsbrMElXf/1ifcL/IpzslMPnR9F6A2JLuIkbiQ3NCeSxoCPd+eDGuhlfWpW1iVg727+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737977; c=relaxed/simple;
	bh=1PismtUr/wGeBz1OUJptxbtDX3EscocL02t2s6Bvd8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr3ZHLx4uDkgdhJrgH81VihBOwxbAmKKmBK8iLbmkvM0aoqmdJI9IwMOnUkdDld8BRz35UwM7fLwePoVHglyaySXekQVGI0EHeLtAciXJWvRW1uvVnTR60OJHe01wSYnCdzmJjOf9FLmaGvnqOC9pFGd5yqGxDnxkruX7YjVyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mLUQY7dy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mLUQY7dy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso3655e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 15 Apr 2025 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744737974; x=1745342774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWFMXVeKRJ+DP9uGC7jJBQmmeqwjnwUxPXQH0Ux5Ukw=;
        b=mLUQY7dy/I0fljkcjc7BVc8nv/kPzbuFisj31o2NyjUPVNeRSHtA8w6kCcXapj+2cB
         B4xKiWYcovoiKWbJGec15WoQz9x1/k26SCN1291vDQb4NQ4I8AaDsjBfFdAeXzCd1R6L
         E3NvrpUpSFnUEisgzazZtVtrn29jNWMs9c5zUCGtoiBOBMkWQqZZfTfOTcNG0hcowafp
         nZr+eDUoKMR6ywROTWa2OGEuA8ggeuZbxQETuVz0HpxaC5FEacsqIbwOZZ3NNBi2Nvae
         k2/rGVayjxa1IXsgvgrjsdEJtdHvi8hJJI41FumTZWZNBVrfasoU26hXVi7LUJCyLJfx
         WgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737974; x=1745342774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWFMXVeKRJ+DP9uGC7jJBQmmeqwjnwUxPXQH0Ux5Ukw=;
        b=S1QmNJaEhgBV8iyiA65yjBmemBwAgDNgRzrV/7a7OgO0zBIkCMqTM/dqqa53FVyCMU
         6TBlhUH9wpvOl47B1MVRH2qdkNfxpJdeVZc7o8q7UtIgT6Qf+K5WF5Bubz+yU6zr+S+X
         czJaBANKD7yyf7xNNRbJdaxDzNhcv/iri+3P7UE0jiZBLt9p9zIX3WzhDacrp2yShQpn
         sNs1VaBXMJonj6V9lf17I0TLcX1tdWv+WbDjlZe6gBb2j4XJTDoZuwEdAZRf+u1eByOa
         s5Dex7ytov1m6wLUPKMmQewuI+u8pjUn99iLMnEY9tU90xWnTFld0QkTh3Qk9+N08/nB
         97eg==
X-Forwarded-Encrypted: i=1; AJvYcCWlrSWKntuOxhx074/xE0HNZSU+v/DLL1s+5O5IP5RX1m9P4TYBvYx0VS/Q2cgcKTUZ6F4IXW8DndadSyLB6Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23mFXXNJ9hbsEzPWDGGo8ab26q3/qKPmaTiVh3f51cyDoqc0m
	Wh8WRSj9J4Mm2EfVpE7ZMu/DnH9Qqz7Bb1Wr/699nR9MKlijdwsicvxOYNm0+g==
X-Gm-Gg: ASbGnctxPLjiLPueYEdqPWTq9mVDAajY1OdN4OS3qYG8x6fPsZ6bUSiZkFJwLJnAhyF
	WBeopgslVyADOW5vLPjQkAI4Aj69yO2nj4UtpFSbF3JOSNBfQ9K6Dkxiiyn5W+/J+T0WKI2cZF9
	mWk2hOuNNgpPSRSjOxwVnJxiqPi6WofJKyLCSrlZiXRv6zNjMzYLeDCM8daYY8NY/fn1IciXU36
	DUvD3JL4x+UovswnMl8C32bXk+tr4bSttEkS21JcTvjSU2kZ33y3VolLV/dAL4Dprm8/d4Rxm2Y
	arzWfP/5rjqelJ2J6F+cj5In8hnBT0NV/lQiqgS4IwxpOlea+7ReFjudPSXS3nXNIzmBZJ8PJfE
	Ixxo=
X-Google-Smtp-Source: AGHT+IERBOKmd6feP9DJaglCQV33flahn0YD0eipRe9wH4OYBzHPnUxVgYSJmbH4zT36GInwEF62VA==
X-Received: by 2002:a05:600c:4f14:b0:439:961d:fc7d with SMTP id 5b1f17b1804b1-43ffe57b0b7mr1742785e9.6.1744737973575;
        Tue, 15 Apr 2025 10:26:13 -0700 (PDT)
Received: from google.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc78sm219997655e9.27.2025.04.15.10.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:26:13 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:26:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	elver@google.com, andreyknvl@gmail.com, ryabinin.a.a@gmail.com
Subject: Re: [PATCH] lib/test_ubsan.c: Fix panic from test_ubsan_out_of_bounds
Message-ID: <Z_6WsC9f0mby1nV7@google.com>
References: <20250414213648.2660150-1-smostafa@google.com>
 <20250414170414.74f1c4e3542b1f10c8b24d90@linux-foundation.org>
 <Z_4dXk0RlyXYuzYt@google.com>
 <202504151006.19150DFE@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504151006.19150DFE@keescook>

On Tue, Apr 15, 2025 at 10:09:00AM -0700, Kees Cook wrote:
> On Tue, Apr 15, 2025 at 08:48:30AM +0000, Mostafa Saleh wrote:
> > On Mon, Apr 14, 2025 at 05:04:14PM -0700, Andrew Morton wrote:
> > > On Mon, 14 Apr 2025 21:36:48 +0000 Mostafa Saleh <smostafa@google.com> wrote:
> > > 
> > > > Running lib_ubsan.ko on arm64 (without CONFIG_UBSAN_TRAP) panics the
> > > > kernel
> > > > 
> > > > [   31.616546] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: test_ubsan_out_of_bounds+0x158/0x158 [test_ubsan]
> > > > [   31.646817] CPU: 3 UID: 0 PID: 179 Comm: insmod Not tainted 6.15.0-rc2 #1 PREEMPT
> > > > [   31.648153] Hardware name: linux,dummy-virt (DT)
> > > > [   31.648970] Call trace:
> > > > [   31.649345]  show_stack+0x18/0x24 (C)
> > > > [   31.650960]  dump_stack_lvl+0x40/0x84
> > > > [   31.651559]  dump_stack+0x18/0x24
> > > > [   31.652264]  panic+0x138/0x3b4
> > > > [   31.652812]  __ktime_get_real_seconds+0x0/0x10
> > > > [   31.653540]  test_ubsan_load_invalid_value+0x0/0xa8 [test_ubsan]
> > > > [   31.654388]  init_module+0x24/0xff4 [test_ubsan]
> > > > [   31.655077]  do_one_initcall+0xd4/0x280
> > > > [   31.655680]  do_init_module+0x58/0x2b4
> > > > 
> > > > That happens because the test corrupts other data in the stack:
> > > > 400:   d5384108        mrs     x8, sp_el0
> > > > 404:   f9426d08        ldr     x8, [x8, #1240]
> > > > 408:   f85f83a9        ldur    x9, [x29, #-8]
> > > > 40c:   eb09011f        cmp     x8, x9
> > > > 410:   54000301        b.ne    470 <test_ubsan_out_of_bounds+0x154>  // b.any
> > > > 
> > > > As there is no guarantee the compiler will order the local variables
> > > > as declared in the module:
> > > 
> > > argh.
> > > 
> > > > 	volatile char above[4] = { }; /* Protect surrounding memory. */
> > > > 	volatile int arr[4];
> > > > 	volatile char below[4] = { }; /* Protect surrounding memory. */
> > > > 
> > > > So, instead of writing out-of-bound, we can read out-of-bound which
> > > > still triggers UBSAN but doesn't corrupt the stack.
> > > 
> > > Would it be better to put the above three items into a struct, so we
> > > specify the layout?
> > 
> > Yes, that also should work, but I ran into a panic because of another
> > problem, where the padding before and after the arr is 4 bytes, but
> > the index is "5", which is 8 bytes out of bound.
> > As we can only use 4/-1 as out of bounds.
> > That should also work:
> > 
> > diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> > index 8772e5edaa4f..4533e9cb52e6 100644
> > --- a/lib/test_ubsan.c
> > +++ b/lib/test_ubsan.c
> > @@ -77,18 +77,18 @@ static void test_ubsan_shift_out_of_bounds(void)
> >  
> >  static void test_ubsan_out_of_bounds(void)
> >  {
> > -	volatile int i = 4, j = 5, k = -1;
> > -	volatile char above[4] = { }; /* Protect surrounding memory. */
> > -	volatile int arr[4];
> > -	volatile char below[4] = { }; /* Protect surrounding memory. */
> > -
> > -	above[0] = below[0];
> > +	volatile int i = 4, j = 4, k = -1;
> > +	struct {
> > +		volatile char above[4]; /* Protect surrounding memory. */
> > +		volatile int arr[4];
> > +		volatile char below[4]; /* Protect surrounding memory. */
> > +	} data;
> 
> Instead of all the volatiles, I recommend using:
> 
> 	OPTIMIZER_HIDE_VAR(i);
> 	OPTIMIZER_HIDE_VAR(j);
> 	OPTIMIZER_HIDE_VAR(k);
> 	OPTIMIZER_HIDE_VAR(data);
> 

I can do that in v2, although the rest of the test still
uses volatile, I can convert them in a separate patch if
it's worth it.

Also, OPTIMIZER_HIDE_VAR(), doesn't seem to work for structs
or arrays. Instead of using it per elements, I guess READ/WRITE_ONCE
might be more suitable for that.

> >  	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "above");
> > -	arr[j] = i;
> > +	data.arr[j] = i;
> >  
> >  	UBSAN_TEST(CONFIG_UBSAN_BOUNDS, "below");
> > -	arr[k] = i;
> > +	data.arr[k] = i;
> >  }
> >  
> >  enum ubsan_test_enum {
> > 
> > ---
> > 
> > I can send v2 with this approach if it's better.
> 
> Yes please, the struct is the right solution to keep the memory
> contiguous.

Will do.

Thanks,
Mostafa


> 
> -- 
> Kees Cook
