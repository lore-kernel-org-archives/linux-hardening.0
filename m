Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26406156997
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336135; cv=none; b=W2EVjbhNPTkjpKejX32wF/gZyXGSmnJGn9O6mpMakH8Dh5g7rs+HK3x4YIhvkDkg3sYyM5fqbMo7WsRzkla9asg4SgfRFvf6uj6wK/ulNI3Sj1DQ17Ug+gvExKd/I9A25la6TAJWJqdb+GcShhZVl8YbocgOE41RfaH8gCz/nZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336135; c=relaxed/simple;
	bh=MynsRNhbsrPxtvbvVnizBFDmaHSKmIVq2jBDR00CZe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw135t9T3DE2Gh/QztJ0j3ieh8b8lUsQhcZqMnjmAW92AGcav8Fg2+alaqGFdsfnfmhjWzXwbI3xJU7Z8OW3ErTa8fOmh7n/xBrpdRk0Qqjnk67f9mVdyQu0cpAJABZgPyhG9TZRypSNAuN1nXR5VzLTjCLggPXbvq26Mc9yBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FvXqDJ1n; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FvXqDJ1n"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71d4d219668so5537a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 04 Dec 2024 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733336133; x=1733940933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68dt2HgYewZvMgqBoQCqDcy5OhUsWD36S+bti5sC6DA=;
        b=FvXqDJ1nxUjNr5RZtpHjQcOGRCIc6X+3H2ZWdRfkTzKX/16P24DHQXHQD0QdWk4luj
         B4hMeEoeNdfqH6/CGwbCViBUVB5plnogYSZmc0pxaGu50NPcSkQe3PG55REhXUpf8qsR
         rATyDyp3x3hKFGARrMrkyECreMJfowzvo038Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336133; x=1733940933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68dt2HgYewZvMgqBoQCqDcy5OhUsWD36S+bti5sC6DA=;
        b=XUYJb4OIOnNbMssjkJQ5nDIKZOrjYaVWXLLiuriWbjC7uQVlY2uHIdbytMRnjkEYQp
         +pbRwdC5Df+B3ddwJRVv/5cU/iqfmiXdMmIWVUxZOnQjaxFyXRbLRIWH/4aTbXWkF/cR
         jROGQn0QMSCdTB1ceKZo0jF5iKHI2Vcvg85Bgx30ymY5ikL919eJqXaP6HLIKihOg82d
         a/9H83E4paskDJn7dqPVgy5FEFwGGeDp7gEH6m4hCRu6uVZuqb259Odxtx9awE2DB8Dp
         rRvkjBZFOLzTFoPC1aWqMJk4VmbUZ+Z9SDVPKbzSczCpyIikgnNgpOzD2n0srKM/Oed1
         a77g==
X-Forwarded-Encrypted: i=1; AJvYcCXfufRpWpWGkss0H8J3BdAFlcx2KQzEnhjB3L3EnFRruYYnlzNxe45POgwgXDRF40fOss+G1qYMb6q6ADTkTP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6sbbR1MVFqPC5ZNqgD1iLEQzm0CemafKi2FE+b3oVuD/wb/H
	tpAzdI42WVQ1E03K58LVlq2V/z6dhIzHbOGwBhx5LoMAzkrpOp7eRUAYzP83Zyfw4pGhwsSdEnk
	GtkuNQ33Tmvawxzp5Sq5e+7pPRf+Q+yLFmYaZ
X-Gm-Gg: ASbGncsyy5jpdE9SNB0fLyZdkv/fGPwf1K5CNFryvykgepHTCkzLCrM/ash2PuMIua9
	uL4jy61Cvf4qJg8JUE7FqU3fRysILAqfw4GWf/w8CArw+MZNSAd9TupWDU1XM
X-Google-Smtp-Source: AGHT+IHSY3KSf7hwPB8tBn76hJj1nE6eqGS9AJv5tyDMXL1lgnT9RR66CgdrlG66pzAXzpS+35RknTDRTr+qOeL2MRc=
X-Received: by 2002:a4a:e6cd:0:b0:5f2:37de:57f0 with SMTP id
 006d021491bc7-5f25aa946c8mr1235349eaf.0.1733336133206; Wed, 04 Dec 2024
 10:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806214931.2198172-1-jeffxu@google.com> <20240806214931.2198172-2-jeffxu@google.com>
 <20241204190429.0a18dd22@mordecai.tesarici.cz>
In-Reply-To: <20241204190429.0a18dd22@mordecai.tesarici.cz>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 4 Dec 2024 10:15:21 -0800
Message-ID: <CABi2SkWT61E6UwWPic414QyZKg0Rsv2KttNRvfcwxQrbvXWvxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] binfmt_elf: mseal address zero
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, adhemerval.zanella@linaro.org, ojeda@kernel.org, 
	adobriyan@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	jorgelo@chromium.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 10:04=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesari=
ci.cz> wrote:
>
> On Tue,  6 Aug 2024 21:49:27 +0000
> jeffxu@chromium.org wrote:
>
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Some legacy SVr4 apps might depend on page on address zero
> > to be readable, however I can't find a reason that the page
> > ever becomes writeable, so seal it.
> >
> > If there is a compain, we can make this configurable.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  fs/binfmt_elf.c    |  5 +++++
> >  include/linux/mm.h | 10 ++++++++++
> >  mm/mseal.c         |  2 +-
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 19fa49cd9907..f839fa228509 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1314,6 +1314,11 @@ static int load_elf_binary(struct linux_binprm *=
bprm)
> >                  emulate the SVr4 behavior. Sigh. */
> >               error =3D vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EX=
EC,
> >                               MAP_FIXED | MAP_PRIVATE, 0);
> > +
> > +             retval =3D do_mseal(0, PAGE_SIZE, 0);
> > +             if (retval)
> > +                     pr_warn("pid=3D%d, couldn't seal address 0, ret=
=3D%d.\n",
> > +                                     task_pid_nr(current), retval);
> >       }
> >
> >       regs =3D current_pt_regs();
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c4b238a20b76..a178c15812eb 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4201,4 +4201,14 @@ void vma_pgtable_walk_end(struct vm_area_struct =
*vma);
> >
> >  int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phy=
s_addr_t *size);
> >
> > +#ifdef CONFIG_64BIT
>
> Strictly speaking, this should be
>
> #if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>
> But since we do not support any 64-bit architecture without MMU, I'm
> just making this marginal note, so it can be found in ML archives if
> needed.
>
Noted.

Thanks!

> Petr T
