Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD44C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 06:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJKGyF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJKGyE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 02:54:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9F680515
        for <linux-hardening@vger.kernel.org>; Mon, 10 Oct 2022 23:54:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so11244634pjl.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Oct 2022 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sga1zyvqspSHTBK1MtPA6ZPMPuSJOrHoE2GS0bxhLWQ=;
        b=VnQ6xnBuVEotqAa9gM/q37YrprAvxlQ0OjmdCa7vk6kGUznFNA5OL0YLN7d6hfFkaB
         kL/CR2JMoYASUIJad8x0f8//OEqqeBw+MXO2dGrHo9C1IjySxeBaCzQae+duEHbZ5VGh
         o5DIeJPzmQ7h0KMT4bBpaRS7P1qRUkw1h5ra4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sga1zyvqspSHTBK1MtPA6ZPMPuSJOrHoE2GS0bxhLWQ=;
        b=C6WqGqiJAVyndkcaC82u6EPI5jGeTUpr4eZWyZl4393tzRC5i+Ey8vkT8ls26RX82A
         l8v+PMaf3LaV8Hd3l4zabwi8rnVkxrUj2dLqXguFHmiKEH72EcW7bAAahdBDQqMIwzHY
         WE6CLk0GuWihPox1OELiVMysMynXeStD8pfZf4yA/Mocrn1W4qy1chagmogOJv7Gbgt1
         IIhVyXoiVhz5heEjz9Huq3m0N8EgJe4tVI5Qabkwsn4WXjv+DukDsofzPN8N+mvGQxsR
         gh5GLXLw9K4FtYrU/GRDJ3lMDGDyrm6MBAaPn/05JsMSiLgj67tX2IL4EhOa0GeBS70a
         tArg==
X-Gm-Message-State: ACrzQf088N0SY3IvZLm4ElCzIQqTpIuGrqcjndWmd8jDcfH2ieo205RI
        QmdNW4vWw+0Hun9eWf4Rp9oKng==
X-Google-Smtp-Source: AMsMyM6NBkHG6BwYBxJhQvcR1RK23iSxIGICYMdvhAsd+Dr1M6D4z3tY2Fra1/RXzh/3MrvXzjBv5w==
X-Received: by 2002:a17:90a:c984:b0:20a:ac88:d39d with SMTP id w4-20020a17090ac98400b0020aac88d39dmr35350554pjt.13.1665471242729;
        Mon, 10 Oct 2022 23:54:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h62-20020a628341000000b0056286c552ecsm8048364pfe.184.2022.10.10.23.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 23:54:02 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:54:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [fortify] 54d9469bc5:
 WARNING:at_fs/nfs/namespace.c:#nfs_d_automount
Message-ID: <202210102352.B80BC62@keescook>
References: <202210110948.26b43120-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210110948.26b43120-yujie.liu@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 11, 2022 at 11:45:56AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 ("fortify: Add run-time WARN for cross-field memcpy()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [...]
> [   57.256986][ T4357] memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)

Thanks for the report! I've sent a patch for this now:
https://lore.kernel.org/lkml/20221011065243.583650-1-keescook@chromium.org/

-- 
Kees Cook
