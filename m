Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D721E529
	for <linux-hardening@vger.kernel.org>; Sat,  7 Dec 2024 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603491; cv=none; b=g3Sp4h38yyWGKMqbNSSTyU+/2pLNBRJ+B211fJ1BnW/RzIgl0yRO3kNfagylXaU4nNQ1cquBxgv4NDtPtAdaLLC1p/46tLmYN5b8TwbPAAudttrz81Vm40iAbgJ4xX3mTzZEJTWvTDX9sgS6wMEPLJVoGzncqT9GUUTauSo/j6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603491; c=relaxed/simple;
	bh=ct+vM4e0Jtr5aDgyp/mMMW/kc2rgYH8fWmf1syFBJE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOAWJIXrvz2qwCDXCpSz5BQh63IDsPwP2m9S7sAU7gda7TOtjE4VVjZaSJtogiNmQORhXsM4169vn3pIHSFCz9slq8SytcueFHUL3SACA4i2g0kwZacQuhTlPNW8xaY0GLK/QgrMvnLlhy7fAoAZzSYD6ffThT6GtARNCO2nh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h/Y3fuZV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h/Y3fuZV"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa62f1d2b21so403974866b.1
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733603486; x=1734208286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ms7Dj4PhpQjQO3I96MAeIgwapri0gFHpEAP0IFi7Ea0=;
        b=h/Y3fuZVKNNhmx4D/LkvbQavy/e58VZaHuZ1IgOsjF0n7A57flpgIa4pyWKLMYx012
         CHaP7T5jEnqJazSzYzhwg+d8Mk0bXhn91SEnkdHxCE6462mkftISmT9kLMoK0yjPda1h
         Olqh4I8kI0IaPi92v7QTx0jY+wZRCdX5CEwLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733603486; x=1734208286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ms7Dj4PhpQjQO3I96MAeIgwapri0gFHpEAP0IFi7Ea0=;
        b=tg+p3egFRko6/hD/ZQYRT3BebhX2gjTaVfdQMKvwPJjsna1O4lg1GbPgI0dY6Cql7Y
         LQvgNlFW7S4yX714BNXm8/XgACM5n7pb8xI7jsFVKCi4Qrdgt+suR7EFkof65Guxwizh
         9u5tkvRJXljU0xFGe7Pm4z6zOIFl/+GkHQYFxRcqmdDC5EIA9zLxX3HmyUfVit/pkSw+
         vIQy8MjIIUHsHxv9wNifIbAc1wgMCE1TW7HzF5yU4U/RWThSiApPB3pYyqpkl5/q0izl
         fRRkGNDfl/PoHmwTqlEuo7wqANdJbQEl7U9BAerwtySlZepZQKdPu7mhQ0tgrHvva/65
         yDgw==
X-Forwarded-Encrypted: i=1; AJvYcCUaEkXBfIYJe8PaEQB+JzomV0MJtMsrC9uH7yCwd8K7j2u918/uYPYCrCCsZMIi9AVFsz8BmfXdx4tjr+z7fy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIIMOd1P0p1v4FbhjeaYvJVvzRPa1L8lGi4ALSZByuvarDEHP
	IfzHWndkbi0xv/9+62Ohn5PlcOAiJ5BnUl5mmcE0zXi+l7FwXhEtXGF7b+pqImYXrD7Q07Jnwj6
	RdDK58A==
X-Gm-Gg: ASbGncs7JE/50RwmgP+TISx+QTlndfBpR3FaTVFGQTdYWSwJT5IDUtnW/zzVrFEqe3w
	1Du51mGUt0eBsxC+xkGWUVIJE19U8hzVwwnm+hkkH87CRz+6GmIygiPu2n8ZkCSrP6LXCFlB2Mz
	VfMgGnBZGXl9/9eMFdMdpzwMI2DLvTFp0nnH4sYEtwsnH7JfgbdSBCEmpRAoIYTySovFhC2rt8b
	XUFUwOBFVvbeT81XHt6ONwJqlgMSI0cR+F+qCtSvATdiYapJHXL9SXq4CP3nZlGu8ZWOBers5Gh
	/jPYw/+2t5nd0O5+JLjwAqzv
X-Google-Smtp-Source: AGHT+IEjkPe6qEXrFtbeHaRAOQzEXPdfGjNG+yNT5g3ngYMK/dJ0DKQJyHVPDGr2ofXJyygVwv/n/Q==
X-Received: by 2002:a17:906:9d2:b0:aa6:4a5b:b72c with SMTP id a640c23a62f3a-aa64a5bb770mr291145766b.50.1733603486477;
        Sat, 07 Dec 2024 12:31:26 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa653d1df95sm120893866b.98.2024.12.07.12.31.26
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 12:31:26 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5500f7a75so439517466b.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 12:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmNPYiXXiOD8GjtE7a/kjJUY4QGwzLn1JxH3zqQazNNO35QYIv0/rLvZ0dSlAWPCu+MqX3BDS6SI8NVhmclvk=@vger.kernel.org
X-Received: by 2002:a17:906:328b:b0:aa6:326a:bcb9 with SMTP id
 a640c23a62f3a-aa63a10fe42mr541173966b.33.1733603485779; Sat, 07 Dec 2024
 12:31:25 -0800 (PST)
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
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
 <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com> <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
 <0f5c07b827c3468c8fa3928a93a98bfa@AcuMS.aculab.com> <e806dd51b1ac4e289131297fbf30fc37@AcuMS.aculab.com>
 <CAMZ6RqLOR3aCRW_js2agV+VFiHdazb4S2+NdT5G4=WbDKNB8bA@mail.gmail.com>
 <b1ff4a65594a4d39b2e9b8b44770214e@AcuMS.aculab.com> <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
 <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com> <6b8c9b942ba6e85a3f1e4eef65a9916333502881.camel@gwdg.de>
In-Reply-To: <6b8c9b942ba6e85a3f1e4eef65a9916333502881.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 12:31:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzFAaksqMdYeYC=T82tny1HnGGcYu_xJTXZF1OZwVziQ@mail.gmail.com>
Message-ID: <CAHk-=whzFAaksqMdYeYC=T82tny1HnGGcYu_xJTXZF1OZwVziQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>, David Laight <David.Laight@aculab.com>, 
	"w@1wt.eu" <w@1wt.eu>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 11:51, Martin Uecker <muecker@gwdg.de> wrote:
>
> Am Samstag, dem 07.12.2024 um 10:19 -0800 schrieb Linus Torvalds:
> >
> > If there is one feature of C I would have liked it is "allow inline
> > functions and statement expressions with constant arguments as
> > constant expressions".
>
> There exist proposals along those lines for C2Y.
>
> From a more near-term solution, I wonder if making it possible (or
> easier) to return integer constant expressions from statement
> expressions and allowing a restricted form of statement expressions
> at file scope would help?

Even a more limited form of this would have been useful several times,
but as mentioned, the problem tends to be that we end up supporting
compilers for many years.

So then we end up having to work with older compilers without that
feature, and can't actually clean stuff up until many years after the
fact.

We're currently still accepting gcc-5.1 as a compiler, although it's
time to look at that and probably (judging by what stable distros use)
upgrade to something like gcc-8.1 as the minimum supported compiler
version.

            Linus
