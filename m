Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1649C83F01
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 22:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHYWlk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjHYWlS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 18:41:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F559269F
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 15:41:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so1984420a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693003274; x=1693608074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNt4DyfeIzhhV0tgLa3rjei+leX4v+4lfQmFyrXCtB0=;
        b=pMXG1akOTp23AsJ05SXCDpWQSJPJ8XiRbFCXmMmoHnZp10DAHWNiwxpZj7c0Yfl4xw
         DBcqgNOUotfmmrMmcAYFzZlASziS1CQiFDIzLyWR1aqEfFf2/sErtJR5rUg2+4fP26hI
         fPzxwv4DJkICTum0sUty6XChrIMdqow7XPn7ftH4VyHLtAa5uIH7+L0cANkLheBK0e13
         loXU1wuUPEktYsmYR7ZH7keYW1B25BXNXVy4AVkPKWz3aI6f51ZSOgVZ8sY4+7+Tc/LT
         SHk2pB2paLp0jllM2RZzc7g02Gk3zjeGEL+R25CjupDNQJTdN/yusjnrXoulwqkHg+gA
         W5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693003274; x=1693608074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNt4DyfeIzhhV0tgLa3rjei+leX4v+4lfQmFyrXCtB0=;
        b=WfSaFj29ia22gkhu85PWQYpvQ6wIpdIvyWn3Ln9FitMfxB2eNeQDBH9mAgi5zNNfic
         Hm1jL1aJSaM71pseWAPdf5HlNxfmqXbOSSPh3t81JJiRiZ+ERXNdrR6HZsfghEKRro1D
         ZTnpQCDp4k9C9kTuj+OcZGBaK9MNdX1hlrh/kjDuz93LPASVH2/8XscXtbJRnp7iKf5f
         nW9gKPwTa1bMneVFQdNnfjMWLO+/tlq2f0hr0ToQxQ5mupWe1y7osCv1MqdrYGgoB8zf
         O7YBoWUfV/LZmm5lL+SkB4VR/dKCbZ7lB6IMgoEFe4FdhhgtRiYP51E/8X1ndzRVWWb/
         kfXw==
X-Gm-Message-State: AOJu0Yy7c73ILQYSRBjsbmTONXc1nUSsJVE5gYrsNe1R18RsG5mip+iX
        iS0nzuIaBa403zvkMPkhqyiGG6QfldtweDcmLD1QQjqGevi56X4OFjQM7g==
X-Google-Smtp-Source: AGHT+IHdxpRbvdQqrV8IEsgFyYkkccQtI62ILyMER9GMSBV09OD46m5LnxIfpKO3HqZNIO6RnyDru8wHwhndx/EvMgg=
X-Received: by 2002:aa7:cb07:0:b0:522:2dcc:afb6 with SMTP id
 s7-20020aa7cb07000000b005222dccafb6mr16532241edt.7.1693003274449; Fri, 25 Aug
 2023 15:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-strncpy-drivers-accessibility-speakup-kobjects-c-v1-1-3a1ef1221e90@google.com>
 <202308251439.36BC33ADB2@keescook>
In-Reply-To: <202308251439.36BC33ADB2@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 25 Aug 2023 15:41:03 -0700
Message-ID: <CAFhGd8r6A4VH5C=yF1WHKEPY86oh6PEzt6wuxPxsJAD0XKfrsQ@mail.gmail.com>
Subject: Re: [PATCH] accessibility: speakup: refactor deprecated strncpy
To:     Kees Cook <keescook@chromium.org>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks for the review Kees and Samuel. Hoping to get this picked-up soon :)

FWIW, I've quickly copy/pasted Kees' suggested refactor of
synth_direct_store and rebased against v6.5-rc7 if anyone has the
means by which to test it.

TEST PATCH BELOW

