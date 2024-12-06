Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE051FFC70
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512542; cv=none; b=dEYG6F1LzosB04pwDdew16XVmmMKJdlqphSQTfSzgFqGEVoPpmKeBaTB0dY9u8jK01a17LsIsgp9Q8MFBSX1fs1sn1eduRz2FGc3N+FifKtwdWjwX25poZZhAwWY+de2RB1wiVrkAG81brSOof3ejSTD/eWpk5jKqprNiemzW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512542; c=relaxed/simple;
	bh=i8VSKf3d9h7aPyCMroFIPs2BgVVC/quFiHlWg+y9lfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiJERHKNBhh5Op+Um+odP2KR6p1rzRhciDVjU/vO6BxRdm3jkBqA+YOvQPlJEu3ow56ZIc4Q7J4DPd+nfii7TB8gBRhDGvmpo6toLRIREeGBz5t9w1DyeEPx0/ui5FQ6Y6trMin021jO1RVACugd643AtLc9TVh4QsDvWwlFRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IaFOPHH7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IaFOPHH7"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa549d9dffdso346177766b.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733512538; x=1734117338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB1D/kV+LS+wbR3JFN0rKIWFlL1hHHNzi40qmGJ0Urw=;
        b=IaFOPHH7Q1qhR31U6jVDe9A8NG8N9GzRTGp1ew27wxOc8vvQbBlRcfInq7il1wu7zW
         jx0d6o83NkzaXTlvBusBom6UOMqVs51dsgbjsiz3YJLcUZEflmHn8xJ2DujiDe8QXSFf
         vZCGq1YA9Folqjlt7tDd1SxQ+ld2p6+6i+aa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512538; x=1734117338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB1D/kV+LS+wbR3JFN0rKIWFlL1hHHNzi40qmGJ0Urw=;
        b=CsPRiibRnIc/5iVoo3ITFP6A2S/l/G+9KaONW4q5IC/OAlGmNT3Puht3QQ+UfrP69b
         eTQD0uisFUaN+VWdZuBWr9qD57kKFX4p2J6MFn+ysP/dZ6vJJ7KL596iDPEvXxGL0N8O
         TQ+WAs/HSvs1n5JrDQ29Ot0tBfEAqsoF98zfOn6u/n9rYnZAK2QPTsGeMUzS1dwArx7K
         LscyZ/j3dUgpOgGNcEfaip2vgv8IO+CJLeofxxq2kzTzZy8O/dZoOrnCKlSeZX6z61ki
         1CAiUsFnWp/0vHiZkh5VsninzH1OhYYJaQa6S7qMIYTDjSh85PZxDL7f/DDIMftaOI3Q
         CmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw7jVzvJvCkiYI4y6JgBWzPd2Hq8GY69q8m2vmtbEsml8Rs+A97zkweHF/Dp5QQ2kDBu+ojB6CvBzV8JVuqqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0PAYeUSCcnzQoWb9HV+ISRmKIY3/LW9wtPBKIXzLBXwbwvQo
	/BuK6hwip+cnktgpnDQKSub3M/++LMP1b5uot8wRTmN6DxbywC8iwnHMC1riYGjzcpO4duw9hY6
	rY1rHCg==
X-Gm-Gg: ASbGncuJ0hC5uXNdwTKWJXAMEWYDIDZ9EHtdd05jXecsMGUrYxwwL6RcnI8dXE/Mluz
	0gqR6ZkhfAxOg8QLXkcvNGBHWtSzoxfDtDpH8OVN4Uh/H9DFwDaQXOQnzsRgv2w/joP6f8obl20
	AVLsUYZcuCpJZs8asFB9AAH86eRAEZA5Zh0eIqkSKcMlukEjmkMJm2lW+5SpgTc9aG2vkYgnu/Z
	9YvdDf7FljiQNdW+T3jMi/DhKLctRSoFiQGn2YCH5wY9B3H003WFntZs5K9+8yaFhmuAurzMkkq
	Ra17HMebmxCaNhlN/hTapfmw
X-Google-Smtp-Source: AGHT+IEQSJyd8NxwHAFPWaxTEOGuxN/cxDokWc3fkCaUMsyKVZnQVNQSGSYlM4sN6M/SZTlkp1Bzuw==
X-Received: by 2002:a17:907:3a0f:b0:aa5:cec:d504 with SMTP id a640c23a62f3a-aa63a08a537mr273143066b.30.1733512538228;
        Fri, 06 Dec 2024 11:15:38 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62602cf1dsm283621966b.129.2024.12.06.11.15.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:15:37 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so298794266b.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:15:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYzvdsClnvGGSybl2Tz+oNHmhcPNdgnvv5vAqgub3DYvGcxKOKZyK0Sn4wbJjPA/znIFs4/KmlnknYgEsd1PQ=@vger.kernel.org
X-Received: by 2002:a17:906:4c2:b0:aa5:308c:3489 with SMTP id
 a640c23a62f3a-aa63a2519b0mr271057466b.58.1733512537212; Fri, 06 Dec 2024
 11:15:37 -0800 (PST)
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
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com> <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
In-Reply-To: <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Dec 2024 11:15:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
Message-ID: <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <vincent.mailhol@gmail.com>, 
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
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 11:07, David Laight <David.Laight@aculab.com> wrote:
>
> I'm missing the compiler version and options to generate the error.

Just -Wall with most recent gcc versions seems to do it. At least I
can repro it with gcc-14.2.1 and something silly like this:

  $ cat t.c
  int fn(int a) { return (a<<2)?1:2; }
  $ gcc -Wall -S t.c
  t.c: In function =E2=80=98fn=E2=80=99:
  t.c:1:26: warning: =E2=80=98<<=E2=80=99 in boolean context, did you mean =
=E2=80=98<=E2=80=99?
[-Wint-in-bool-context]

> Does a '+ 0' help?  "(var << 2) + 0 ? 0 : 0"

Yeah, that actually works.

And "+0" is nice in that it should work in any context.

> #define const_NULL(x) _Generic(0 ? (x) : (char *)0, char *: 1, void *: 0)
> #define const_true(x) const_NULL((x) ? NULL : (void *)1L))
> #define const_expr(x) const_NULL((x) ? NULL : NULL))
> I send this morning.
> Needs 's/char/struct kjkjkjkjui/' applied.

Oh Christ. You really are taking this whole ugly to another level.

           Linus
