Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED4135A75
	for <linux-hardening@vger.kernel.org>; Thu,  7 Mar 2024 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838650; cv=none; b=WKTAnmJzfrOKk+Z/VbUd8wIM8If7WWAWXhQDsNunM/Jz2pi7piECgXoTW0kqFzNhbzy2UL3Af3D1v0smdSpixJEtT4yebYWbWz5I92c4/F2izcphCHnVsPfk6L5F2781V9j3t4LDbB+x44lITlwkiMwWeIXoxdpyDgI92MLtepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838650; c=relaxed/simple;
	bh=izSH/PMxUOlhLqiqWhtGUMGagmQW6jaoeudrrfnJ9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti22Y3pPQYbJ1p2rUdU1q0zRwp7u0kmK7jElfPmaJ3vfRMpslM0//MsG0FOF4cMxQfNKlQ3C2he5bE+M3DkIxwctC0urP1goei8wZ1WE/c/rt81EEO30ylOs8jg8j96c9wZ+oaivKoWtWaFia3lCrJPIEWzv3i9gAWLLU1DyEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KGGKnv/8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGGKnv/8"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so975816b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 Mar 2024 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709838648; x=1710443448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6/jADR/0UePn6YUf/L4DAbrCMU1cm50ZPRMKWLUirY=;
        b=KGGKnv/8YuctKrGXVQXW8dxWq8ftiGlZx51D84ZxcYEX42nz27+TWRx9Uh8mpm2tVH
         fnEjkQ28SUetzzWjr0Ouk1OG2F1J30fVbfy4gBafrf+QqGuTb++PJFj/cb6huPtBqXtu
         +h8BGP8cL6aEqg0eZlsINgnPvumAdxMCYiE4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838648; x=1710443448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6/jADR/0UePn6YUf/L4DAbrCMU1cm50ZPRMKWLUirY=;
        b=uF2VpR6m9+l4OZaZ6d9TBLFlroJYtfexcqMlWGhBOWULkPwSjZafBRLETdEEIos9K7
         /JK5+DmeUk5dyMdUs3HbuLgirhAJncsx6q0csn34bybzyvaoOqRrXa9YVTjCa3ftK+py
         ID5PRVrLSbcC2+vLBRVIhyC9ddfjEpjRUnzWvMiMGF2fKNGdOspQmHKmEfJ7bme+g2dA
         mZ5IfP4xYRml/MRr7VIIUoNBpmIFBmoF6ryht3z9vih5HqgEoJTu9j+KitYxHGFarUgH
         sbAzTWU1yCknsckKYpCupg0pb8Kr4Y1CypWyPLoCD9EM2FmnSeT0n21NBQSWbdrnLEWA
         uiKg==
X-Forwarded-Encrypted: i=1; AJvYcCWA1qQAKgXEI8967H9IBre5eRu7U4KdIsImVWaULvI4dHiyl3WENNJwBrtKqpm4Z8RzfvpwG84sRwaPgnrXsOxBEMyQQ+tyQhMkBtfLmsy/
X-Gm-Message-State: AOJu0YwL196Amdnr9lzmeudH7EDl2zMVlp6Ny/jmJLsLu5BAKhvzYMCz
	ByEvxUZILRkTkqiTGFFBKlODE8JJ9De2kIZJoZEM+nsNDyf25TlzmS7A9mqyD8jyw9gRy7DKUTY
	=
X-Google-Smtp-Source: AGHT+IFN6Sz1G8Qiw0tjzpneM1RD2JAmKvXtZLyGSb+PlWyD/N9lVUXVr/U3iktkEiuQ0N39CeDwsA==
X-Received: by 2002:a05:6a20:5498:b0:1a1:6914:6bc0 with SMTP id i24-20020a056a20549800b001a169146bc0mr3186404pzk.5.1709838648372;
        Thu, 07 Mar 2024 11:10:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r11-20020a63ec4b000000b005d880b41598sm12872052pgj.94.2024.03.07.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:10:47 -0800 (PST)
Date: Thu, 7 Mar 2024 11:10:47 -0800
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
Message-ID: <202403071105.C3B038C@keescook>
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
> For the strength, we have at least four options:
> 
> - strong rng, most expensive
> - your new prng, less strong but somewhat cheaper and/or more
>   predictable overhead
> - cycle counter, cheap but probably even less strong,
>   needs architecture code.

Are the low bits of a cycler counter really less safe than a
deterministic pRNG?

> - no rng, no overhead and no protection.

For the pRNG, why not just add a reseed timer or something that'll
happen outside the syscall window, if that's the concern about reseeding
delay? (In which case, why not continue to use the strong rng?)

-- 
Kees Cook
