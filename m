Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F80C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 21:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiBCVEP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241914AbiBCVEO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 16:04:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73142C061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 13:04:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y17so3286979plg.7
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXCyJIfbpLGxYBIbWAc7Goy/U+/enGtkfIUDufgG5no=;
        b=RN+nNTd2KY08ojmx+rurrM8Bco9OeNs0WRScp2CK+r9LCNzp64NTOEMjXnQVm24qyo
         wO7H8nt7ZgWhWAxYuOVShnWUfDiM9/1AiVV6vNCyTVEdoHah5R8ZjkopBY+8uUL+h7Eo
         pOaE/TaH1Ss7lgkxTUQQORRBFTEXe9mi1T54M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXCyJIfbpLGxYBIbWAc7Goy/U+/enGtkfIUDufgG5no=;
        b=rLrf/BgIUqEFAc0iah953F08Y7ObBIxw1SMQgy3EB3Ycq08ZZ5UW0mn1CeWzeVTuR1
         5Sn7/MtjYu1iShNJKNP3iJ6PB7erNkva5gmosMmiTPpIj/qoozJmy1cFc8qupdL+KgSU
         7dIIJng+6gqxj0EX+eyxD5f+Ox60pfCD7O31CNLxm2s9xhhryg5dVEC6DEMSRrYt2Xbu
         6p727u9IsddKPKfeaqK5UO+hnw7GkqoYU6d+1Ljz9N20SnmegHxo1/6MgtKG7t3ib0mq
         8zYLHQGdcM7bag7B5Bs3mv6ZBNjgku04c1CJd2DJdpB0Jx671HoGZfQwkgOxIOK6Nd0v
         elAQ==
X-Gm-Message-State: AOAM531m6SiLlGd6Swc6qU7j1YmEkhmcrr/CoZ+9ZtPI2xpEgWsIzoe2
        ixSTS2xd3cpaiFHi3PfyRnNGcQ==
X-Google-Smtp-Source: ABdhPJzHdXzL/QHbPAYTIAbR5kUmDhbNvKJm0lPvrYqdexCUwxFUHuGjIxkP9nZ73WuTSjfPXxN9BQ==
X-Received: by 2002:a17:90b:1d0a:: with SMTP id on10mr15687871pjb.167.1643922253959;
        Thu, 03 Feb 2022 13:04:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm18049411pfw.86.2022.02.03.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:04:13 -0800 (PST)
Date:   Thu, 3 Feb 2022 13:04:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
Message-ID: <202202031301.437D8FD3@keescook>
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-3-keescook@chromium.org>
 <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 03, 2022 at 12:26:15PM -0800, Nick Desaulniers wrote:
> On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In order for FORTIFY_SOURCE to use __pass_object_size on an "inline
> > extern" function, as all the fortified string functions are, the functions
> 
> s/inline extern/extern inline/

I will update that. :)

> 
> Yes, they're the same thing, but it sounds backwards when I read it.
> 
> > must be marked as being overloadable (i.e. different prototypes).
> > This allows the __pass_object_size versions to take precedence.
> 
> Is this because of the `const` additions to the function signatures?

That might be an issue, but the *real* issue is the implicit mutation of
the function into an inline with _additional_ arguments. i.e.

char *strcpy(char * POS p, const char * POS q)

is really

char *strcpy(char * const p, const char * const q, size_t __size_of_p, size_t __size_of_q)

(i.e. what I was doing with macros, but all internally and still an
extern inline)

-- 
Kees Cook
