Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51920C04A6A
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Aug 2023 05:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjHKFz5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Aug 2023 01:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjHKFzz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Aug 2023 01:55:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2C42D6A
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 22:55:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26b1adbd655so502045a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Aug 2023 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691733352; x=1692338152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OD5ZJXsW01Gkak3C9PDmNcxF6jiUQnE47JaTYXQ2XI=;
        b=KmJ7vo2x2kgxcCOFYtH2hKSHu+0pY2VUNnZpCBbS25LCbKUtxA688X2pLRPq9USzib
         SUIXyKe3IQrJtsvW1BW3eo5YJGPrXCSJVMzZDcXuk5jr83tmrf5PuCtCj2wpE4VcbgcK
         T+S+T323/s0Qx0kVW3cGQ6hnilxAECCDhcmz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733352; x=1692338152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OD5ZJXsW01Gkak3C9PDmNcxF6jiUQnE47JaTYXQ2XI=;
        b=HqC8IZ2ajtsIU3EZYsbYxh4wW6rAMJgxvcUzV/6Y/f7UzGEbP+n0Q72VcMP87mcbNS
         Z1H9ch2B8cF3Z8/WDwefgCHOJee1fEp+s8ea6bH8PdktiLv4N+tnfZgmHJ4ppFF3FLZy
         OByC1/cegvwTrtpfeumEUrTUewbwojm8gsa0R9XoLxpEItpzIwBVirGeJvHzOxLnxTA1
         4nUiaxkG/vG6M6FGRLtQOgSvRSly74SV9Mwy7mMTe9fgCxjszoM5mOqVlZ65BG/a3Tx0
         K1KbRbhrXVc3GnUwxTDPRx6CeN1zfigCJYSI05y0lNG4Frh2jxbbnAqiNut3+EP+67sv
         JSeA==
X-Gm-Message-State: AOJu0YxtEihbC8PcpVmYwNvVhB+ANrd3nq7VzHFQuK8mPOIu2ayYe22i
        nXFg6SsKO/WZGjKV/G0yM6qwUQ==
X-Google-Smtp-Source: AGHT+IG/KPGlnVMvs4ls738U22u+HBpqZA1zXRBdAtInf7cvftgHPpkb2CXU/kZ/s1PD0WUg+5/Ziw==
X-Received: by 2002:a17:90b:1b04:b0:268:13e2:fc91 with SMTP id nu4-20020a17090b1b0400b0026813e2fc91mr449458pjb.31.1691733352385;
        Thu, 10 Aug 2023 22:55:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a898a00b00263fc1ef1aasm4350298pjn.10.2023.08.10.22.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:55:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 22:55:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ARM: ptrace: Restore syscall skipping and restart
 while tracing
Message-ID: <202308102254.689CB3F@keescook>
References: <20230810195141.never.338-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810195141.never.338-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 10, 2023 at 12:54:17PM -0700, Kees Cook wrote:
> Fix tracing on arm since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall:
> always store thread_info->abi_syscall"). This was seen with the broken
> seccomp tests "syscall_errno", "syscall_faked", and "syscall_restart".

I'd like to get this fixed in v6.5. Russell, do you have a fixes tree
that you'll be sending Linus's way before the next -rc? I can send it
via my seccomp-fixes tree if that'd be easier.

Thanks!

-Kees

-- 
Kees Cook
