Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02D5C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Oct 2022 18:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiJZSrz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Oct 2022 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiJZSrz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Oct 2022 14:47:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346A75FE7
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 11:47:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hh9so10626778qtb.13
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ri/V70PuN7YE034eBVrKO+65hlxsDWHRaEAqsCWyzp0=;
        b=W1vAJPTEgLgFYKZDmntaUewFXJRoS5SLYpwNKHQaxuRPhk16gmO8vKWHC/uwRfHyKW
         nYZb73p9M8oASZmW82NdRcO6Hkf/qYD5F3GXc1h97z8RWjlaA7ncXdpBLCmVRPCKWpjS
         WAGAUeO2XRxEnLGuaPCfRaClQZfyu1KtW2YDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri/V70PuN7YE034eBVrKO+65hlxsDWHRaEAqsCWyzp0=;
        b=mGV62lwrL8fZxyZ3l8cH42S5UgZdOGJwgipbSBAxLsAv6PhUJO2iy2FncFSBjLBfuy
         IdwOhvqX9yatrr0aKV1TsvZHbm09xF9kzjDGXXCkC7aP85IertilLD4vYgitLF19vQ5S
         9FNIkmg6l4v0EfJYIR9iZfgxLGodEx22S478JhoTWtmCEIlXk+6yjOn/8ehnE6TMi/Xt
         e/PG4/RKEOxJ9ahUvEBv+8Lam8tPjVfTyKLRUjddRfuMv4vhDa46AIMstWTavXYqvUTK
         ZzRM6s38Y5T3stKT7B4Gt6ApO9NfyPQYY0VCVUaJt1lbmEASdCwz+jPVH4HI50ydIB7W
         VEmQ==
X-Gm-Message-State: ACrzQf1LrrOO7VFhirkVQnUiz+zER2VaUF5wlzbD3JUy8Oed4vCGrsOU
        BPZxuUqcY+SQvQkFaH2YA9KUNIWMexbN8w==
X-Google-Smtp-Source: AMsMyM4jRlGSK+yP3T24kh3RO/j/C+6KXOHhVUvv8Lrzw9vABXVlayTyB2srshUINrm/on1veIIwvg==
X-Received: by 2002:a05:622a:650:b0:39c:fa98:2de9 with SMTP id a16-20020a05622a065000b0039cfa982de9mr34742204qtb.535.1666810072598;
        Wed, 26 Oct 2022 11:47:52 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bk37-20020a05620a1a2500b006f3e6933bacsm4402526qkb.113.2022.10.26.11.47.51
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 11:47:52 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-36d2188004bso96754797b3.4
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 11:47:51 -0700 (PDT)
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr39348282ywl.67.1666810071636; Wed, 26
 Oct 2022 11:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221025231627.never.000-kees@kernel.org> <CAKwvOdkDaSQZ_e0hX0ggNqsWn+=0xyqMdbf6J+YW0-iZ=ewViQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkDaSQZ_e0hX0ggNqsWn+=0xyqMdbf6J+YW0-iZ=ewViQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Oct 2022 11:47:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whybqnsbCe=+xfxx3ncjg-JG5+GQAZ70M8WKeAnVrZd5Q@mail.gmail.com>
Message-ID: <CAHk-=whybqnsbCe=+xfxx3ncjg-JG5+GQAZ70M8WKeAnVrZd5Q@mail.gmail.com>
Subject: Re: [PATCH] fortify: Do not cast to "unsigned char"
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 26, 2022 at 11:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> If the intent of __p is to avoid repeated application of side effects
> from the evaluation of the macro parameter p, this could also be:

Not the only intent.

The code also does

        __builtin_constant_p(*__p))

which basically checks for "is this a compile-time constant string"
(yes, I realize that it only checks the first character, but it ends
up being the same thing).

That would fail horribly with __auto_type and people using "void *".

It is true that we could probably use __auto_type in a lot of other
places where we currently use

        __typeof__(ptr) _p_ = (ptr)

but our "typeof" pattern is

 (a) much more common because of historical reasons

 (b) much more generic because it often uses a different ptr type (ie
macros that have a value and a pointer, like "put_user()", the type
comes from the pointer, but the initializer comes from the value, so
"__auto_type" ends up being completely the wrong thing).

We do have a couple of "__auto_type" uses, but because it can't
replace our __typeof__ users in general anyway, I'm not convinced we
should strive to make it hugely more common (even if the __auto_type
model probably can replace a lot of them).

                  Linus
