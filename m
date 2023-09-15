Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB0EE021A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 04:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjIOEBF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 00:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOEBE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 00:01:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76302102
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:00:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso14609135ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694750459; x=1695355259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSXFfyqgPwKVqMylZWaZxOwMkCRZt/DukldIcyDr7/Q=;
        b=OLrBWk+HHUIEagXG9HPi9FmVAexOREXK8DbV4Qa9njdBrjDNZ5qiM3QaBAAGlZqgUS
         84DVS843GER+iS3+9N1WMDQKv7VVywrngGQG/KZnAFFXGXI41pMQih2gh4yqU3fyWnWw
         vtPQ71EdCJ1HBaCHm/K6UabYgv+1faZsGG8Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750459; x=1695355259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSXFfyqgPwKVqMylZWaZxOwMkCRZt/DukldIcyDr7/Q=;
        b=Kf0+KjYbMvnUBNQ48Cms5pqO7nw6tHShL/uyCLL8xk9vxaLvUbVDC2SpYMwK41yl7q
         qaamMmGUebN8XSbgWmiFlcQ8ts4hfLut5QBQj+Q0ohIyol+GG554uvFrIozvnOFzipLg
         Ejz93cNkEPE1ra0BllEmmN+gqP0P57/yAVRIOslr+kH98u59Gl2VwAhVQ6SqpHOg0olr
         7G7cn+DrvitZ0r4k5H2zjL1wb1qr9+0Md24Ulx6bSXCUargQWpLfl5XJ+wx7J4njT/dX
         02nt7AKoBsdS+zmW1i9qMjf+Y4B8tvmGSBMvn0sVqg5aGagw+i0RJ6h9WolPDET8nclA
         lM7g==
X-Gm-Message-State: AOJu0YwEKcSynlFJgF120/hhh4Y2P3NDvz8uQrtG5sjyvBJjTKgfNjHB
        m9iKd9J7CMsVkrbZosqh1UBhLg==
X-Google-Smtp-Source: AGHT+IGrfmym+Yfc4T+2FuFkeWde43uGhYIAgsRNS/mPDe3YUyp9Q/Gpkh8qdFQgMFLcFHhnM1UsEg==
X-Received: by 2002:a17:903:2302:b0:1c0:afdb:1e6c with SMTP id d2-20020a170903230200b001c0afdb1e6cmr691210plh.8.1694750459263;
        Thu, 14 Sep 2023 21:00:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001c0cb2aa2easm2350777plb.121.2023.09.14.21.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:00:58 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:00:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: bpmp: refactor deprecated strncpy
Message-ID: <202309142054.8D93862@keescook>
References: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 13, 2023 at 07:38:44PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> It seems like the filename stored at `namevirt` is expected to be
> NUL-terminated.

This took me a bit to establish, but yes: buf[256] is used to store
filename, so it'll always be %NUL-terminated with the 256 bytes, which
is the same size used to allocate virtname, which means it will always
be %NUL-terminated.

> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst maintaining
> the NUL-padding behavior that strncpy provides.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This one looks weird because namevirt seems unused, but I assume there's
some kind of DMA side-effect happening somewhere?

But, yes, after digging around here, I think this all looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
