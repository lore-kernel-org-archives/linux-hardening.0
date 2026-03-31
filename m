Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9503A382E
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987902; cv=none; b=L5AiNPfZgQObRjZFfO6iaPg+fszGlORNe07XzZL93sAxGzF1ozPNbbMuRzKI6+FWurcoMStteH2erzdPLCZfeRM2cCC0LubD7uxsUNFyGn19uXQav48Ge9aENosn4LBDnxgyEp4QEU1p94Na1wyTcW1jSU391wgKnZVPzEYskik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987902; c=relaxed/simple;
	bh=Y/YFED/0OtgPfgeV4gPZ7asbBZssxn6FNaeq1L4CVTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+DhDCVlhhYM3Yjqb1+mI2qwcdhFg4ynNDYa2Xh/Pd0pwuSqtvW4vQPcqtKFHkqZ/Z1AG+h8UhovGifEbIy4/W8duhKQfZTUfXxXBi5EJXDIWFenEJdR2igVr5PUKoTAedD+J7gt8/yJ8Hsuxs8TouCyzr+/ZX7zPXNw2WaIU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FDLKqf1U; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FDLKqf1U"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b97bca3797dso951669366b.0
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774987899; x=1775592699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcN9sER3VoMAwC3I5Sh98SVftLUl9If6/CrHtfP+ol0=;
        b=FDLKqf1U+jKTZnYa/0oHxJXIRm7iOYp7bDTOisvU53xbdq7atkRk9QQQ9V+sZKVhLy
         sDMv3tjnLjS9CxVpoQF6aqAtSjwq8bgWCXyTDmOmPVzrzBZQsddtE+WjAxuJSjE4PsmD
         ZQMCkDtF8eJYz3R+NvlGNPO5rLe94+ROMb3L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774987899; x=1775592699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcN9sER3VoMAwC3I5Sh98SVftLUl9If6/CrHtfP+ol0=;
        b=FCNB/CnprvQcG/BlbZ55wMcniRBLG5CsFOu56dQp8WOuQuKemYufiUYZJVWU6bt+LH
         1ZvM0r5ItGqfwcv6jFrqoswq9N7dC0/nFbJ6R5i/PTJY/+RmZrg2HhAsHOpYLPpRelN4
         mXufgbCRM7tUpCkPHUD7I/u1tIdvNY84/ftQ0k9GLwWQZkj/tjLo9xWYwD0XiI+KFHBL
         m2ZW2j1NN3ikFO7C970Dsu7uQOwB8D8w1GqBtDUjxKlUyISPxE8NBXQWfT2aPRDeyqeE
         4pFN8xiEHfpaTdnLZG1OmunbswgBh4CUlAJHHRmObV/VuWOifITEcTqtvrPtSWg4mvtZ
         Ql7A==
X-Forwarded-Encrypted: i=1; AJvYcCUmOr4+tZkx2M87hKk4JpAOyMP8/T+M0V/cTSLusJlnBPNv+9sCRFm4FT7XSLZgog2z9UfUrrGg0nyKYiW7Wf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGavidk5LZgm1bMOqKQXTm7hqRv+tkaitCRDDYdudDKiXuxNsn
	QJSgqfUh2SshBP2sP3Z4u277FRG6kWlQdpuDPeBzyPnsabZDhSzdPEt1nxZqjHl5cWFc2apJZ2s
	YW0kmKEEdUA==
X-Gm-Gg: ATEYQzzuTBDblwTx1BS9pMWGhUVXoXjKS7d/9t1rloACoEVqvVS2czrdBjcZIutCpV2
	iONcfZJJiabrddaIfE/WTG1tmtxDhhkJ+4Fv8iqbzyfYrwATYiYRJ+Id7hVrpcnK4wEuCXiiBC+
	Q5TISZPRPLrLkyydvAIYq3r8Gl1IBhZI3j4z0Ty9f2dkjjZwuVV/vPTXmUH31xSCZ3/5e2ONzLo
	AvLp+Q1pn07Or5u899ffTz2wR1VHyNLFPLx8SsXHSjYjXFhTnHY71DjkEcMATCgOxFn8vsEotTF
	qU0nP71jht+SY9DA1JTCxjj446jm0QpOaAWmlzWB7L6BnqsUrF6C5p7Qd3UHxfzxv2OvI6hYzgh
	BuYLJLgQK6AcXkIhRerFa3t4T3gcq+afoxF9rmE0owuL3ZOCmebtT8P2U/nbVaDG9YiUfal84sB
	Mz3jY1kjLo07OIKKUHXxV1f91wKGhvZEU8U919RaIeNqzCzLUm+V/+q9hME4S1pvyJ1gWlxfN28
	JLbzlNwjCI=
X-Received: by 2002:a17:907:e118:b0:b97:1d24:bfd1 with SMTP id a640c23a62f3a-b9c138e19e0mr45698366b.13.1774987898812;
        Tue, 31 Mar 2026 13:11:38 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1ee612sm445542166b.53.2026.03.31.13.11.38
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 13:11:38 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso2690540a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 13:11:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqomQ3kN6F60xXykUmipZz7TxSULLkmd3KqB+zYco9koJxix+oE6Ptrp7WAalLjYjoZ0TebjPQ244keYQdMNg=@vger.kernel.org
X-Received: by 2002:a05:6402:210f:b0:66b:a9bf:41 with SMTP id
 4fb4d7f45d1cf-66db9efda06mr583269a12.27.1774987898160; Tue, 31 Mar 2026
 13:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com> <202603311253.95C54588E@keescook>
In-Reply-To: <202603311253.95C54588E@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 13:11:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
X-Gm-Features: AQROBzCgLuTpLW2yBmTolIYlFODjWyPAxSyS-qNDPcZnOIgx-hYNdl2uT2sLn6M
Message-ID: <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Finn Thain <fthain@linux-m68k.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	llvm@lists.linux.dev, Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nsc@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 13:03, Kees Cook <kees@kernel.org> wrote:
>
> Mark Rutland had strong reservations about function-level annotations,
> but I wonder if the combination of new type _and_ function-level
> annotation could get us something near what would be palatable:

Yes, if we had some way to specify the label, that actually looks
really nice to me.

So with _this_ kind of interface, all my reservations about it go away.

And as long as the compiler actually requires that label to exist when
trapping arithmetic is done, I don't think people will use it without
having fixups.

> Or we could make the label a global part of the language itself so it
> wouldn't need to be a function annotation, but rather a _required_
> element of any function that uses a trapping type?

Yes, I'd be ok with that too, because I think in practice you
typically only ever have one, and I guess you could use local labels -
or multiple functions - if you really needed to have different
targets.

We have a few years of experience with "unsafe_get_user()" and
friends, and a few hundred places that use it, and while it's common
to have several cases in one function, I can't think of a single case
where we actually had more than one error target.

I tried a quick grep, and nothing jumped out at me.

(And a lot of them use "Efault" or "efault" as the target name, so it
probably would have been fine with a default name)

            Linus
