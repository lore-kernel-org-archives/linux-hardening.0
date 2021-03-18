Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58117C433E9
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 18:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116EA64F69
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Mar 2021 18:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhCRSpw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhCRSpl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Mar 2021 14:45:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD79C06175F
        for <linux-hardening@vger.kernel.org>; Thu, 18 Mar 2021 11:45:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b83so6183306lfd.11
        for <linux-hardening@vger.kernel.org>; Thu, 18 Mar 2021 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXJ1Kpw2oRWiOPlZvmgzPqNpjS+OST6GpCVGaYkcfjU=;
        b=KVhzG/Xt0d2tzVy7gn9DeiCmjSKqLb+wM+t8KT/0yYxikiuuU7zFmWYcGH7rBKFF2b
         AtHQOK1YfGzGRBG0KZ4thwg0+JZusdpXujSogBcYD6D0hMB/V73nccM2C6cWPSHOEUQU
         a1mayCuYUN57wUJaEJfG9UApRea4LPqYff1TlxP6DG3qTXu7cW9ElW4rVEx+PacKVcM4
         1ObbqRp1qWL2rwPmFRQgVM7VmPubsIbfCjOIIgk5xp14ryEBC3GPnUcfaEyo/ZkGvVMu
         jDzsbdtLYDpL+BtsNICkUJ0UHfPoPDJ1i7+u6wbVW+hhoK4xDwxigkc/8xNcpzwV8JYt
         uF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXJ1Kpw2oRWiOPlZvmgzPqNpjS+OST6GpCVGaYkcfjU=;
        b=rpi9AYMwnLCMJhUfJcd2hZtLb+mM3su2SDbz0bYQf4sIZ+uigS2dATKLI7/m0sR5mV
         3aS4GH/7GkfFlPvtONCquJC/a8+Y54NT24bOn8TPG871dxig3e+H40KaSS2MZcgv3z9j
         CvNpEu0e/C4wYx9MSDe74BWstA1OX/vWjqSJKbJtxBEIwthquI+vnPLNTf3bzRuBfj2m
         8khlPLorTH/VZZhAKxvViEqZhA7uQYt4w/JNIPWzrtDHcH8yIVhZ5APyjReCMVfXUchE
         uZjy4oA732PfXpQoQS/+2xR0WGbq+bR7m4mDGbZFaCqkeQlI4LhzvIgmKNpnoUYL+wKi
         vxTg==
X-Gm-Message-State: AOAM533vZGOrNLm5sCxjoKdwCAixEVOi0yeyNfTxCuDbI9rayhvJ9UK7
        ZE2hLG14Ow29h5G4KPK4cp0FPv7H3jpgmlE9jK15cA==
X-Google-Smtp-Source: ABdhPJzI/cXQgUy2RSLmNuSxvjB8uEjk+GLf2aUWomqyxgvUmHefmj8Y6oB/C1sojY9blIJSTxDq0p15b1fs89u6VoM=
X-Received: by 2002:ac2:538e:: with SMTP id g14mr6055632lfh.543.1616093139630;
 Thu, 18 Mar 2021 11:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-11-samitolvanen@google.com> <CAKwvOdkn7MY+-9D0DQ-18OR=s1XmgPaP7VchCm6VV5kYuKSAkA@mail.gmail.com>
In-Reply-To: <CAKwvOdkn7MY+-9D0DQ-18OR=s1XmgPaP7VchCm6VV5kYuKSAkA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Mar 2021 11:45:28 -0700
Message-ID: <CAKwvOdk7wg-BoE=A0wN6Oz7ptK4y2_YHUBNTTc80CvWuY=nF3Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] lkdtm: use __va_function
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 18, 2021 at 11:43 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > To ensure we take the actual address of a function in kernel text, use
> > __va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
> > the address with a pointer to the CFI jump table, which is actually in
> > the module when compiled with CONFIG_LKDTM=m.
>
> Should patch 10 and 12 be reordered against one another? Otherwise it
> looks like 12 defines __va_function while 10 uses it?

Ah, nvm patch 3 defines a generic version, I see.

>
>
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/misc/lkdtm/usercopy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
> > index 109e8d4302c1..d173d6175c87 100644
> > --- a/drivers/misc/lkdtm/usercopy.c
> > +++ b/drivers/misc/lkdtm/usercopy.c
> > @@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
> >
> >         pr_info("attempting bad copy_to_user from kernel text: %px\n",
> >                 vm_mmap);
> > -       if (copy_to_user((void __user *)user_addr, vm_mmap,
> > +       if (copy_to_user((void __user *)user_addr, __va_function(vm_mmap),
> >                          unconst + PAGE_SIZE)) {
> >                 pr_warn("copy_to_user failed, but lacked Oops\n");
> >                 goto free_user;
> > --
> > 2.31.0.291.g576ba9dcdaf-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
