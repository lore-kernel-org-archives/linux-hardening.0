Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D118EB64DC
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Jun 2023 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFTUfR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFTUfQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Jun 2023 16:35:16 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFF410F8
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 13:35:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b52fd56b7aso22197805ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687293315; x=1689885315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKfNB5u3nFNglXnsp9o7gsrnCr6dmCCW3qYFfaBUwUA=;
        b=LcMw4psdStH5MFHVQS2kMwJv0T05uTa/co1p38cNr68MBOrTjNM+712n9/v/DKI+ZH
         YiNok73TyBu5n+604Shv46N9t0icaw0NxBDvfwHDA4j/sLzUpIRdl6FmA0KTVCYKqgDv
         4leuNt3EISe1P5Za4zKHxr1OS7t4zK8tJwHhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293315; x=1689885315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKfNB5u3nFNglXnsp9o7gsrnCr6dmCCW3qYFfaBUwUA=;
        b=R1K1WQ2voHUmOs2TtUI0aN1Xj2ci/8A0oVMpu6/JsIE/TCqHgwQGJGcNwE3CXxdpNU
         TYmIJaPvXtkRHq+nnXjER1RZiUtkqpBjEeDLXciPWC+FgoN3xEhEgWAQnSJ7W5FYy213
         ZQCzYo89a7GqZhlK0tPL/7wt9Y8OGNBRS64WHO+QWYFFrAq3oJ3DLdjZXLCPsPfFdw3R
         bLvbZ02s/oAWgrh03kiuKQogBzJMRYON47OuAVbNKIIi5I4yrgstkgwjAXjzEUVmTtlS
         ebIh6CpeuVxDsDD510W4+Az6PcdFGPy941n3mFFEi7Rw2L2aNQ6DTIUNL5a45wRZApnc
         0zBA==
X-Gm-Message-State: AC+VfDyFMtvq9SYfYgfOeO0GGBH5OuV6lLgR9tdZwzNNzGWFmrrekoDy
        u7ihAhMA/ICi7+5tAneP55UGYdOmat68hBkPB8E=
X-Google-Smtp-Source: ACHHUZ4aNFZGT2jrBdXRcHnhNkSHBJJUK1GpV1xH4w7UkAwhaU9F0+YC0le2l80CDW7oZ0eAQ8AYMQ==
X-Received: by 2002:a17:902:f7d1:b0:1ad:edbd:8547 with SMTP id h17-20020a170902f7d100b001adedbd8547mr7662452plw.15.1687293315404;
        Tue, 20 Jun 2023 13:35:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001b23eb0b4bbsm2009835plq.147.2023.06.20.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:35:14 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:35:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, ebiggers@kernel.org, azeemshaikh38@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/boot: Replace strlcpy with strscpy
Message-ID: <202306201335.D6D772A@keescook>
References: <20230615180420.400769-1-azeemshaikh38@gmail.com>
 <168729290245.455922.11993639418267016143.b4-ty@chromium.org>
 <20230620163325.35c9203c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620163325.35c9203c@gandalf.local.home>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 20, 2023 at 04:33:25PM -0400, Steven Rostedt wrote:
> On Tue, 20 Jun 2023 13:28:26 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Thu, 15 Jun 2023 18:04:20 +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > > 
> > > [...]  
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] tracing/boot: Replace strlcpy with strscpy
> >       https://git.kernel.org/kees/c/b1c38314f756
> > 
> 
> I was going to add this to my queue.

Ah, okay, no worries. I will drop it from mine.

-- 
Kees Cook
