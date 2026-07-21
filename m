Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213446C4C7
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650516; cv=pass; b=QJ8tQgW9PKtIxGWdHwGdxZH0eCyBdv8+Hw8h5AGX4xj9RlnTywWIKsXFOtcPnUcJark60VeIoNeVUTzBRxdx5ovsKU6NyBaeSvHLW8L2carlLpvBglQuhUYu56NYRTUs5McOv5ZZ/kzlRnzUqdZRpbYZlTXtIB3gzPzj8dTbVAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650516; c=relaxed/simple;
	bh=5jNF/wdr5AnCE3efKH/glvasNKose7c8fAIiOsTYCr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhBB+leHIf7I8fNaAVbQrnqofcLiwZJRYIIcXpTPILC8E925SC/VhczORCzNO6Qs1H4JaB46zVgjCP8AKKEoA40+EWRibNAiiQRHxkDpOaKvecIsqwRE5I/qJSUS31AFz/NHRso4tYS20SuLsIoNMI7AmqTI1FqPgu0w8IyLr6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjvqolA/; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjvqolA/"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15f360851aso1248754066b.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 09:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784650513; cv=none;
        d=google.com; s=arc-20260327;
        b=MRteZaPQtiTAC2qy6ZryRhQu8pQnLgUHeBd5RPLt6jQ2k0E+X7afkus+6r7zwOH+uK
         Y95l9yTQHqFKmtVCBd/a+95aT9TFD8W1MONeSQCquu0QrYojfsmvCqwb62EgN9tn1zRI
         l9uEiIDGAauT4lvrJIrwtygHgcmb881LyciOkpXUntpNb93a1wyEm5tZnlpDOj+fE1mX
         di5S5GR/3RS1j1RVmD9/MuSx7Hqscq1mSjPTdMM3xyslGJ5B4RAuIqtkn7tqnw1MSaij
         0T0Nqjb4cuRddbvF6ghK5du6aLIjN+O9ImdPO+yXYI1dL9PwoWTXjSwfDeSPAJKQru32
         fr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5jNF/wdr5AnCE3efKH/glvasNKose7c8fAIiOsTYCr0=;
        fh=kjI4eRMjQvIWlS1DMzQHBGthc3PoXoEQqKNZGtDVnIA=;
        b=Yx8e9DyvQNoFdgwqOB0k1fKiwFEz+mFLYhP1vzbsnTgcRWAbgglLLbCDxh0KyTeVzc
         off0Uy3cIwRlMhOlaT30aFWEtOndtiLZPqyRliKqi0boz2mGrgRaKVtAy8nVlVLOfHzE
         gpF0fgHlYRHvxzyRf/THY/LTh+IksyYdNFlWJuhlJNYG4DDGOsT21a29ouojqh42wx4q
         TUTweCmOmTb18hLuUIWjfyaX1WasZjjjsR+teIEIjmVFALyCehf3/uItX6aVT5UUowFV
         aTh/XlL8CUp2NGa3KysNc9QbK/CdUgmj0qWbt8NPEz7i15NfsnT9r7foinYz9PYp3JiE
         QDJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784650513; x=1785255313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jNF/wdr5AnCE3efKH/glvasNKose7c8fAIiOsTYCr0=;
        b=RjvqolA/8F/l2WxoEoKRtUulipPFww/WBUKuZZWS4h1b69EOTlpu5C9zeKSD1OShVV
         /C7vO/PbTyg1PL9DuQzWt2by/OuTZaome8LgYoTQHHp43jcHA4nG8bPbidE3hwey8BHF
         lJ+hebM3enA3eguPUjhY5LCWMFKQVxVaVPUyR3U5mZ90KXIIA6mfuFxgzKU8UG9m2G8N
         mDXEhJ/XLBF+0WACyJfWmdBI3zZMtl77X3WGynSdHWFwqqZ2AKhwO3VRaIwlqOLpTzYa
         gpXVKqYMuk5/6zRAk158+kalglk/QR4KZgvKA6bLRruYm2F1yL55yTvr6cfUdtzukZ9n
         4N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784650513; x=1785255313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jNF/wdr5AnCE3efKH/glvasNKose7c8fAIiOsTYCr0=;
        b=PfRHnXzud59nr0Gc6HXRFZjjVKUtcGU8LSXbi87XUG6z42mOkPZRSqu3lgvQilZRSM
         6mutyxi7jGvLZniy0aFiVkUdWWy2FEQbiMjvVq6yxzh7sf4gssfvJFB9l9pKQvtrWJqv
         yiqhhsEu0T4PJK1BnKFujLGyFs3XFDUzfRT7Ei+ZwcA2eLC1RgoZS7GZ83r0ynv+BeIy
         RMxnbdcm0FlWgPKD/coy/mqwFwhmGEKFJt3gMhI9BxYofg8nJDSA+CktuZ+yfCSKbi2n
         xa1S+odnk18w1T3kxaBY2y6uPJ8tmfq+SZWe4Gbo571G6f7pY6rvPpfQ6c3wLu9T1vcz
         2JYA==
