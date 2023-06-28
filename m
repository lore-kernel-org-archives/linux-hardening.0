Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA6EB64DA
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjF1R44 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 13:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjF1R4B (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 13:56:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2815A2942
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 10:56:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8063aa2e1so1534205ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687974959; x=1690566959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFGqQjNLgtCZhOK9NTaUTj7bxMdQbyY6Zjaqy2ayJjA=;
        b=HT4hhiN5JNn0QZARAU/GPGa/fqMUEU/xWerlomznK4qOeXv70AjIVWQytBKI7nuUOr
         y30LJria+EJLeMYiwDI19PBMLCYv1zqAHrXhJ6OjGKVqFeNZQkbHJWTgPh+UcIJ+VZI8
         nwgB7vTZxK12d6z/+pMZx7pQCb4SnIcPvgFdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687974959; x=1690566959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFGqQjNLgtCZhOK9NTaUTj7bxMdQbyY6Zjaqy2ayJjA=;
        b=CVzbdySFnc6d3FXdyg/n308R60P1w2TTAluEFmRVv94RnIJ5KoAnTf1aUlDf02QYz9
         7LA0dCshz9irGAKZEWcsrqps9o1QEEUXXdBh+VPokZ5fXzjY8IkJDy1TrLSoM0n0AJhe
         OocWDsefJdz0IFDlQ/tIOqOmeS+LhCBDS0Vkm72LOa0TaM5nv783v0+aRwn+gWyvOS6i
         Ep2nfsUmKBxRIpONmK2yWD0e/ElhIgGKVXTkFGlsxDmZ9jwtowGglTwcNF5Whebak1n/
         G3G/5mh2X1S/72lkbfAYY32bjn/AvbzS2p+kaB98EqL8Tk1aGyk0lU677oC+BTwel6ne
         XX+Q==
X-Gm-Message-State: AC+VfDz2Nuj0Ow1V9Cq7vGTu9VeAFxQoQ0XT4s5ieDgAU5wtFm0DHcMB
        /JHpNOW0m3G/AJEvufFwQhAJfg==
X-Google-Smtp-Source: ACHHUZ4pCHzrs3aB3Au1vDEg5t3p5jkohCdi/8ZwcCKxSUqYnxrYOVYU9Bcm50mn5vuXsh9GgTVoug==
X-Received: by 2002:a17:902:dace:b0:1b3:c7c1:8ded with SMTP id q14-20020a170902dace00b001b3c7c18dedmr10816630plx.27.1687974959600;
        Wed, 28 Jun 2023 10:55:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902b08800b001b8307c81c8sm1970075plr.121.2023.06.28.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 10:55:58 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:55:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yuxiao Zhang <yuxiaozhang@google.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Message-ID: <202306281053.EC5115465B@keescook>
References: <20230627202540.881909-2-yuxiaozhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627202540.881909-2-yuxiaozhang@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 27, 2023 at 01:25:41PM -0700, Yuxiao Zhang wrote:
> Current pmsg implementation is using kmalloc for pmsg record buffer,
> which has max size limits based on page size. Currently even we
> allocate enough space with pmsg-size, pmsg will still fail if the
> file size is larger than what kmalloc allowed.
> 
> Since we don't need physical contiguous memory for pmsg buffer
> , we can use kvmalloc to avoid such limitation.

Conceptually, I am fine with this change. I need a little time to trace
down the allocations. At first glance, I thought this patch only needed
to cover pstore_write_user_compat(), but I guess the read side needs to
be adjusted as well?

I'll double-check.

And yes, Greg's questions are all good -- fixing syntax and adding size
details in the commit log would be appreciated.

-Kees

-- 
Kees Cook