On Fri, Aug 25, 2023 at 2:49=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Aug 24, 2023 at 09:44:29PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > Use `strscpy` as it guarantees NUL-termination of its destination buffe=
r [2]
> > which allows for simpler and less ambiguous code.
> >
> > Also, change `strlen(buf)` to `strlen(ptr)` to be consistent with
> > further usage within the scope of the function. Note that these are
> > equivalent:
> > |419  const char *ptr =3D buf;
> >
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on=
-nul-terminated-strings[1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/accessibility/speakup/kobjects.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessi=
bility/speakup/kobjects.c
> > index a7522d409802..8aa416c5f3fc 100644
> > --- a/drivers/accessibility/speakup/kobjects.c
> > +++ b/drivers/accessibility/speakup/kobjects.c
> > @@ -422,12 +422,11 @@ static ssize_t synth_direct_store(struct kobject =
*kobj,
> >       if (!synth)
> >               return -EPERM;
> >
> > -     len =3D strlen(buf);
> > +     len =3D strlen(ptr);
> >       spin_lock_irqsave(&speakup_info.spinlock, flags);
> >       while (len > 0) {
> >               bytes =3D min_t(size_t, len, 250);
> > -             strncpy(tmp, ptr, bytes);
> > -             tmp[bytes] =3D '\0';
> > +             strscpy(tmp, ptr, bytes);
> >               string_unescape_any_inplace(tmp);
> >               synth_printf("%s", tmp);
> >               ptr +=3D bytes;
>
> Technically, yes, this is fine...
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> But wow do you find the most amazing code. :)
>
> This thing is taking a buffer and chopping it up into at-most 250 byte
> chunks (smaller than buf, I might add), and then sending it to
> synth_printf() ... which uses a 160 byte buffer and silently
> truncates...  and uses "%s" which is just a string copy...
> why doesn't this just use synth_write() directly on an unescaped
> buf??
>
> I think this entire function should just be:
>
> static ssize_t synth_direct_store(struct kobject *kobj,
>                                   struct kobj_attribute *attr,
>                                   const char *buf, size_t count)
> {
>         char *unescaped;
>         char *p;
>
>         if (!synth)
>                 return -EPERM;
>
>         unescaped =3D kstrdup(buf, GFP_KERNEL);
>         if (!unescaped)
>                 return -ENOMEM;
>
>         string_unescape_any_inplace(unescaped);
>
>         spin_lock_irqsave(&speakup_info.spinlock, flags);
>         synth_write(unescaped, strlen(unescaped));
>         spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>
>         kfree(unescaped);
>
>         return count;
> }
>
> (Though honestly, why does this need unescaping anyway?)
>
> -Kees
>
> --
> Kees Cook
---
From e7216bca30673a162660c51f8bad3b463d283041 Mon Sep 17 00:00:00 2001
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 25 Aug 2023 22:32:03 +0000
Subject: [PATCH NEEDS TEST] synth_direct_store refactor to use synth_write

I've just copy/pasted Kees' suggestion here [1] and rebased it against
6.5-rc7.

This patch needs testing as it refactors behavior in synth_direct_store.

[1]: https://lore.kernel.org/all/202308251439.36BC33ADB2@keescook/

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/accessibility/speakup/kobjects.c | 25 +++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/accessibility/speakup/kobjects.c
b/drivers/accessibility/speakup/kobjects.c
index a7522d409802..0dfdb6608e02 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -413,27 +413,24 @@ static ssize_t synth_direct_store(struct kobject *kob=
j,
    struct kobj_attribute *attr,
    const char *buf, size_t count)
 {
- u_char tmp[256];
- int len;
- int bytes;
- const char *ptr =3D buf;
+ char *unescaped;
  unsigned long flags;

  if (!synth)
  return -EPERM;

- len =3D strlen(buf);
+ unescaped =3D kstrdup(buf, GFP_KERNEL);
+ if (!unescaped)
+ return -ENOMEM;
+
+ string_unescape_any_inplace(unescaped);
+
  spin_lock_irqsave(&speakup_info.spinlock, flags);
- while (len > 0) {
- bytes =3D min_t(size_t, len, 250);
- strncpy(tmp, ptr, bytes);
- tmp[bytes] =3D '\0';
- string_unescape_any_inplace(tmp);
- synth_printf("%s", tmp);
- ptr +=3D bytes;
- len -=3D bytes;
- }
+ synth_write(unescaped, strlen(unescaped));
  spin_unlock_irqrestore(&speakup_info.spinlock, flags);
+
+ kfree(unescaped);
+
  return count;
 }

--
2.42.0.rc1.204.g551eb34607-goog
