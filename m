Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11CECA0EC3
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Sep 2023 02:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjILCP3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbjILCPR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Sep 2023 22:15:17 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C454F6AAE
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 16:21:30 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so10799516a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694474359; x=1695079159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUI+yciS9U7o/XSp9QS87LTWNwGIJn99OxRUAsE808g=;
        b=Kp5XgHpKv484f0cCY+Q9cEFHlX4h7XfvAuC/0CvhTXieER8VVZdhp/geg8k9BhPaVl
         o93lK/DIwvcbtVVqOv1DuPWNrk/uw1iidnxFOKW6Lke4r/6ZUECxSaV9OItTT+eiSCXv
         s3ssMtnC5HaIHmg3EwHrwZVx3E0QzmmHNUPWhn/BC95U3mTpCC36mVEeP5OO/pZKOEpp
         vwn8Qdyo/YeZM/Z8/cC2Tfw/iw9spQYntfWkLwSvXoqiyz1+X8s1TLyPYoRS5Q6lG/4K
         d3jnclq/FX0kFsFrSRa4EWvgbOyPQAq6+rFXQ5E27y6Vr0U2slPjrjxv3Gu11j2o9FB/
         a+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474359; x=1695079159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUI+yciS9U7o/XSp9QS87LTWNwGIJn99OxRUAsE808g=;
        b=jnvCO9aag6LPgw0N+NqYlnGcoM6IcbrePv8rR5mRbzFfj4OPIjMukW07f+Jd7fYrXz
         US2/CzTgY9UGMj/GGAEzIBPsBGy3GFgE+AhXQcITWellf5KbNUawEmm90nvnhiWi1JsQ
         /62NIwenqAtFG+zZwe7EWmhKdEgj6a9hZ7/SrqpKNQupqklBLkXD3slCUIhGzYJ3yDS+
         K9dO9Ey4f2BSWaYkqdYTRAmyTz8bL9LmlhjImvu0DbOZrvQX7n3rqYGeamqIWZy/vqU7
         H8yR9obhefn1NS48CeLGCY5LNNeUcbqWw/lKMukZxiTHNPBN0LcTeeyPWP+vHXDW91j+
         VzOg==
X-Gm-Message-State: AOJu0Yy+ke/ao/CRxK2cB03DR1wZUnQSKU9lXvtjYdJSZZgkDGNRH4i8
        AVu9R7rhAkP9AtoY/q9CIpiOd9jylOgMXnlYeu/QhyByv8wcBPwwOdE=
X-Google-Smtp-Source: AGHT+IHaNLCNW4cCXydLmeSfIqjRZlpdje9Q9CqRKN7n2BIIz4uXg9TIClQFO/T8fGoiUiX1e8Hx8nBsO1IygogGXic=
X-Received: by 2002:a17:906:3006:b0:9ad:7f8b:2b0a with SMTP id
 6-20020a170906300600b009ad7f8b2b0amr768078ejz.22.1694469689026; Mon, 11 Sep
 2023 15:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <69643667-4564-0266-1b26-13833191842c@intel.com>
In-Reply-To: <69643667-4564-0266-1b26-13833191842c@intel.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 11 Sep 2023 15:01:16 -0700
Message-ID: <CAFhGd8rohHPu+Zqr+w35=6=goUNC4ycvKk78N+7LSvNbnDnvuw@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 11, 2023 at 11:51=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 9/11/23 11:27, Justin Stitt wrote:
> > `strncpy` is deprecated and we should prefer more robust string apis.
>
> I dunno.  It actually seems like a pretty good fit here.
>
> > In this case, `message.str` is not expected to be NUL-terminated as it
> > is simply a buffer of characters residing in a union which allows for
> > named fields representing 8 bytes each. There is only one caller of
> > `tdx_panic()` and they use a 59-length string for `msg`:
> > |     const char *msg =3D "TD misconfiguration: SEPT_VE_DISABLE attribu=
te must be set.";
>
> I'm not really following this logic.
>
> We need to do the following:
>
> 1. Make sure not to over write past the end of 'message'
> 2. Make sure not to over read past the end of 'msg'
> 3. Make sure not to leak stack data into the hypercall registers
>    in the case of short strings.
>
> strncpy() does #1, #2 and #3 just fine.

Right, to be clear, I do not suspect a bug in the current
implementation. Rather, let's move towards a less ambiguous interface
for maintainability's sake

>
> The resulting string does *NOT* need to be NULL-terminated.  See the
> comment:
>
>     /* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
>
> Are there cases where strncpy() doesn't NULL-terminate the string other
> than when the buffer is full?
>
> I actually didn't realize that strncpy() pads its output up to the full
> size.  I wonder if Kirill used it intentionally or whether he got lucky
> here. :)

Big reason to use strtomem_pad as it is more obvious about what it does.

I'd love more thoughts/testing here.
