Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC91487E9
	for <linux-hardening@vger.kernel.org>; Sat,  7 Dec 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733603335; cv=none; b=GSj087pkG74YTsyMd5heXX+ZnFzwNGSmapK54X2URhpOivBLJsLHnyCSMblVLoQiDPncVulDDJJkXsByUkD6jnSvLNh+UYwqhvLZGi14UeisQhykImXRI8GiwNCygEahEIwTsJkzm3nqoYBc/ueIszikYDdAJCNiXeugEamk01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733603335; c=relaxed/simple;
	bh=7mHyTv6r85AJbexntlqRENNWjYsWWzkVfT4oFafMmAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHPefWPpGQO81bm7vbdtta/g4zrWUNqZLR/bWvyrgvK2jBywDuUiZJzS6XV5D2zOHGypIiNcMk1aGZnnR6VfnkMHrKFn+nuCwxcIHz6vh2hpr61jOxm6+oKxR3icaJyG8ut7N7/waARqttBiAS3Lt8XDu6qjh5deozoO+RMegvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QdXVXDMp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QdXVXDMp"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ec267b879so604380166b.2
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 12:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733603332; x=1734208132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HiZTKf4hCKQ8GKQ+oAO9V4GLtbxeasgvzn3MVqs40sY=;
        b=QdXVXDMpVGnmG6En3ZUU8WZDW+TtkLwWEfbV+Aq/UeNxm6+muPXv1sghjFaSoMrBO4
         CxLzcuI1FArwZzoVQKmKhfkg8wSm+Y1QfDJKDhlm+egfjoREktfMpAvEMofj9Tkp/AXN
         ZrywYALFgQe3q+5HwplAu/dep1aUdaIHzK3Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733603332; x=1734208132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiZTKf4hCKQ8GKQ+oAO9V4GLtbxeasgvzn3MVqs40sY=;
        b=Crln2QeU6wY9iJVbhJEx6VxACdPm1f4qYg5y6JJq1TahZKaRqFm8zpkHVwLHrn39CR
         WcIHp0bi5fo2FSLcFACW3Y85vCTer+zmE0AC+V5PE3aRTJLst4O1oewoNiXjL+t6Yixx
         RJjGGJyt428ePtRUvB7texI/Rqm1ZTcGcBVtDpVr6DIU3p3jwz2j4zbBpziXeka6urr6
         pApE4XCLQw5VdCdlGRbcjaCvltZGv0t9btHGMtFWY31SVrvOlNx6wOP+/l7BKNgGYxDv
         HFha1JXYvZ9KxsEJGxUUsYYeoC7wZwUbBeN0S437kYrkLxbw0j8qAae1gTRdUjghPit5
         +2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8e7tY81ibZ6QagzHB4t9gZjsSMBjQCAKgkyYBFXCNfwbfhmhD4JFytv6IumS9dqIjeiqzoymkDioeGlXJOoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0x30gTZSZA6sTMUcF+wR6K5ZErIqw0aA9ifTSIizfb6tD4HtZ
	VlyoQCgTmDoO2xUdMYmQuyG5Da1v2dVt2Zwl5p154AU/PE1Wzd98ReSlORos4jOkK4/uckvq9ae
	GNLDeOw==
X-Gm-Gg: ASbGncspHnKjwJkF8/HGY87gWg6K86Nbts6c8Q+q2MS6+iChDUSoEyFf7BHm1TTS+s1
	QmnyJP7mYKiOqNLd04G6EXdcKeVDcLObyblFJZOEjnSs1DFcok+fazWy5PsnMMNO7qtC7d1HRrm
	uqCyHB4PF0H4bAEr+ku/PbPw/X1SafJ7xUdjsBOErmlbaMrGDzxD88yxOyHpsBcWqpnC5iaTk6/
	p9VKtsBTIzi7R4nJ68A53RtEEopvTccttb6xia+Ga+oE5ak1qP9DfAHY0czJA0Se0K5uSoDCM74
	UyLVM/y0jyUi3mCfl7vhr6ja
X-Google-Smtp-Source: AGHT+IFeqp/XCZWQtSfOcuSzcLoMx4hhrk2LeS2gbEINWWvIfPAD6HSJiacGy8a7uqlvC4n4UDijpw==
X-Received: by 2002:a17:907:7847:b0:aa5:cac:9571 with SMTP id a640c23a62f3a-aa63a07fce7mr684963666b.28.1733603331706;
        Sat, 07 Dec 2024 12:28:51 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dbfesm427420066b.6.2024.12.07.12.28.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 12:28:49 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa66ead88b3so50937766b.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 12:28:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVj6lGdruivq/LXFuFq5pOfucWuJxNPIKIsYVdWrNNVogNCcfQS0Qrz2n3wTkDxIw7U0Wpe1GdULtIXAlt5KqA=@vger.kernel.org
X-Received: by 2002:a17:906:5a52:b0:aa5:3853:553d with SMTP id
 a640c23a62f3a-aa63a21b715mr608706066b.46.1733603329136; Sat, 07 Dec 2024
 12:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com> <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com> <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de> <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de> <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
 <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de>
In-Reply-To: <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 12:28:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
Message-ID: <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of __is_constexpr()
To: Martin Uecker <muecker@gwdg.de>
Cc: David Laight <David.Laight@aculab.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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

On Sat, 7 Dec 2024 at 11:19, Martin Uecker <muecker@gwdg.de> wrote:
>
> But that all seem solvable issues on the compiler side.

You know, there was a whole *architecture* that was designed and
predicated on "it's all solvable on the compiler side".

That architecture was pure and utter *shit*.

Because no, it's not solvable on the compiler side.

Getting things like value range analysis right on the compiler side is
fundamentally hard.

It's hard to the point where either you only get it for the simple
cases - yes, I can show you a ton of real code where it's trivial - or
you need to have explicit markings in the source code to help the
compiler, and then you end up having to have the compiler (or some
other tool) validate those with asserts or whatever.

And random asserts ARE NOT ACCEPTABLE in the kernel outside of pure
debug builds.

They may be acceptable in most other situations, but in a kernel you
can't just say "we stop now because it turns out the analysis was
broken and the manual notes could be fooled by an attacker".

Now, would we want to have proper value *static* range analysis in the
kernel for other reasons? Oh yes. It would often be very nice to have
the ability to state "this value is trusted and is in this range", and
have it percolate all the way down, both for optimization purposes but
also for various sanity check purposes.

But it's simply not sanely available in the generic case.

> a) this is not guaranteed in a specific situation (-Wvla-larher-than)

We'd either get horrendous numbers of false positives that we then
have to manually add special code for, or

> b) transform the array automatically to fixed size array
> of size X *or* something smaller when it can show this.

we'd just do this by hand *once* and for all, and say "VLA's didn't work out".

So yeah. We did (b) by hand.

We used to have VLA's in the kernel. It was a disaster. We got rid of
them, because the (big) pain wasn't worth the (few) places it was
actually useful.

So we have been VLA-free for the last five years, and it's been good.

Simplify.

             Linus
