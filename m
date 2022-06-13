Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1266BCCA47B
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 19:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbiFMTET (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346966AbiFMTDK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 15:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4AABF51
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA6646153C
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 16:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDE6C3411B
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655138676;
        bh=+dTqx5heREdYCinls9Eh76fNXxrPb/Tb4OmAn0ARKWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MiCmGexNMi4VEYiQXXxcB4u/y9hjNsjDVAHRtbPNZa7q3LmybiNqnltQ/mtX4tv6n
         /lbEK52wn8HIv0hI0Eqz/EnO+twKPwPgpK4x0eXaotFSiCa3mS+2d4KP3Hdo6fmwcF
         OWXIUVgzcA6DshvgMpk3Su5SwG+H0zPr0n0LGVigFulMRW/esnqQ9ruQc82KkPTXbh
         sLd8T0cn42R8Hf2Gv42yPUbcsG9nAddFJTFH3S3LWRkD5XI+7p8eKvnFeisNnSFc2e
         81Z5+enk+WO65FFUo3jrYJHVkMfb9uVlcCkqc7j7QqlF2z61w5Qhhu6h2fIUzyYOxN
         mABmX6Em1uW/Q==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso9138407fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 09:44:36 -0700 (PDT)
X-Gm-Message-State: AOAM533Phc4mgPgp1vw+pXjL2BXRYf/jRNbhmJQQoy8NrQSJcwp9IXlq
        acJB3SN8hB94Xzi3JnixZayO1q0AhbV3naYUH94=
X-Google-Smtp-Source: ABdhPJzVj6rz5HKatO1nOr/XV626uO0OYgohA25uZtNyLr+1cTDfsYVlyEd/4Yu7c2psPGVHp07kDP6qST09jwtn/Mc=
X-Received: by 2002:a05:6870:e98b:b0:fe:219a:2449 with SMTP id
 r11-20020a056870e98b00b000fe219a2449mr8409292oao.228.1655138675398; Mon, 13
 Jun 2022 09:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220613144550.3760857-1-ardb@kernel.org> <20220613144550.3760857-25-ardb@kernel.org>
 <202206130932.592AAE7@keescook>
In-Reply-To: <202206130932.592AAE7@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Jun 2022 18:44:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEaURMfYM4tTO+zqbrp+tREmikXxXkg2c+zTwawenD06w@mail.gmail.com>
Message-ID: <CAMj1kXEaURMfYM4tTO+zqbrp+tREmikXxXkg2c+zTwawenD06w@mail.gmail.com>
Subject: Re: [PATCH v4 24/26] mm: add arch hook to validate mmap() prot flags
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 13 Jun 2022 at 18:37, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 13, 2022 at 04:45:48PM +0200, Ard Biesheuvel wrote:
> > Add a hook to permit architectures to perform validation on the prot
> > flags passed to mmap(), like arch_validate_prot() does for mprotect().
> > This will be used by arm64 to reject PROT_WRITE+PROT_EXEC mappings on
> > configurations that run with WXN enabled.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  include/linux/mman.h | 15 +++++++++++++++
> >  mm/mmap.c            |  3 +++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > index 58b3abd457a3..53ac72310ce0 100644
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -120,6 +120,21 @@ static inline bool arch_validate_flags(unsigned long flags)
> >  #define arch_validate_flags arch_validate_flags
> >  #endif
> >
> > +#ifndef arch_validate_mmap_prot
> > +/*
> > + * This is called from mmap(), which ignores unknown prot bits so the default
> > + * is to accept anything.
> > + *
> > + * Returns true if the prot flags are valid
> > + */
> > +static inline bool arch_validate_mmap_prot(unsigned long prot,
> > +                                        unsigned long addr)
> > +{
> > +     return true;
> > +}
> > +#define arch_validate_mmap_prot arch_validate_mmap_prot
> > +#endif
> > +
> >  /*
> >   * Optimisation macro.  It is equivalent to:
> >   *      (x & bit1) ? bit2 : 0
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 61e6135c54ef..4a585879937d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1437,6 +1437,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >               if (!(file && path_noexec(&file->f_path)))
> >                       prot |= PROT_EXEC;
> >
> > +     if (!arch_validate_mmap_prot(prot, addr))
> > +             return -EACCES;
>
> I assume yes, but just to be clear, the existing userspace programs that
> can switch modes are checking for EACCES? (Or are just just checking for
> failure generally?) It looks like, for example, SELinux returns EACCES
> too, so this looks correct. (Looking at the mmap man page, it seems the
> ship has sailed for this to be EPERM, which looks more correct to me,
> but so be it.)
>

Taking libffi for example, it will use the fallback on either EPERM or
EACCES, but only if it thinks selinux is enabled. If it thinks PaX is
enabled, it will not even try PROT_WRITE+PROT_EXEC, and use the
fallback unconditionally.

The only other occurrence I needed to fix in my user space was
libpcre2, but there, I had to rebuild it with --enable-git-sealloc
(which, presumably, more selinux minded distros are doing already)


> > +
> >       /* force arch specific MAP_FIXED handling in get_unmapped_area */
> >       if (flags & MAP_FIXED_NOREPLACE)
> >               flags |= MAP_FIXED;
> > --
> > 2.30.2
> >
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook
