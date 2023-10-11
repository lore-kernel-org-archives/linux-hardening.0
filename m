Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21041A713
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wh8oxInp"
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DFF9D
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 02:17:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66b024d26e2so6588316d6.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697015851; x=1697620651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ui4FIOXF4erofK3EEiBiXcu0Hxm1HMmxaKkqRWWBw=;
        b=wh8oxInpFZtf6XXQiMQnRBsMtFbLoHpOZgY41h+uCfOcYjlAk+rwyA7EgR8X09IHXI
         al05NAmn5RT5CR7aCyx7mYSubWFrjnSyICRSOwGK9qeoBgVTXmFDo5gcModECI6w6yoh
         62RVPOunDUPP9MWog3JCEBLziWNMJcZZcZhDLvOko1r4bJ1aCjCscfk5s17cIe1ln3P9
         o/DgJA/V5gwbImmxr7A9Elum47fq6294BG+Bb5mMarLWuqkLLoj9SkiKqXJRi5KP0kHS
         x0979Y562zkSd1NUkseqfxSDZadZSZ+CVoaTNZBLwXPjOGCjsLzoWOXe5Ch2NOLmeA7/
         2SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015851; x=1697620651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0ui4FIOXF4erofK3EEiBiXcu0Hxm1HMmxaKkqRWWBw=;
        b=n9CGXS8RSiRmNfZQ1WY4iXszILbf/k8JmALa8gpNQoobwBqOpprHAmfaeln2eQj4B3
         3bGR/8/SbzlTXj0QRy8w9YLMN5GW6zxezGw/AHrrtt0uXJsPMhotqm4SuwkLn+ViBsYN
         anIsPSGisw4+NwWvwa5FthM2ugDGwOpPEFnqZopr7LciFliWGLAMp+KYMxVBvTfIxzMx
         f16FtR2uk03byJ9kO36QUaJDLPuqwnfth6UMvRcjej+l5cMVNYj/Lb2sIM1pdU1IK9Bg
         akfye/l4zi6FiwJLzNY2Deo/Lr0g9Rp/2Td9xi2KsvGoeIxMQaIwwoK0yf6lpDilsLlV
         v42w==
X-Gm-Message-State: AOJu0YwQ67nvJ/WrmEDUvgEX7+7nqvvP4f3WqCxXNScmQG9aXtir4ABm
	In0QxSutFyis78NX6DVxcQJnpOhC8/H2rs8JwuhltA==
X-Google-Smtp-Source: AGHT+IG+rPyyOblyJSoglo8ncjt3dp7Z3DIXVrqQ4vGB7pn+rmpGmyxgol88V0zb3M685htN9UAVO3vWeH+qrZJ4lK4=
X-Received: by 2002:a0c:cc02:0:b0:65b:2738:9bb4 with SMTP id
 r2-20020a0ccc02000000b0065b27389bb4mr26931856qvk.23.1697015850728; Wed, 11
 Oct 2023 02:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-12-matteorizzo@google.com> <386c175e-bd10-2d5d-6051-4065f6f9b84a@intel.com>
In-Reply-To: <386c175e-bd10-2d5d-6051-4065f6f9b84a@intel.com>
From: Matteo Rizzo <matteorizzo@google.com>
Date: Wed, 11 Oct 2023 11:17:18 +0200
Message-ID: <CAHKB1wLetbLZjhg1UVhA1QwZHo226BRL=Khm962JEfh0F+CVbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] mm/slub: allocate slabs from virtual memory
To: Dave Hansen <dave.hansen@intel.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	corbet@lwn.net, luto@kernel.org, peterz@infradead.org, jannh@google.com, 
	evn@google.com, poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 15 Sept 2023 at 23:57, Dave Hansen <dave.hansen@intel.com> wrote:
>
> I assume that the TLB flushes in the queue are going to be pretty sparse
> on average.
>
> At least on x86, flush_tlb_kernel_range() falls back pretty quickly from
> individual address invalidation to just doing a full flush.  It might
> not even be worth tracking the address ranges, and just do a full flush
> every time.
>
> I'd be really curious to see how often actual ranged flushes are
> triggered from this code.  I expect it would be very near zero.

I did some quick testing with kernel compilation. On x86
flush_tlb_kernel_range does a full flush when end - start is more than 33
pages and a ranged flush otherwise. I counted how many of each we are
triggering from the TLB flush worker with some code like this:

if (addr_start < addr_end) {
if ((addr_end - addr_start) <= (33 << PAGE_SHIFT))
partial_flush_count++;
else
full_flush_count++;
}

Result after one run of kernbench:

# cat /proc/slab_tlbinfo
partial 88890 full 45223

So it seems that most flushes are ranged (at least for this workload).

-- Matteo
