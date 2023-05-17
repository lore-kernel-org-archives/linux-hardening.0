Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E7AC77B75
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 19:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjEQTOu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 15:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjEQTOo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 15:14:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F98DC49
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:14:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e16918323so923387a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350865; x=1686942865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Dlq/LhLdjBBa7rEoCSYP9M1ozuA1zyVPiangWQIFMI=;
        b=eIEE4i1XP1pkhSnVGQGWgRG8pI2jWOJ+cKID0bS4SWjSUNZSszxmLvKlYs83DOtNvF
         euc4WHz7O5H4eJswSX2r5tdLaLH69xWiwS8HTiIeB29IE9ymKTPasc6OezkZ8HLw3gkU
         O+NPk9Cn9iplJ8RJdF7qBi4aBY7UTxCuj4pMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350865; x=1686942865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Dlq/LhLdjBBa7rEoCSYP9M1ozuA1zyVPiangWQIFMI=;
        b=PeRkrycV+5eQwZLNzCAVOlIkuKExzdbmfbkQVQshSyCbX1unw0GqXIsj9l80RG0Lgu
         UU1EeHGVwu2uSKPX9+FNJ0OxcRrXAMQkkvWfqKMsF7Y7hAMR4ZlqOkh3M3rriAezD1VC
         61N09A+NnbDEi/Uvr0aqV4hkjymKGs+S9lNwIdsJoTmB4bZz89NI79wVEf6bIV5TFWdp
         W4Kn5iM2dDq5OnSXrltTArPEW/gB8AYdgn2GXc/6Tv75Eqh9X+ckC4IbACdelpb/CAv5
         HRawGz1aPhjwvOC7r6R160Hiu3TazxRvNnBPTSh3s6hLk78UA6DUvh72Fpx6Qw7Nrc4Y
         kQjw==
X-Gm-Message-State: AC+VfDz5KrN4yJvhiLjjQzl3Hz4xV8ZILYHQ2+Jy4Kjjh3EWiVMloBU3
        ydXejeTwAXi36sDPaQk//wOBIQ==
X-Google-Smtp-Source: ACHHUZ5r2i4mLMI3xIicT2J4MajYzfFC1hE8hQL6/UmcB88TIbPCyBR2eUzHiVUd+FeilmvLK0PLmQ==
X-Received: by 2002:a17:90b:186:b0:250:bb6:47ed with SMTP id t6-20020a17090b018600b002500bb647edmr659228pjs.33.1684350865131;
        Wed, 17 May 2023 12:14:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090ae61300b002500df72713sm1996216pjy.7.2023.05.17.12.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:14:24 -0700 (PDT)
Date:   Wed, 17 May 2023 12:14:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-hardening@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Replace all non-returning strlcpy with strscpy
Message-ID: <202305171214.C6B93E6A5@keescook>
References: <20230517144910.1521547-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517144910.1521547-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 17, 2023 at 02:49:10PM +0000, Azeem Shaikh wrote:
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
