Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1C0C4332E
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB464F93
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhCLCqF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhCLCpc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 21:45:32 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2901C061765
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:45:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id ha17so3681431pjb.2
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4kwV+ZEKg/XUTXzjIOI98K3vszan57O9kTgEQIPUcyY=;
        b=jjgy6DIlMrFWse7xf7SeVmNo6/eGcfxozbDUHSMQIaAkUvtKpYHpt1Nwc6YY8mktC0
         QvA45UlbJ3LdLEcjQJRShs+Mi+w+YtXcAlxhMbLCprgTfdm3QxYC9CKRfKXx0lp5VKN/
         0rig3eJkC3MeuhK1bHFBrPGYFC3oy4KEA3qQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4kwV+ZEKg/XUTXzjIOI98K3vszan57O9kTgEQIPUcyY=;
        b=DQzPWehEMFhgjZ0y9qdqiTk4vaEnmCw1yDlGrRwfvZm/HyrYMxxRXjSI8UWi2TH8si
         grQYFFSlwk3gBNR+DQZSBW5/WMpz7pKcD9Qksnnp38AU9N7rXuWKwdfULHIcip5J6RUj
         hLeORBSV5eehJCiJTNq2ulYFXcNewROTOWx5ySftZ2REau2atI0EfQVB66twi4V/A/wp
         ijGiMQMPN1QI+IB4wMSatVJjpe2btx4Kz6gpjLN7wviTp3Le8V75LMG84sJkoDQUaTC6
         U0WNp3LAWGM6w6/kv1lUqPdi7HXbyBrwGGhWezGyMdiV4qK3aaBPs/fgzsTPZxiPQo4S
         iQnA==
X-Gm-Message-State: AOAM533vvEPwwPcplFLnV3I2J7Rc6j9+KrfGCZh7eIkMmNFqDFSxY2Jl
        8Forq2vf4H36j/K3r+dwL+4VTw==
X-Google-Smtp-Source: ABdhPJwDCBrjoyl24XQocrPBFT0JUae7XRtchBVIiOME05IAIHkeYXy2xsIRiO8vA4pM0qb+BqLZfg==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr12125260pju.54.1615517129325;
        Thu, 11 Mar 2021 18:45:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm3684714pfo.45.2021.03.11.18.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:28 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/17] lib/list_sort: fix function type mismatches
Message-ID: <202103111845.A61BBB44A5@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-10-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:11PM -0800, Sami Tolvanen wrote:
> Casting the comparison function to a different type trips indirect
> call Control-Flow Integrity (CFI) checking. Remove the additional
> consts from cmp_func, and the now unneeded casts.
> 
> Fixes: 043b3f7b6388 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
