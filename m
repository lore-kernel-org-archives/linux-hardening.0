Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD99DDA3
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GHWuMtFp"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-20451bc39b1so2539175fac.1
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jan 2024 21:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704863442; x=1705468242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqFyBuMc6fS1E/k0UoQASz+hs9FQx1u1fDT0hLV9lNA=;
        b=GHWuMtFpYIwoe42qRwZsGFubYEvh1fXTj969PaNa7K4dQN/p9bDPfxgRNmUvq/9AGs
         9b6DLbFmS99hUBIjS7SuK82qHTDMjHSDRO/9oQ7uAS3Bc3SvgN6iUTflIXXE58lJ4EEC
         ZiCY7ys7YxVM3PKQ3USzloKxPnkmx6tItLz/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704863442; x=1705468242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqFyBuMc6fS1E/k0UoQASz+hs9FQx1u1fDT0hLV9lNA=;
        b=o3qwF7JcM3YJkAYsPkW8KGD4u0g8YKFKqGCUBOIdgiuedvI0b3oJUuvMXP87v9uEoO
         /0U7IGlDc4saAQlktGkQpoN4AMZU6f6SuWbQmHVkpf2M8q4UaJLSM3X6iXJceIaUFFpj
         t46tZ7XEe5OsuSB2D0XsNPju8Tf+myf0A3JNhC87MaUuHFuZdSNhaRakTu5gAQjzTf3K
         VLzhtsTwsZT1ub40JAWtpjBpv6xEAqRdDumo2pJs4PJRv96/cA4ngehHsIUuiu6nXT/6
         nxNU+eeyfZLBUCEnRpXwUX9Dbi4qskwQRjpmsRvW4gVNqq5H2JxzswWfSIJeSjvgdBwa
         ZZpg==
X-Gm-Message-State: AOJu0YxX6hL7o0TUxVR6HCMxcpH0o0Zw/MLoIgTRXgFvLfSWJvEA+Yd5
	Kf29cHg+/jzhF0lK0Ekm08I+6S4wSmpK5OKPqMn83+eeISTa
X-Google-Smtp-Source: AGHT+IFzInwEpmPhc/U9+ydEplUFYyrbuwyIxW/doupjiq5FShE4fPsCc8x8D2TMy9+WDinLmFAW9YkJ/grsITlSt80=
X-Received: by 2002:a05:6870:b296:b0:206:7b6:9700 with SMTP id
 c22-20020a056870b29600b0020607b69700mr182118oao.41.1704863441699; Tue, 09 Jan
 2024 21:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <20240109154547.1839886-2-jeffxu@chromium.org>
 <CAMuHMdWhHuhviuK=Ku-HUm_y9SzVPuubjiNfHS_jQMk4NRxJxg@mail.gmail.com>
In-Reply-To: <CAMuHMdWhHuhviuK=Ku-HUm_y9SzVPuubjiNfHS_jQMk4NRxJxg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 9 Jan 2024 21:10:30 -0800
Message-ID: <CABi2SkVGPjeFEk7jUHHeckx9U+EuFW8ydf8oy92KCJcSHbiWNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/4] mseal: Wire up mseal syscall
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:32=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Tue, Jan 9, 2024 at 4:46=E2=80=AFPM <jeffxu@chromium.org> wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Wire up mseal syscall for all architectures.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Thanks for the update!
>
> > --- a/arch/m68k/kernel/syscalls/syscall.tbl
> > +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> > @@ -456,3 +456,4 @@
> >  454    common  futex_wake                      sys_futex_wake
> >  455    common  futex_wait                      sys_futex_wait
> >  456    common  futex_requeue                   sys_futex_requeue
> > +457    common  mseal                           sys_mseal
>
> In the meantime, 457 and 458 are already taken by statmount() and
> listmount():
>
Thanks! I will adjust that in the next version.
-Jeff




-Jeff

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/m68k/kernel/syscalls/syscall.tbl#n459
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
