Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F44E4C40
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675384; cv=pass; b=jSr7EHHFyglGGePSkWGZXTdKWA9OCN94yyVbyUS7PzdnCN5ZWV2xzUionmuLNuCbIOrGDz3sAjsZXObA7vTObCuRsBnYlrQ4m9vf0PYIGYjdZm7dXDhubevZbIsHKw+VfamYoh8TuE/kKLrAnelV3jIIlaAlp0asqFWpQhUE10s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675384; c=relaxed/simple;
	bh=GpHjDtqu+AzW6bYVn14IR7601Ha7EtaAYwvYSeYG9jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHgHd/T8RsCf7Vr2JiLFM2wfNHOkwgc7oCkGQHFGIzJJbQSRui0h5TKLMVAp0B7za+03PJG9TY/oVK5hbDIIMH4pSpws5DF4kNsHRRLizKDzU6cJPG+XJAacqhcWub46W2Q1Tai27NzHvF/looCwWylli1m0agzhhiraMmxiFDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfRoG1si; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfRoG1si"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso244305e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 13:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789675380; cv=none;
        d=google.com; s=arc-20260327;
        b=b+QZ1aFS7N6Qr0DJcXrx9m8cYPEBRhYAVrwcwPhS+/0vryZA35DD64QRoI6f/mOMeb
         W8HKyR1kjaSDk0rtrNRhmbkCC1x/CVwratSog3AzYWtaiBCNcEci1a7LMsmasq/bPIEZ
         zx2Spi1Sm8u5Ti2zcwfo5A8UU4+IdTKneUdBmzcyrNFE97do+7mOmZ+WVSOI1EY4GdYS
         xXm+OfH5DCG3GxdAsDKjcNLXe5dG0EgRfZx2Nf4DHBN6hRhIRWUlqFztO3D0AUldTBRM
         DxwaTOdvVNQeph9t8W7kkKMRUWFnrLIGAUKnEBm2K2fHYmwIgns7tgStshMvISvdnutP
         GBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25a39fQthoJQenvf3ilsmj4we8U0R1UDFLTQO2djkUo=;
        fh=rBm1bn1b7YH6Z2Insdbg8XR82zhe6X4wxehs8+VgsMk=;
        b=hFrDQsOs0LDTAHNk5cOandNhw3+AhkM62eeUfBzEqIHam+9sckp7h4/ecQDkrJ0CSM
         tKAHKyKZF+FMHVF0zwO8DXRdjiC4+zkPtSCeDyRhKHme0msFfgZ2oc27gOOcIM9BDRo6
         xc873HAGpHDnB8GqBlwtfZJsWtS3M7Vkbb0g2kDC59Mqy1L+CAve1XNpXFBLnhZuFn11
         n/ElozpmmDOx0uaaYk90et6DqiuwCzKMpXjaUuU2XpW2wbM7k4YY2mEV+He4uqXhFQUg
         pvx2YMDm6AaetppyFaZIrDJpvM4bIUMNLV5k50wYJ7d281LP+/LeYIxPpabMZS0gkLHI
         sUsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789675380; x=1790280180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=25a39fQthoJQenvf3ilsmj4we8U0R1UDFLTQO2djkUo=;
        b=RfRoG1sioHwQsGYSkcve3ZDGfErdmSWrgCWHA2JlCBaobnXxnBfdr0TKVq27LK2zIZ
         UOvE17R6vYGLa6zQAttig93toa0GDEpwxIgGBTum0FIhjWQ2ZvB9dyNYwvdV/otOI5vm
         A3ZFMmlVd6uq3DhAGMGK/mu80sINzK4rP2D3RMyU2gORKLRV1tGre9kz1kts6W1QAYaT
         9XuABFIURZMRzl1KZihvHVFw9CQ9VbWSNQiQyhE/Rv/Yb9DXy8oRagR/6b1gegQS3v8y
         YYEboH4Y45Pq3GkmJCdeXvha1ezGt4n7sH0US7ujlIUX6kFFOMpc2oolhcFXbjqXk/zG
         N+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675380; x=1790280180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25a39fQthoJQenvf3ilsmj4we8U0R1UDFLTQO2djkUo=;
        b=KMgpnH1mbpOnsbTzKUaVXDZIXuVVNsYOrpPd50qtY1OX7v0X4ELqAUnlxecvhadPUC
         CDXYS655xi8UpHJqVbWUAF6KvViPq6M1Ww6D/jvTNwn24V7XUPjetJZLq2YBlkqYL3tz
         SJYDmiF9S2PQelVpAKvLzKCl9I4voJAJgqqe8DGFmxNn9gBc+d+FQajzdEoS2nTlNb8j
         /eMZNjPeKJcjdMyLAl40XZ3pIQ2qN5xRRyZBZ3cDilUxfww7tQBzw8XPglBJ0SfWha4Q
         tZ+cMyuXLuNSx34GuJ0pnO/Emx+rMPxaAKuaQSZ3Hs+FZctfGP0w3kfJyE7idKg7GwzK
         H47A==
