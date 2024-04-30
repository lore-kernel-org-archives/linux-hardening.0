Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966F1758C
	for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714455307; cv=none; b=tHAWebZcOEP6/AKbi3iNLpdmhAVOIT1o1Sb4TY1RKY3Jp+CjPJFhKslWpJ24/y1sQPUuNhkaBLOMFet/r/N7Pl0atBXLOWaU7JNI0KGeGQCNg3lkRL38wXbYZv/Jv1shD8+6d4HR1qO4MwNyb+q/OauP5TyiyBuILrCrgPVHbis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714455307; c=relaxed/simple;
	bh=0lANZJBk2q8qyeCEkyiuDs1ISrEWT6/wJvz29MPlTds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suvPzQsTLDis6l2TkCxJK0ROGMCRA9OpzAMH2NCWzFCm5y1+28g6nVPhoQO7LbiijYvNEpzZiRsnoy6cvToLRhmJwG5GpfHayhpPuhYcz1Mk54Xf+85Ubq7hcO+xFn+eo1v0YflhxmR/TXkvKsm/lAD1XGkLMCfb1e2Hp3ViHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fgdPrb1f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fgdPrb1f"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so47577345ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 22:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714455305; x=1715060105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C86TkJMefuwLFYqPDfjsQaXZDgvqLvjIZeQbeqShpoI=;
        b=fgdPrb1fqMg18QNi+Pibt7ddGBbLBeJTYIr+rtbLx4zjLo43ZPIOW8c9E5FGJW6+MP
         1VxatqfLGnebt+stBICmPtKa355/tPMUFLb2jr/6oGDJshRknfbLwjWPuyrqvEXcGS3t
         dJoSkL6kbLyXEokUdojkGlim1daRxm6Dyjo4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714455305; x=1715060105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C86TkJMefuwLFYqPDfjsQaXZDgvqLvjIZeQbeqShpoI=;
        b=wDmQ5PkE6jXSfK5bV5Ke/NCBdoXIPkv/OV1w4y/0XS2nnsMsbsf4Ed25AnP44OTEOm
         4OFmtwmf/troVifRS/qvJy8wFQpQQgcA9Iytw5QSnhULdTAqPfC8dBOi4NEJql7eCghJ
         swXGoLutCnCa/jK9gapM3b94LAD0P6Nsiw4NkOxlXG2n9unMUB+nsynPTW0qqGQgSnlO
         dbY3iZzRYM/yknsWHw5n5MTQ5XvvScbTdad5mKNzkF/ZOiqw7059VxB8WJJAgGXpOgqW
         tuQ+QdVwydRTfzZ+63MA8fJpeeTS/maQaXmNQiIjkjJ4NuDn3EifM2GvnbVCoREwOhCS
         iVhw==
X-Forwarded-Encrypted: i=1; AJvYcCUV2Upgh1PwMF9PdHkr4zWrat9YQvG2izcADKLMGjzxLINDrJTCy16g40FyeqGV5Nna2Ed4x+nMh0SV2cuR9V7pZAs9U8u4/nmo7Bm7wpHL
X-Gm-Message-State: AOJu0YwyO+0HkP+2rCdGEKcMAjIozunYbf8N/1IiJtMORCUExZPYqxbr
	gJlMyZqSAe7y5wFddpPpswDt78ZA5Db431umtndPsC3rEjs67Wh9zfvXJuJwdQ==
X-Google-Smtp-Source: AGHT+IExYVGtME+b7bsTki80m/529C/WFpqN5LWnzvSEWxibnamEqrs4aXGKwGyaazB7ViSXdQpIYA==
X-Received: by 2002:a17:903:41ca:b0:1eb:1240:1aea with SMTP id u10-20020a17090341ca00b001eb12401aeamr16493520ple.20.1714455305039;
        Mon, 29 Apr 2024 22:35:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902edc400b001e29c4b7bd2sm21410591plk.240.2024.04.29.22.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:35:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:35:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <202404292233.9A98A7C@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240429221650.GA3666021@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429221650.GA3666021@dev-arch.thelio-3990X>

On Mon, Apr 29, 2024 at 03:16:50PM -0700, Nathan Chancellor wrote:
> On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> [...]
> > +# Enable Kernel Control Flow Integrity (currently Clang only).
> > +CONFIG_CFI_CLANG=y
> > +# CONFIG_CFI_PERMISSIVE is not set
> 
> Should this be a part of kernel/configs/hardening.config because RISC-V
> supports it (and 32-bit ARM will soon too)?

Probably yes. I was worried it might be "noisy" for archs that don't
support it, but frankly if someone is using "make hardening.config" they
probably want to know about unsupported options. :)

-- 
Kees Cook
