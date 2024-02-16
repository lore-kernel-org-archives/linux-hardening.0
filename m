Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AEDDC4
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049301; cv=none; b=Tf/UOVtHmfVvoaS2VWInLUDY36+XWkbd7B57lvE8csdxZ8isZwpvwUZHBO4H32YCYBkk6sQyFC+SHOjrfIfV28sMqmUC/jdkjgSnrW0b30E+aE3cXgpD+2edu6686q9ZSBg3njjB2xMeYqfiBHDCg1nT39l5FJxG7icft/ooI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049301; c=relaxed/simple;
	bh=WPcvYjxb4w9YIWWYMIdg7ZaHOMchUT6fLkJQ32xNvGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be7K5YGVk/gNeijmjCOeiiPb2dCNcMdU1C6VabW3bemd7yqm9CdCxUR1N+fvub4H1ji1ldyXKKMmOeD8072jm9tSUZUmWZtEC4Mmq/lPQQ0DRxa25Lo+2jAB8DM3nxrR3l56onyI7JdPW4/M1I+0JYkYx9gcbmhmPxy/hTFWvFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8ZfnsEY; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8ZfnsEY"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2a67daa25so885668241.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 18:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708049298; x=1708654098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTc+84P6h7qaWeWHuphcF1mjd1aBRb3DZ4CwaFy4lYo=;
        b=F8ZfnsEY9AMBsWiS9+Kr0I1W7htlFpQaKrgiohxGWdNuQoyB+PakJ5fOgJLcsj+mT6
         hooVrF6+gHuO/8RnOTC6D1flI5iXuDAbM7R07Nk2JblS4tXBXtA+e7+/3REDmZCbwsGZ
         pOClFUiIn6ZFGiMqLlKyF7p5Y6UwjFlnzoD2+dbSNyEZoKunOx9ki0/Y6PbNxRctwk4t
         swZbmeBaZ77PWrW91REbay/omybMYM8j+c0i8CPyrVLKxRx8V+KiV/XYwQykrzs/3pqR
         TeYpfnaRpG2/EmNj9fKKZqTmFTIWofDlk8yIX0YLHnMIC65lD5rUG1aPxWItC8mv+DuF
         lOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708049298; x=1708654098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTc+84P6h7qaWeWHuphcF1mjd1aBRb3DZ4CwaFy4lYo=;
        b=i/ZFoR+WEhNxa8mh5hI++y98KKKFjKSIHyKBHzEbodnqdlLY5lyCKYxu/8iVLpa2rT
         fqJl+LbtVyc/RVbPjKBrcVh0h973igsjc861FC8vLxXszQg/EDG/4otUCnwfZtSEPKDA
         yJ+G5CXIiEH7DCzzrpqDCSeEgVvE5Wqxyj5kRP8oTF2wxiIHyKH95lYA5ChZq1+Uh5jf
         Dw9RP42ex6DKtowoPGTH4pMhK19x5ABjkYOpRtkceKf8obw4kiPWaYWTm/03l2oxXWgQ
         awAaMb6l3ftVy1T0LquP36w5gwv8SsPu00cxDUa48koxDUz0LXdQsVR9gZ4xQwwb0rCx
         PAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUajuUuioyPXRTvvc/3O1VwcG6/uzlDGJgNMO2YZKQl+2/JLlU6oD7cHmaYEaB+/R6l622XlSk/Grp9VoEC3sVGWLmdP0HwRhvetC+AF27J
X-Gm-Message-State: AOJu0YzMhJ9OzQ4l5ALOot6bhUQ2fKS6lSW3wMSshP8t27VElj5uEekS
	EjnSqs3/cXD+Y00t8HLpjHLDxQq3tyy6FmaUEcifxegUSoCYERCM4iKv5v7IwHZVLODc75xFnoB
	qDheiKzY3J8W8cxeWAxyjAj4Aiec=
X-Google-Smtp-Source: AGHT+IG4WvUcl0FAVHjhMGixRZsvdpjswizL3cOSEl7lIA4nqJnbB7abKKT72ncNf7SNpPQDfh8YGoP72xLCH1INXLI=
X-Received: by 2002:a05:6102:243c:b0:46e:bcbe:67cd with SMTP id
 l28-20020a056102243c00b0046ebcbe67cdmr3458871vsi.18.1708049298588; Thu, 15
 Feb 2024 18:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+2EKTUwj-WzNh0BNxCdAQoxRyn1Bg7Nx7yaXJBSeqoGTBkLrA@mail.gmail.com>
 <202402141415.FF36393A@keescook>
