Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39533C07E9D
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Sep 2022 14:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiIXO67 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Sep 2022 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIXO66 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Sep 2022 10:58:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E981B3D
        for <linux-hardening@vger.kernel.org>; Sat, 24 Sep 2022 07:58:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p14so8172pjd.3
        for <linux-hardening@vger.kernel.org>; Sat, 24 Sep 2022 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A4T+kyw377orQQtPiOvYt9e0D29BYPUlLzt2R5wjAss=;
        b=R1sH2TkWj77H3g/bP3nEOSG0YjWqrb+dM9Ntz02b5KBX5jfO3NsMPm5ze66YWrNR9f
         kdRjg9teybAjH55Wkx5f24ieS2aYd4fqgbCfkeFroTeLH1t3Gbef/8x5f4zvcu1YAVzo
         ABxk2hoi5oOIk4sKmgcOCR0iftwfAYJmOwySE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A4T+kyw377orQQtPiOvYt9e0D29BYPUlLzt2R5wjAss=;
        b=FQ3z+mdnT+9Xs5HpPOSXpX4zzm50bHzzmhMLRQwoqv+x0HWsEfPxowIYtxVtRFRqhC
         gUUmOHpQWFXCwLPEgjwUE3DO0UxdGAJLEhcc+fIsNF3mckDeVR78llUHEIdUELumy8QA
         d+zdId6QaGfeSko/O6MmUqpxVQsuL01uGF8OYptJaSRLvEbMXtcmrQ2/G9YpLCp7qAx6
         TQ6ODC6unwLywtPQhJEv12cBH7+/4MbfEMjxcS+qh2Ltt3gRov4Kb6TB2VSuhiG6S8sl
         CLhUn/x7OHc2HWaodCc6XgQFM6EgKcZk6fHg4yWRffS/p9lt8dN3h5QM5gER+o/UxU/0
         nFPQ==
X-Gm-Message-State: ACrzQf0CuoSIg2JexXNslsnRNDqNIR7wcrZS0G/3dDLfAkOLSjWjpdvC
        dxHpXTBbIhijMknXXd7e75v5SA==
X-Google-Smtp-Source: AMsMyM7kevo+f32kAEhGZsgaVY0iUt0RhFVuHM/4Cd8FeTJRnT4o/Efhy/oEyMRjra2SK2TrSMG3cw==
X-Received: by 2002:a17:90b:194a:b0:202:e6eb:4b62 with SMTP id nk10-20020a17090b194a00b00202e6eb4b62mr27737434pjb.33.1664031536143;
        Sat, 24 Sep 2022 07:58:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902edc500b0017534ffd491sm7875331plk.163.2022.09.24.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 07:58:55 -0700 (PDT)
Date:   Sat, 24 Sep 2022 07:58:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Introduce __access_*() function
 attribute
Message-ID: <202209240757.3AC47AC6@keescook>
References: <20220923235424.3303486-1-keescook@chromium.org>
 <CANiq72n6zK=sXn2j71bAEUUYwRse2dT9f8kLrYzncnPjN1XTow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n6zK=sXn2j71bAEUUYwRse2dT9f8kLrYzncnPjN1XTow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 24, 2022 at 12:06:31PM +0200, Miguel Ojeda wrote:
> On Sat, Sep 24, 2022 at 1:54 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > are specified. While it is legal to provide only the pointer argument
> > position and access type, design the kernel macros to require also the
> > bounds (element count) argument position: if a function has no bounds
> > argument, refactor the code to include one.
> 
> Should this bit be included in the comment of the attribute? (since it
> is specific to the kernel)

Sure; good idea!

> 
> > These can be used multiple times. For example:
> >
> > __access_wo(2, 3) __access_ro(4, 5)
> > int copy_something(struct context *ctx, u32 *dst, size_t dst_count,
> >                    u8 *src, int src_len);
> >
> > (And if "dst" will also be read, it could use __access_rw(2, 3) instead.)
> 
> Also maybe the example could be nice there too, since it uses the
> syntax for the kernel and you took the time to write it :)
> 
> By the way, shouldn't `src` typically be `const u8 *`? Given it is an
> example, I would qualify it.

Yeah, I will update this.

> 
> > +#if __has_attribute(__access__)
> > +#define __access_rw(ptr, count)        __attribute__((__access__(read_write, ptr, count)))
> > +#define __access_ro(ptr, count)        __attribute__((__access__(read_only,  ptr, count)))
> > +#define __access_wo(ptr, count)        __attribute__((__access__(write_only, ptr, count)))
> > +#else
> > +#define __access_rw(ptr, count)
> > +#define __access_ro(ptr, count)
> > +#define __access_wo(ptr, count)
> > +#endif
> 
> If you do a v2 for the above, please take the chance to indent with a
> single space after the `#` (like `# define`) for consistency.

Fixed! I will send a v2.

-- 
Kees Cook
