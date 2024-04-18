Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9426180A8D
	for <linux-hardening@vger.kernel.org>; Thu, 18 Apr 2024 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471577; cv=none; b=DTll4oPNMR5SPZ1NOzI1YYLjLGkSTCvb+iZra0MQCiW/rLuJNPeKVymt/cGVAqU+LdrKwvIAX9uGOX+za91vsmBpJtdzq3qb7OW4tCvHWHCB3DTRdgOqyUkEvFh6WoAzTNo4eCpHFkKEpx3mSk3eSr9B2sflNRbu+W85MtXLshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471577; c=relaxed/simple;
	bh=GHCNVkmiKMtErCRmK707fpfOJuzqtHiTwgHg2mid5x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y93ZuoXovA1KkmgrRUqIbHabYl2b/9Fwy6Byif7A+6VSPYIz2es+hrY6ElS9YjICXtpB2cPPT+JFjDKfL01rbt0kB9b4tkz2ko0WdShoe1IntJHsrGfBjaJQlOs5h8GSMQQDlEulkIb8SEG0Msx+Ox3WBeXEQsL5Po2VLSgdHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAl1TfM0; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAl1TfM0"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de466c64163so1197859276.1
        for <linux-hardening@vger.kernel.org>; Thu, 18 Apr 2024 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713471575; x=1714076375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8QBUU5Ysvq0j9xQzigQOcx89V1FF41qSoo2aFaccrc=;
        b=KAl1TfM0+hVEptPYHgQvGm8MXa1sH7JbFJM/VwUV84F5h9iy7FqxkCDNCM99AssSv5
         TMhHb5LMw5sK6NVJctbKo+/G0F6ee4W+8WkAqc14EZAILDiT4IZdrlENVf8pVIt2U958
         M9MIsjZoDAq2JKI1A5lUfiFcgChPe+Fyt6scaW+hNDdsOftgFaqPZ8H4QNFW19FZiHX3
         vciCTxPKFIkozvYZpr5Iy00muX8bqs5DuesBcMKarliMY1FXmJACe9zyJRQk0utCZnJC
         kISe09Thfegsm5MwVjwhG0dqUDLGXW5F4/87uvAHE9qURS1q3NyGroghtzutW/Uj/zSx
         Lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713471575; x=1714076375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8QBUU5Ysvq0j9xQzigQOcx89V1FF41qSoo2aFaccrc=;
        b=aikhTeAmSPTBcVPAO1J2A8nQNpP28ghX2sndjHbizj0eQaeubLXiSX+buAzR2F1V62
         s1AcTkJb1YAzc/9LZgSUVO2+qb68EZWu1TSOI3TipNjW0dfs9nmScoDCGx7KcnaorBCX
         V13aj/iQx9Vgkv/3xDPUqojzfxtCxPlJdaUKrjCF2QsY0Jiu4/j5kj/hK5LiUNa+XvV2
         XTYbZs1+v2jpa6W2li6+tM1gK3GHR5+5MMm8XhUFdr8ePOag12yo/REhcwMv4x+ibgtd
         Sipk3CiQxcF60Mgi3jqCfddnxDsWs+EFA3ylgPH48a1Qh+7TzfZEdiaFrLP6XcLccfWT
         P0nA==
X-Forwarded-Encrypted: i=1; AJvYcCVakGzUGlh3Rkr7pCAL+tGtxDeXtygLqSCMA+VrC5zkNKgqg+HrF6xoA0+2RgjBt82eZB6dvfQRbe4nbhjdgdTuphxvvympzj6TAvC5Xv8h
X-Gm-Message-State: AOJu0Yy6hP01Uh082DzzRnm1JDHYQTaIU5kwwtg55GEm3VAz0P6DunNo
	Z0pcHOKkTADGimKBw8yqPRqxU52ecsjvxfs0xefzeSEBlW6yBNx0j3XWypLCaUjDcsk8ZiYg7El
	vAziOC0TF+mQ4gE3BZegeMeoLLwZngiYje6T3
X-Google-Smtp-Source: AGHT+IGu9bLqHeW4a7VwQv2rIIJwjvvl2bf1vYPr5n5skx61Fk0UUEN3VzUE36VDByjHyx19HwGN1Ahow7j5FwTcF2I=
X-Received: by 2002:a25:bad1:0:b0:dc7:4bab:c390 with SMTP id
 a17-20020a25bad1000000b00dc74babc390mr3618530ybk.61.1713471574368; Thu, 18
 Apr 2024 13:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
