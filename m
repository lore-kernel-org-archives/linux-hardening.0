Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38BCC433FE
	for <linux-hardening@archiver.kernel.org>; Mon,  7 Mar 2022 19:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbiCGT6R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245245AbiCGT6A (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 7 Mar 2022 14:58:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FFE8A333
        for <linux-hardening@vger.kernel.org>; Mon,  7 Mar 2022 11:57:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m2so9017468pll.0
        for <linux-hardening@vger.kernel.org>; Mon, 07 Mar 2022 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jYGBOhY+YvOBE5ajs2EKO/Fw4vwhlIv5/OzecyNBxUY=;
        b=MhVTEzfX5LNA3eMH4yHZ97/d4z2HLkI847Lak9vMWfOCsnxCKRkJarB6Z0uoMDtHIM
         rLIx2BOpMYdKEUxZnuXYu05aPKWFhrr0yibtTroCkQdK+KT+UgxHfq1J29KiozjMHbii
         iBv9/FOQazz0oO+Pwamqw9fCHZEwuzKjUbWEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jYGBOhY+YvOBE5ajs2EKO/Fw4vwhlIv5/OzecyNBxUY=;
        b=4ntDx9DR5WXaSQJbSo056pUgKgaeU1qVuDoz7tHAR4wgclm13MUlyfXuxPPhv0d0DK
         kfGS4EcNiujmhgeP+acTlYv3vCU/pw2ZZ7Y9IIZzki3rHgnoD73ka8w8dxLc6T8myuzz
         /+aBlr50QfDMxE0nLPhwdYkJW+pt4FABjSx4OJXd4qBA8NeqjXZlu5VwVCgkryVrls/k
         C25skq6pi2l9aW3lHYx+CBbvp0pF73OQGC6Z0delD2BdGxd88D0U1mVJX7CcMNcrgoQJ
         geuyFhV0G3dyIOLaaeF6MafJXbCZtB63fJsqUhWCsGgdKyrasqhae6zRzjxYO2tyAQAj
         HlDQ==
X-Gm-Message-State: AOAM531oZTYJclwuWM5PGIPrlp+Cu8o3Icyo/LuZbHT+BM+vkqwiS5EH
        DSuouV5A+HHALwFZUN20JSJsvw==
X-Google-Smtp-Source: ABdhPJzFSwEk/kHMWe/4LsmtSbJfExBxEBu2A+0J/xfhRd+JxYC9ib8tEgYrzcL586sB3ZUTNQEB8w==
X-Received: by 2002:a17:902:cccf:b0:14e:eb44:40a1 with SMTP id z15-20020a170902cccf00b0014eeb4440a1mr13882125ple.111.1646683022900;
        Mon, 07 Mar 2022 11:57:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090aa00c00b001bc6f1baaaesm164252pjp.39.2022.03.07.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:57:02 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:57:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] xtensa: rename PT_SIZE to PT_KERNEL_SIZE
Message-ID: <202203071157.2218B9B29@keescook>
References: <20220306064435.256328-1-jcmvbkbc@gmail.com>
 <20220306064435.256328-2-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306064435.256328-2-jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Mar 05, 2022 at 10:44:34PM -0800, Max Filippov wrote:
> PT_SIZE is used by the xtensa port to designate kernel exception frame
> size. In preparation for struct pt_regs size change rename PT_SIZE to
> PT_KERNEL_SIZE for clarity and change its definition to always cover
> only the kernel exception frame.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
