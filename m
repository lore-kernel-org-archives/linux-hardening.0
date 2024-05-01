Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EE16191B
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594407; cv=none; b=loEv2htSr8tk+YjpUkPiTZBK2oF472W+1uZizgu/RodHC4VYM0TCEw1AlztBiLUHwAy+X8bKHq63n/nxrc0UpY+XOIRANeBuozklwltYWhDmwf63MyUXcxbOmgLeRsPKeRNAho98wLe7GH828aqZns4OeS4KKPMgkmMpnB9Uukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594407; c=relaxed/simple;
	bh=4ywZCAUhnkyRouoGXFeP3qU1/bxbRV5WojnoTHw3CAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXJX9TIDbLzkCYLqVvF8N8h/XP0htE9yPvpZ1NxWcU8raxbFZBfRKHOcZKPbQAPCURApY5zX58WIpXks/jMCXObueEIhEw4fbcE+StM+vgAR5nvAXjXDmPlJSAL0Wg+4tAyGWi6y950AGyRKWSK2/XzdcgB955JiEQmuP/ir/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cq73uVVR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cq73uVVR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso6335020b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714594404; x=1715199204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzJNyUjTcyvayOGi2RmNTOhiNWDsJ2lrCXlytRPvm1U=;
        b=Cq73uVVRzj6HMzdt5QVbKcr/k76sr9w0oytb6P2zs1XmFrJQL2WJAjDEvo/OXwfGcU
         oQj2RnQNNI+6TylFn99Ju9q37kCwj4K2lsl9p50RDz3Lqf+8GXrsFpwXoC8oYlXs1VeS
         vNiJII/xVcT2nJRFmSyWzO4p1i1CxQHIjlQqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594404; x=1715199204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzJNyUjTcyvayOGi2RmNTOhiNWDsJ2lrCXlytRPvm1U=;
        b=O7TU3hKCHWZPZkFSUbB0TCrZ9fb/80KwdF/8+IsigOeEK9oHh9/9BprU70mLLCWEJC
         0A/UdoQ8mFIgfAO941wGkgc5/FpBMhz4CENpxqKUyU+9FeJ2LPw3MYW0R2q+dO6q+aRL
         IF31t8ymB4xkY11h3pH6eprC8ItkWpQw13mtDMBFVA2KM3+lfo3IHgaJqkDV29o0u/pw
         bGpiOlyWoXGpIVYJ7d1fc1uYJV1hSwM3OV7tyrgUNn+sBbmYMUP1dNmvmYSqhE6Hyh9w
         bH1tT4y2JG241a6etB0ioKBAeu+vUGaPy43uXbL6UBW+iD51Lk5QaE92VvzU2+UFw5ay
         8f2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3suOd7AX4xMh4oow610MWbV8QBQChnHQXAqlXDDqFP41KKtUWSIs5eRf61lLl5fHFUVrQRw8eCiSS1hlkktzZuLFk4VVlyuckYhGOaDhi
X-Gm-Message-State: AOJu0Yw5RhLZZy1mAqe+DQzlSVXJjNSnZy95YbpoV2l1xtNBYrVuCXQC
	LCOf7YHQU5HgZBAyX9VqNe3YjqDwecFqaqRSisZBzn2sr6x6WjsI1Nh/mdWB7g==
X-Google-Smtp-Source: AGHT+IH2F7ggeD8WqIrB1Dq6jq/1RLcQimv9rH0YngcVlTmpQvQ888AUBOkKaiZSGmgPfIrw6a4Oig==
X-Received: by 2002:a05:6a21:1a8:b0:1a7:5fbf:3774 with SMTP id le40-20020a056a2101a800b001a75fbf3774mr5708830pzb.55.1714594403848;
        Wed, 01 May 2024 13:13:23 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78142000000b006ed007b3596sm23070981pfn.69.2024.05.01.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:13:23 -0700 (PDT)
Date: Wed, 1 May 2024 13:13:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>, Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: Make FineIBT mode Kconfig selectable
Message-ID: <202405011307.2C8E9BE5E@keescook>
References: <20240501000218.work.998-kees@kernel.org>
 <20240501163314.GA2472577@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501163314.GA2472577@dev-arch.thelio-3990X>

On Wed, May 01, 2024 at 09:33:14AM -0700, Nathan Chancellor wrote:
> On Tue, Apr 30, 2024 at 05:02:22PM -0700, Kees Cook wrote:
> > Since FineIBT performs checking at the destination, it is weaker against
> > attacks that can construct arbitrary executable memory contents. As such,
> > some system builders want to run with FineIBT disabled by default. Allow
> > the "cfi=kcfi" boot param mode to be selectable through Kconfig via the
> > newly introduced CONFIG_CFI_AUTO_DEFAULT.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I verified that flipping the configuration does indeed change the
> default and that 'cfi=' could still be used to override whatever choice
> was made at compile time. This patch was a perfect excuse to put my new
> CET enabled test machine to work.

Heh, yeah. I have my one lonely CET system that is only powered on for
this sort of testing too. ;)

> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

> CFI_DEFAULT_AUTO reads a little bit better to me personally but I am not
> looking to get into painting today :)

I went with CFI_AUTO_DEFAULT since this seems to be our current pattern
for setting these kinds of boot param defaults. A selection of examples:

arch/Kconfig:config RANDOMIZE_KSTACK_OFFSET_DEFAULT
lib/Kconfig.debug:config CONSOLE_LOGLEVEL_DEFAULT
mm/Kconfig.debug:config DEBUG_PAGEALLOC_ENABLE_DEFAULT

-- 
Kees Cook