In-Reply-To: <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 18 Apr 2024 13:19:23 -0700
Message-ID: <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Jeff Xu <jeffxu@chromium.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 12:40=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> On Tue, Apr 16, 2024 at 8:13=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [240415 12:35]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > This is V10 version, it rebases v9 patch to 6.9.rc3.
> > > We also applied and tested mseal() in chrome and chromebook.
> > >
> > > ------------------------------------------------------------------
> > ...
> >
> > > MM perf benchmarks
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > This patch adds a loop in the mprotect/munmap/madvise(DONTNEED) to
> > > check the VMAs=E2=80=99 sealing flag, so that no partial update can b=
e made,
> > > when any segment within the given memory range is sealed.
> > >
> > > To measure the performance impact of this loop, two tests are develop=
ed.
> > > [8]
> > >
> > > The first is measuring the time taken for a particular system call,
> > > by using clock_gettime(CLOCK_MONOTONIC). The second is using
> > > PERF_COUNT_HW_REF_CPU_CYCLES (exclude user space). Both tests have
> > > similar results.
> > >
> > > The tests have roughly below sequence:
> > > for (i =3D 0; i < 1000, i++)
> > >     create 1000 mappings (1 page per VMA)
> > >     start the sampling
> > >     for (j =3D 0; j < 1000, j++)
> > >         mprotect one mapping
> > >     stop and save the sample
> > >     delete 1000 mappings
> > > calculates all samples.
> >
> >
> > Thank you for doing this performance testing.
> >
> > >
> > > Below tests are performed on Intel(R) Pentium(R) Gold 7505 @ 2.00GHz,
> > > 4G memory, Chromebook.
> > >
> > > Based on the latest upstream code:
> > > The first test (measuring time)
> > > syscall__     vmas    t       t_mseal delta_ns        per_vma %
> > > munmap__      1       909     944     35      35      104%
> > > munmap__      2       1398    1502    104     52      107%
> > > munmap__      4       2444    2594    149     37      106%
> > > munmap__      8       4029    4323    293     37      107%
> > > munmap__      16      6647    6935    288     18      104%
> > > munmap__      32      11811   12398   587     18      105%
> > > mprotect      1       439     465     26      26      106%
> > > mprotect      2       1659    1745    86      43      105%
> > > mprotect      4       3747    3889    142     36      104%
> > > mprotect      8       6755    6969    215     27      103%
> > > mprotect      16      13748   14144   396     25      103%
> > > mprotect      32      27827   28969   1142    36      104%
> > > madvise_      1       240     262     22      22      109%
> > > madvise_      2       366     442     76      38      121%
> > > madvise_      4       623     751     128     32      121%
> > > madvise_      8       1110    1324    215     27      119%
> > > madvise_      16      2127    2451    324     20      115%
> > > madvise_      32      4109    4642    534     17      113%
> > >
> > > The second test (measuring cpu cycle)
> > > syscall__     vmas    cpu     cmseal  delta_cpu       per_vma %
> > > munmap__      1       1790    1890    100     100     106%
> > > munmap__      2       2819    3033    214     107     108%
> > > munmap__      4       4959    5271    312     78      106%
> > > munmap__      8       8262    8745    483     60      106%
> > > munmap__      16      13099   14116   1017    64      108%
> > > munmap__      32      23221   24785   1565    49      107%
> > > mprotect      1       906     967     62      62      107%
> > > mprotect      2       3019    3203    184     92      106%
> > > mprotect      4       6149    6569    420     105     107%
> > > mprotect      8       9978    10524   545     68      105%
> > > mprotect      16      20448   21427   979     61      105%
> > > mprotect      32      40972   42935   1963    61      105%
> > > madvise_      1       434     497     63      63      115%
> > > madvise_      2       752     899     147     74      120%
> > > madvise_      4       1313    1513    200     50      115%
> > > madvise_      8       2271    2627    356     44      116%
> > > madvise_      16      4312    4883    571     36      113%
> > > madvise_      32      8376    9319    943     29      111%
> > >
> >
> > If I am reading this right, madvise() is affected more than the other
> > calls?  Is that expected or do we need to have a closer look?
> >
> The madvise() has a bigger percentage (per_vma %), but it also has a
> smaller base value (cpu).

Sorry, it's unclear to me what the "vmas" column denotes. Is that how
many VMAs were created before timing the syscall? If so, then 32 is
the max that you show here while you seem to have tested with 1000
VMAs. What is the overhead with 1000 VMAs?
My worry is that if the overhead grows linearly with the number of
VMAs then the effects will be quite noticeable on Android where an
application with a few thousand VMAs is not so unusual.

>
> -Jeff
