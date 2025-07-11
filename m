Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD92F1FEA
	for <linux-hardening@vger.kernel.org>; Fri, 11 Jul 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256758; cv=none; b=EOYY/hG/D0/fGx+9bpduHf4Jr6WJgw5o6mqioBLf14o+Kq+KBoDo+vVwwWI4yw26wZ1k9dhP9lIqrgTpURNf9DZ/MExJcOx5AlO5aGtgaRfzSuGBts/sxndNTPw1dmBNQ3kZrpma0SnfIvclHg522wsNcGhK7YS9mmg++IoamM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256758; c=relaxed/simple;
	bh=kJPTgPdH0OPrTn/YGSgGWpc1xCCW5T5ErXZFEUacy4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTG1iOwGke1QqsPgTEMjsH0Z09TmVDjaM0BSkvTTopcOGXNjND4+RYqmaspPyZ/ex0GPAQJfXOirIx9tihWwbynIVN3oAU44BulsypX07h7Mcc+BTOv73h5iYsU7bhaEnEH0s+iVgM8jrsUDgmH393Tv0tTmh7Tz2N4/43eTb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e84vmfS/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e84vmfS/"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso3970967a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 11 Jul 2025 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752256754; x=1752861554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HO86Lx8//8hSyzYLerKKeVnItqg9SoMBkOdjNB0C6us=;
        b=e84vmfS/uvJd4/7X9x9JaZqS7k53tkpjlFfTh956f9UYkN0iEsN4RUnhwm+GEhTleH
         aC35uCL288fvWaHkxq3WSDZGWMtpie/ZxuHaqmQBfzlu9cUll2ECAJfie1+xkuSjFBT1
         nIhTYvwv1VzPUOCcHQkqS4nbupaiquHTToLNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752256754; x=1752861554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO86Lx8//8hSyzYLerKKeVnItqg9SoMBkOdjNB0C6us=;
        b=IkLRm4VEEqJQkgPzGwrhSrfKNJ6/6VSfDpHvaXz3/zVo3lUw1Nlx6jZK4g3BvrmzjQ
         Pzx/Ztg/0djV/GwPIj/oTbZoFsMuGBxa04mW8DS0thOE1uQEHDbxKr+39IuURtdBsiWZ
         msdNy3so/XsK2kTRSeNeOA4oZaiA3NKQM1LflLAZGYYktT6J5XaPQwBRTNt2zmD7Uynw
         jYf0YBIeTqdOTl4CwVl5724N0iMtrWo0KBT5Ia/8nGRmhgNC4oBtDEp3umlGBn2RYnRR
         PGHDQIwmP4kzBoUibXjXsYeHVMfWJv0VbkJaZ4uqcijQQWpvmdi78aCKaJM4wcF82i4S
         J9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV9h0uAhiqZ32zCUUjgLjF4TDNbYl3lK22/StRsn0q7ld+YuO1qCu0RqNAfoQFqp/d3hQEK3qUayoTzJsybn5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLlczzgoE6TSwKwjmaGRfyAoYcIyWrWHs6198gIaZ5qPi0Nfk
	U74OLP6rSgE9ORzuh6ADqWYmvP/8d8nmELr3x9XAgQ13PSOeKQdh4Awbm/1K/3Tws+lZB1kOF49
	K9zjPRX5c/A==
X-Gm-Gg: ASbGncsl1MgZp+xwFssu38k+8ugcTEZcLYim6nZTvePTgc3QfDjtUY34Ra5GjHlZ02+
	804lFZh5yWmCAnGxLcvnG6ki/ucENdo9fMz9iQTUOw6ctL7Wl5k4S+XqPYzuAYgw3e8G8Q4UxX6
	ArILu1bWsiLvoEUUo00QryY2UIXiIzkwJzOYjBgj3P01wp3ffy756s0r3R2Svw4MvOMMqgYl5Dy
	5dSIGVpxZ3aGOgYH7owGVz6rW82QpAFX4khkloEF/vIA2/l9gdJzy7vKZdh53mXV9X0N/gZBweb
	G+WajWsBrSALSFoGNBnyI+on9eW4H8reu31hE01p3mzbOJ5aAxNi4HG/xYsQqKvg7hfYl8nMrYI
	DK5i8w3NyxBB17HliXSRPDgbtDNeWxVg0o15rgrmVZGoflo6xLFBtEUYVMkjN0mTPQ8+QPfUoGG
	shqaj1HiQ=
X-Google-Smtp-Source: AGHT+IGIJzUK4YmsR1JqY/93ZhekFFE81ZU91Y+WCTCweurHxPqqOWP7LQgLU7pVVOJNJ8Vqc6kR6Q==
X-Received: by 2002:a17:907:972a:b0:ae3:cc60:8cf0 with SMTP id a640c23a62f3a-ae6fca6dc16mr470928666b.34.1752256754362;
        Fri, 11 Jul 2025 10:59:14 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910e8sm333829166b.36.2025.07.11.10.59.13
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:59:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso3847283a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 11 Jul 2025 10:59:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUptuMW0w0N71u/pWwnCezp2LktclTk8HaQmPv0Nsq/qxQrO9NsoguuVnvGYr72iGYH3K8/Gl16xVCPEdWXYcY=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:60c:40bd:8843 with SMTP id
 4fb4d7f45d1cf-611e764f6e5mr3668397a12.11.1752256753054; Fri, 11 Jul 2025
 10:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
 <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
 <28c8689c7976b4755c0b5c2937326b0a3627ebf6.camel@gmail.com> <20250711184541.68d770b9@pumpkin>
In-Reply-To: <20250711184541.68d770b9@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Jul 2025 10:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
X-Gm-Features: Ac12FXy_-gvqQgEDwxrh9_yUhPGT4NZn2yvYc_wfrsBVUNUS1D4_tzcLfdrYbJI
Message-ID: <CAHk-=wjC0pAFfMBHKtCLOAcUvLs30PpjKoMfN9aP1-YwD0MZ5Q@mail.gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
To: David Laight <david.laight.linux@gmail.com>
Cc: Martin Uecker <ma.uecker@gmail.com>, Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Jul 2025 at 10:45, David Laight <david.laight.linux@gmail.com> wrote:
>
> What does that actually look like behind all the #defines and generics?
> It it continually doing malloc/free it is pretty much inappropriate
> for a lot of system/kernel code.

Honestly, the kernel approximately *never* has "string handling" in
the traditional sense.

But we do have "buffers with text". The difference typically exactly
being that allocation has to happen separately from any text
operation.

It's why I already suggested people look at our various existing
buffer abstractions: we have several, although they tend to often be
somewhat specialized.

So, for example, we have things like "struct qstr" for path
components: it's specialized not only in having an associated hash
value for the string, but because it's a "initialize once" kind of
buffer that gets initialized at creation time, and the string contents
are constant (it literally contains a "const char *" in addition to
the length/hash).

That kind of "string buffer" obviously isn't useful for things like
the printf family, but we do have others. Like "struct seq_buf", which
already has "seq_buf_printf()" helpers.

That's the one you probably should use for most kernel "print to
buffer", but it has very few users despite not being complicated to
use:

        struct seq_buf s;
        seq_buf_init(&s, buf, szie);

and you're off to the races, and can do things like

        seq_buf_printf(&s, ....);

without ever having to worry about overflows etc.

So we already do *have* good interfaces. But they aren't the
traditional ones that everybody knows about.

                   Linus
