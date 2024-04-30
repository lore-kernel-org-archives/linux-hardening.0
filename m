Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE41A38F0
	for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512337; cv=none; b=KqNhgmdXM1qRM89BA9rTQcr0RtuKYKhKlXZ2ebuGOpq6WNSS+p7YJUUvbCDgD7m4ERTJi5Nl8K9LQx92hrpCyUjmKx9lNibzeer+0nsTdTUVJ0GORaecw9z2PD2YWyexP9VOfw6d361559bxtT/9xzqXjzWrGpMyEfKOopQYKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512337; c=relaxed/simple;
	bh=A2BKfjstI0QAqB/arpyjcxV2OCbaaJu3tI5uRAVc04s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TolUgD36Vcb2OGdUwsZYvRJk/0fkwrN08nJ7vavWpBRWwZdishrqYKOmNmmwdUWtX+djnlfT3OCQOgG98U1Mi8OTlje29CHmyS2Na4YTb07TU/uC9B+8R5LmPNP8jtjs8AdMA3ak9vbai6fmp0MXRxuw0/doUN/rxkN6IiZdaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UkpjcoGR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UkpjcoGR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5f7a42bf0adso4423575a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714512336; x=1715117136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yL344saeiEHbqmyOopyOdGQH0USlm3SnC2xCq0SoJLU=;
        b=UkpjcoGRCslNY+nJjND5YxLCENbqyO69ypLlRWqSPHXpzTLKmSfwTYWM+GIB6q+SSd
         aeb3Tdd59YH6iGyyB4BlE51A1w/RA0MsDF5j1Nl6jn9iqhmyayOF0h6TeF25v87LpPnY
         Hy+S3hDniK3U+a9198PvAmSYCE8zKi1TUKcSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512336; x=1715117136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL344saeiEHbqmyOopyOdGQH0USlm3SnC2xCq0SoJLU=;
        b=T8KIQE11JHUI9SRZuxk6lG0sc0b/m6LJ9OuzQ9gKOrUfut/RGfokhwoz+WvloMwO3x
         YIm12dLxz1f7qrBNUO6Bh+ORmPguqFA/ANsqVbtzZwM9JU+eHj7H+RzDkFsDWqMMIEEe
         2FmQPpB84i7tky5JLm5ZQ+qtMcdVUNJz5ll+Y4KDVRXAZmvlhtFT2zgduwqBH6WRINEH
         EqSafBn3oB4sf32u+ATWA49IyxjAB1n0/GIalPL3tayubTnvb2etp6KVMRVgNKUF+Xy0
         f9Ay3dMdUOvOmrC5PLa/JLEdt+btQG9MRcc6XSMtcKPFEN/kASFmPoaTOYlD2jeF/8eU
         4IrA==
X-Forwarded-Encrypted: i=1; AJvYcCUxIiSIdPvJQes9wduvHrW6oHVxqADyefAdpHh3zbivlKxRGIyQasHYd356nHYq+Km6MFDli1qoUgEboqrj9Io4xdf1ca1p2p8z9WRneDL7
X-Gm-Message-State: AOJu0Yw+NUYdqI2DCWAcufoyJ/bjOPWqYi1Gix6R8IJErGZpSB1wIaJo
	g5k8v2fLLm7op4rn79TOwY9rheYFaeWo1h8T4Bdbjk3PBm8ddqtcY9kQV5O7kA==
X-Google-Smtp-Source: AGHT+IFIxVelglvKW5StU7tXy2dZZm6BsDNmXrzU8ELIShBXYB5SRyvBVWCFfa0CxoN7Rk5noHrHnA==
X-Received: by 2002:a05:6a21:998:b0:1af:4fd7:6c6f with SMTP id li24-20020a056a21099800b001af4fd76c6fmr545627pzb.35.1714512335948;
        Tue, 30 Apr 2024 14:25:35 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb33-20020a056a002da100b006ed14fed3a5sm21507308pfb.154.2024.04.30.14.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:25:35 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:25:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: Refresh KCFI options, add some more
Message-ID: <202404301424.FF88864115@keescook>
References: <20240426222940.work.884-kees@kernel.org>
 <20240430092140.GE40213@noisy.programming.kicks-ass.net>
 <202404301037.9E34D4811@keescook>
 <202404301409.D3BC98D5@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404301409.D3BC98D5@keescook>

On Tue, Apr 30, 2024 at 02:15:53PM -0700, Kees Cook wrote:
> On Tue, Apr 30, 2024 at 10:48:36AM -0700, Kees Cook wrote:
> > On Tue, Apr 30, 2024 at 11:21:40AM +0200, Peter Zijlstra wrote:
> > > On Fri, Apr 26, 2024 at 03:29:44PM -0700, Kees Cook wrote:
> > > 
> > > > - CONFIG_CFI_CLANG=y for x86 and arm64. (And disable FINEIBT since
> > > >   it isn't as secure as straight KCFI.)
> > > 
> > > Oi ?
> > 
> > Same objection I always had[1]: moving the check into the destination
> > means attacks with control over executable memory contents can just omit
> > the check.
> > 
> > But now that I went to go look I see 0c3e806ec0f9 ("x86/cfi: Add boot
> > time hash randomization") is only enabled under FINEIBT... seems better
> > if that were always enabled...
> 
> And FINEIBT actually can't be disabled... :|
> 
> And as it turns out CFI_CLANG doesn't work at all on v6.9...
> 
> [    0.587220] no CFI hash found at: __call_sites+0x339a8/0x34450 ffffffffac20cef8 00 00 00 00 00
> [    0.588226] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:1182 __apply_fineibt+0x7a9/0x820
> ...
> [    0.619220] SMP alternatives: Something went horribly wrong trying to rewrite the CFI implementation.
> *hang*

Welcome to my TED talk.

I'll keep debugging this: boots fine on v6.8, but booting v6.9 with
defconfig+CFI_CLANG _does_ work, so something in my .config broke it...

-- 
Kees Cook
