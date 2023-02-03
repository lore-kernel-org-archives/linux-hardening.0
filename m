Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3FFC61DA4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 17:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjBCRyD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjBCRyD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0059C1F5EB
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 09:54:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so9542438pjq.0
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9RKTKl/Bb3c4duHC9Bqed53UuuEJJvB8k+GUCNePruY=;
        b=HQ0vQysX1kKI8O+PparDZ35dBYNpcFDWtsPkazH7LUJi2OaBa11iyQ9FQsErdO66dx
         1UzzputCQRuAr/bCctGzAZwa0d+aDQ1lgiTzHsFutD6VgNmqAwFcIqJ3F8Tcxz5a8QLk
         /pYo5xZE+h1m4VZPPnBgpQttdWfm3JlDR1S2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RKTKl/Bb3c4duHC9Bqed53UuuEJJvB8k+GUCNePruY=;
        b=1XdjlwH3jWjw57vIY0zzONkgIaFIhx/5AZzzYb376wFyU1Lnh+sMS7l1i7w0vvGPbz
         gfSu40rzpPl8KmaI6LWorgAdx24cEebBy0a29Qm5qzGJOJ+SZC5yr65U7mXhbHSadfoD
         cSu8jiwtkl0U8eoWqOG0Gy+xGKDuPhxymROqzcpLcR4h390BCJkkLSQ3VtgCo1oW57GP
         TtasUyEQevSdP1sQB0+5HwZzao/DBspEMBfl2FUT+xzzU9faHofvnFM5nIbazNSfGAJC
         CVzW/VHn7pCy28Gah09Vgad9vffBtvdtx9+fde1Wt+DAMyWSTRSr/c8aCHeH8ufQcjK9
         FZnQ==
X-Gm-Message-State: AO0yUKVBxH+fFe6gvKxhF3mx4IpyHQQSQU288bGQHq/+s/4va6Ax9oN7
        la/9lL+5M0bwR5AFzyuQiKpmXA==
X-Google-Smtp-Source: AK7set/EmLEgIMfPrEdynvHAK1GlETqG/9g9kQULpuLqRZcPGdmTTgRxZ2UAdRqjHzv/ZYrfp0Ow/w==
X-Received: by 2002:a05:6a20:8420:b0:bc:246c:9be4 with SMTP id c32-20020a056a20842000b000bc246c9be4mr15305808pzd.45.1675446840510;
        Fri, 03 Feb 2023 09:54:00 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a637805000000b004c974bb9a4esm1737998pgc.83.2023.02.03.09.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:53:59 -0800 (PST)
Message-ID: <63dd4a37.630a0220.e4652.35de@mx.google.com>
X-Google-Original-Message-ID: <202302031752.@keescook>
Date:   Fri, 3 Feb 2023 17:53:59 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xfs: Replace one-element arrays with
 flexible-array members
References: <Y9xiYmVLRIKdpJcC@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xiYmVLRIKdpJcC@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 02, 2023 at 07:24:50PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in structures xfs_attr_leaf_name_local and
> xfs_attr_leaf_name_remote.
> 
> The only binary differences reported after the changes are all like
> these:
> 
> fs/xfs/libxfs/xfs_attr_leaf.o
> _@@ -435,7 +435,7 @@
>       3b8:      movzbl 0x2(%rbx),%eax
>       3bc:      rol    $0x8,%bp
>       3c0:      movzwl %bp,%ebp
> -     3c3:      lea    0x2(%rax,%rbp,1),%ebx
> +     3c3:      lea    0x3(%rax,%rbp,1),%ebx
>       3c7:      call   3cc <xfs_attr_leaf_entsize+0x8c>
>                         3c8: R_X86_64_PLT32     __tsan_func_exit-0x4
>       3cc:      or     $0x3,%ebx
> _@@ -454,7 +454,7 @@
>       3ea:      movzbl 0x8(%rbx),%ebx
>       3ee:      call   3f3 <xfs_attr_leaf_entsize+0xb3>
>                         3ef: R_X86_64_PLT32     __tsan_func_exit-0x4
> -     3f3:      add    $0xa,%ebx
> +     3f3:      add    $0xb,%ebx
>       3f6:      or     $0x3,%ebx
>       3f9:      add    $0x1,%ebx
>       3fc:      mov    %ebx,%eax
> 
> similar changes in fs/xfs/scrub/attr.o and fs/xfs/xfs.o object files.

I usually turn off the sanitizers for the A/B build comparisons to make
it easier to read the results. It looks like it _grew_ in size here,
though?

> And the reason for this is because of the round_up() macro called in
> functions xfs_attr_leaf_entsize_remote() and xfs_attr_leaf_entsize_local(),
> which is compensanting for the one-byte reduction in size (due to the
> flex-array transformation) of structures xfs_attr_leaf_name_remote and
> xfs_attr_leaf_name_local. So, sizes remain the same before and after
> changes.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/251
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

If xfstests pass, this seems good to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
