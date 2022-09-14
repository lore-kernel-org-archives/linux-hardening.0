Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A60ECAAD3
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Sep 2022 13:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiINN7h (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Sep 2022 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiINN7f (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Sep 2022 09:59:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2067D1CF
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 06:59:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i19so11129627pgi.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Sep 2022 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wavsrAyG6NiOWTam0JHv7PKYgavbpXhgMRnb2r58pdo=;
        b=kH4L3gqh4xzjn+C8/0iA1Uc6n5BYUDTf66L2gvMLHiPbaL03lhM8U+vvbFU6sEp7kv
         1mKFE3Mttqx8cGHXnYEBcLO+pObY56ATqdnlLUZWvRYItE2D58jJtYg4lTNIFXn1kw15
         T1KkgtxGGBdDxPkiThQyvg8500khkMUeZL0Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wavsrAyG6NiOWTam0JHv7PKYgavbpXhgMRnb2r58pdo=;
        b=fD1yjikpgKkh9fy0lhHsNHZIs4Y+mSDwWEx7YImZo0O/GZ8vIhJTbXO3+GdV5cZYk7
         tezhCKoSEACMr7+prqux+Kc6K4hMaA0UDfPycJdsnjxFDM09GNh0XUaVsO2/GrOe01c9
         ucFZsZl5HZfw7WCQhpRd5jD9Xt8oZrwliKqw+sZMS8Wka+wy6wyQE3o2nmPpj6y7tqSR
         jLNznshVA5byP+0mlJRHTP6CLXjcG2EAig6/83GtTYWsId+JL9kZ9KUmMIXjq99z6qbq
         nFmOqQiHe4YYxtfgOIoSdVqglYfNR6XKkh0YP6dVSCgLvoajvnBs+IhVWZOhVOp/LeIv
         nYcg==
X-Gm-Message-State: ACgBeo0+/qvbQe4+f7l2eFp7m2VFKflrwNtgwVWBx7JWRLDh3vYS1J0A
        83UGniPMl/JlDThILKp6bUDqtPUG4DYhEE5H
X-Google-Smtp-Source: AA6agR6y4ULei98zaMifYBH1DzZDIoH+v39NLO21Q/U5CM0RCjhTsjHyJqiAC+NtcWxFmIgg5xCBFQ==
X-Received: by 2002:a62:5443:0:b0:53b:b934:ee8e with SMTP id i64-20020a625443000000b0053bb934ee8emr38389448pfb.10.1663163966560;
        Wed, 14 Sep 2022 06:59:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001780cdade11sm10653354pll.51.2022.09.14.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 06:59:25 -0700 (PDT)
Date:   Wed, 14 Sep 2022 06:59:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fortify: Adjust KUnit test for modular build
Message-ID: <202209140658.A471548@keescook>
References: <20220913173136.1926909-1-keescook@chromium.org>
 <CABVgOSnSsMxHQJNPs77rzA729wW1k6o17_ERqGvszFVkQ-hv_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSnSsMxHQJNPs77rzA729wW1k6o17_ERqGvszFVkQ-hv_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 14, 2022 at 06:13:59PM +0800, David Gow wrote:
> On Wed, Sep 14, 2022 at 1:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > A much better "unknown size" string pointer is available directly from
> > struct test, so use that instead of a global that isn't shared with
> > modules.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/lkml/YyCOHOchVuE/E7vS@dev-arch.thelio-3990X
> > Fixes: 875bfd5276f3 ("fortify: Add KUnit test for FORTIFY_SOURCE internals")
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Whoops! Thanks Nathan! :) This fixes it for your reproducer.
> 
> Ah, this is better than saved_command_line, IMO. I don't think it'd
> necessarily be a _disaster_ to just introduce a new dynamically-sized
> string here, which would be more explicit, but test->name is at least
> obviously related to this file anyway.

Yeah, and I'm trying to explicitly use a string that the compiler won't
immediately be able to see through, so best to get it from an external
source.

> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

-Kees

-- 
Kees Cook
