Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B071957F8
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511175; cv=none; b=tq4R6S96ZvbobQCivkqM0AK4JFX/s83twOViOp+G/Se/VKu241rcyP10qEToV79LarE+WBvcLM67KJVSefQq623MBQY66AEnE2SR8kmRxtLr8caZf09Ecj+0YCfsmCnX9gHJJkhn685CqQwITXnHQ0uC9jTPdfb6+WcGDeQ67po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511175; c=relaxed/simple;
	bh=uWEIYj04jJcQVEnaMjzH0epqUyK8EmgQnn9LnSnYd+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPi4hYRJgo+QXrmDC+22cG+IpSRmbFSXxf7FRkACli/xCQdn957zs+hf24Bc/iQa9pKWhTgwVkVVitzNPH5UKJXPT8ko6Hg0KJb8uVyJL4yTVA+ZMgxgB9SXy9pRIq2UYXoj5otJwEc6R43JXN9L5PpONonRcUcJvxIF/DZzPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KE2O9AAo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KE2O9AAo"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa55da18f89so325349166b.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 10:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733511171; x=1734115971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGtbOaTCTsAvyUDr9a4PNqlmY0QlpNlNkPLsZ0+zYxc=;
        b=KE2O9AAonaJvTfQUit8WZXOeNBfbp5aVvkFV0z49ryRXmKIQ1zZl/WIeLUJIUpKifG
         ptxJ/93OWVnJ09B6jiynRIo43dpr35kMQF3AVw4zi3P8gTK+O9oLgR/60qpV/beCbTnb
         BgZhx7FqDekXz5Y7IIOg/dLpwHVXcUD82HVIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511171; x=1734115971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGtbOaTCTsAvyUDr9a4PNqlmY0QlpNlNkPLsZ0+zYxc=;
        b=UWihft8xRH50Xrcy7pjDC2W0EFO5aFPY7HD3pexqmoPnv1AM4XMhwHpMNjI7shoJrX
         5fLT0e3xUDvgdkeO8WMjuEcJohZQVhYfbq97YIjiiPClMmbk1e5u5j44XlR8nm1h0L7m
         ytGZKtNL9A3Y+mbus9WWCAyKxpMtTn3L1VeC4+Uh49uks8pSsWKxtlOfJRjGArW+Hx7p
         mCDQf2+OfFxu9RLlF4Q/x6a13SVGPJqWgDUSpOTs2Fn/0ApmHk3OtOqF0s9rdHdjmXpc
         3pbEN/WrTuiSaUxqGKwubwniNdXTxfc+42eM1OAhdbadwK4iqBUee13J1Z4gvd51RobS
         Dhew==
X-Forwarded-Encrypted: i=1; AJvYcCUyBeGvnVf0yjHc5EpXrEYmUWuqA6CXeUAUEOhmYWq925j3NMv88zdeWkRiTB8iZ6/WKYcKKGoSHsepsozfLE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlwLEDVhChSy4dZCNPMKWI6XxxWFt/lkngt95lv20Z6qmzbeS
	FBWgttYx7Kd7t4lerIyjCLaD7mXNYxT8+lmmBDdwdu5i8p94yCAwtkjM3nYxH3VG8nT1KCC1JZy
	xp8rr2Q==
X-Gm-Gg: ASbGncsqonXKiMmcMvDUX0SrHZ4fof5YfiBC/YmIGqR9eIKysNVG/s4VqgjqKLN8Hhn
	mM3doxYO7saswRwdz96cAdFc5p5/mzj/LnXRngsuivdETvAF23LlC5EOX5Lr6miEzPuTn+P411e
	p8bSlfGi4otLteorFnjWzv3PST2pFR0yfA4g2shKcsK0VFw/EIME7GZKJsISvou5LPPBk7CaPl8
	+utdoOJshr5UUYSVE5PcHYxlh2PRB/TpsjL85+STuwrn7VYZZTHHatPaVXecZvqDa3m1Sre1QbU
	GxQO0a6dWRYcDZE71Q51vly+
X-Google-Smtp-Source: AGHT+IFj5WJOCSdJNHMAsoAiNZoyMc024ck5QXLVCkEYt+AzD6IYgILgvs941elSO8T7H8mSecSyQg==
X-Received: by 2002:a17:906:5a5e:b0:aa6:3c7c:eb6c with SMTP id a640c23a62f3a-aa63c7d80d5mr257414266b.57.1733511171131;
        Fri, 06 Dec 2024 10:52:51 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e92fe3sm278454866b.51.2024.12.06.10.52.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 10:52:49 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa55da18f89so325345466b.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 10:52:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQuE7SKPIboPpPo5573KdF75pjHqa3yuGHodVnVFiP8t+cwhVjvqG5/yup89Q8nl/IAaxD5ttVln/jYiq+eXM=@vger.kernel.org
X-Received: by 2002:a17:906:1ba2:b0:aa5:451c:ce1e with SMTP id
 a640c23a62f3a-aa63a0aa48amr290776466b.32.1733511169269; Fri, 06 Dec 2024
 10:52:49 -0800 (PST)
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
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 10:52:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
Message-ID: <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
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

On Fri, 6 Dec 2024 at 10:31, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > causes issues when 'x' is not an integer expression (think
> > "is_const(NULL)" or "is_const(1 == 2)".
>
> But 1 == 2 already has an integer type as proven by:

Yeah, I was confused about exactly what triggers that odd
'-Wint-in-bool-context'.

It's not about some actual bool type, it's literally a random
collection of integer operations used with logical ops.

So it's things like "!(var<<2)" that generate that warning, because
some compiler person at some point went "maybe that left shift should
have been just a comparison instead '<'".

But it turns out that "(var <<2)?0:0" _also_ triggers that warning.

End result: I have *no* idea how to shut that crazy warning up for
this case, if we want to have some generic macro that says "is this
constant". Because it damn well is perfectly sane to ask "is (a << 3)
a constant expression".

How very annoying.

This may be a case of "we just need to disable that incorrect compiler
warning". Or does anybody see a workaround?

             Linus

              Linus
