Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB0C55178
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 15:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485D6223C7
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 15:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqXQFUGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKCP2w (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgKCP2H (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 10:28:07 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8407CC0613D1;
        Tue,  3 Nov 2020 07:28:07 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n15so16279475otl.8;
        Tue, 03 Nov 2020 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxNgOQvQzQD1y7rtzGi+GT8dfHZ/R+vwp6DNWXHP+vE=;
        b=jqXQFUGx3VlYxUOMhmR5gJfjoaqEGWaK5mUIDBDB/tdIadAYMPjEoZTxw5wgnKHMqy
         MOC3GURBn1BRFjBgNFBlcA/wVrDm+EH5DOAtaqEdKIbQV3hYdkeMoOXOQT69W1hc8spN
         Mrk29ebYkwy84a690nCxRRAOuBTAsjt83a2Ds+MUKZQIeq1toCZxiTwFNQLkAqCdZ2Il
         l+JFlT22l61AkxG31ShaC0Qw1oYQLWteXY+34as661ZjgCOZxVZ4d0zuTjR/G127u4UX
         JbIKX0/2p+TczVDqr4LHqCb3uXkUMhdun2IoI7AWx+/DSq3jntw3iR2acEB6PXyKr30Z
         6OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxNgOQvQzQD1y7rtzGi+GT8dfHZ/R+vwp6DNWXHP+vE=;
        b=gXmMhcpCP0Pm9YmtpFs6PrNW4TtxavOdYSO39oE+CmXwvIhTTsYCJzN6YDXzUlQ/6t
         Zl0stSLGMAa7xkNG8xZ6+Xx9DiQNBO5fYQCL8rSPg3tImp0gC7YTOcYWl8eJS245F/Ih
         zf5O/F3CQmzjs4NDSXHWsYb26GUCoV6+oWAdiCoiDSpWgwxX8HotlmAvRN/wRbBaA5ma
         ZEKaeCbBJuvO133erNS6kBjpYmYSz5m0uGjiAY4Iq/CppxFAVLT+mIzGVGNVBMhMHxQt
         6rnK9jH+pmz748k+Jot9Kaa3Id6mMiiAFJZdIEgxBZRNs88ow29geFDmMo0GV7zwRl/+
         jhTQ==
X-Gm-Message-State: AOAM530u1UskF2OYGZjZyfJ8bhy3FNmeYBC1MCdKcUedhTFxJKH/wB+T
        iOC7WWoI/t4SK/XK/nUQigwi7ddRQ1FjD71lRDVCO9R76Kc=
X-Google-Smtp-Source: ABdhPJwGf6FEVyrEXjFf9t9cigS6rbgz0ERQiGUrPDsmdeMbF27OaQ5ITy8dCxdVHxMqP6aMsG6w0X53iN/Yb2aDnYo=
X-Received: by 2002:a9d:4703:: with SMTP id a3mr16366490otf.179.1604417286824;
 Tue, 03 Nov 2020 07:28:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604393169.git.szabolcs.nagy@arm.com> <7b008fd34f802456db3731a043ff56683b569ff7.1604393169.git.szabolcs.nagy@arm.com>
 <87r1pabu9g.fsf@oldenburg2.str.redhat.com> <CAMe9rOpmiiBEZqLz-94_MEwgRky+EUsfd=X6Ue30H2c9R=dSKQ@mail.gmail.com>
 <20201103150412.GA24704@arm.com>
In-Reply-To: <20201103150412.GA24704@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 3 Nov 2020 07:27:30 -0800
Message-ID: <CAMe9rOpOn7YgarNf5R1x6DFKC5fsnQBJX7--yQWjP4x=jBMmjQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] elf: Move note processing after l_phdr is updated [BZ #26831]
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 3, 2020 at 7:04 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
>
> The 11/03/2020 04:36, H.J. Lu wrote:
> > On Tue, Nov 3, 2020 at 2:38 AM Florian Weimer <fweimer@redhat.com> wrote:
> > > * Szabolcs Nagy:
> > >
> > > > Program headers are processed in two pass: after the first pass
> > > > load segments are mmapped so in the second pass target specific
> > > > note processing logic can access the notes.
> > > >
> > > > The second pass is moved later so various link_map fields are
> > > > set up that may be useful for note processing such as l_phdr.
> > > > ---
> > > >  elf/dl-load.c | 30 +++++++++++++++---------------
> > > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/elf/dl-load.c b/elf/dl-load.c
> > > > index ceaab7f18e..673cf960a0 100644
> > > > --- a/elf/dl-load.c
> > > > +++ b/elf/dl-load.c
> > > > @@ -1259,21 +1259,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
> > > >                                 maplength, has_holes, loader);
> > > >      if (__glibc_unlikely (errstring != NULL))
> > > >        goto call_lose;
> > > > -
> > > > -    /* Process program headers again after load segments are mapped in
> > > > -       case processing requires accessing those segments.  Scan program
> > > > -       headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> > > > -       exits.  */
> > > > -    for (ph = &phdr[l->l_phnum]; ph != phdr; --ph)
> > > > -      switch (ph[-1].p_type)
> > > > -     {
> > > > -     case PT_NOTE:
> > > > -       _dl_process_pt_note (l, fd, &ph[-1]);
> > > > -       break;
> > > > -     case PT_GNU_PROPERTY:
> > > > -       _dl_process_pt_gnu_property (l, fd, &ph[-1]);
> > > > -       break;
> > > > -     }
> > > >    }
> > > >
> > > >    if (l->l_ld == 0)
> > > > @@ -1481,6 +1466,21 @@ cannot enable executable stack as shared object requires");
> > > >      /* Assign the next available module ID.  */
> > > >      l->l_tls_modid = _dl_next_tls_modid ();
> > > >
> > > > +  /* Process program headers again after load segments are mapped in
> > > > +     case processing requires accessing those segments.  Scan program
> > > > +     headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> > > > +     exits.  */
> > > > +  for (ph = &l->l_phdr[l->l_phnum]; ph != l->l_phdr; --ph)
> > > > +    switch (ph[-1].p_type)
> > > > +      {
> > > > +      case PT_NOTE:
> > > > +     _dl_process_pt_note (l, fd, &ph[-1]);
> > > > +     break;
> > > > +      case PT_GNU_PROPERTY:
> > > > +     _dl_process_pt_gnu_property (l, fd, &ph[-1]);
> > > > +     break;
> > > > +      }
> > > > +
> > > >  #ifdef DL_AFTER_LOAD
> > > >    DL_AFTER_LOAD (l);
> > > >  #endif
> > >
> > > Is this still compatible with the CET requirements?
> > >
> > > I hope it is because the CET magic happens in _dl_open_check, so after
> > > the the code in elf/dl-load.c has run.
>
> i believe the note processing and later cet magic
> are not affected by this code move.
>
> but i did not test this with cet.
>
> >
> > _dl_process_pt_note and _dl_process_pt_gnu_property may call
> > _dl_signal_error.  Are we prepared to clean more things up when it
> > happens?  I am investigating:
>
> yeah, this is difficult to reason about.
>
> it seems to me that after _dl_map_object returns there
> may be _dl_map_object_deps which can fail in a way that
> all of dlopen has to be rolled back, so if i move things
> around in _dl_map_object that should not introduce new
> issues.

