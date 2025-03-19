Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38B24E4C6;
	Wed, 19 Mar 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372701; cv=none; b=lIPxvs9JrHXlzoXOOVz6fuWem/jXq+pqFFoox0XT99w/J2Lsi5FZfkzZI15v/cySXeuASUZCltCO1YuemsxhcR0wmz/fwhiWBvR4b/HyJsQUIanvHtOK00mPz46qKSKDyWRWAJaczayERZXNr616HoO5BGfRbkJNhZhJJq8TyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372701; c=relaxed/simple;
	bh=S0AYngSp6IRwU5XoS2YJ1FLiuxJpd63Qv7ZYag1p6k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQCvUB5HY7uzQISEo/Z5fAJkkgbO4M9zkP2f2qdYp+yOQqwhlqq2zvLFF9sp6y9xzpNbOrlsgLwV9KbXlDKB8db4NPE2YCjZFTQSePgQfasVdJwvFZih3JYVlAgx8s/5LkO2BR2paGeiQOs9Kb7P5z4DQeB4UKNs0qqu5uFnJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso1304864fac.2;
        Wed, 19 Mar 2025 01:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372698; x=1742977498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3Ds+jegAtMklTvKU082/ddFxDidNFmq+32PxWXwrHY=;
        b=sgxNeeM5n+kpTh4ZXVIM0A3ptJmBqt2rZUU7EPdxPrfFVt1FzrXclyj7cay3Q4raps
         LY7OE0iGR7YAneMrJAvx8CCM3RdQa6AkM1qJW2mRZHL5VxqzQA8n+TJpRh+0dI6vqucr
         hE4aow6JSmLM8D3OsjfGoFWChW4CDlJS8jiGQL2sf7kVtwVlo7nT8bxDVrJMGmC5YLg1
         nm+FkSeFOog4mtUp4cUUleEG+1Lv1e1rORTYMvNb6m3/d+voqG5mZ5BnKprniTXwiGUj
         DI7h/khEgbOVo3/P3kSqWXduntgEAsTP5D2kKRUGcRJh+j2xg8Uj1gvI8ukPp0LNZVC8
         oZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXI8sOS5+fH/bDyyq7LwooLHjEtVvFisE8g8mNXKLCxuxTKyZCeyblQwq2HQYEi2fg5zTq1WA8MeQJ+lsTvvco=@vger.kernel.org, AJvYcCXbi8wEyvp6OspOlTAfn7z768kEDELhvi8vB2Z/eeqAhoFBoJj59C/d5QkInEVd4GYpD0ACIhgv5JaxH6YA@vger.kernel.org
X-Gm-Message-State: AOJu0YwSythYQsouYXXvd/2nP5kunQx0uTq2mYHll54CPee7JlIciaZa
	VZjJqhB5i9b09SwNl+y4MTMyP+51CQn/q5bLIfVTYj3wtJJ6Gon2T/10Pv3d
X-Gm-Gg: ASbGncsF1MuqQ0lXuvjJERzYVVQW7VE9f48fBzmYSWBwJqkO+MJw847AzLq6sSDIP9z
	4epDFDwqQYAKLfJDvQN8rVcqMw33klBmaHfdHU0WhRvuhfVTn3vECn+TwmY7FR9VB4TvLGQNJP9
	ocSg+nEVaL/Xor27iDq4OoTzNepzpPuimcvrQQWuGn39fkA7i/sXBXHF5u7C03c9L9QUjPvp0nx
	qGToPtpUylDq8wdCh3IetaMTEnCFu/F82lIlwULKokZNfA5fdAOWDE2A+cm7e7dCOAyesjb4ZoA
	BU1iu78yEpxw1GAZwZVTVJFDo/SVMBYw2gQ1FeYe6OdgWUbniECTwbLF+WVJtdzVghNFb9QICaJ
	aUAMXzd8=
