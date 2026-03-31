Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA034166B
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977519; cv=none; b=UCSM7o+JA5I+CFuSVhU9GNUx9WyoyeY3+8+wwX1sCPPBSHantmGpIELbWn/CFGpVUDJFmo0cQc9tDiNCwzxGQgLEn5lgx1gUPvjdMlaYVEdcSOYUmLo5oQSf4fd830CS3cXPFTnWLSASg8rDSRnZzjvPSJrOEtag0U4ocup+LHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977519; c=relaxed/simple;
	bh=fvOPupQEnVmV/NcMv1g9ULLTpQ2SLYsqRQYOCWOIjsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xy/K/e/z2VPkmu8T7ObNRxClKOfx0NPlA8QZ0/TG9BuwELD0sSQ80+/AGO+T50ywyuVrb89iu4B4RbrcnK8E1SIH6T9QZSSWuJUWrw2aaOVSdX2KV04og1/JVV4yqKImyFDPiLRvIMpLP5u0dF8o+0bJMz+DdyFXbcOMur9cbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ODDlg+1s; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ODDlg+1s"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so11255620a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774977515; x=1775582315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5+4YPeQId4Y1cXleVK3wn4GXPFCaXiKdSrMa6qJPwN4=;
        b=ODDlg+1sKBigxb8IKslRzrsn95g72L80+2oNbPnYfjZpvHClsb+DjSYchl0oam4F7/
         e+nXC1h5wDpyvt1oxGrZh4dxFD8w0S4IjrEt+OS+z3saRS2fWsh4BKuRDl+jK4bT9pVf
         vyM9UbBzDsOEL0Ci3jgUUJ3GiHhiyRnSc3LaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977515; x=1775582315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+4YPeQId4Y1cXleVK3wn4GXPFCaXiKdSrMa6qJPwN4=;
        b=PstPtCK8nG+DpX3JyO2PdX+ESZePnWMt0qr3++Og1xoKe2Owt1SzPJgnBjgi2337xi
         wuPVgeBxl7jVfTzIbQ747BHDUwG84cmabONFzQROndphpSYIy/dHNdlYScxdn1lYyv46
         r8kzedD77u4XngnNS37UcrSvspKb7HyKVJSLzlsqI5keq5wBDBjxdbR9geyqlZaDz6fs
         D4GAOgYXEe7nuIcxFmG2oIRDw5wETPFl6Ubz3JGrN24m2/J4h3u9h4lF32Y7qX2EFymL
         hg33p6QSytjE4EyCZ0E0/fiqw0sUL5ek5YRjyhZluHoqsWSPbCRrYGDexrSZCjNpGQZM
         RisA==
X-Forwarded-Encrypted: i=1; AJvYcCVqYdW3zac52AMII04j3FlwueriAPmI1c7Fhb/2afbvE6o1ZIpNrsIwss7VPTs8xFbphFdd1bNDRd4qUdxM7qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNhJZ+vypXhIQ6T/blZM/2jYyPP62Vb/fofjq3A1IJ+pRxNX0
	AGnoXOgSvU7vi5WrAG8LVCnAbYV9IjC2DZZm9QK/cpfk5klzYGLUP8NcNe9B33C3kvRUEjsL7BA
	g1jnEa+IYsQ==
X-Gm-Gg: ATEYQzw9E+kcyV/y+egyyY5AT9Zj1q9ip2DwaiPyE9+unmFJDdfru3gAoXyCnUUTf0q
	8emLmyYyvDYHrF9qI7hkI1XugqqYtcSny/0mhlrBzcHd4BjK0y/cl3SLcG8nM+n/3GGr18W/0uA
	x2C0+YHth0nweUePv2I/RQMQcMn2V9AnZZdiLaKNa+SNGwPK2B6AgAUua7WkAHUgMi8eeJlFd7S
	sl1uICfahoEdvD4LUSuLMOINRCqtrvOIYH4euc4ducAsCnWLAJ2qrTwQRHrNDbLw05kIot7OjFW
	4UXlYrnrtMczygF64Ssqm31Kj0y8rgPP5a573KHT4cIg6cPibxaS8/YhKNk7n9wUHKVPCLKv2Jv
	FUG2LWWpDZKDKDXr+xk6cgg7m346uNRk7R1FGxFu6FxL2XNR5dw5UYWCEZaicv6rPC2d4jSw0BS
	ZGHT+tf9i/HPQ4NMkS2e+AwmXztMnrX7pKaFwtWck6LrhMEFcAOFP7FVNqUVI9R3Wqcl2z4WjF
X-Received: by 2002:a05:6402:1f4c:b0:66c:167a:30c2 with SMTP id 4fb4d7f45d1cf-66db02ab1e7mr218359a12.8.1774977515598;
        Tue, 31 Mar 2026 10:18:35 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b76078a28sm3737526a12.22.2026.03.31.10.18.35
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 10:18:35 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9358dd7f79so54598066b.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:18:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuz52if7gI0H+ka7Fvw6tDmlPHGM2Di/zagy0VW00joxyEpCOKgP4LZdp0OuVZnBUY6SdBqCmukJwWr8aKKnA=@vger.kernel.org
X-Received: by 2002:a05:6402:320a:b0:66c:2ab4:1c17 with SMTP id
 4fb4d7f45d1cf-66db02ab9fcmr248797a12.9.1774977068945; Tue, 31 Mar 2026
 10:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
In-Reply-To: <20260331163725.2765789-5-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 10:10:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
X-Gm-Features: AQROBzDm3gEHu3WZ_nfCrD45b6_U9t89WHlDWMoUx8NfrAs9jBI1Qm6jv38zdhA
Message-ID: <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
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

On Tue, 31 Mar 2026 at 09:37, Kees Cook <kees@kernel.org> wrote:
>
> Current straw-man proposal is single letter suffix because it vaguely
> felt like the least bad of all choices, and they should be short or
> everyone will just continue to type "int". :)

Violently disagree.

I'd rather have people continue to use other types than have somethign
that isn't visually obvious for *VERY* subtle semantic changes.

If somebody starts using explicitly trapping types, they need to say
so. Not just *say* so, but scream it at the top of their lungs. No
hidden subtle behavior changes. This needs to look _very_different_.

No stupid one-character things. If we go down this path it would need
to be "wrapping_u32" or whatever.

That said, I think the trapping behavior is unacceptable unless
there's some way to recover from it. An dno, that "some way" is not
the broken C++ style exception handling. That thing is pure and utter
shit, and fragile as hell. Anything that requires trying to unwind the
stack is just a complete no-go because it's going to be buggy and
untestable (sure, you can have test-cases and the unwinding will work
for *those*, but...)

I don't actually see any sane interface. The "unsafe_get_user()" thing
with actual labels and exception tables works very well, but it would
require wrapping all trapping operations in a macro.

Which is maybe not a bad idea - it's almost certainly better than the
overflow builtins - but might also be disgusting. Hard to tell.

              Linus
