Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A5C7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEPVEX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjEPVEX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 17:04:23 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B65729B
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 14:04:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5208be24dcbso10564272a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684271061; x=1686863061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R93tkvEtSyz3YtU78eyvXjYmdxsbp4hYMRMbW122LIs=;
        b=LJRQ4P+tMZI+1x+Z70dKKlTd5/8Aq1heFXHpQ9DDsqCwSwijDgYXhDpd/Hnq9Px+Cp
         1gukiwIWQrzO3krbhVpyh2ateBJGiYyO47XLaJg6yvfWrFzbCECrTcscfu82p5rth5RF
         LLbuieiU3yBjrrVqDSDPdLRwOjThGvWB/ioDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271061; x=1686863061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R93tkvEtSyz3YtU78eyvXjYmdxsbp4hYMRMbW122LIs=;
        b=AKweE+pKgOnHsn8yan7ILMC/VQ+6bA+s4F7FL8SX4tAbrShMLQb5Y6xwJSYZV2frmG
         0DVzs7kqdlMu+onQh3cVLLMsfJjZ0JAQSAPvnrWDj1pXPCSiWpclKkuG3LsIA+OC5i0W
         boXTpRdboaQCXvqd68yzUMOdBY2M3w1IA9qyJ4mBEvJibuxNGfeRQZgo+X+mju4T1R7c
         oak7/g1JK6RAFoCKqypYrRP5MQEy74RpXHnoUF2n1kAnAuQ7eQsc62y7tipplyMtuIJ/
         0N2UXx53Z7ab94G5yVsQmrnwWZjqAYmgpTDRt4oouayKkz9jg/ni6qMMDVOOvbGflCKp
         /vtg==
X-Gm-Message-State: AC+VfDwwj5sonYCRQ9M47KL8cOOtd3U4m6rxQsR7xAWrzVKfE5QJCLDJ
        nFMWHEoFk7el20y+MbTZ+n5uecKnYSOuzrV9hHQ=
X-Google-Smtp-Source: ACHHUZ4alEuWp0NXjdyHu1loTFOOF5uR6wg79aQJ2l0c/X9gDIxEXdyAfsA9hlCGkAUd5BC8oyzFSQ==
X-Received: by 2002:a05:6a20:9184:b0:100:d4ee:ba80 with SMTP id v4-20020a056a20918400b00100d4eeba80mr29398227pzd.27.1684271061239;
        Tue, 16 May 2023 14:04:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a4-20020a62bd04000000b0063d47bfcdd5sm13860888pff.111.2023.05.16.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:04:20 -0700 (PDT)
Date:   Tue, 16 May 2023 14:04:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: Prefer strscpy over strlcpy calls
Message-ID: <202305161403.15ED4EC@keescook>
References: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 12, 2023 at 03:57:49PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> Check for strscpy()'s return value of -E2BIG on truncate for safe
> replacement with strlcpy().
> 
> This is part of a tree-wide cleanup to remove the strlcpy() function
> entirely from the kernel [2].
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> Note to reviewers: the one case where this patch would modify existing behavior
> is when strlen(src)==destlen==0. Current behavior returns 0, with this patch it
> would return -1.
> 
> Not sure what the implication of this updated behavior would be,
> so bringing it to your attention.

I'm not sure either, but I would prefer non-terminated strings produce
an error, which this change does. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
>  fs/nfs/nfsroot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
> index 620329b7e6ae..7600100ba26f 100644
> --- a/fs/nfs/nfsroot.c
> +++ b/fs/nfs/nfsroot.c
> @@ -164,7 +164,7 @@ __setup("nfsroot=", nfs_root_setup);
>  static int __init root_nfs_copy(char *dest, const char *src,
>  				     const size_t destlen)
>  {
> -	if (strlcpy(dest, src, destlen) > destlen)
> +	if (strscpy(dest, src, destlen) == -E2BIG)
>  		return -1;
>  	return 0;
>  }
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
> 

-- 
Kees Cook
