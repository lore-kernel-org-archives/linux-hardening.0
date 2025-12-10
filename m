Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFA2F6929
	for <linux-hardening@vger.kernel.org>; Wed, 10 Dec 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353235; cv=none; b=rWjSswq7M25O42ciHUoY3pCkywBNtigL074VbPD8bIl1qVJPW8mGotk7+FvtVBsaYM0WCrrh8jPYLGl2MOAz7eIJfC/Sqw4xmm/jZvSG2iiGOgRN1Alsbf/dZtEPgSs7xg3Jm+oDVWTarPf1odxJ7x943IJ3dU/4hdF9JHqY+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353235; c=relaxed/simple;
	bh=D/+seJG//nC/P4iPB6ZizEmDXJnST4bMlgf1OqxUW98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQRAy1Dy4nk28yAcJdgl2Mku7tpvSpDUUI2KeIb0F23JP4rMPfJHczWP3jdVDEBkjTLQF7rxPXQ/Ouecu/nKHex3oHFwMP1SvJIrGuMiZVSd1VebnKZ/+AzbhsUrYCOWJusFOgGSMN+39gL+cyMO9DdGln9f7hXuzD5ugyTfgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uacU3afq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uacU3afq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso86251585e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Dec 2025 23:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765353231; x=1765958031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAfe5xpVHnGY2Zbu61+EcStytc/6fH+jNqtQ9R31Tiw=;
        b=uacU3afqkaMa+WPCVBgWiWf5abVanywcETVYInSHYb4TpR7ADiGPlfN1gVZW29j78E
         1IGdHXqPOoXRscKcvn0+AhPgUep7Omcly+OEtZRK0riN78CQM+eUK12IP+PHQ/ZrrYww
         rCs1MepiIK12Bw78lZN2UIlXgPnwfAeD0Z4CDOECYHtoOiijybqlfm4RCWKE02Z8J1J5
         p9CBRZUfmgntLdKTJ3gQig0D72aOXbIX/yrcIoQT9fzXs7InX0kE6mfcF8WlVSVyr2c+
         BSFDh6dNW4DsMoxIxAeJUpZaF77JCKjuCp2WtmCzcpGkBXQxRT7TpFVqk7Of14MBcCkc
         ksdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765353231; x=1765958031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAfe5xpVHnGY2Zbu61+EcStytc/6fH+jNqtQ9R31Tiw=;
        b=sBcwr+rT0vWI0dyP8aljQs36yvFIEe1+24TNlXVZ4P88wtwU37Ibl/9tH3NXphAy8D
         QD8kP3ObX07WcCdsxK8IZGmTytGlDu8Aew56Qg59RdrL1W6BwcmE42OoI0oaKp0Srbwq
         QcgX8Yxa/awQvFYhX30zIHfOJqg3Mdb/VtAllA8wOroQs1CI7bOMW5JyKfn5UXewjNEv
         zvn7VqxX+ku5KQT3RergvjZBbsB0CL44+f9GZZiJbsrvosFEDIYvdtcg0hc6MH0rSXaI
         SvO6iRxMFZT3Y6M8koAzt8/SLqT51Tap8t6j0JfhOBvhjrRl1GTsaqi19pUMQ3T2Euh3
         DfFA==
X-Gm-Message-State: AOJu0YzWxAiM9fMhy5cce5P+RlIslnOiBfKExoXSslZrtc6c7f67TJPi
	lzFTXFEUT7c5IrcslMnC7kFyMLtUB4VKXfsJywERiRTonvMqASl5SVfX82DLcmeqpbBNqSKoSe3
	b6JmU