I haven't investigated it in detail.  But there are

1314   if (l->l_phdr == NULL)
1315     {
1316       /* The program header is not contained in any of the segments.
1317          We have to allocate memory ourself and copy it over from out
1318          temporary place.  */
1319       ElfW(Phdr) *newp = (ElfW(Phdr) *) malloc (header->e_phnum
1320                                                 * sizeof (ElfW(Phdr)));
1321       if (newp == NULL)
1322         {
1323           errstring = N_("cannot allocate memory for program header");
1324           goto call_lose_errno;
1325         }
1326
1327       l->l_phdr = memcpy (newp, phdr,
1328                           (header->e_phnum * sizeof (ElfW(Phdr))));
1329       l->l_phdr_allocated = 1;
1330     }

When _dl_process_pt_gnu_property is moved after it, will l_phdr be
free on _dl_signal_error?

> but it is not clear to me how robust the dlopen code is
> against arbitrary failure in dl_open_worker.

I think we are mostly OK, except for some corner cases.   Delay
_dl_process_pt_gnu_property may introduce more corner cases.

> >
> > https://sourceware.org/bugzilla/show_bug.cgi?id=26825
> >
> > I don't think cleanup of _dl_process_pt_gnu_property failure is done
> > properly.
> >
> > --
> > H.J.
>
> --



-- 
H.J.
