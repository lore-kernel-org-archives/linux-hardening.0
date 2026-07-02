Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A433AD8B
	for <linux-hardening@vger.kernel.org>; Thu,  2 Jul 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006817; cv=pass; b=JXIUKM4/1oUmdlZVYiSZEuQi4N3WhNrvWDQHMPgQVQ3226VN+Mgzr7YWhST9MW4D4Yr2reZtM6V0al3DEFbINmpWZOmmO4eZ6l0/gSW/g5BE8TqgYbAaNI0eCd1XRjhOEaFQ25Bp4ekMUf2jS3lYSib5umJA94UbDsn+RAK1s3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006817; c=relaxed/simple;
	bh=iNinoTrCwBOfPghiG9xKszZ45U+jYGs9LkTKb4QIfns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyklJGYPuu/3l+bet7Fgjfl0lNJTyNKiFeZZuRxibDMF6GIez5bbMmNjRGcssxNFb9kdtO3oCKRJv76/uRZLsNYl1in14rZASRNuRHCwT6dX6emONFPriqhfTZGZ6XKiDfxMfcwkedjLEdW61sYtINfCCaEHgzFEfSaMQPWfHAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owyn69JM; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owyn69JM"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664b2c00e12so2779322d50.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 08:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783006815; cv=none;
        d=google.com; s=arc-20260327;
        b=qqzmW+F1OXTs5lhBSQJcdUBoStyMQhRe8keW9oeZzYS4ghqeG5UmC11NYS2Vw78uUQ
         zdkvXICILU+yc+dYQPg+nNAQtI7Susym/V74kdvt4HvNZRod2wGifPs3598TfReLC8uN
         Nt00h9uNjcX0DPbi8C/sQRaKRIuXO8k7ZDaWJkEv26OtVxSQkF1gnxGe28tJIMIb431E
         QAOE93pAy7296XMI32UMBXuT6XDj6qPl2hVnmthJP2rBjJa1AegtQmTop/ETSquio1FE
         StZW01nwF5224R8WfUR8cwKV2xYAPGzCVqa/wyauexKJglgTPbPQDt+ZFSZsPzx8UNPN
         RVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g09CPOiEjRdcq2MSHfeKmcvTW5xcwBZpYTF7uAPIEtE=;
        fh=4CjAh6fK4wXPx1q0d0/MpE06uhQfK/xMaWrD7ic3Zsc=;
        b=qOeAof+6+AelylnoGkmzsRmGAVjgkTMgrRr2UeWnC+MEjY4+pqI7BYpterWKmRFPyY
         SObKj/bzR8gSb9eE/oEHkFPYVW9oTjbjh/kmEKyO2MsDfZYCgLZH34yReA+RQ6Rd9M2n
         /5+E/YeN2b9kPB+uOYentEREe+VoBOgY+c2wwZk6dRWVAK/+/+ivNyO6DSMmwo/XecSj
         WMaX2UU9FHF+K4QJw+oaCanZjVtKSFSpLDp7KN39TwFWvSQ7r4AI2pkQn6fUcl49gZ5S
         A6MxdFz2QXeabym1jx9uMVcB8PRiOyAGhA66XEi6PBBHsl4vIjaehHyh7NMmFNLBgbwc
         ehyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783006815; x=1783611615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g09CPOiEjRdcq2MSHfeKmcvTW5xcwBZpYTF7uAPIEtE=;
        b=owyn69JMgWIe33F2L6G0dfmipYqoD2ITP9aY0nbn49UJHkmw0+8uxcRl+G6hMl0xSn
         SrURKwgF2cRUCAEcxRwbmJEFpuBQdRuI7B1C3ovB+XzjMv15tZjzZo44KBpz5C/R4mD7
         EE9Izrzs64TxyEdFdxJXxGjkEv6M1lGU4EGBKvuerQ3NQ2Qr2vP+szp8Gm1XwERcgHH4
         TWEx7Pikis+fg3bn9o8SD2ZQdRNTDXV1zxIlj0RvVcPzv8gBg9FxzsT0csWGr/T6smi0
         TJqBwNWIJdcTXLBH1tcRbUxXj7hVDpA7CLiWv3N49w7EVv8VslKwLIwOZkXEzKJcEV2+
         RBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783006815; x=1783611615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g09CPOiEjRdcq2MSHfeKmcvTW5xcwBZpYTF7uAPIEtE=;
        b=qTJm58LIBEM+4u4f+Z/vcp696Q0ABvOVno5nHXG/oVQnCmN6ej2Mrd7NIIkImbWFSz
         HdGm1N/jc6IGC+kOxqAAFSic1A2JJ2QkPVWffj9gJTDN4alad5JF1Pmp3jK86/OEmQsC
         bliPDPvykMWFNkeECXBopKn82SMyd0x9JWHJ3cRloAfegN4b3Nb3j8s855mYLxrwhnFt
         4mkR3k2hMVggEWP9SdDMv74NFP/uZH/Z1dePLVdtE59oQ6kdbJwM0eo6za/8Yg2Ls4d5
         /Ei1J0Jy7u0SECCXIJe9OnCzStF6daasNBEbc2KejZ87IBe5EXBQMFqJDcJkOgsBAuTX
         KQrg==
