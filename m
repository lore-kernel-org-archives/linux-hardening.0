Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F4C4332F
	for <linux-hardening@archiver.kernel.org>; Mon, 17 Oct 2022 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiJQUil (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 16:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiJQUiX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 16:38:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22504804B4
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 13:36:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h13so12160486pfr.7
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DNUgQk7rQANqDSMtoJoYUOw4oQuNQKM8I6m3nk0AGE=;
        b=YzfeGM4m6J3abKwEOKljd0JgEPkmOomTt9HwLUISAMGSblNS7OCJ6O1zBMqf6PhsmN
         zCU8Z5hHj4bkVMMh7lc4lbGrHTkQl24Fr9jCl4EgMhMr8/W9Hg3rdPzraOFFL8lW7ZAq
         bVGWYOz9cE8Kz7gBzvDAHlQtq8ZgNUyoGVB8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DNUgQk7rQANqDSMtoJoYUOw4oQuNQKM8I6m3nk0AGE=;
        b=xwD+/ut2FlnnG0a9pPbM2lmlP5nRJBKx6b2RT+MpwiSb/Te7G9KprYLwlrMqofQNH9
         oQ4Wuhw5Sh9uHuyA7DtS2gFBq2K2L3Ixsrk4kJbrMJ4q2AbzHbQL3OOvpdvcD0M7Mqyc
         PLoI+5SzFFZAeQoOiI2PVtXH159Se3YdPdwRfSaStUU7Y5sdadXCoJZtooKBk1/Osa1J
         B6FmbtBWR+y/75Z0Gx8KW7zQcB7SDRE2+5ZCKFXw7ggviRhMMcK1dJLWpsA0oi/bXJbT
         0dhUh1PCuSHlfNjVj3Xnvsrf5fN7F7nHnoNede9araAnSwhH+KNrMyAe7ghYfFR5DX1P
         bF9Q==
X-Gm-Message-State: ACrzQf1MVgzlwS+1VTSjx9AB64aVENUyJk3ZP20GYBOVe0fGLXOUmmYR
        TL4anGkj3fmQCGYERnCCcrvGcQ==
X-Google-Smtp-Source: AMsMyM68pSTudLPa7hJy8BAwqvdQjj1kQLn4ssdt75W+B4lqRnrjftLjk8uol0BPMm6mdcJmNtwVjA==
X-Received: by 2002:a63:c145:0:b0:44e:9366:f982 with SMTP id p5-20020a63c145000000b0044e9366f982mr12011932pgi.584.1666038957593;
        Mon, 17 Oct 2022 13:35:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902ca0100b00174f61a7d09sm6963867pld.247.2022.10.17.13.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:35:56 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:35:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171333.309A3D9@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook>
 <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
 <202210171237.DF5D4A3FD7@keescook>
 <CAMj1kXGmsJNg7En-55aRF+ApicPD_Opkh8Jw+oTorSOSO+cfuw@mail.gmail.com>
 <202210171307.32A5D9C07@keescook>
 <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHced1khwsrHqMUmECh_7irYOckFd+Sx3z9KSmsL7tPxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 17, 2022 at 10:13:52PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Oct 2022 at 22:11, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 17, 2022 at 09:45:08PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 17 Oct 2022 at 21:40, Kees Cook <keescook@chromium.org> wrote:
> > > > Okay, so strictly speaking, eliminating the per-CPU allocation is an
> > > > improvement. Keeping scomp and doing in-place compression will let
> > > > pstore use "any" compressions method.
> > >
> > > I'm not following the point you are making here.
> >
> > Sorry, I mean to say that if I leave scomp in pstore, nothing is "worse"
> > (i.e. the per-cpu allocation is present in both scomp and acomp). i.e.
> > no regression either way, but if we switch to a distinct library call,
> > it's an improvement on the memory utilization front.
> >
> > > > Is there a crypto API that does _not_ preallocate the per-CPU stuff?
> > > > Because, as you say, it's a huge amount of memory on the bigger
> > > > systems...
> > >
> > > The library interface for each of the respective algorithms.
> >
> > Where is the crypto API for just using the library interfaces, so I
> > don't have to be tied to a specific algo?
> >
> 
> That doesn't exist, that is the point.

Shouldn't something like that exist, though?

> But how does the algo matter when you are dealing with mere kilobytes
> of ASCII text?

Sure, though, this is how we got here -- every couple of years, someone
added another library interface to another compression aglo. I tore all
that out so we could avoid having to choose a single one, but was left
with the zbufsize mess (that, yes, doesn't matter). So now pstore can
just not care what compression is chosen.

-- 
Kees Cook
