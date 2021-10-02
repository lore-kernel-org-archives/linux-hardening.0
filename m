Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A016C433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 00:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6061AA4
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 00:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhJBACT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Oct 2021 20:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhJBACS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Oct 2021 20:02:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E21C061775
        for <linux-hardening@vger.kernel.org>; Fri,  1 Oct 2021 17:00:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so10761822pgu.13
        for <linux-hardening@vger.kernel.org>; Fri, 01 Oct 2021 17:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyR0BLvLKJGXSob9Ifla3i3P7VKq6NSER7OryFjz5kw=;
        b=D4Rb5NZpuDSNx+ISAjTu3oceC69bI/BD0movoPn7MtXhmP43veptQrEEN/0rzGA4Dm
         zXXstG72cbUCZmZHjnewO0K79iI86YeELhOXvwnrBZ/tLgIw2jvae+0nhAn66b8PX+w1
         mywHvk3IWE87W7vLyN2kUTnHuOvl65/nv3CAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyR0BLvLKJGXSob9Ifla3i3P7VKq6NSER7OryFjz5kw=;
        b=cjEF/PMcMQLQXEx2lOfD+LQ63f/MtCC4oAr5cy7WRHUQKDrxMhMFbY1BIIphhqzTKQ
         6CfrEJiAaYncwuGsk4QgGgK8J4lqZ50iEaqi8encbmBj0EtBXqS4EudrIjvqHDo5eBJq
         u5bgfO72Wg52CcYkVgno/CuY3+7cTNQicYo+PHZoPaOFh+z/vma07cpZmyy9UaE9ODiy
         fv3LFVdNMK7DERNNKa8jac1ObdakQCn3REYzuwccVlTPBLWpU1dmuHf9Q9tiGYX8DEXo
         17A2DiOn3H0KKzIwvJ6/ObLyKuDXCD6krXd/UuVhk+vbmSe+rRk0Qf+Ug1X+H8HxmG5g
         RJfg==
X-Gm-Message-State: AOAM530Av++oEbG3MirGuX86fbTKbNdYxNr4bj+nGr0vzIALgZJC/VIx
        vmIC2rw1Q2s+R7zeKuht7rQ7MA==
X-Google-Smtp-Source: ABdhPJxirD6G77cIgR1B9Ulclv1SoHM6YoexC3zTvyOlIEV0bu2e93K9nYsNB0fJBidlnhqx0zGAWw==
X-Received: by 2002:a63:4457:: with SMTP id t23mr685389pgk.354.1633132833327;
        Fri, 01 Oct 2021 17:00:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm3282047pga.55.2021.10.01.17.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 17:00:32 -0700 (PDT)
Date:   Fri, 1 Oct 2021 17:00:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] docs: Explain the desired position of function
 attributes
Message-ID: <202110011659.F4F81D4196@keescook>
References: <20210930235754.2635912-1-keescook@chromium.org>
 <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 01, 2021 at 12:05:25PM -0700, Nick Desaulniers wrote:
> On Thu, Sep 30, 2021 at 4:58 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > While discussing how to format the addition of various function
> > attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> > close as possible to Linus's preferences for future reference.
> >
> > (Though I note the dissent voiced by Joe Perches, Alexey Dobriyan, and
> > others that would prefer all attributes live on a separate leading line.)
> >
> > [1] https://lore.kernel.org/mm-commits/CAHk-=wiOCLRny5aifWNhr621kYrJwhfURsa0vFPeUEm8mF0ufg@mail.gmail.com/
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> While I appreciate you getting the ball across the finish line (having
> _any_ documentation to point to in future bikesheds), I can't help but
> shake the feeling that the chosen policy will harm the ability of
> existing automated code formatting tools from being able to automate
> code formatting on the kernel.

I am but the messenger here. Is there something specific that'll break
if we follow this?

-- 
Kees Cook
