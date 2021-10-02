Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F4CC433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 10:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAA8619E5
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 10:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhJBKsf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 06:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhJBKse (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 06:48:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD2C061570;
        Sat,  2 Oct 2021 03:46:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e144so14580649iof.3;
        Sat, 02 Oct 2021 03:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4Vbvfqul2QFRFjweRNao7lCpjhaECLAq5CXnSLrpSc=;
        b=Fva1PNUDrspBT6Qe0CKmeiDlLQYn67jc2rEtlOgRoO8FU3CZdwYpTed5cW4Uo308rm
         OyiSMfjQge65mReRhI3soLOTBWg4ZInOOUMi8dXwcRkeKP4yelPNhFLdUmiZCouDr3mP
         +FJk7IsSne5B1YI+qo5qrPI2AKXkFl3D2Jn/+L9LPO9cuooTNlRu6pApag+rKzM9Egxc
         i7uyiMoYkotU7PyLaH8F903WuzYYJ3mnsPmUTnVBKVUhgLNxO38pN/FJ6oYJ8ayUS+2Q
         jaINIV/yAUlA2LpBovEfWb4xoTTh6Sdnsl9nIW+fM3Df6xP0wMvdk/5ktRuZk75UJiyp
         1awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4Vbvfqul2QFRFjweRNao7lCpjhaECLAq5CXnSLrpSc=;
        b=6zSpt5zQ2I4/QSzuGlIUZ6Z5zpclJclZHvc+lbu1we5Op0QMa5RUlfGHegLk75MfLr
         xSsG7/lrgsZRcxlG0Qv4kW1Pv5+6N1qdCR9iYZOZHyF/c8uTDouvict+E02DDW9p537e
         soLGRhUaxn+hkLmnT0ldVsYBK0oNkZUOcof91TJaSG1oXXJ0fpfgWEzDplMNRGQ5rrFX
         SBk72exU75Wq1b2hpCPWDOYbM/wBV5uH7gzXmxFKdX3UZ9N72mdMNXSlQuVmOxQDP+DZ
         Ky11GAByXjiP+UK9f3m1uU8E9dqePQGEB6ikMlAr10j9n3hDiIcUJk6424ySISs8j87C
         nVSA==
X-Gm-Message-State: AOAM53261g4Q0Rb8+KSwiR3n9zHpBOns3Q/mo0tju/xbpI3oZbp0yLq/
        0573WPX74q7jN8VKC4gd3Foej1giTyHBjKgRaCM=
X-Google-Smtp-Source: ABdhPJz7DQ9B1xRDxK67+F0v4ZEUenO0JwNu2opo+RO5QCCO+W4xelFrC3zfK2DDB15nEA7awHxuGqRlMDBO5125Smk=
X-Received: by 2002:a05:6638:12d5:: with SMTP id v21mr2388869jas.133.1633171608331;
 Sat, 02 Oct 2021 03:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210930235754.2635912-1-keescook@chromium.org>
In-Reply-To: <20210930235754.2635912-1-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 2 Oct 2021 12:46:37 +0200
Message-ID: <CANiq72=Z30f6nPN+pBLYzkew0UipXmBV1Wd_hr4u6aiug=8qrA@mail.gmail.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function attributes
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 1, 2021 at 1:59 AM Kees Cook <keescook@chromium.org> wrote:
>
> + static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
> +               size_t size, u8 count, char *fmt, ...)
> +               __malloc

(From my other email) Is this `__malloc` intended to be in a separate
line? (the first example has everything on the same line).

Cheers,
Miguel
