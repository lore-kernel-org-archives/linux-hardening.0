Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D613440D
	for <linux-hardening@vger.kernel.org>; Thu,  7 Mar 2024 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838926; cv=none; b=eksaQ379lTZvwZupA7ZygGC10I01dgNIPsP1Uc1y4GBh/CdkKnY3rCMUCWgnPF7DmhzS2Kw/0MvrGmAVnYU+SLeLRR2wedCfjfiWAfkxnHMJ0fww+vNJDA3PSrS7hqm6WM4Yhwav0fT2Fr6C8LKGrY023bJyHcU7iUAydrpqOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838926; c=relaxed/simple;
	bh=iV+OYTSsiAzVIZf65NDnap/uKAr9OJdA2mFdEdjwGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy9zR2C/t7bxvAhWMXwLxYQS6/H4PLRPuwM98X6DEYvipj+W94eM8w8QtFx4EcHN28MJlfxW5Zdw97/+JAE2YovDKLbeEkCSEB6iKqo1OQCx2IJU/mUegVSdmhDUaoImimhqMnyjKCy3q98sVsi+Fx9/bJq4Evl3kiiZ4/RXQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dq+vSyWM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dq+vSyWM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc09556599so11540525ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 Mar 2024 11:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709838924; x=1710443724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adtXnm+UfFx0dkkz1N9cMCbOWjdrx1dY7LOvsQ2Ti4s=;
        b=dq+vSyWMx07f1I7q8OSlwaEyKVGWuMHhIUietyCQKCmhgA9gPbe0NuwOA1SqIGXMao
         fjnmh20hIoaHsJnUB/AIj/ElqPgvBmyb3VlceNRxEunMUv3YI708eYNm3DSUtdtQeKhZ
         bV9DV1gVQx6p5kNv699NwrAWIQ8JA5SBCvoD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838924; x=1710443724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adtXnm+UfFx0dkkz1N9cMCbOWjdrx1dY7LOvsQ2Ti4s=;
        b=njiMK9TvU9z8A1JHHl2PEx2H/PLsB2uukLuV/EHe/aECPYmW3KzqvhpLsA6Oo1Arvo
         b/DfvA6qOjJtO5cpORwmzwhkoifHMkEiJzJkqfH9dbEJG1WCVFtQu5An4TvQbGbLDr9b
         UQ2H/Srxg8MKdjgu4BBXnjQa7bnzFNQ8QXoyYwJlAfCl8/9JOygMSZtxNcNBN9YIPgp/
         mAfrXqeHU5uLgcuaM4EUqg6BMDThIdZoiJ0mmSYuxoMU0jEgS9B44rMcLOpFY2qIgbpT
         nnyYE/DorcjM6QieJnGQzvv2oGta+ljd7EGw43zlhbkST0MLPvapXaAJRIkwDxCp20mR
         Iz6g==
X-Forwarded-Encrypted: i=1; AJvYcCXcIl/EECV6okmZsvSW2mRfWuYUtTacG7j8AU7qgYI9D5wPf0DjFrkv8yGNK6sno7EwrClfk9uTHZb1cbPijhPQx8qEIb9PaYyHxgU30l44
X-Gm-Message-State: AOJu0YxoEL4n1HyBq3GD83YSvhcQMbd+ScrUEfxmTXHzY7uDqpTTk6OI
	kd0FxOGY7RgTXhPxEWfmGIkavhREcTjVeZo5ZLYIrIF2vPCpkqzefOogoZ36Jw==
X-Google-Smtp-Source: AGHT+IEfz0ZlLYkTZgYNEzshYOrsBM9a29I/dbatU4XBUS/LLZXPEPxmsUjxmgrOyECAYIyMWb6Mxg==
X-Received: by 2002:a17:902:6845:b0:1db:e78e:b38d with SMTP id f5-20020a170902684500b001dbe78eb38dmr8469823pln.18.1709838924636;
        Thu, 07 Mar 2024 11:15:24 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id li4-20020a170903294400b001d8f82c61cdsm15036341plb.231.2024.03.07.11.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:15:24 -0800 (PST)
Date: Thu, 7 Mar 2024 11:15:23 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>, Guo Hui <guohui@uniontech.com>,
	Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202403071112.01B4579@keescook>
References: <20240305221824.3300322-1-jeremy.linton@arm.com>
 <20240305221824.3300322-2-jeremy.linton@arm.com>
 <202403051526.0BE26F99E@keescook>
 <34351804-ad1d-498f-932a-c1844b78589f@app.fastmail.com>
 <38f9541b-dd88-4d49-af3b-bc7880a4e2f4@arm.com>
 <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dd15ce-69af-4315-8d7c-b7a480e541aa@app.fastmail.com>

On Thu, Mar 07, 2024 at 12:10:34PM +0100, Arnd Bergmann wrote:
> There is not even any attempt to use the most random bits of
> the cycle counter, as both the high 22 to 24 bits get masked
> out (to keep the wasted stack space small) and the low 3 or 4
> bits get ignored because of stack alignment. If there was
> any desire to make it more random, a trivial improvement
> would be:
> 
> +++ b/include/linux/randomize_kstack.h
> @@ -80,7 +80,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
>         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
>                                 &randomize_kstack_offset)) {            \
>                 u32 offset = raw_cpu_read(kstack_offset);               \
> -               offset ^= (rand);                                       \
> +               offset = ror32(offset, 5) & (rand);                     \

Shouldn't this stay ^ instead of & ?

>                 raw_cpu_write(kstack_offset, offset);                   \
>         }                                                               \
>  } while (0)

But yeah, we should likely make this change regardless.

> My impression is that is is already bordering on becoming
> a "bespoke rng" implementation that Jason was objecting to,
> so the current version is intentionally left weak in order
> to not even give the appearance of being a security relevant
> feature.

I don't think it's bad to make a trivial improvement to entropy diffusion.

-- 
Kees Cook
