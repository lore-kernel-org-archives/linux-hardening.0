Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00661EB64D8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 17:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjFNRx0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFNRxZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 13:53:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514952110
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 10:53:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3f66dda65so14381385ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686765204; x=1689357204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9fj86uPzHKHKPX1wldmULl0XqXDSPGGeaR3eMmaqoM=;
        b=g3wZP4kEF/0MGT5tCDD0ukqrS2SqYZB6jGjbDf/E8Joiv8RJrPZPnOOobgq3rKVC+L
         RB9GPYodgn3JF/MlworDXZZE5sW6PWFSH0ZqOYzbpN0QoKvPhgGt9lPZx/Ob2rcgKLsM
         euYoHENfjJ1jiKm6wHTYfUxTU47NznlaMimaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765204; x=1689357204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9fj86uPzHKHKPX1wldmULl0XqXDSPGGeaR3eMmaqoM=;
        b=OJVCdVNof9VdFCl6xMvmuwP2MmQYsaCftItUy4FLAYdovzqaoKSkIF+GfB2VtD/vch
         wVG7cVOTHO8hXNqHgXtzR9hXlPDapP3HfE9OVGrfbwfGgwAGYrfqsbEfJigm7AQQ6a0T
         lcJkLwNix+lIU4iacHgksdhk3mFdax4naLYIsYYD3clSplZG3ZvCWe+Ah4afwGbiCMFg
         ZhA+7wFZgH6US7hiQHBW1bTFuQHJDfT6DyBs/QccBCA435jCeJkDp2Wt3lo0DpkocYwR
         YABdc/bWVX9+gfVajGDB86lBoE4HKMk4PSywek0BtiCgk8o4P0mClPmQAswB2sljtAe3
         0XRA==
X-Gm-Message-State: AC+VfDxNSl5o1uCOy3I+nuT/J1UVCMc/sp+7wbtIYy1nyCgF8jwViaks
        oNAgJwHOTak4LeJuhgrwoD22ag==
X-Google-Smtp-Source: ACHHUZ73ificKnBEN4Y4oJNws11Nh+V2R8igTOiWQQVlZNLGClfQYikoltoGKYfCx04Yj9HDDKth1g==
X-Received: by 2002:a17:903:1104:b0:1b0:2d08:eb51 with SMTP id n4-20020a170903110400b001b02d08eb51mr16215661plh.12.1686765203877;
        Wed, 14 Jun 2023 10:53:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c14600b001b045c9ababsm775899plj.264.2023.06.14.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:53:23 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:53:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miroslav Benes <mbenes@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] kallsyms: Replace all non-returning strlcpy with strscpy
Message-ID: <202306141053.8C337829@keescook>
References: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 14, 2023 at 01:03:54AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
