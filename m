Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98792C4708D
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 23:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiLBXYS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 18:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiLBXYQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 18:24:16 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69F0F8984
        for <linux-hardening@vger.kernel.org>; Fri,  2 Dec 2022 15:24:14 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y17so5997002plp.3
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 15:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=on58jY6T434zQgu2CSXS/icw6nLEfVeftPkBpeTWD00=;
        b=f9N08HoP3vjXrlBMoa1BWvaTSWYndYLcM4wvp+sp+YXl3LIIVsOpQuF46rZaSwVNfq
         nHVkSzNk6vjd6vvV4fmVD3rpGz5vZAwUikyB5tUcEHoW+afHzh1WXuoPSu784boKvqNM
         FdiMdq9PdHK4j0Q/imjoWxQ2FaNvTxNHqr7LrJfZ9lwi3EMqsJfwCF3hnBUWxxpwRTn0
         0jvlP5iIb4KaObAhu8XtR2n5TKJLYoG7RLWkUrDoas8k4jsWcAWlntQBnMiRZqlEYoTP
         H442pPWf0jqdJyXM05cDctKukg6U+w+JyvNaWMDjfVn+YuFO5hK7+MJnmg0T32oxYnDL
         oH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=on58jY6T434zQgu2CSXS/icw6nLEfVeftPkBpeTWD00=;
        b=3+uHVYE8XFBNunDhOfaCZMPQO8waRy2LoyeoHfEC6hALsD5xsq4qgkK1Hh5aNptkg0
         Y3k46z6JiSwwVemo7X0BF/N736FOxWIKm2k0GfW73i95YYdjcgo+AnRsKk6Rp/95dSwf
         eUZD4Nqa9qthU2dznZeBxvCp5iqI2EQZDwrV8I89RsEkmsP5ruZD58Ix7YH3r76J0boi
         66xKENtOZwZ7x0OZQ84psa+ZLPrQf43/lp5Fy5YcfGWxa3drs7c/YfjdzP7crC4/L9Hz
         3WYwnPz3HgYW6NE6ulrwmwBBq7ZURr9oN9K5gD/p70/RNTFcfsylmkGSANZxFsbhyPkw
         QDKA==
X-Gm-Message-State: ANoB5pkFxd1hujKeSrmGKHD1hC6JUo++4SvdaxdtexUScBJqo/qobkJc
        Lo8hibKnsQg24N61Uj3Itmyzf6bPEEkwF4Ts9ZfxgA==
X-Google-Smtp-Source: AA0mqf5E8zMLU2q3bZ7mZyyna7VvQKkHk3cfGKZrg32/dY3cWByKKJPBLwGkdKGt4CtkQAcmr9HvbrVMpAETT+qUAP8=
X-Received: by 2002:a17:902:ec04:b0:189:894c:6b58 with SMTP id
 l4-20020a170902ec0400b00189894c6b58mr28915373pld.172.1670023454228; Fri, 02
 Dec 2022 15:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20221202013404.163143-1-jeffxu@google.com> <20221202013404.163143-6-jeffxu@google.com>
 <202212021457.EC46B27677@keescook>
In-Reply-To: <202212021457.EC46B27677@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 2 Dec 2022 15:23:37 -0800
Message-ID: <CALmYWFuQUcd1RYu1idS5cirAXNbynDLkxLYTHRAFS6yQE=gOmw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memfd: security hook for memfd_create
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Dec 2, 2022 at 2:58 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Dec 02, 2022 at 01:34:03AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > The new security_memfd_create allows lsm to check flags of
> > memfd_create.
> >
> > The security by default system (such as chromeos) can use this
> > to implement system wide lsm to allow only non-executable memfd
> > being created.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/lsm_hook_defs.h | 1 +
> >  include/linux/lsm_hooks.h     | 4 ++++
> >  include/linux/security.h      | 6 ++++++
> >  mm/memfd.c                    | 5 +++++
> >  4 files changed, 16 insertions(+)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index ec119da1d89b..fd40840927c8 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
> >  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
> >  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
> >        unsigned long arg)
> > +LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
> >  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
> >  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
> >        unsigned long prot, unsigned long flags)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 4ec80b96c22e..5a18a6552278 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -543,6 +543,10 @@
> >   *   simple integer value.  When @arg represents a user space pointer, it
> >   *   should never be used by the security module.
> >   *   Return 0 if permission is granted.
> > + * @memfd_create:
> > + *   @name is the name of memfd file.
> > + *   @flags is the flags used in memfd_create.
> > + *   Return 0 if permission is granted.
> >   * @mmap_addr :
> >   *   Check permissions for a mmap operation at @addr.
> >   *   @addr contains virtual address that will be used for the operation.
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index ca1b7109c0db..5b87a780822a 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
> >  int security_file_alloc(struct file *file);
> >  void security_file_free(struct file *file);
> >  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> > +int security_memfd_create(char *name, unsigned int flags);
> >  int security_mmap_file(struct file *file, unsigned long prot,
> >                       unsigned long flags);
> >  int security_mmap_addr(unsigned long addr);
> > @@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
> >       return 0;
> >  }
> >
> > +static inline int security_memfd_create(char *name, unsigned int flags)
> > +{
> > +     return 0;
> > +}
>
> I think this is missing the security/security.c changes for the
> non-inline version?
>
Yes. I will add that in V4.

> -Kees
>
> > +
> >  static inline int security_mmap_file(struct file *file, unsigned long prot,
> >                                    unsigned long flags)
> >  {
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 69e897dea6d5..96dcfbfed09e 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -346,6 +346,11 @@ SYSCALL_DEFINE2(memfd_create,
> >               goto err_name;
> >       }
> >
> > +     /* security hook for memfd_create */
> > +     error = security_memfd_create(name, flags);
> > +     if (error)
> > +             return error;
> > +
> >       if (flags & MFD_HUGETLB) {
> >               file = hugetlb_file_setup(name, 0, VM_NORESERVE,
> >                                       HUGETLB_ANONHUGE_INODE,
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
> >
>
> --
> Kees Cook
