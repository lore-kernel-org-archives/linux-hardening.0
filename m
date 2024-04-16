Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536D185E
	for <linux-hardening@vger.kernel.org>; Tue, 16 Apr 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228391; cv=none; b=JGs2bmrz4vSBierjgayVtShp/gVb7mUXn/2jsyE2DeakUKrM+U360ZATAZtcOROB022/WyqTTVYwfqs7Z2zTaGdZbhBqcNCvJEWH8MGaZxPiMqkChTTu+kf5on3vEa84yb1N1rUJ3HcJARlwg6f1DE9PBTbASLBIrz6Jl4OkqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228391; c=relaxed/simple;
	bh=015eEwhLzWafHkc0BsCRogWYfs3SqoEKVTXAAy/Fhf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DruyvkaX1L94L/qxE3IZFLq1Crs4yQzFxfYDlRs90TqVIZoGZ10Al6vSD24XGfDRuEhqLSVk7S0sggGjwqi3ribXgjMNWwnwo/XN09f5eJvrAE9V492ea0RZBoFz+T8658OMriwmVc55xJ8pWFn9fykwIfs2xF5pON4lKkI0LJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0gwi6j9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0gwi6j9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e424bd30fbso29862225ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713228388; x=1713833188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SarbV9gzd7Ext5uREk+cO+VjFEa4L7Rs/CELnpCJsv8=;
        b=P0gwi6j9oLI/Dwi5h7eAZTZi3aI00LBxvktANtbgHKKzHAFmz68iLfOWl05rx1bfUA
         ldfTKzej5CEwBxGW74Sf6f2U2kl01+mMPBmpYzmOQhl9oYWn35vpzvak3m1jaTylVs+c
         Ceq5Habm015Kj15goXxJKgXLhBfEglQax9Wl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713228388; x=1713833188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SarbV9gzd7Ext5uREk+cO+VjFEa4L7Rs/CELnpCJsv8=;
        b=RRsOqvqTYeU2zYWXsLVJGos/ffbG18Gu5u54h7lFnU5qBGRuBZjzsSs9OEr2SS/Xep
         qY14ADgl91epHiXuKnz727elhw2IZgqX0Qt+Gl4lkIM9kltorwmlZsJoSaMe9vCnte/h
         sA8CSYBo21UJcBky/yYuqCTgZZ6i7cLeuylUkZFaEmWQH4/2ovkBfKOpKKl9ISz9tReP
         d4kv7pTaq3sHvmQhCTXJrh9sSQUFAJqjOY+jnblBBdRO1U0GCw5OtPbmgu5pldb10c7J
         96CQcjOe6P0ybW5v4LSV0MBRsDSf2EQsssKuJrMVv97pOM4Ia9wq99fxh+6FPvGD0m3E
         /lhA==
X-Forwarded-Encrypted: i=1; AJvYcCU0eQ99jQN6dT1iNS+ob3nKZMqOwnPq8VncKT185TlD9J3cSXM1TBg/4ituIky/7qHzfiaiM/Mu5KAvEeEJNNxwacoCx2sWw+Pps6M2O07S
X-Gm-Message-State: AOJu0YzyNnRpBcvrryPl9k3n6e05QxQ3ccNsT47AtySVqdq3ISFeMuWe
	PjvrUlfVfJ6K608R4ejvqUHHVnt6zbXGUJWWBjlVI9ZO2q1y1xerXSfWsKU1/Q==
X-Google-Smtp-Source: AGHT+IHX1mELGRta6OeQsH8t8lp3e5H1mp/8L3cNAf/ZlRUnfUwX1Jl3r6/rRS9SAEK7dC+5kIawkw==
X-Received: by 2002:a17:902:82c4:b0:1e4:b4f5:5cfa with SMTP id u4-20020a17090282c400b001e4b4f55cfamr11411241plz.27.1713228388653;
        Mon, 15 Apr 2024 17:46:28 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001e3d2314f4bsm8688355plb.132.2024.04.15.17.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 17:46:28 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:46:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marco Elver <elver@google.com>, Justin Stitt <justinstitt@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ubsan: Add awareness of signed integer overflow traps
Message-ID: <202404151738.AC6F6C210@keescook>
References: <20240415182832.work.932-kees@kernel.org>
 <20240415183454.GB1011455@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415183454.GB1011455@dev-arch.thelio-3990X>

On Mon, Apr 15, 2024 at 11:34:54AM -0700, Nathan Chancellor wrote:
> On Mon, Apr 15, 2024 at 11:28:35AM -0700, Kees Cook wrote:
> > On arm64, UBSAN traps can be decoded from the trap instruction. Add the
> > add, sub, and mul overflow trap codes now that CONFIG_UBSAN_SIGNED_WRAP
> > exists. Seen under clang 19:
> > 
> >   Internal error: UBSAN: unrecognized failure code: 00000000f2005515 [#1] PREEMPT SMP
> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/lkml/20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org
> > Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> As I mentioned, CONFIG_UBSAN_SIGNED_INTEGER_WRAP needs to be
> CONFIG_UBSAN_SIGNED_WRAP. I applied this change with that fix up and the

Whoops; thanks!

> warning now becomes:
> 
>   Internal error: UBSAN: integer subtraction overflow: 00000000f2005515 [#1] PREEMPT SMP

Perfecto. :)

> So:
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks!

-- 
Kees Cook