X-Google-Smtp-Source: AGHT+IHpG7ozEEFAwC7ZYZwul7Bim+b3rjCzxWKVGLavArh8gld5ocpTRlRAp6Fby4FQy1xmyDufVg==
X-Received: by 2002:a05:6870:17a0:b0:2a3:c59f:4cba with SMTP id 586e51a60fabf-2c745597402mr1308017fac.17.1742372697775;
        Wed, 19 Mar 2025 01:24:57 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8d7sm2328856a34.3.2025.03.19.01.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 01:24:57 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-728a433ec30so2097147a34.1;
        Wed, 19 Mar 2025 01:24:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAk2x/LxOb7fMKs9UlJGnybmxPi6FULlJoP+F7pvtAsI87rWzgfJaBzqMyxjNmULkpEeEOWAOX3l/MA0zj@vger.kernel.org, AJvYcCXpxd5FA/TfzO8F6rN3oZUfLVgVH3UvfB/lOUOzC6dEmr8JO5b2k7ADmEAxyzY171HWOY8rTMMGuO4suv5jyKQ=@vger.kernel.org
X-Received: by 2002:a05:6102:e11:b0:4c1:9288:906c with SMTP id
 ada2fe7eead31-4c4ec6725e3mr969799137.9.1742372251934; Wed, 19 Mar 2025
 01:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
 <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
 <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
 <CABi2SkWmxwM-MbfmRCZvBYek8KpmOKPMsFmb=-eZTgKfp3AN6w@mail.gmail.com>
 <CAMuHMdWUHwRXR1VHEVJm36Dp0B_H6SNwtWHAW1dMQ-iM4ORUWQ@mail.gmail.com>
 <CABi2SkVndMyOUpRR8z7f0J-r7chkVNZ17-kaEcBje1kBjk-1iw@mail.gmail.com> <CABi2SkUAnWAu9L-Km35U4XMmbp9-w+hKCXkM6MYNejYi5ip5Tg@mail.gmail.com>
In-Reply-To: <CABi2SkUAnWAu9L-Km35U4XMmbp9-w+hKCXkM6MYNejYi5ip5Tg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2025 09:17:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUruXfLCZ7vC+VmPRnJUH1Z1LnN9iaeafGaa_EAisnk6A@mail.gmail.com>
X-Gm-Features: AQ5f1JpO0_XcfXoHShSgJlnBUI9J7DjzvJzSL8Es7jU8eavT6AC7t4ncH5mz_20
Message-ID: <CAMuHMdUruXfLCZ7vC+VmPRnJUH1Z1LnN9iaeafGaa_EAisnk6A@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Jeff Xu <jeffxu@chromium.org>
Cc: edumazet@google.com, m-malladi@ti.com, 
	Kevin Brodsky <kevin.brodsky@arm.com>, guoweikang.kernel@gmail.com, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, svens@linux.ibm.com, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, 18 Mar 2025 at 19:39, Jeff Xu <jeffxu@chromium.org> wrote:
> On Tue, Mar 18, 2025 at 10:21=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wr=
ote:
> > On Mon, Mar 17, 2025 at 12:14=E2=80=AFPM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, 17 Mar 2025 at 20:02, Jeff Xu <jeffxu@chromium.org> wrote:
> > > > On Mon, Mar 17, 2025 at 11:14=E2=80=AFAM Jeff Xu <jeffxu@chromium.o=
rg> wrote:
> > > > > On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <geert=
@linux-m68k.org> wrote:
> > > > > > On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wro=
te:
> > > > > > > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.o=
rg wrote:
> > > > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > > > > Add Documentation/features/core/mseal_sys_mappings/arch-s=
upport.txt
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > > >
> > > > > > Thanks for your patch!
> > > >
> > > > I used "find * |xargs grep -i  CONFIG_64BIT" to look for CONFIG_64B=
IT
> > > > under arch/, and together with internet search/wiki page, and below=
 is
> > > > the proposed update.
> > >
> > > That way you only find users of the symbol, not where it is defined.
> > >
> > > You can use
> > >
> > >     git grep -W "config\s*64BIT" -- arch/
> > >
> > > to find out which architectures are 32-bit, 64-bit, or support both.
> > >
> Microblaze, openrisc, sh, hexagon all don't have CONFIG 64BIT defined
> in KCONFIG, and are not using CONFIG_64BIT in their arch code.  Is
> there something else that makes you point out the hexagon as 32 bit
> only (and not other 3) ?

AFAIK Microblaze, openrisc, and hexagon are all 32-bit.
Linux used to support sh64, but that was dropped, as sh64 never went
beyond prototype hardware.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
