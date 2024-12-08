Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B85EC5
	for <linux-hardening@vger.kernel.org>; Sun,  8 Dec 2024 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733623139; cv=none; b=DmqFbn4SqDGoxMAzRddxmt4pND6ndU4nOxY7Q639XBU3+nX5nhaK1hOAvjT9uKYN6EVl4itt1an9ozkUsWAFYxlZMKZ9MxgosAdB/pRq1o/aVRWO//YM2sWjehHGDOIZDMIz00nHOASsUZtifTTDqQiiTQTygD43WrHyu/ccbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733623139; c=relaxed/simple;
	bh=IAtH1QPZVCuHz2tcdeD7lZlJGCLbl6dYQADoubFHbLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUxXA1CB1W/jDuhGc3+yVQ65Zqik8uFPzB0E/0PHm3dIivyBz3BKRpUmvy65GaifOTNqjI+Ok26b7sh0BL7Fv/MfpY5eTJqK5scep0VGhftqOCq4YNOM58bvlzL8t9uGU6OwvbW7Z7bzP/KVBYRgaGvAO5jnwaOgh77gz/xEYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IoMGSPXS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IoMGSPXS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa67ac42819so10970866b.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 17:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733623135; x=1734227935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EZjbRKhMOCLvsh/fbuGewVnDsfkV1Y6IoPuC3JohNPQ=;
        b=IoMGSPXSJUSoInUUnMnu7OCTroKZFf4O0WOjcCScySJDzWBtZlH23dSym7mTpPFXsH
         XTHZ18YTdNxJWi1bDYC5wEoPsXFx9FeziWvxPv9g3Tw79sD0rgX60HXqqP/2csUv/btt
         ISPSEU/XgAiyi+be59IjIH34MlYnwYJDz3JkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733623135; x=1734227935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZjbRKhMOCLvsh/fbuGewVnDsfkV1Y6IoPuC3JohNPQ=;
        b=jslJEhV5Vhnj1iDFyNz2OM/bFoM4+QF8+qAI3LDqUmU5vp1FtlbYj26tRqAyVu0icd
         40c0CQtYQRgtsFMMdjP3s7Rwtp88MgazZ4O8zJniZRVtSR9p0KjVwgT9limzAvelg+6f
         et6bl19pu81ZUSujXmH1IxVUPpHqkczJcbphYmIYQmifmdutKJ60Z8yyp2bvAXodQyLw
         Hur2iOeoZA8c06Loe7u9vAbajdB3sPCSjBva3r+TC6gCQnoyI9Nc0yBnr/pM/8omdqZR
         AhnZunojuyTTPV7me8EfbKXg9zKw/huknHgyA+LXsdMgl6GMuYDwgXI+IihcwCTxcBON
         0quQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6QRXbO1RfqYbUPUFb+9O793PSVgRgWDsaqQ+CCbNIXOmY46ZUHd2GG7y/ecuiOijlZz4h72zKXOJxK0vT+O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMp39+TsZ/eqhuxImdECtgKHxk51GwWYzk+XuRNy1lNo9XDPzy
	3G5pKKzx51TrewglekHh0jajel7AT3PnMwj/3aUoV4OjlL4EAFKveEan7NboggDjxd/B0oPCyAQ
	5Z8nG2Q==
X-Gm-Gg: ASbGncsp4Wic1/3O9lt+8a95DDuKnsOvZJgNJC4ZsIRpmjoFG3krClBQMMOgZd/dWtY
	SWCFcoPEf7RxuOzmXKt20fkypV+a6OPuf2yUk7fJGIIYjEgyPDdoSAMfwRZGQGpj9KPWuDSU+kj
	N8Iys6vBfjnmC/FccL/ty85YnlGebKL8E/TUMPstgOrsjEfO8DYIhHPTdmQPvLr9u22XMp3whDC
	IuUr5vpczxF2Yh9K+C4Zbon9yr2igb6X7B350G+F+DUbsq8Ht2bZCZwmkcSc2Mp+/sp3/Rs4Tes
	TB2t7lTEU4tUNAATetFaiZHO
X-Google-Smtp-Source: AGHT+IF6hHSxjGXMd+P+anKUkZlvTd4yZMdJAon9NVGQDhDr1PwUd60XpS6FBt27uAtABB/Qmofk/g==
X-Received: by 2002:a17:906:18b1:b0:aa5:639d:7cdb with SMTP id a640c23a62f3a-aa63a014017mr516608166b.22.1733623135119;
        Sat, 07 Dec 2024 17:58:55 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e92a13sm460533766b.52.2024.12.07.17.58.54
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 17:58:54 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa62f0cb198so395351466b.2
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 17:58:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeHxLodXR4SmvCngv4ii6des2ueqMsRqEs3WkNaS2mpdTJBa116flQQMTx/pC8DuQjGrfV/eS+zbV144OU7gI=@vger.kernel.org
X-Received: by 2002:a17:907:84c8:b0:aa6:2fc7:71aa with SMTP id
 a640c23a62f3a-aa63a24f1famr565813866b.55.1733623133832; Sat, 07 Dec 2024
 17:58:53 -0800 (PST)
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
 <0a2996a7c63930b9d9a8d3792358dd9e494e27c1.camel@gwdg.de> <CAHk-=wjsfYYKBYuW8_6yKjdwHih0MMa2GwUJh_LHcuUNFR7-QA@mail.gmail.com>
 <9d9567dbdaf39688bbd0d240e29dec826a5931ee.camel@gwdg.de>
In-Reply-To: <9d9567dbdaf39688bbd0d240e29dec826a5931ee.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 17:58:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVGmj+nAju2XuWWD_FZHdeytRW2XX5D-L3MqDuRRciVg@mail.gmail.com>
Message-ID: <CAHk-=wgVGmj+nAju2XuWWD_FZHdeytRW2XX5D-L3MqDuRRciVg@mail.gmail.com>
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

On Sat, 7 Dec 2024 at 15:52, Martin Uecker <muecker@gwdg.de> wrote:
>
> Can you point me to some horror stories?

So the main issues tended to be about various static verification tools.

Ranging from things like the stackleak plugin for gcc, where handling
VLA's and alloca() (which are pretty much the same thing with
different syntax) was just very much added complexity, to perhaps
overly simplistic tools that literally just check the stack usage by
parsing "objdump --disassemble" output and then building up
approximate "this is the combined deepest stack" call chain
approximations.

And even in the *basic* infrastructure like gcc itself, VLA's simply
made -Wframe-larger-than= just simply not work.

I also have this memory of bad code generation (again, this is 5=
years ago, so take this with a pinch of salt: dim memories), where gcc
wouldn't end up re-using VLA stack slots, so VLA's made the frame
bigger for that reason or something like that.

We explicitly use "-fconserve-stack" to get gcc to reuse spill slots,
because gcc has been known to sometimes makes insanely piggish stack
frames when it just creates a spill slot for *everything*, even if the
spills aren't live at the same time (think big functions with lots of
case statements).

We also had several cases of the VLA's just being silly, when a simple
constant-sized allocation just worked fine and didn't generate
pointless extra code.

Pretty much none of the code core actually ever wanted VLA's, so the
end result was that we had these bad patterns mainly in random drivers
etc. Don't do that.

                Linus
