Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA776031
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559764; cv=none; b=PtsEqiog0MzCvHkq7tc5GXZjYwfGcn8bMk/WdMX3K2Qj1sK3IziZh/IUETlg/zXz4THZ2QdMAm+sY5NpqwH0cocg7X4wWfCLpB/o1h+0iZcDUMaxffIcZvjLcrnyV+0iFPVaBkfVB952xxOrCKG5cKmhyWhb4vwNbwG/qEgtFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559764; c=relaxed/simple;
	bh=o/NbrqV2S97L+H13EY/x2OcLCIh6zJNlJHIhIlry7AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL/3TW7CfwwdV9v7lsLGUfdug/0Y9Ev3+GWZYQdCCfd/O4T729znRL2h5GupVW2xH9f9db7fYyec+M7Hc9hU1aCJKplY57ewQu/3W28H+9jADjGkg9ryitLzMcVnLhc/ratShxPbcFgbzksgUbOqIICcuseCNz9J91FgRahUxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l6n3sbA8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l6n3sbA8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2906855ac5fso1372868a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jan 2024 12:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706559761; x=1707164561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z42ayviXl00pFftEywfCdZI1FjhKV2PnUlVfJ3EkjmY=;
        b=l6n3sbA8UIfAPfLgTY/02EhFrd04r8IE4ZzFBTKec+N1FZFBcjJ4x4/q4wFUtJCItD
         a3Wf6gUMbrZJQhe1u7fEWHbMMfQuFeFxYXl9+u4GB7gQLPG/kf/a+/jy/ECMIXLLMC2g
         XriZkhjdu3eeTbRRrpgq/KcSgMK9dijIsXufg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706559761; x=1707164561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z42ayviXl00pFftEywfCdZI1FjhKV2PnUlVfJ3EkjmY=;
        b=Z+mb6k43+1PO2+mucUOlws3ktR0tgjTDSPTNBH7UDaOxYyWEAZZJklKOgU0d+cpcoB
         X1d8ZZoqf5bBlYQQAXZ5iNLldwdX3d/FGnvxBEu3zb2R5cmqLO5fh5JvaaJnHPz9g0ER
         KcpE7FyTwc20JaoOXeqGzzzpktcA9nmUCNFBUAZHyfImKT4Vl3NPcdbv6yRH+zwOfVuq
         KtfbbumBI8J2tZpe6l/PPH40KRRmNThqbA7TOjZYHhG6/MMTOwL+v9gnnjt0TEbE7zPm
         LqIg+CaPLT/28EMtw6nCTs334unvzzM2+Abto9eBlWAShJY5ms3spHdAEvA+huczSE+M
         kpcA==
X-Gm-Message-State: AOJu0Yw6AC+97ThmmYSyU02wZo98QQ547boVmUdq4N7Ta5dGgT3lPSar
	rTWjRM4a/PBIFMUUFVZs87XOASBLA4fpx6SAJtRiUVOT/IccCyBOVO/pyw1T5A==
X-Google-Smtp-Source: AGHT+IHKFFpzQdzMeVVxTYSKwO60dgMxA8EJGc7W4MEDm2qbbjGDlc81pU8+CdO3BRwKTHCRTbIyDw==
X-Received: by 2002:a17:90a:b013:b0:290:121a:c382 with SMTP id x19-20020a17090ab01300b00290121ac382mr2629214pjq.24.1706559761292;
        Mon, 29 Jan 2024 12:22:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a498f00b00291000d8210sm8568534pjh.19.2024.01.29.12.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:22:40 -0800 (PST)
Date: Mon, 29 Jan 2024 12:22:40 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Marco Elver <elver@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Fangrui Song <maskray@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/6] ubsan: Reintroduce signed and unsigned overflow
 sanitizers
Message-ID: <202401291221.99D8568D0@keescook>
References: <20240129175033.work.813-kees@kernel.org>
 <20240129180046.3774731-2-keescook@chromium.org>
 <20240129195418.hftkcdksptmpfv3i@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129195418.hftkcdksptmpfv3i@google.com>

On Mon, Jan 29, 2024 at 07:54:18PM +0000, Justin Stitt wrote:
> Hi,
> 
> On Mon, Jan 29, 2024 at 10:00:39AM -0800, Kees Cook wrote:
> > Effectively revert commit 6aaa31aeb9cf ("ubsan: remove overflow
> > checks"), to allow the kernel to be built with the "overflow"
> > sanitizers again. This gives developers a chance to experiment[1][2][3]
> > with the instrumentation again, while compilers adjust their sanitizers
> > to deal with the impact of -fno-strict-oveflow (i.e. moving from
> > "overflow" checking to "wrap-around" checking).
> >
> > Notably, the naming of the options is adjusted to use the name "WRAP"
> > instead of "OVERFLOW". In the strictest sense, arithmetic "overflow"
> > happens when a result exceeds the storage of the type, and is considered
> > by the C standard and compilers to be undefined behavior for signed
> > and pointer types (without -fno-strict-overflow). Unsigned arithmetic
> > overflow is defined as always wrapping around.
> >
> > Because the kernel is built with -fno-strict-overflow, signed and pointer
> > arithmetic is defined to always wrap around instead of "overflowing"
> > (which could either be elided due to being undefined behavior or would
> > wrap around, which led to very weird bugs in the kernel).
> >
> > So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
> > CONFIG_UBSAN_UNSIGNED_WRAP. Since the kernel has several places that
> > explicitly depend on wrap-around behavior (e.g. counters, atomics, crypto,
> > etc), also introduce the __signed_wrap and __unsigned_wrap function
> > attributes for annotating functions where wrapping is expected and should
> > not be instrumented. This will allow us to distinguish in the kernel
> > between intentional and unintentional cases of arithmetic wrap-around.
> >
> > Additionally keep these disabled under CONFIG_COMPILE_TEST for now.
> 
> This is present in the patch but perhaps its worth noting here that x86
> has trouble booting with the unsigned-integer-overflow sanitizer on.

Yeah, though this is fixed later in the series.

> 
> >
> > Link: https://github.com/KSPP/linux/issues/26 [1]
> > Link: https://github.com/KSPP/linux/issues/27 [2]
> > Link: https://github.com/KSPP/linux/issues/344 [3]
> > Cc: Justin Stitt <justinstitt@google.com>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> 
> This patch adheres to the language semantics as I understand them.
> Moreover, we would've had to send a patch similar to this once we land
> some better sanitizer + -fno-strict-oveflow support in the compilers.
> 
> Currently, though, -fsanitize=signed-integer-overflow instruments very
> little (if anything at all) due to compiler optimizations in conjunction
> with -fno-strict-oveflow. I am working on a new
> -fsanitize=signed-integer-wrap in Clang which will instrument more
> arithmetic even under -fno-strict-oveflow.

Agreed -- I'm mainly getting these back into the kernel so folks working
on this have a common base to work from.

> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks!

-Kees

-- 
Kees Cook
