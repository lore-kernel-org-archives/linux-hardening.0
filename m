Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772814EC5B
	for <linux-hardening@vger.kernel.org>; Sat,  7 Dec 2024 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595984; cv=none; b=anaWYAbW9r5ZVJvfEwAUl+2WeEY+1k1EdrcEpxq+A8Reo7isa/8IRH7HkJVNJctnlJppaFBy/2falJTzaLGCjldNMzHUxfivdXNkUki5hVdBDpMctFM0hcNytdXthimphjdvSnpvREJrS1PlhBH3gR3nRoctLJrpMLh2ltCelkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595984; c=relaxed/simple;
	bh=pCyqxQB1wqSB6HSVhdTXB/6ltiXA8UsqI4BL9ES1zGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htMoKuBoRh4SkgdMnCHn40rSuG9B0cTGenAh2Q6hO+A3G2iA/rdsCFcuuqP+Yy4oTixCXOZYtU0zpQTZxqC4T+KeVQBLcqUeVJRzaoAc8UO4HnItn2oyoamkV4tJ5oH323X6g3VaUxJow1fjq5mp3LGpDdzIBN+prxae64DrLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cieSwvWw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cieSwvWw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa560a65fd6so561937366b.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733595981; x=1734200781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/vNc5nALUWVUmfD8b/aC22BtPTbXjUkByw6MJHP530=;
        b=cieSwvWwsDQfoM4RaTg6CeygEX2j3fgiomuTTOt12BgW/tqae6TVG6++rRDYvBxDjR
         37spXp44rh5P4zOgW0aeS0LdQl5GJBP3D9XEXZ5K8ANKex4GUidXW8AHHnBTVCIG0zaw
         PP6tThVF6mNvdWUyrU474k+xJoby94bNXQXes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733595981; x=1734200781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/vNc5nALUWVUmfD8b/aC22BtPTbXjUkByw6MJHP530=;
        b=qa1AcvpnNzlcXYfItHvkq1+rbcyJrLt8AAPcnvMI/kXaLfOsqG9u//Ei3Nq+sJj+2K
         AaCJeSc+ImwT+ioxd3rsQ+fikzdF0T3qB6WBrdAXrP8hw31ia4Bn531fT41Ol1zdxa8R
         CHmLL8GDmWlkg4x1EUuz6CGPjkJU76borgWK4Uuj00Op4aDHbML+DQLPmg8KACOQ3+47
         6AjTXB32dj7ojePvdOS1Robyv+UY01bxUHwJXveU6B0FN1oq1kU/bPsSVgw9l/4VXPJE
         JmqGcjuxK1lOSScYRbIwFbnRvwogGyVrMhKHTW56F4t0MfmGEavLNkmLVzJF7sUkvY6J
         QdGg==
X-Forwarded-Encrypted: i=1; AJvYcCUC0JyHRX9B0B8MjGb3RByoxA0wMkoOeNMIw1SvTpdVuWPwx/ONoLvrWw/3xAbn6dvVXIuHfojtXrGNb+d6z3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Z4j/7gkdbdPyKHzNpv7QPVc4QSS/fhpT5sIVwnyBF23GxnhS
	q4l4CAAcMzfHcD6qfGnlFX/rJXnJugOoXRIbZoOjPCbp2AfQTEOJm0ewix9REEQ+w/Zc/QChMQ2
	HHwnatw==
X-Gm-Gg: ASbGncvVWZq3aqq0wAYkuv2QHiCqgPPPWuqEa66qB5DvUC9frwx13YIJ+aXYRnDcxuO
	jvEvjKTSGH1AQYm/EZv2/mbp/VyWGbSPLWJr4Ytn2biDkoeIxuebsRwe2wOLTSsDZz4XC2sObuM
	XTCX+BuPrkPHF6R07n7mpDLPTeTqf1CuCm4DVhF9gys9afvXdVFCXrL+aKlNkpO7FZDZvMjqACp
	+2VzhJQTKNF40XJhOKEabUAR8jH4AbBY7+NeY6LB7HzywGkJq9lMi2Avxy+nj91XM9X3iuemb96
	/BPoS/GemuP9+YcJ8zaSE7Tg
X-Google-Smtp-Source: AGHT+IExVsiJp7QUnJXacG1YXlxgStgSIpy8XCWscETSrwsiz4IKBBBvBhrzU5p6B1L77lm1PdyZ/w==
X-Received: by 2002:a17:907:c28:b0:aa5:b4e1:ab6d with SMTP id a640c23a62f3a-aa621aadb05mr1096856766b.29.1733595981234;
        Sat, 07 Dec 2024 10:26:21 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6590f5457sm100754766b.195.2024.12.07.10.26.18
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2024 10:26:18 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa662795ca3so73005366b.1
        for <linux-hardening@vger.kernel.org>; Sat, 07 Dec 2024 10:26:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8DEFINFFEbDEFRg6xEflzDnh6JBnk5TR6+RW5AskZFlzwPMwjHJJj0cE6G+mR03xyDd2XEHQitZUxiU+pKpo=@vger.kernel.org
X-Received: by 2002:a17:906:32c2:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa6373494a2mr765427966b.2.1733595978237; Sat, 07 Dec 2024
 10:26:18 -0800 (PST)
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
 <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de>
In-Reply-To: <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Dec 2024 10:26:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
Message-ID: <CAHk-=wjpVXEjX16PP=-hi4CgLqEGJ_U-WvKWq+J3C+FW-hSSfg@mail.gmail.com>
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

On Sat, 7 Dec 2024 at 05:07, Martin Uecker <muecker@gwdg.de> wrote:
>
> VLA use *less* stack than a fixed size arrays with fixed bound.

Not really. You end up with tons of problems, not the least of which
is how to actually analyze the stack size. It also gets *very* nasty
to have code that declares the VLA size using an argument that is then
checked afterwards - and if you have a strong preference for
"declarations before code", you end up with *horrific* issues.

And even if you are super-careful, and you solved the analysis
problem, in practice VLAs will cause huge stack issues simply due to
code generation issues.  The compiler will end up doing extra
alignment and extra frame handling and saving, to the point where any
advantages the VLA would bring is completely dwarfed by all the
disadvantages.

We went through this. We are so *much* better off without VLAs that
it's not even funny.

Now when the compiler says "your stack size is big", you just look
"Oh, that struct should be allocated with kmalloc, not on the stack".
Boom. Done.

            Linus
