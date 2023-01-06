Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB85C3DA7A
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 19:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjAFTHx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 14:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjAFTHw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 14:07:52 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F101A21C
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 11:07:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id c11so2763578qtn.11
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5A0t1b8GCaKZoioAehodSZpoVJBMnzQHzgwS+wcGljY=;
        b=c6aSqs9RAgnpQbfs24Hy+BdkBfwEBqdowlV8Kgcqy1p1Xzv+pWEcDyAAgexmWac3OK
         ao8J+ggBkFsQ69q23eXpTlhanR8ko+mxGAdcEnDwW9RaPC3f27lyqx4gXOOadbQrjqfS
         PuS+cGVk79ubhoVzMoSLeLT+8pUy2Ge5R+a8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5A0t1b8GCaKZoioAehodSZpoVJBMnzQHzgwS+wcGljY=;
        b=G/LJo7gOLlWzDWIt1TOKSVgmVKZTXnR3SnQ6MsSOBNdAA8/8Znb23JZTqyWsNbWkoq
         zZdN6LyfiTrBgyj2FhinQqIMp5+2pi8Fz8EcOh40nEYqB1us/UhHkPnQ2m9SYT9l0Fx2
         o4o5SS4iB0opULAzZ7t2xrfqkfKEIh3MUWqwwviD/Lp7EtDa89FqPMlArIXiSM33GjgA
         oZGB+7yy+ol5wzXIaYmaN8Vc2FUEikL24JbG6YinxnqFmsk+Pdg7c/YVLRqx8mchn84w
         bFh1NG0bJRl0AJWmG1AgIOdPJK09T4fXbN9FtE6DJXLS0CPCy/bP4L5GWvghK+qfziSb
         MLbg==
X-Gm-Message-State: AFqh2koi4rhpsLyU6H/yt2TRiKPzPml2GpR3XyriFfsyUFoQa3sTdKm7
        bQrqoDhTRMTKXD+OpWqP+Z4xqByNOgAh5xRf
X-Google-Smtp-Source: AMrXdXvx4+YW5LRuoXuu5Jh01zDCGyxZphc4n5LyWOfGVgCUyx75caeE4kQNdwZz+OhVSu+BwO7iaQ==
X-Received: by 2002:ac8:6999:0:b0:3a9:82a1:4fb with SMTP id o25-20020ac86999000000b003a982a104fbmr76857918qtq.34.1673032070790;
        Fri, 06 Jan 2023 11:07:50 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id i25-20020ac860d9000000b003a7fc70d59csm875616qtm.41.2023.01.06.11.07.49
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:07:50 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id h10so1556956qvq.7
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 11:07:49 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr2620694qvv.130.1673032069668; Fri, 06
 Jan 2023 11:07:49 -0800 (PST)
MIME-Version: 1.0
References: <1f4d159e-5382-3c75-bd5e-42337ecd8c28@omp.ru> <Y7hDGoCbWG2ZYdlV@alley>
In-Reply-To: <Y7hDGoCbWG2ZYdlV@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 11:07:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCTaDeS9gPf=57rBMCOw6MGmzCHywX=en05=pZaCnjuw@mail.gmail.com>
Message-ID: <CAHk-=wgCTaDeS9gPf=57rBMCOw6MGmzCHywX=en05=pZaCnjuw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: fix possible NULL pointer deref in vsnprintf()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 6, 2023 at 7:49 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Adding Kees, Linus, and linux-hardening into Cc. It seems that
> __vsnprintf_internal() does not do this in glibc. I wonder if
> there is a good reason for it.

I do not think that patch is valid.

And I don't like Steven Rostedt's suggestion either.

I think that code *should* take a NULL pointer dereference, exactly
the same way "strlen()" would do if you pass it a NULL pointer and
claim there is room there.

No silly checks for invalid cases.

There's any number of invalid things you can do in the kernel, and we
don't check for those either.

I don't particularly like the "pass NULL to sprintf()" thing at all,
but *if* somebody does, they had better just pass a zero size too.

And doing

        git grep 'sn*printf(NULL'

seems to show that all current users do exactly that.

If somebody wants to check for this, make it a coccinelle script or
something. Not a runtime check for invalid use cases.

               Linus
