Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9716FF29
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242376; cv=none; b=RyNlPtuPAwoV0hh/XAZcQdlE4RplSY0EBNTrbVFxoWfdDF6xEqKpmrV8zIeNk/1DsQl3ggocq7jyF1uSShLaxYfmQDC1JEGHQRunPTVywu3TGZTmubUBWRzoHgNcUXJeFIaD6wMXfRYbYA2badL/svd76e2JlkAEiMi3gSx0Y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242376; c=relaxed/simple;
	bh=M1OIAA0ItaLeA6OMZsMNhafiM0P2mVk8eYOUN2HrEfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnm/JaE5ZrTAUxPg06MOcNz5Nrc3RoRORi04zhh9y4V+taCWIfi7C1of6vsH+yQgYzzquPSAC+2edK8FjCLVFi+cEiNHY/jkA6vQVMf6qD03dLnvQA3rP2XQDaj+U5OtAKl9D9CIcK+qs9LibcBiyLUM15CKujVR9pGj/IfjLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I+9QetA6; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+9QetA6"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dc20645871so1002904a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709242374; x=1709847174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZXiBnNhAhi4ZtO0SADmUcnGG7Y1r2RQ91McDK9U7hM=;
        b=I+9QetA60AKN7+t5WCRGjyqQwKr9rI+ukig6Mf/i2z299vpTYLGtWS9tn9ZHxElQkt
         dFio/wStFf14NLTi30iYq8N8D09+JygkatmXoIRG1z9YbJKvEnTi8GQHUGsOWiK/spJF
         1zSwoSK5171OWb4jpi4BY+BLYI7PQ+0/a6jaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242374; x=1709847174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZXiBnNhAhi4ZtO0SADmUcnGG7Y1r2RQ91McDK9U7hM=;
        b=peUIPLYt9O4DiZHvQW8u0vVENtaDdaiQVWxZt0sS3/sJwdVO0kX9PQojBwJV8+i5IA
         Fbx3cMjNg80gWgREt0FVkSPZNnbIVqFQPpsuSlbkanlhclGxspfs/YA7J/fFswiV2xCx
         F0308XUrMymfjQv5BG9IXh6rov+DIWkzlSufoeDYcDrbNvhMIITYzusbVLLmFpNikbRN
         n+6iPjGAe5NlIPZCG2xk2fI1QwjyuQrBeVtCuYdH+T49mQ46SdHC1iTX74Vb45RBuDeF
         nesP5a1X7dUdotm35COGaJGhJyYHFmy/Yq3l+kiNXztFp2t43uABKcpfvnc331+ikm6/
         eGFg==
X-Forwarded-Encrypted: i=1; AJvYcCVX9EbdCnL2ricfA6IgnxAsNiDxT2ulO2vSBiHSsk55uzXJBRthR+1w02HBloYP0nBDefWK3zSYfzwRX5tlfxgfwL9RZdmqQ2KIxaSY2irv
X-Gm-Message-State: AOJu0Yw/Ba1AMNNdP++qvm/PVGc2ueeXxUsFBdxWTBhzC+i/bZ6Vmrdu
	Vst8pwVBPv5h10qx60M6dtvw5Y7M0tkA0/agqRV3K2cy3YRf44XU/6eoKbj7bQ==
X-Google-Smtp-Source: AGHT+IEvsn9DgpO+cW37vUplHd97MaD5TAZWQ0EdSVcQR53nFAD39hdF/sei1lWoc7NAH+n5Ef2cEw==
X-Received: by 2002:a17:90a:4491:b0:299:3c2c:b680 with SMTP id t17-20020a17090a449100b002993c2cb680mr241994pjg.15.1709242374560;
        Thu, 29 Feb 2024 13:32:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e53cc789c3sm1728164pfo.107.2024.02.29.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:32:54 -0800 (PST)
Date: Thu, 29 Feb 2024 13:32:53 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
	Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Message-ID: <202402291332.2C89081A@keescook>
References: <20240223165942.work.950-kees@kernel.org>
 <ZeDiZrrLuqkvxrIY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeDiZrrLuqkvxrIY@smile.fi.intel.com>

On Thu, Feb 29, 2024 at 10:00:38PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 08:59:45AM -0800, Kees Cook wrote:
> > The UBSAN instrumentation cannot work in the vDSO since it is executing
> > in userspace, so disable it in the Makefile. Fixes the build failures
> > such as:
> > 
> > arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Andreas Larsson <andreas@gaisler.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: sparclinux@vger.kernel.org
> 
> I dunno how you applied patches, but these Cc seems to appear in a few commits
> in your hardening branch.
> 
> I formatted patch from 9fd54b08040669, checked out the new branch just before
> this commit and run `git am 0001-...`. I don't see them.

Ah, hm, yes, I'll need to split up my trees a bit to get the right
results. Thanks for pointing that out!

-- 
Kees Cook