X-Gm-Gg: ASbGncupPAbqPD6zgcpU7rYfO2/R1wTl+qc5r93IGBk+p57iRAHzl5BXWwlWPwi62rp
	3uFM3LLl82u1kwPn2+WjzC3JbAkj2DbWk5baVnVGFMFVFRRT5Oa7fHPUfbtQ84PfjuZNnxEsXvM
	q4JsKQZy9jaWw42l52UE93Jwx1FHuROquU8PVp6Rml/B0fYmTi8SvLm4qY2csIIthTJpBBAfmwd
	j0cVoUczDbnFKJS64Zn8/iDmf+/BHwX5FRbVJRqZ2n20OIr2xEtK6+o4URaE2ydslPF4m+EKyEX
	FVcih/rvyntzkrtX62fuzcVG8yw+ZroDTl49T31jy4R8sOHER/iT+rNmd2WjYK/iSJ7n+W4mZYY
	yFsZdWU9w819spQXqkP5vcihsLdriHAvItTu0BuA4VdZRpMHHBEpGn6DCPPOW70UhNfxx5Ht29G
	vc5n5Z4W5tJdAkpJbr
X-Google-Smtp-Source: AGHT+IFAxc9+MiZJUAUnbNcL1F+kG7TAkmzsOeTPbtUzhYDn8Z09MPKEdiLthnyruYWc8ighlEwehQ==
X-Received: by 2002:a05:600c:1c8e:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-47a83814448mr11849975e9.9.1765353231153;
        Tue, 09 Dec 2025 23:53:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d5239asm30321475e9.15.2025.12.09.23.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 23:53:49 -0800 (PST)
Date: Wed, 10 Dec 2025 10:53:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	llvm@lists.linux.dev
Subject: Re: [bug report] clk: visconti: Add support common clock driver and
 reset driver
Message-ID: <aTknCZRscyltxAri@stanley.mountain>
References: <aTgetqy8BGerPGTl@stanley.mountain>
 <20251210073611.GC1147766@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210073611.GC1147766@ax162>

On Wed, Dec 10, 2025 at 04:36:11PM +0900, Nathan Chancellor wrote:
> Hey Dan,
> 
> On Tue, Dec 09, 2025 at 04:05:58PM +0300, Dan Carpenter wrote:
> > Hello Kernel Hardenning developers,
> > 
> > Commit b4cbe606dc36 ("clk: visconti: Add support common clock driver
> > and reset driver") from Oct 25, 2021 (linux-next), leads to the
> > question:
> > 
> > drivers/clk/visconti/clkc.c
> >     187 struct visconti_clk_provider *visconti_init_clk(struct device *dev,
> >     188                                                 struct regmap *regmap,
> >     189                                                 unsigned long nr_clks)
> >     190 {
> >     191         struct visconti_clk_provider *ctx;
> >     192         int i;
> >     193 
> >     194         ctx = devm_kzalloc(dev, struct_size(ctx, clk_data.hws, nr_clks), GFP_KERNEL);
> >     195         if (!ctx)
> >     196                 return ERR_PTR(-ENOMEM);
> >     197 
> >     198         for (i = 0; i < nr_clks; ++i)
> > --> 199                 ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
> >     200         ctx->clk_data.num = nr_clks;
> > 
> > ctx->clk_data.hws[] is __counted_by() ctx->clk_data.num.  Don't we have to
> > set the .num before we fill initialize the array?  Or does the checker
> 
> Yes, it looks like line 200 needs to be moved above line 198.
> 
> > code allow us to access the array when the counted by variable is zero?
> 
> Nope, I just had to fix an instance where num is one and hws[0] is being
> accessed:
> 
>   https://lore.kernel.org/20251124-exynos-clkout-fix-ubsan-bounds-error-v1-1-224a5282514b@kernel.org/
> 
> I suspect there will eventually be a report on real hardware when
> CONFIG_UBSAN_BOUNDS is enabled and GCC 15 is used to build the running
> kernel, which is the first version that supports __counted_by(). How did
> you find this? A new smatch check?

Yeah, but it was a bug in my check.  I need to add __counted_by()
support to Sparse.  If I had that, it would easy enough to add a
warning for places which access the array before setting the counted
by variable.

regards,
carpenter

