Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4526B775
	for <linux-hardening@vger.kernel.org>; Tue,  1 Jul 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391536; cv=none; b=nweQehvZp3x+vKg4Ol5zBrqZeF7FlB37YKXN7bU5Fr2q0lTp9rk/uBk6a2iVEjaGIbOVJICU/BrkZsMpPRMMM1PmtqoRSbU3ZCqC/0BkwlDGUMy7TU+fThvN+wjkYAmq1AN6Q6+r1nuBtsSug4KurBDhkqUboyvNWvvImvyaIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391536; c=relaxed/simple;
	bh=5zvEsOvSYVhWyUtVM6u5hUWth1qIUNz4CrI6JeOFUK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OscP4ysz4852C0kUeMZL2+Zj6h4Mdj14fxSQpvyPGU0ieJkwexdGV+EprP7NCuDzOr9pO0sYGvx/PdLYhQs9hO/TU6N7+P4QXi1sMH0H4GstlUTWPUb88MI83Oz+ebkuxRxFY+rP6zqbeLQWCgk2k0QADw4+VMPARD6X1239tnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3m89p7lm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3m89p7lm"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0e0271d82so1048362466b.3
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jul 2025 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751391533; x=1751996333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfxUpibom5vvnS0KKvDzUm1M8BKe5OlSJnZe4zWpxjk=;
        b=3m89p7lmr4uKWcrckqhwiCDXdQDRUrXm0INB2+MuiDtvuFTDewVqBk/esztQY/Ao9H
         o25nZk+szTAenBEgGQoK47rNdZGwLhCuYSRNp4OVusFN47tw6znMt4/fYAiWsFRS+J84
         z4qBAlxOfsOHGIoeGBCj0n/F6AzipW5jQVNVO8WgdNu4emAOX4R3wDP3yOTQqtm42uej
         jMfCVks6s4yMokfR/XAWvu9ap43MrRnPOXQGDcWu4ZmfRp2daGb9r8S7v5au9DuD19Hg
         R29DJ5/AxHhp57q6mfSXELWuoK91lAJHqVksIsPFFCZ2k0V6JiThhGyV8UR1KJUVePUo
         pNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751391533; x=1751996333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfxUpibom5vvnS0KKvDzUm1M8BKe5OlSJnZe4zWpxjk=;
        b=aM4Z5aALUw/K2lyIVKag6ipnOQslovwm2CMXmTiRDx3azRCUjgm+ezpBQaINYeWX1C
         uhCR0tO82PNv6RMkewWtCh+ADg5BPgvCRdA56yBDcADWfGqX3cS7/cjToqluNw0VSFuc
         sj1pbl8vHpL6hfTQxIshUAB3qc5O6USFc1DM0q+oN2WEXl4u2tVNSe9ZMIpvrzZjcsci
         POMZ6qSnDZ3uflPqXK0XBZVMR60G4WFKqgMILfaUP3Mxf/sGJ4lazTTdaJJFS7tSb1wX
         muCodTX1eBtL7fU/CKxViskWd/hgH+xf7tpXAxc5xkAH7RF7v8C6COGtCVVjC20Gyera
         McEA==
X-Forwarded-Encrypted: i=1; AJvYcCVV2sOqgp4nqH/ed2+RJsu8o17415MdRYg8oYaZRuouRBh4c27T2LaQyVGgT4hOR7V/19nczAv1/VVUB6Janns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxfNpxqApSmtrdDprD8QreQGwuL3GuSieBnaVSTgu2a8PscRI
	EdOgfok/5bHF07jPysJhrz9m3CBFMjKVeCIN3898VEwfwwYbAJH7Nx6vZFc3YVrFbiEzFaTrugR
	CHStqWft4wBUV9wu619UQz9b2i9ZW7P/gH4znklc=
X-Gm-Gg: ASbGncsMNxIaeo7pLbferyOViDsucqmL6vl3+9jqOJJGR26w2wP8YPankTm2OrzgiS6
	DfdArqtwdfdDvygd5Bh5thFR2OEEX9E5tqQVRaR5O2y3edN5qBnOnvbi9NJpCk01w9yQX9mydLE
	WblwpotBSnsCj9Szq7rzHplqN0nAl2qqTLFXChPxVP
X-Google-Smtp-Source: AGHT+IF+/tonZS3eprL8fBz59HFoDazzWtNrnqbkDEo/bpyI80sUtntiayP1Q+kl77kfKAamsjQgNVIYfD+CC8tFZXo=
X-Received: by 2002:a17:907:e885:b0:ade:4121:8d52 with SMTP id
 a640c23a62f3a-ae34fd6c415mr1795492966b.16.1751391533096; Tue, 01 Jul 2025
 10:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628234034.work.800-kees@kernel.org> <CAG48ez0n1E0iuOxPe=jq4MuuP3w2wMSNixmfNmBbB89jyJBSbA@mail.gmail.com>
 <202507010926.1650356E@keescook>
In-Reply-To: <202507010926.1650356E@keescook>
From: Bill Wendling <morbo@google.com>
Date: Tue, 1 Jul 2025 10:38:36 -0700
X-Gm-Features: Ac12FXzCjsprue_aHpjZnVxD8VXCkB47OcxITm2WNEvN6g9cKXegv-O1gblDGPQ
Message-ID: <CAGG=3QWVM9tTRoGws0X+Jq+m7Fte2JeQC+jUL=EZ5hqGzSY6hg@mail.gmail.com>
Subject: Re: [PATCH] kunit/fortify: Add back "volatile" for sizeof() constants
To: Kees Cook <kees@kernel.org>
Cc: Jann Horn <jannh@google.com>, =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 9:27=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Tue, Jul 01, 2025 at 03:41:35PM +0200, Jann Horn wrote:
> > On Sun, Jun 29, 2025 at 1:40=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > > It seems the Clang can see through OPTIMIZER_HIDE_VAR when the consta=
nt
> > > is coming from sizeof.
> >
> > Wait, what? That sounds extremely implausible/broken to me.
> >
Agreed. 'sizeof' should be calculated by the front-end.

> > https://godbolt.org/z/ndeP5chcb also suggests that clang does not
> > generally "see through OPTIMIZER_HIDE_VAR when the constant is coming
> > from sizeof".
>
> I agree -- something is very unstable about this case, and it's been
> very frustrating to pin down.
>
> > Do you have a minimal reproducer of what you're talking about?
>
> I have not had the time to minimize it, no.
>
OPTIMIZER_HIDE_VAR doesn't have a 'volatile' on it. Could that be it?

As a side note, the current definition:

  __asm__ ("" : "=3Dr" (var) : "0" (var))

seems like

  __asm__ ("" : "+r" (var))

with extra steps.

-bw