X-Forwarded-Encrypted: i=1; AHgh+RoAq41tv71WxYaMGxhvmAaOly/UR6LA9pubwtr3/G748corpElnnbqD5AMGb8osXi64WlvIKosVZsv/HRhd2OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDMEX4k19iGOk5j+GYQ8YFcz8pA4USfPKfuWsQaQVhMArvV2e
	0gtBDSsg2Yk68CZnnHwieBMTW1mj97M5jw7RcfinoEJile8Ku8mg/sZN4EuQWeeJkdXokEulDiD
	WifO7JWkXm/TQigS75xYh1ElH0wm0xklhjpKpZJHT
X-Gm-Gg: AR+sD12Bqgh2+G35NqRpT1rIK5Vna6lUInu6U1SmmxSWKKPqLCl/vs5fivicTezUbe5
	FAd5X9s7FizaLbvPGeFwffgMz2zXU5cWYN1oPBcaf0W4fxUHiTRaQg+6dfu4HjorSFJvDpQQb1X
	Z+AoUaprMfSD6qOXf3h+vmnMwQMVXIfIQQS0XL474+cXhlmOdEHUOYn90rS0hyDUZ9L7AySccGi
	+URVvSYDxPiNpisIKEZU0TF7Bj4shA4V9uO36T4ePaiB0ZGqrE6CuCDWzTmGv/PJK783810+ggS
	WKjeUf5BmDnCG9+3OsBFAkNGbOnI8NcmgX1ppc9ICosz223hAOPmHqhJ7/9Q86RQvO+1GOaczw=
	=
X-Received: by 2002:a17:907:94c8:b0:c16:9ca5:e547 with SMTP id
 a640c23a62f3a-c16b487d78fmr786880666b.62.1784650512817; Tue, 21 Jul 2026
 09:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715175223.make.153-kees@kernel.org> <CAD++jLk549ZcSjpRN0G27i1C-n-k-dOpmgvfZBgmHQ5s0F6dJg@mail.gmail.com>
In-Reply-To: <CAD++jLk549ZcSjpRN0G27i1C-n-k-dOpmgvfZBgmHQ5s0F6dJg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 21 Jul 2026 09:15:01 -0700
X-Gm-Features: AUfX_mx5hRFHlWZYNWCg31sOkuFqVIIRwEEvjRv3_jo_QY0cIF7eQh978jRBuUo
Message-ID: <CAKwvOdk54Fi3SHxTNA0sLQn1toDuc8uK4b0nbKYsrB42_gTjVA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: traps: Implement KCFI trap handler for ARM32
To: Linus Walleij <linusw@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Nathan Chancellor <nathan@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Zhen Lei <thunder.leizhen@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 12:54=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
>
> On Wed, Jul 15, 2026 at 7:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
>
> > ARM32 GCC KCFI[1] violations currently show as generic "Oops - undefine=
d
> > instruction" errors, making debugging CFI failures difficult. Add a pro=
per
> > KCFI trap handler similar to the aarch64 implementation to provide clea=
r
> > CFI error messages, including the call target and the expected type.
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> > Clang and GCC trap CFI failures differently on ARM32. Clang lowers
> > its checks to a BKPT, handled via the breakpoint/prefetch-abort path
> > in hw_breakpoint.c, which cannot recover the target or expected type
> > and so must report via report_cfi_failure_noaddr(). GCC instead lowers
> > KCFI checks to a UDF (undefined instruction) whose immediate encodes
> > the registers involved, so the handler can decode it and call the full
> > report_cfi_failure() with the target and expected type.
>
> Aha, that explains a few things.
>
> The UDF is a better approach for ARM I think (Russell will know best).
>
> As noted from earlier conversation the breakpoint usecase overloading
> on ARM is a mess, and we would certainly like to avoid it if possible,
> albeit I have a patch in Russell's patch tracker to paper it over.
>
> Do you think that long term we could switch Clang to do what
> GCC does?

Yeah, I think that's reasonable.
https://github.com/llvm/llvm-project/issues/211032
https://github.com/ClangBuiltLinux/linux/issues/2176

--=20
Thanks,
~Nick Desaulniers
