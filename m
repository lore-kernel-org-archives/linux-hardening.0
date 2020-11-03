Return-Path: <SRS0=r0eN=EJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A723C388F7
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEC322243
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Nov 2020 12:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD7mAyth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgKCMhU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Nov 2020 07:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgKCMhT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Nov 2020 07:37:19 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D39C0613D1;
        Tue,  3 Nov 2020 04:37:19 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n11so15795878ota.2;
        Tue, 03 Nov 2020 04:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrbagZwNW9slCt6d/AW8rMDwMZtrFWYw7alPEHvkmb4=;
        b=XD7mAythtfRoMdczS5VWBLhyjc7jTlavZz1aVCztraJAEromDAsGVN2YLNSbWrhI8m
         QJAJ+ra69zL0lDZxUQJesUh91Q2B82zivVUoFqa/tUWzRJeDhEp+Tko0/5rU3DCqD1QU
         u3GxNhasdzl/iL9iR2J2JR0JVKKiVQVA9mdTBYNzWmWCJqCKgX6KIBREHBksolSjLptU
         4dVSjoml5xDkIa6S5ONv6595yfQ1j1IigtUI78jmegtrtWvgX0Dzu2LE5FQ06VZMnDEq
         bBMk8WdZwFHTR3UKA0o3rINViXNQNSNWtH58O4NxyVLPTUAahVyJEVvkp5y64dANxo30
         9fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrbagZwNW9slCt6d/AW8rMDwMZtrFWYw7alPEHvkmb4=;
        b=VXtllIzxViOLhxamIz6n/6hMJya3FLsQXG0yjH/tETX7p6rQSHNdr8qWlVclShCE2n
         Y/JqtmPZKWoRgF0sfDRqtWqZV52TV1030TPPEzJwo0tfpIxyv/DBgV3taUgyC6g87TRf
         OkylXQ+ojGysHyUVSUs5bokhjHJfXU4Sc+A0yodXqS67VEI7QO4ecA8sGlVW//wwnTy5
         AfAq7DzNYQjRfkQ4y1NAOOQTE/o9IWj2MCdNWaRTZS4undTjto+iFNHdjhQ+GJNj3zZm
         3be4vKJU3nCRn3CRucIvc3kf7gAhQHguTr+7B3wap7fqqpo+Ck3lbnpiIQNTyUy1pm9v
         7dHA==
X-Gm-Message-State: AOAM530BNz3FeYFnVaBOLax7EsVB8GDu4NqsLNPIa7pfljAztGp9RaRU
        Gpd+ml34X949T1qoVptBbaX5Q15dSZy+w3MXkDs=
X-Google-Smtp-Source: ABdhPJyiy3o8C1TgEne1rTFHQu9/FF6LUkyCqxhXYUWuyQK4hEgSdw24cCTFKp2kv+fiAqnSzMITpQ8pDGqPeuVJmVI=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr14654958ots.90.1604407038742;
 Tue, 03 Nov 2020 04:37:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604393169.git.szabolcs.nagy@arm.com> <7b008fd34f802456db3731a043ff56683b569ff7.1604393169.git.szabolcs.nagy@arm.com>
 <87r1pabu9g.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87r1pabu9g.fsf@oldenburg2.str.redhat.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 3 Nov 2020 04:36:42 -0800
Message-ID: <CAMe9rOpmiiBEZqLz-94_MEwgRky+EUsfd=X6Ue30H2c9R=dSKQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] elf: Move note processing after l_phdr is updated [BZ #26831]
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
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

On Tue, Nov 3, 2020 at 2:38 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Szabolcs Nagy:
>
> > Program headers are processed in two pass: after the first pass
> > load segments are mmapped so in the second pass target specific
> > note processing logic can access the notes.
> >
> > The second pass is moved later so various link_map fields are
> > set up that may be useful for note processing such as l_phdr.
> > ---
> >  elf/dl-load.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/elf/dl-load.c b/elf/dl-load.c
> > index ceaab7f18e..673cf960a0 100644
> > --- a/elf/dl-load.c
> > +++ b/elf/dl-load.c
> > @@ -1259,21 +1259,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
> >                                 maplength, has_holes, loader);
> >      if (__glibc_unlikely (errstring != NULL))
> >        goto call_lose;
> > -
> > -    /* Process program headers again after load segments are mapped in
> > -       case processing requires accessing those segments.  Scan program
> > -       headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> > -       exits.  */
> > -    for (ph = &phdr[l->l_phnum]; ph != phdr; --ph)
> > -      switch (ph[-1].p_type)
> > -     {
> > -     case PT_NOTE:
> > -       _dl_process_pt_note (l, fd, &ph[-1]);
> > -       break;
> > -     case PT_GNU_PROPERTY:
> > -       _dl_process_pt_gnu_property (l, fd, &ph[-1]);
> > -       break;
> > -     }
> >    }
> >
> >    if (l->l_ld == 0)
> > @@ -1481,6 +1466,21 @@ cannot enable executable stack as shared object requires");
> >      /* Assign the next available module ID.  */
> >      l->l_tls_modid = _dl_next_tls_modid ();
> >
> > +  /* Process program headers again after load segments are mapped in
> > +     case processing requires accessing those segments.  Scan program
> > +     headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
> > +     exits.  */
> > +  for (ph = &l->l_phdr[l->l_phnum]; ph != l->l_phdr; --ph)
> > +    switch (ph[-1].p_type)
> > +      {
> > +      case PT_NOTE:
> > +     _dl_process_pt_note (l, fd, &ph[-1]);
> > +     break;
> > +      case PT_GNU_PROPERTY:
> > +     _dl_process_pt_gnu_property (l, fd, &ph[-1]);
> > +     break;
> > +      }
> > +
> >  #ifdef DL_AFTER_LOAD
> >    DL_AFTER_LOAD (l);
> >  #endif
>
> Is this still compatible with the CET requirements?
>
> I hope it is because the CET magic happens in _dl_open_check, so after
> the the code in elf/dl-load.c has run.
>
>

_dl_process_pt_note and _dl_process_pt_gnu_property may call
_dl_signal_error.  Are we prepared to clean more things up when it
happens?  I am investigating:

https://sourceware.org/bugzilla/show_bug.cgi?id=26825

I don't think cleanup of _dl_process_pt_gnu_property failure is done
properly.

-- 
H.J.