In-Reply-To: <202402141415.FF36393A@keescook>
From: n132 <y0un9n132@gmail.com>
Date: Thu, 15 Feb 2024 19:08:07 -0700
Message-ID: <CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com>
Subject: Re: Two Seucrity Issues for arch_randomize_brk(arch/x86/kernel/process.c)
To: Kees Cook <keescook@chromium.org>
Cc: security@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 3:31=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Feb 14, 2024 at 01:31:47PM -0700, n132 wrote:
> > Dear Linux Kernel Security Team,
> >
> > I am writing to bring to your attention some security vulnerabilities I
> > have discovered in the `*arch_randomize_brk*` function located in `
> > *arch/x86/kernel/process.c*`. This function is critical for generating =
a
> > random offset used as the heap space offset for programs in user space.=
 My
> > concerns are twofold:
>
> Thanks for bringing this up. FWIW, I don't think it needs to be private.
> The limitations of the brk randomization is understood. Regardless, some
> comments below:
>

Thanks for your attention to this issue.

> >
> > *tl;dt*: Heap can connect to bss's end and the offset between heap and =
.bss
> > is in the range of 0x2000 pages.
> >
> > 1. *Insufficient Randomization*: The current implementation, which reli=
es
> > on a 0x2000 page offset, does not provide adequate randomness. This
> > limitation could allow attackers to brute force the heap or Position
> > Independent Executable (PIE) addresses if they acquire one of the base
> > addresses. The predictability of the offset significantly lowers the ef=
fort
> > required for successful exploitation.
>
> The brk randomization entropy was originally chosen on ia32 and came
> with some concerns about programs where randomization broke assumptions
> they had about distances between various allocations.
>
> See commit c1d171a00294 ("x86: randomize brk")
>
> This is using 13 bits of entropy, which isn't terrible. On x86_64 it's
> not as high as stack (28) and mmap (20), so I'm not convinced it's
> "insufficient" (brk is used for somewhat limited purposes). Perhaps we
> could raise this to 20 bits on x86_64? (Totally untested...)
>

20-bit entropy (same as mmap) is not bad for x64 and it's okay to keep 13-b=
it
entropy for x86 since the limited memory space.

> > 2. *Lack of Guard Page*: In certain instances (with a probability of
> > 1/8192), there is no guard page between the .bss segment and the heap. =
This
> > absence facilitates an attacker's ability to overflow from the .bss seg=
ment
> > into the heap, thereby extending the attack surface.
>
> Getting allocated next to .bss is certainly not ideal. It should be
> possible to trivially add a guard page here with something like this
> (totally untested):
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index ab49ade31b0d..1489829e86e2 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -1030,7 +1030,7 @@ unsigned long arch_align_stack(unsigned long sp)
>
>  unsigned long arch_randomize_brk(struct mm_struct *mm)
>  {
> -       return randomize_page(mm->brk, 0x02000000);
> +       return randomize_page(mm->brk + PAGE_SIZE, 0x02000000);
>  }
>
>  /*
>

It looks good. That is also what was in my head. Can't find another
simple and effective solution to this issue.
I did some tests for this modification, finding this can set a guard
page between BSS and heap.
Also, this modification doesn't influence other parts of the kernel
(since it just avoids one possible case).

> >
> > Given the complexity of the necessary modifications and my limited
> > experience in kernel patching, I am reaching out to seek your expertise=
 and
> > assistance in addressing these vulnerabilities. I am looking forward to
> > your feedback and am willing to provide any further information or
> > assistance required to resolve these issues.
>
> What results would you see as solving the issues you detailed? (And feel
> free to bring this up on linux-hardening@vger.kernel.org)
>

Your fix looks good to me. We can try to solve the "bss overflow to
heap" issue first and figure out a way to
add entropy later. I also cc this email to the hardening team.

Thanks so much for your help!
- Neil

> Thanks!
>
> -Kees
>
> --
> Kees Cook
