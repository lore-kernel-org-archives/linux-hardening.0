Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC314B96E
	for <linux-hardening@vger.kernel.org>; Sat,  7 Dec 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595954; cv=none; b=k3OFY5SeMr2cuXhkayBgKdOxMRIEgGeDG0D4xLuhYH9AWMh/gBZfZgHf4pYrsDy5aLcPgBLd+GpPMuDEIkBXatYhZ2eCQk1KwSJT4357Xsi+Au3fzpLbb6TEJL69PDEFy6kH/IxA3PU3wCJe/YO/t7SQBygCM9iqXRo9yCaZxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595954; c=relaxed/simple;
	bh=xXsYNQRaodrrqkXbZvBZDBxwyz9RKFl5ErY9YCsri3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pj/3BUVK5e/Zw1/cL13ZsnYu0hlEXUXo1xsMxLCbukXWT3bTt2hTxVkZTe9Iip0UInkHPBw0sRsX9nylJOA7XLC94WHlKPJ9VB6xh617DBUsh3l7iexfvC3kuqGTVFkPn9KMz/bplLAhUJUyju+wj/WN9FaJ5N7AIh7FCp1x4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fZXSK3R+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fZXSK3R+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so3748558a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 10:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733595950; x=1734200750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hz+XAesKzHzZKAdlmXfk5ETHyOV9LQeE1EOaQCTU32k=;
        b=fZXSK3R+1uHo5jTNj5sYY9gYYHnRUrIGFqdEQAZ2NnM6kArCFWaOfbo5IOScjydCWJ
         pfNyiENnUJEGA7xbBRaYMzVSbNGpbPGbEYJPgbPFQqrIIavpB0mErkMK22cZZJ8YY53s
         WeUvNji5qC9MyXcAyer2SX8xlrNBl5Knig4J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733595950; x=1734200750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz+XAesKzHzZKAdlmXfk5ETHyOV9LQeE1EOaQCTU32k=;
        b=cUoelJqwhU+DaCzk++giuUbeCw57pmP3LBimVaEPMg0YWKPz//r6Qf3NRZlg9upK7A
         fWG7oUWGslv5tXgBZYWz5dOke7QkGvmbV4L2Xu8O+9WdY5rsEpgCjuU8poOpJHQ6PAW3
         tkYWLuNW/rRQTOxl69fkQCczT5pueLJ2lZUxdP2jnen+KC9qSor9fVkVRZNoPxDEsSlb
         TzHbzhj4I8ZxFBiClobuABQh+BWawOSxeY2TsOIdYjtBW9WRZThi0nCb261QnbyUndY5
         QL4+8SD5OfA1WVv/vvHLSgbKEwESxSyq84FjTnWxgKE7rGiAVTG20FmqH3MxhmyOmknM
         MDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU62aL8AlSKh6OB7q+8tj4sRlNXV0IdVfb7fWhFdpzWIWlx5KOIEwqPyxsQRZhMyClN24lOU2mZsyNIuVwoRLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynt0P5uaHn98vpU0QYJoWkMbt60qo4OrP8stpfGgN9q+rCEZXR
	KGhE/S6KBHKtkL5EMwrm3ReMi+iXxWr4sOLG02CZ1kVfXBdOI39EhaeOFYvuY+7IwH2paiywY33
	X+4AyEA==
X-Gm-Gg: ASbGncs3TZFEpAubEMvUCPURNWLsFAmmdDZg887+HP+p9AnEgG+CHoEGYqAgwiWtqZX
	YRcPIWe4/F+3ER/oGc8GCIAnqZ2tm+Y9oVEW+xgiTYghhBKgI08K8Y2XTJyQE5QRYd22Scva/EG
	DdBK2yWC9YEs3E0578eMVI7k/sQtY2tYwewidQoQ1iRz0Kr0Zf6SP1jYWEdK0pIxeSOwrYNObou
	iprf58LaHEJ4iy2mfeFMD9sPUILsuRqedreUDi6R8M9qOydflxCiKHe+B579JAN7Nr/NK5eix5f
	gHx9Kvevxa41dM24zzkVArhb
X-Google-Smtp-Source: AGHT+IGyNQjKlhYjC8ED3f3myjOyY3SD/DvzUPLDJJDqPvY6INlnQIUhTZYlaMCLxT7ADqAYf8kezA==
X-Received: by 2002:a17:906:4c9:b0:aa6:2cc5:56b7 with SMTP id a640c23a62f3a-aa63a0acff8mr601546766b.33.1733595950129;
        Sat, 07 Dec 2024 10:25:50 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625ea38d0sm413597466b.73.2024.12.07.10.25.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 10:25:49 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434e8aa84f7so6190175e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 10:25:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdkLW5sRaxWZiEmXcaUtXcQXDO0FuOVSQ5FLxguhU4VfhaMFEZTIaE1wcJlT2Te0bJDMRh2ZLskAMqogCrRMo=@vger.kernel.org
X-Received: by 2002:a17:906:1db1:b0:aa6:3de7:f258 with SMTP id
 a640c23a62f3a-aa63de7f394mr497786166b.37.1733595590996; Sat, 07 Dec 2024
 10:19:50 -0800 (PST)
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
In-Reply-To: <CAMZ6RqJFReLJTd-O8s02oQNeB0SPQh3C-Mg+Nif5vMB9gFtQww@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 10:19:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com>
Message-ID: <CAHk-=wjpN4GWtnsWQ8XJvf=gBQ3UvBk512xK1S35=nGXA6yTiw@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, "w@1wt.eu" <w@1wt.eu>, 
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"uecker@tugraz.at" <uecker@tugraz.at>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 04:24, Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > No good - expands everything twice.
>
> And? __is_const_zero() does not evaluate its arguments, so no side effect:

No, the problem is literally the expansion.

Double expansion of these fundamental helpers gets exponential,
because they are used in various nested ways in other fundamental
helpers.

That's why we then spent so much effort on trying to clean up the
min/max macros, because a single line of code would expand to
literally tens of megabytes of horrific expansions.

And the problem with these things is that you can't make them inline
functions, so they have to be macros, and then you build up other
macros using them (like that "clamp()" macro), and it really gets
horrendous and affects the build time.

And yes, it is very sad. Particularly since a compiler would have a
really easy time with some nice helper builtins.

Of course, often the compiler *does* have helper builtins, but we
can't use them, because they aren't *quite* the right thing. Like that
"__builtin_constant_p()" not actually working for some situations
where we absolutely need not just a constant value, but a constant
_expression_ due to C parsing rules.

Quite a lot of the pain we tend to have with these things is directly
related to the fact that we often want to do these tests in contexts
like global array initializers etc.

If there is one feature of C I would have liked it is "allow inline
functions and statement expressions with constant arguments as
constant expressions". Other languages have done that, and it really
does help. And yes, it means that you have to basically have a
language interpreter in the compiler (you do want to allow loop
constructions etc), but it really is very useful.

Oh well. Even if compilers added that today, it would be years until
we could take advantage of it.

At one point I literally was thinking I'd do 'sparse' as a
pre-processor for kernel code, in order to have extended language
facilities like that.

            Linus
