Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB4AC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jan 2022 22:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiAZWxd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jan 2022 17:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiAZWxc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jan 2022 17:53:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8743C06173B
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 14:53:32 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so1043886pja.2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jan 2022 14:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jmylYnPW0itqk7X3kALZZJzsAaqdNt+3di958skR0YI=;
        b=PHqUwsaNVoleX6lM8/jK8bmNbOWlq2er+xvJuFqzw6iPanil4hooAU8qxSxIqs3gnx
         yD9wnS+rsC5aOFii+X674igUsl6mXFK8bCd/0xiCKcYur8FlJGVHBVZctdKSCdJgYe1x
         5UnYTJIOx7UZVbzQCFMMs6OhpI24L0xOF/rR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jmylYnPW0itqk7X3kALZZJzsAaqdNt+3di958skR0YI=;
        b=XcJ1aiEkHyqqvKiTDBUll8C2+fVDbwv4P7yaL6yk67rnCqn3ceLJuafgB/f4yqONvw
         QFYEL5OYbTRzWn4MGxDvICV2cCEaASrMKNVqjYKuxvrdQ77CLx+wF8C3zaP7367Or7XP
         na7BvugQZbzID+0UUFHaV65LLWqu2p9N7tV/mUAFVzbyL4kx2F1MNT5TQlGLsocq3FXx
         xHdglbDctxpSlZ/IH7h//e3eh230iPUrfadmW+jKLO0llQGzPBq24DgHYDo44rJyI6eg
         nqT3LIifaGJYJO6A9yzx5zuylQ6Csv2tI7f7VgKetZYoDIZBcFYGc/UCVjCunHTsNbVO
         CHCA==
X-Gm-Message-State: AOAM532kPxS0KNvkyXfKhz2BJR3wqIyOxy1CrIsnLQbpG7RSOz3rS/mt
        mK0xEPx5+szcmffvWGspCFonIA==
X-Google-Smtp-Source: ABdhPJz0naa97lzLP+/kLQLkxJiIfooOGk727zm3c6gKvGHG1g4Up7tKbetD2ZS99Jox6VBbC04MAw==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr10993180pjb.228.1643237612205;
        Wed, 26 Jan 2022 14:53:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14sm3246409pfm.17.2022.01.26.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:53:31 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:53:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] net/mlx5e: Use struct_group() for memcpy() region
Message-ID: <202201261452.97A809BE9C@keescook>
References: <20220124172242.2410996-1-keescook@chromium.org>
 <20220126212854.6gxffia7vj6cbtbh@sx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126212854.6gxffia7vj6cbtbh@sx1>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jan 26, 2022 at 01:28:54PM -0800, Saeed Mahameed wrote:
> On 24 Jan 09:22, Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Use struct_group() in struct vlan_ethhdr around members h_dest and
> > h_source, so they can be referenced together. This will allow memcpy()
> > and sizeof() to more easily reason about sizes, improve readability,
> > and avoid future warnings about writing beyond the end of h_dest.
> > 
> > "pahole" shows no size nor member offset changes to struct vlan_ethhdr.
> > "objdump -d" shows no object code changes.
> > 
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-rdma@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Since this results in no binary differences, I will carry this in my tree
> > unless someone else wants to pick it up. It's one of the last remaining
> > clean-ups needed for the next step in memcpy() hardening.
> > ---
> 
> applied to net-next-mlx5

Thanks! How often does net-next-mlx5 flush into net-next?

-- 
Kees Cook
