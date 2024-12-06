Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557AD1D89EC
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465699; cv=none; b=c2lKRP+p+05vwo9ubONTWhNtLIsr5b+PgeNCFP8c2kgKCgIFhEseaMKjMV6qdKtBPbTsWThTx5I15qvIsY2Pen7W8nHhSQCao6iaEYuJMPRPI/Q7zzvuUaKDZYYq3O2mKkmS1+3K4f5aENyb6futA1RbpHePWpfyqMT97f4tl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465699; c=relaxed/simple;
	bh=z6hEp8csz74EZNAx+MsdQ8oAglzBDLPIjblM5QboFag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT3o6GR8nyHWlRZET2DXVLsrKnLqDAeamdZch5pWWDf5AwHYFaDbTfzKeBq+N9VJghSBzvaqzFyVOGe51gShWeDn6MQHr+7gZXPElH8NZTUkL2E0vmUlKJkKg0O8N6zTCT68IVnfY1Q2FwYpHFTRQAzXmx24iEfbdqrZyUC1M4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iBe6nH2w; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iBe6nH2w"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d12709e1c1so2123638a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Dec 2024 22:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733465695; x=1734070495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkINBrTDhyE0tcSEzrQhWY00f3rEWU+OMRPtBhc6Jxo=;
        b=iBe6nH2w89cSp3aP2k3OYrT6xXL5JPt1el06Xg/9HqC+GTF9IqJdo5G/D9u99Qx5Jz
         0mdnk3MoLYl3wrM8xWsRx0FICd80XvU1okN+cYgRVY8Ef7ISWofNRSahiLM8gUkLODH2
         lwlseVwRPnD6l5sIXHhjyZFoB4/0BRNfIG7d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733465695; x=1734070495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkINBrTDhyE0tcSEzrQhWY00f3rEWU+OMRPtBhc6Jxo=;
        b=S4DIi7005FDVStkjZdlwwNLLrcnFp6WC8M9AH7cjA+/Zjq1NyoByHaY3Ber8lO6ZOR
         Rz1cKuIe144nen/HR2zZC1Oxw4tAu41uxfKd1WPraGzP2jHlipFBIdKwFdsgvea2tVZZ
         q0DFkg/Fn/ubdvzRyNHXXkSjF5zHKiKiFpxKUTl3wR6nHEah6L7mgVAG9gWN1YBYENxT
         qbdoQi0k7FcnXUBHkMC+gBM8y/+DNJRXTIj1vz2ybKvAHyZrSIiXQCYeF7Y70x3NQ8P+
         zqce7URZAE9pUkH05101wb9clclonjuM04b3O3zUJ54s7cLmp1EvDrN2fOdn6M/sUDHJ
         xZIw==
X-Forwarded-Encrypted: i=1; AJvYcCU8R2e0O2zUvlWCvJMcQqpG3haZRebILmPfT/ZJg1Tf7wqihEAGXJqnT6Yqm5T6N0Yh6eGIU7nOHdZF6fbLaj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JTLx3frxfVeFpoQJE+NPIPOQ/XwyxNNWe7Eu2jZmeaPXcUoE
	miRnIyJPar+YjXmlcmkXWDPvonJdymvXQPv/G7C0kztNgja68uoQRcJUeIUFTbLKFmBSAZdkEN+
	jAHWf0w==
X-Gm-Gg: ASbGnctbQd4cABdhRKZTNSSnsvnxIswTeswDXpTaUCsNvVnNwv1B1i89/01b1R2wuOq
	+bTKms3gLoqvE8okuSOsOQHJEf8IBNjasPkYtB1J++BSUp9Diugxyur2ViCnSUOffIXChXaEIxm
	jx/QFAP8/gkAQJ3fYdi4CXLj6UPux53kQ37waVrDD6F6EtYp9q3TnyNUSlpFfMrqdg1QpX50SZ1
	1hmf/5MLXXbanhogqQ9UjcbOfq9STOHkibU4w6qpytyIByb85N5ZGFQgGf6+8O2F8c/G3Kbi4Gb
	Dm6goVv1A0TsZIHyUPHLb95B
X-Google-Smtp-Source: AGHT+IH3uQnYSeppY1pGRGVU3afoWjRS83aWvEIiy10djYqYzN2IyT+BWWSfgIiyB0s4ciefyRRpSQ==
X-Received: by 2002:a17:906:32c4:b0:aa6:24a3:aa39 with SMTP id a640c23a62f3a-aa63a080233mr132814766b.28.1733465695427;
        Thu, 05 Dec 2024 22:14:55 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5d2sm190269366b.93.2024.12.05.22.14.52
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 22:14:52 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9e44654ae3so267582066b.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Dec 2024 22:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9T+PwYW6jXQkWYfTMyk+/PZSx5ELH7ZYkaW12UjRyX5aJVhTJibMcbLyUXmSJDIrZiRezSBg6x+Ihjx4iTdg=@vger.kernel.org
X-Received: by 2002:a17:906:1db1:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aa63de7f394mr66959966b.37.1733465692215; Thu, 05 Dec 2024
 22:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
In-Reply-To: <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 22:14:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
Message-ID: <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Martin Uecker <muecker@gwdg.de>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 18:26, David Laight <David.Laight@aculab.com> wrote:
>
> From: Vincent Mailhol
> > ACK. Would adding a suggested--by Linus tag solve your concern?

I'm genberally the one person who doesn't need any more credit ;)

> I actually suspect the first patches to change __is_constexpr() to
> use _Generic were from myself.

Yes. And David was also I think the one who suggested something else
than "!!" originally too.

I may have liked "!!" for being very idiomatic and traditional C, but
there were those pesky compilers that warn about "integer in bool
context" or whatever the annoying warning was when then doing the
"multiply by zero" to turn a constant expression into a constant zero
expression.

So that

  #define is_const(x) __is_const_zero(0 * (x))

causes issues when 'x' is not an integer expression (think
"is_const(NULL)" or "is_const(1 == 2)".

Side note: I think "(x) == 0" will make sparse unhappy when 'x' is a
pointer, because it results that horrid "use integer zero as NULL
without a cast" thing when the plain zero gets implicitly cast to a
pointer. Which is a really nasty and broken C pattern and should never
have been silent.

I think David suggested using ((x)?0:0) at some point. Silly
nonsensical and complex expression, but maybe that finally gets rid of
all the warnings:

     #define is_const(x) __is_const_zero((x)?0:0)

might work regardless of the type of 'x'.

Or does that trigger some odd case too?

            Linus
