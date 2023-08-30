Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A7C6FA8F
	for <linux-hardening@archiver.kernel.org>; Wed, 30 Aug 2023 22:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbjH3WSf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbjH3WSd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 30 Aug 2023 18:18:33 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC1E5F
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 15:18:06 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-34961362f67so3656325ab.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Aug 2023 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693433877; x=1694038677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUAmAIfHsOOy8zS6TdEt3xyRCqjjcX1SJ2/1LstkkSY=;
        b=5RNKAGaudUZwQoGbtOK5zrirwuh+BbCGATe4chEu1Zt9U2PrARMa48B6YE111O3Nfh
         P2rCfbKhyiMN37bNfDzNlJfeG0YgYkiivub3+gFr6qH+aJBbPTdwMWUOpcGbq0+sMmEe
         c2xaMPjgCcFNig3KcJ+GlNnXZZ0O+mG8sQ+TlnLQ8hlIrQu1ZdzKMIUpUTb7N/KyAz2R
         cixh9crsY2Ko/sAgqz2cWa5sik5ljF2i8qK2zPS+mqwrgCzOxROsOZtSap/x73hzwXhW
         LfHXrbFtgbjVpZ1lqzdRoSx+2YQg7+LdK0SEgBkBQzCaueCNgo1U9g5hZDp/gBfpAdG0
         szlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693433877; x=1694038677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUAmAIfHsOOy8zS6TdEt3xyRCqjjcX1SJ2/1LstkkSY=;
        b=CmEnLBe82K9ySl9bgv4U2/zL3ngc8foQDMHYvAypgHSLUaUdJGvQaQcIlIPUz3Xs/0
         8Vbw7mbNM4N2SWQRu8i+QfVFOhG7K6/ggVHu6VJDhz+vBps06LRH3OBqNmebAW9i0MAf
         43oD5/x+mMAIMaqy15tmf7o0zTPQdEJNuXPoLsj70iHrQiBBzKcPDxQG9Fj08CQLAIER
         BMH5jbbbdOqj2Aq26CkziHF2a5LBMvkF/jQFbiE+6wIRe0tUzHh2Zv6Yv3btUaHYCF3r
         D31hhmrB1/JHkru7C9HTXlykxnnek8t9I7ah1fFPkbQYvsw4x0cFAXqy1GwCNykeolGO
         pDQg==
X-Gm-Message-State: AOJu0YyGu/LegWNpYkiF5xX+N3oqvrombEpgp4YRjqauIHe6VDqOadG0
        xrNbZxL9K2yVfeLTLh6v/n60Dg==
X-Google-Smtp-Source: AGHT+IEJl2Gy/UlH0rjOjWUj+pyrp/3+xYSPOMHsZ83QRaizwW1QDk1RZG+FSAw+dDLKsUqFelUKBA==
X-Received: by 2002:a05:6e02:16c6:b0:348:b07e:fdac with SMTP id 6-20020a056e0216c600b00348b07efdacmr881860ilx.3.1693433877356;
        Wed, 30 Aug 2023 15:17:57 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id t6-20020a056e02010600b0034632ab31c9sm60981ilm.21.2023.08.30.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:17:56 -0700 (PDT)
Date:   Wed, 30 Aug 2023 22:17:54 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-hardening@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/2] ocfs2: Replace strlcpy with strscpy
Message-ID: <20230830221754.3bhdz4qipppihoxz@google.com>
References: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
 <20230830215426.4181755-3-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830215426.4181755-3-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 30, 2023 at 09:54:26PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> Direct replacement is assumed to be safe here since
> it's ok for `kernel_param_ops.get()` to return -errno [3].
> This changes the behavior such that instead of silently ignoring the
> case when sizeof(@buffer) < DLMFS_CAPABILITIES, we now return error.

Not super familiar with the semantics of `kernel_param_ops.get()` but do
note that strscpy can only return -E2BIG and not -ERRNO specifically. Is
this still OK?

>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> [3] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L52
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  fs/ocfs2/dlmfs/dlmfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index 33e529de93b2..b001eccdd2f3 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -80,7 +80,7 @@ static int param_set_dlmfs_capabilities(const char *val,
>  static int param_get_dlmfs_capabilities(char *buffer,
>  					const struct kernel_param *kp)
>  {
> -	return strlcpy(buffer, DLMFS_CAPABILITIES,
> +	return strscpy(buffer, DLMFS_CAPABILITIES,
>  		       strlen(DLMFS_CAPABILITIES) + 1);
>  }
>  static const struct kernel_param_ops dlmfs_capabilities_ops = {
> --
> 2.42.0.283.g2d96d420d3-goog
>