X-Forwarded-Encrypted: i=1; AHgh+RqS9rYt82SCVDM/GvVmH3zYXC7UepApVPgECqnrbx3ZKPNedlNOsPxw7j4zZxldaSzEmCol5XdIczIvrkEXzT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeMyMci4aQ6lFYhRLm3Uw0yFsuCf6U/9AzfuO1VFRaUr9Z12P
	yeEWQ7C5519XB5IbK1KJw/jGhX/b8WTkEr2hLktVSLwFA2+sh5BYqw8x/rvm4VN/87cdecAEcXG
	I+fRPwWhe0rhnNv0sCxypaywydhwXJf8=
X-Gm-Gg: AfdE7cm3QZAJz+ji/WebGQ6t12odhhq8IJrlH+SlKIofAbzdTByuOgEB642RiSs0QLs
	DUgq7qyGEOEvVa4CF1fJ2l66KSz8XEYgljocM0+Qa9qYELpbtmOdAMXlihyR/vvPisGIouiAd7D
	g13udHcRKxWFEE3TDJuUo3O8Tr+nQffEmG0RhHwtGmRCNcAL4S0JQXCSa67O3139Zb2ybQmTwo9
	bYhFeXkaBIHgGNSHXo9QCpjAwEwP9JDqnWdpZK4/FpqwYwlp2HRlZnvN0KPKib3cUfz0MuuaF+m
	sl3VeVyWFMje4uEzOZtXuKAVe7E=
X-Received: by 2002:a05:690e:dc8:b0:664:e8ac:21ce with SMTP id
 956f58d0204a3-665964e61ebmr5869169d50.24.1783006797047; Thu, 02 Jul 2026
 08:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619162113.416864-1-mertsftl@gmail.com> <20260702144917.GR2108533@google.com>
In-Reply-To: <20260702144917.GR2108533@google.com>
From: Mert Seftali <mertsftl@gmail.com>
Date: Thu, 2 Jul 2026 17:39:45 +0200
X-Gm-Features: AVVi8CdExbWLEvBCfGNhooVePIPil_ClyKDRJeEVzspcRHcseRGv_6iZ-6EaIdI
Message-ID: <CAA3NooqNH4Pu2EaiwOJOmDV5oQ9HNw1aAu_naXS75LL=EnmRzQ@mail.gmail.com>
Subject: Re: [PATCH] leds: pwm: Annotate leds[] with __counted_by()
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026, Lee Jones wrote:
> Nit, why not keep the variable names the same rather than use the for
> iterator?  i's and j's are usually for throw-away variables, but this is
> counting something real.
>
> Or if you wanted to be even smarter, why not just pass the priv->leds[n]
> that you want to operate on and increment num_leds here instead?
> Less args == more better.

Sure, that's tidier, i'll do both. Passing the led_pwm_data element in
means led_pwm_add doesn't need priv or the index anymore, so it drops to
(dev, led_data, led, fwnode). And bumping num_leds in the loop means it
doubles as the index, so the throw-away i goes away too.

will prepare v2, thanks for the review!

Mert
