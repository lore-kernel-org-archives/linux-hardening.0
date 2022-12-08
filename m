Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E4EC4332F
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 20:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLHU4D (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 15:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLHU4C (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 15:56:02 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7458B1A4
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 12:55:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w37so2152376pga.5
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 12:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJg0tjf49GVzZZXYJm/ESQ/vYejcTaVis8L45uiNSHA=;
        b=WGDXl+n8K/dWeZKeldPrcD/v5Zbw4izCFegv/+gHVqJz5fo4i63IakbdgfDk32UOJ0
         K7CA6axewHrdePgh+eO1x8V+20MgZoSmeS/R+OUwnzbSv5HurnxALTfCXtREO7ppxxNa
         U6LdFtKTrAAZMCV9qJ/PEyYe9JUYQMujpcuIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJg0tjf49GVzZZXYJm/ESQ/vYejcTaVis8L45uiNSHA=;
        b=P3n09vHzDDhcXgYgfNFHkxi1El0DRXD2jfcebSl3kXgDeShX1PkiMdOG9A0f6eAYlU
         mwQVdmx08LAqSUCoJESeoGQUP0Zm5xpkBJMeaulO5vkV5RTExcNYEBD8/hwNMcU+721X
         rBWchRscfDRAEa4md1tppuDpEDn78GC+ZIdcaHvlU1SI8SkuXll6k6nJuugA4JPnyPvo
         uDKxYyIU/aTaDwZYzoZMvmzllP8LZTJdqXgsu+uBAr8QR6Z/lW6VukfzmBoUCb/XvUou
         bYNOjigFYGxvNv1v/BJWWpk77MgJ4dCV0RnD05aesWzLOkr24wbMXyUfX7fwQNkHBitf
         eYLw==
X-Gm-Message-State: ANoB5pmO0b1YkqgTpFHI9TBEuwrliS5USBi6QjNrlUZ8L5fGGJD2y/Bu
        2zCHEU6bn24DJ9HA8egoFksZHg==
X-Google-Smtp-Source: AA0mqf4zdrgHUuOag7wMXflhe99eH3jKylHoxnM8ECvbLmGYxFdavLPXAx42+E9rBdvD3R4pu3TLog==
X-Received: by 2002:a62:e219:0:b0:577:5678:bc80 with SMTP id a25-20020a62e219000000b005775678bc80mr9602372pfi.62.1670532956522;
        Thu, 08 Dec 2022 12:55:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7-20020aa78e87000000b005764c8f8f07sm12310108pfr.84.2022.12.08.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:55:56 -0800 (PST)
Date:   Thu, 8 Dec 2022 12:55:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212081255.22D92C5@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <202212080809.687CC8BC23@keescook>
 <CALmYWFukzdw4e3RHWRsdXvYr1RZs7Bx6NZ3AK91hoArgVy-RxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFukzdw4e3RHWRsdXvYr1RZs7Bx6NZ3AK91hoArgVy-RxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 08, 2022 at 10:33:19AM -0800, Jeff Xu wrote:
> On Thu, Dec 8, 2022 at 8:13 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Dec 07, 2022 at 03:49:33PM +0000, jeffxu@chromium.org wrote:
> > > This is V6 version of patch: see [4] [5] [6] [7] for previous versions.
> >
> > When sending a new version, can you include an overview of what changed
> > between this version and the prior version? This helps reviewers who are
> > following along, so it's easier to focus our attention on the
> > differences. Also, it's helpful to version the links:
> >
> > > [4] https://lwn.net/Articles/890096/
> > > [5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
> > > [6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> > > [7] https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
> >
> > e.g.:
> >
> > v6:
> > - moved foo to bar
> > - improve comments for baz
> > v5: https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
> > v3: https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> > v2: ...etc
> >
> Will do!
> Much appreciated for helping me  through the process of my first patch
> in the kernel.

Happy to help! I'm excited to see this gap in memfd security closed. :)

-- 
Kees Cook
