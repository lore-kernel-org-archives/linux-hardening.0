Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5E435ED0
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620492; cv=none; b=LsRffX+CJ8/c83JBn71eNdlVYTy9LKJ+EyN9oeUTBPtpCWxZ86SGf+m/PVHes3lBhxDpLD0oNjSEB1rX4+RZuYnl0lJhuF+J6yZLo3t4mPcDxs268nP6pvH6I+3YxUKQSY+sbR3I6xXRwToMe4K11fnwZQMjzSkZKACWCltHxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620492; c=relaxed/simple;
	bh=dCFp8azqbtjMnvLCWbCJTpVJiM5s5tHj5DD4OdLTAbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3Zo51Vln5LA09WW0APmYOsJcuGvtrUR/DFt8Q7LrrqEg3FJV5Ch10xOiwD+zEVXvx3vdBmSpRsYs54KPyM/uAygUOWaU0PFHu9KC9PpM7bdvhkmlnYzgXqKzmC5F/TdarmcBn5bCivB5rbuoE/fNTK2lEVVvuzreU7M8slFVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzDvOdby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzDvOdby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AC71F0155F
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620491;
	bh=dCFp8azqbtjMnvLCWbCJTpVJiM5s5tHj5DD4OdLTAbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MzDvOdbyzTCAvdoapu1Tim55VE4TPHvrsM716xnZiCJqz1gRE/ytbZAHFZTSScv/c
	 0PBqGmUU+Q0+8wWYJ3ggt7bIxBahPf1Z92LImAqaPHxaLg4RsBlKuZXf15WdZZcmn/
	 bMgi09VrHwwqMcskbiqckVfAwDTHtCQTsHH7xWqYeOeF5Bq0Yj5Qeps+gCszEWiV78
	 nbU6UUNqoHA193nqFxdJYEXUKNrhTPcQMU4HPb6m4FKBvZoA4SMIQTL80XfbSZykwH
	 zaABhGQjS98KMnWwRgi+VnslfcrZzi5etB+TaAKRcuw/bYx/yhvEQRjj2EMApQRBjK
	 yWwC1qyhCcL1g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso58149581fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 00:54:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RriTbkLK7N39traiqoeOX8eB2KK2HXYHFro0MHEpYGsEwonVzumnZDKMXIkqEN6eiLY5nebO0l9BsZRrXQhjgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwamKLGxBoPGs3DDL0BzubzlY5D6n9yUedSu0Jjl9LsfxaJvIZr
	W2+TzoZzjla9wFE2Zw5/7zJeEeizJWJrbxdR/HvrtuBGWdLa0tKdukL0pP+mruV7rht4Fw/fsjl
	lI1bEqsU+NpYHZC9tlIUEy3QP1pPJJEE=
X-Received: by 2002:ac2:5b4a:0:b0:5b0:177f:beab with SMTP id
 2adb3069b0e04-5b28f9b8ab1mr2888376e87.44.1784620489665; Tue, 21 Jul 2026
 00:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715175223.make.153-kees@kernel.org>
In-Reply-To: <20260715175223.make.153-kees@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 21 Jul 2026 09:54:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLk549ZcSjpRN0G27i1C-n-k-dOpmgvfZBgmHQ5s0F6dJg@mail.gmail.com>
X-Gm-Features: AUfX_mzMwCV8Z7xeaNpPDzFxYqTYvhmmKEur1wOLmu4Wv6aUpsrNZUfEjvv8O44
Message-ID: <CAD++jLk549ZcSjpRN0G27i1C-n-k-dOpmgvfZBgmHQ5s0F6dJg@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: traps: Implement KCFI trap handler for ARM32
To: Kees Cook <kees@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 7:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:

> ARM32 GCC KCFI[1] violations currently show as generic "Oops - undefined
> instruction" errors, making debugging CFI failures difficult. Add a prope=
r
> KCFI trap handler similar to the aarch64 implementation to provide clear
> CFI error messages, including the call target and the expected type.

Reviewed-by: Linus Walleij <linusw@kernel.org>

> Clang and GCC trap CFI failures differently on ARM32. Clang lowers
> its checks to a BKPT, handled via the breakpoint/prefetch-abort path
> in hw_breakpoint.c, which cannot recover the target or expected type
> and so must report via report_cfi_failure_noaddr(). GCC instead lowers
> KCFI checks to a UDF (undefined instruction) whose immediate encodes
> the registers involved, so the handler can decode it and call the full
> report_cfi_failure() with the target and expected type.

Aha, that explains a few things.

The UDF is a better approach for ARM I think (Russell will know best).

As noted from earlier conversation the breakpoint usecase overloading
on ARM is a mess, and we would certainly like to avoid it if possible,
albeit I have a patch in Russell's patch tracker to paper it over.

Do you think that long term we could switch Clang to do what
GCC does?

Yours,
Linus Walleij
