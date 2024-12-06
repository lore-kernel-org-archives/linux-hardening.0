Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB3154449
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511789; cv=none; b=ncL94sYePljzuwdZN/67nakZDBT+FLTDe3vfb+EphZj8e1Up+RLBOY7f1To7H74YGvqSt7Qrtz9cyixNNVOF8pSzda1y43Vb4WlD9w7xTuTG3WO4vml7I+Y38lhFysqKpK66mzy4sVYhvqKDYksEIXh/vnaR/KW+kmfCfoSKMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511789; c=relaxed/simple;
	bh=mpzJOBPMyEgZbeHSaWVVY8PUqVjZS+sd0oYWuGX6RdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwb//FZGNwGEvMMUj0bWieG//4N+DQ02HRkgGGFo9WlCG1df1vVEi90Btu9PwcZHJRjX4KupSamTVUSNcRurgIs3aUVerfd8sLWPkuqQJAaa6ydEyMkCuvF19Z5aE/EvyBKTKMi0aORrRwz4Z26k1BLpkLSnwlISp5fLAPXOSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KK4NNFt7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KK4NNFt7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa62f5cbcffso309925066b.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733511786; x=1734116586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CnspTgT+QlMaq72RnxBUxeYja+eFoihpXPIoDsPSZVk=;
        b=KK4NNFt79GbTK4phG/CizRQmxevV9ME8O7PjS7LF0s8PTU7KNabUbTlsrKRrREz4Sx
         nUOci3PzSNh0xk+aA0V1P6uUyUnarWiSzNO/0V3ML+4UpFudLP5pumddSM2KxWIyu3ig
         lTe+4D82S7vtpeUDyADhSMi9WT3jWkOujhpRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511786; x=1734116586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnspTgT+QlMaq72RnxBUxeYja+eFoihpXPIoDsPSZVk=;
        b=c2WMD+FxB6S+9PvO25mQNR6si273+7x26KamEC1kq1ZVDnpa9Vnfw0zJfVcXEB3qKh
         1Xo0vlfNH6LcpWLH2/CwXZ26kStv/HYL1uaZm7yaZxrcISx090ZyPerHDf7UmJBNbn2z
         MjPxfhzDTb/K77EyVc1OciKidx21zzfMZ261fh0gjhVREfkd8gPRCfw/n69Qb2tJpvzP
         k0IVzG7/qDwqXH39SKxm8A7VptC3At6POjurWazpMg98moUWmhzrtJfdPE98VbbFqa/e
         Rk4oxtYBhsaGe/kgrDbyjtLjUHKykwqDF7+3uL+db1i03ZtcYTuz2rD0++3jwiFrsfW/
         mPIg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ITFRwpNwOpvU3hKpVYfa2JE+hX8W3VJ/zAuM8Ks3cOs5XvQrXCgJfHwt8820L3qYgHt5n6L28MeiP6JkGwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3nq1eNXpZYeh1PEW+bC8VZEKWbD2VDStIvLpPzu+hcVayVau
	TqMBTxg2xIELa3AAqn9dBLQcilzQDO2Z+mvFzjFUwQztAubGNuE2K2BeAfJb+LHDnrbU0UfyCoe
	SSdkaVw==
X-Gm-Gg: ASbGncuPArvicmg6LGQTTmbyeXwivpzMJVsMD8lcLHYOPlGipMuaN/VVQfSMcrN6lMN
	MQ04+CQWxVyOthZjQMMN5mw3xZur+7sfaRyciVQ656e2GFTBazhbHv7DRi1xsByumPrBSGykHDC
	A4mi64di2PjMXnneOq340/YsZelMyKS9vpKiWoUBvytmjm++j6zesx0i9fGyrXGpgL3anrYHuBH
	GaXr4cnlSic9ZdA5COAZCN5OlPjpV/Ah9ejXSWExdMAUwd/lqZj3vheHYOuqIa7m8PwUl/bUTKh
	8rEa2WDSd/qJkQMxI+NkT81/
X-Google-Smtp-Source: AGHT+IHkMsgn1RzN5iTACkg0Je7Wwa+NOtRgEpAjqYvOOAE/F9s10iLrWrFWxvF0/ParRHE6tuvGCg==
X-Received: by 2002:a17:906:3ca9:b0:a9a:616c:459e with SMTP id a640c23a62f3a-aa637621b57mr407446966b.27.1733511785855;
        Fri, 06 Dec 2024 11:03:05 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dc5bsm280454266b.22.2024.12.06.11.03.04
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:03:04 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa55171d73cso651093666b.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:03:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/PDGzNwlxa6+tFCTVp02LHSIwULwJ1AZLlL8AyhNJS9mhrY+ql1QXkNNYksCT2TLrabXfmiKITcly2rhaWOE=@vger.kernel.org
X-Received: by 2002:a17:906:9c18:b0:a9e:b5d0:4714 with SMTP id
 a640c23a62f3a-aa6375f5cd6mr310802966b.21.1733511783880; Fri, 06 Dec 2024
 11:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com> <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 11:02:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk_thfjRnAYRoGX7LjJ8AyiPTmBqjJEPu6JiKDLG2isg@mail.gmail.com>
Message-ID: <CAHk-=wjk_thfjRnAYRoGX7LjJ8AyiPTmBqjJEPu6JiKDLG2isg@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, uecker@tugraz.at
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 10:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This may be a case of "we just need to disable that incorrect compiler
> warning". Or does anybody see a workaround?

Hmm. The "== 0" thing does work, but as mentioned, that causes (more
valid, imho) warnings with pointers.

And it's not necessarily require that a pointer expression actually be
marked as a constant, as for the fact that these macros often get used
in various arbitrary contexts where things *might* be pointers, even
if "not constant" is a perfectly fine answer.

We do actually consciously use __builtin_constant_p() on pointers.
It's very convenient for format strings in particular, where
__builtin_constant_p() is a good test for a constant string, which
sometimes gets treated differently.

And in fact, dealing with NULL pointers statically might be worth it
too, so I do think it's worth keeping in mind.

               Linus