X-Forwarded-Encrypted: i=1; AKwUvBxt/5wulbICW3iyaFn+qLJJA/bCLXzIjLW8NpaJhzkf6pifbuukX68oqj9FIZlmyOOKXLw+aSgP+kpLfx0sQO8=@vger.kernel.org
X-Gm-Message-State: AFuF++k3su85Ay77cYzhiEVGrCn1JjJS6xf7T7lGUAI3oZ6yVYiXTekK
	wBeuNsxu4kMNNKc05ScmwMH5HFRdY7q/aIJ+DaQteuGsYWTjUApxSNfHQ7nun2NpchLuZ395JuO
	YB5mhALjVpMaXyndYtXtq96RenPSkureEYzsZ7I1g
X-Gm-Gg: AYBFou23cOCI40Dsy9TWu1KHHdBrNQ4BO9uFsDoSItTkGIr48COoIRtY6KymJ7YFfYy
	ujQgUP2WxEV1ueCtCGXnm6qm5YVR4EuU90ipN3JzGX2nX4+xCGi3NDhNrijxHmnc+1RHj1e8sMx
	XRNycPYh5hRpVoh5VxJK0iYDCDTml0T7g9708fuvZONg5kV7ElF0VKuoJMXpJVHM8fJ6a0mh9kQ
	Tmvi55w5IwE1DKRL+96i5FpkvZko7dKq/2c+aYEUDMUeJrZpSSQDFcPxNyB64Qn1Rp1S9YSAeQw
	cCvk988ZHfEBCptdj1IPMI5jyT514xYy55Ef565l5UwhpRuuQbLMxgzsxC7t6cOfREbYKKN9wZM
	P9t5KGotc1iatrIT8Y0O8rNYeIazyK0BMSynf4DZeARNfHTse+HpXs7H9Oq2tcQZ/gvCFOUQ=
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id
 5b1f17b1804b1-49fc574a9bcmr72735e9.25.1789675379819; Thu, 17 Sep 2026
 13:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-build-speedup-v3-0-9ecf4163ff36@kernel.org>
 <CAHk-=wjwtJQPW+MRAkQCcSGA1EZWehxBTUiEUUhdACCNHSKvTQ@mail.gmail.com>
 <aqwkk7FcQ0XWeqJW@gremlin> <aqxCNyxYRzN2Oher@gremlin>
In-Reply-To: <aqxCNyxYRzN2Oher@gremlin>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 17 Sep 2026 13:02:48 -0700
X-Gm-Features: AcwNN1XUt93HLe1Zu-oZLdknUZyAU05hxj4P7Ko_JzOHOx4U0fnT6yaI1XKYaw4
Message-ID: <CAKwvOd=zbE8MZXCNCBJNpd2WWn7f+AOfxYcmCp7e-8uFSM+D9g@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] kbuild: significantly speed up kernel builds
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:42=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Thu, Sep 17, 2026 at 06:36:18PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Sep 17, 2026 at 10:15:26AM -0700, Linus Torvalds wrote:
> > > On Thu, 17 Sept 2026 at 09:06, Lorenzo Stoakes (ARM) <ljs@kernel.org>=
 wrote:
> > > >
> > > >                 =3D=3D defconfig FULL build =3D=3D
> > > >
> > > >                         before    after     delta
> > > >                       ----------------------------------
> > > > Threadripper, gcc        32.5s    26.3s     -6.1s (-19%)
> > > > Threadripper, clang      34.5s    27.2s     -7.3s (-21%)
> > > > EPYC, gcc                28.7s    20.6s     -8.1s (-28%)
> > > > EPYC, clang              39.8s    32.2s     -7.6s (-19%)
> > > > M2, gcc                 519.3s   512.4s     -6.9s (-1%)
> > > > M2, clang               634.5s   569.4s    -65.1s (-10%)
> > >
> > > There's something odd going on with that M2 gcc build. Why is it such
> > > an odd duck?
> >
> > Ugh dear lord I think the LLM somehow corrupted the numbers... Let me
> > re-run those myself locally and come back with the actual times!
>
> OK numbers are in:
>
> M2, gcc                 564.7s   512.1s    -52.6s (-9%)
> M2, clang               615.1s   564.1s    -51.0s (-8%)
>
> From the v1:
>
> M2, gcc                 564.0s   512.4s    -51.6s (-9%)
> M2, clang               616.1s   569.4s    -46.7s (-8%)
>
> (Tested as per the cover letter pre-reqs, i.e. applying dependent series
> first etc.)
>
> Not sure on the -5s delta on the clang build :) that might have been me

Clang is faster on Thursdays.

> being more disciplined this time to not use the laptop at the same time.
>
> But broadly in line with the original numbers.
>
> >
> > >
> > >              Linus
> >
> > --
> > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo



--=20
Thanks,
~Nick Desaulniers
