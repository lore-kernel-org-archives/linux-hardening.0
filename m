Return-Path: <SRS0=yYSg=DG=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925DC4727C
	for <linux-hardening@archiver.kernel.org>; Tue, 29 Sep 2020 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BFB208FE
	for <linux-hardening@archiver.kernel.org>; Tue, 29 Sep 2020 17:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EgdYcQxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgI2ROG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 29 Sep 2020 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgI2ROG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 29 Sep 2020 13:14:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DFDC061755
        for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2020 10:14:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so4387815pgf.5
        for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2020 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=glZ74uXs4uVYpYfsBsjhUYHj82y51C7rtcPVZ0nTWqQ=;
        b=EgdYcQxE7ZZjtGIKn7hfGvTL2dAAS4WYGICct/4ovCNiMZS8Km97CjFJt3irHOI5b0
         1NWe9X+2BEnZBNDw5VjAHScU5u1VsM0MZGeZL2ZPww6WQLY/oSfCJ+ylsXnv6zQCov1F
         A9BS2Ff1KEPFtA7BOyPRVy9zLkxBaesNC7P0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=glZ74uXs4uVYpYfsBsjhUYHj82y51C7rtcPVZ0nTWqQ=;
        b=C5qEI2gdFBIBEfA1OE09CSX3miBGeCsjPh1VF7v6rxEPYRNVtPQRvHLptiNM2b44Lz
         WA/UCgzdhh/1rCnHiUEfiuCTIQjjLs6B7/7FPvU/mOuk48mFFdA9X8RFQSrjGPE8Yi8M
         c23svo82iJiAb8zruWR93W3maCO85ZSPKZlzQaUnl7nCEBMwJE9K5cDkGTWRuRdlPF4f
         +LuA+fTkKE4yYk+O01onJjpm6MfY7Us4sYcdiIR8kP/OT9qyDJFYA3zT2S0IehhUnb4O
         ZGpyx3qRb0sSYAyjmo63wkIVEvmQK0apcSRyvZ0svl/YfNpau0j6BUy1zgguG2hlHrms
         t7jQ==
X-Gm-Message-State: AOAM532kAE/zxdvu9WKwvgLSXR683/WvxG0S772v4XU3zDXMRPTabG1C
        zIt8Jv1CvrxAUpATnXq/yMYlKC0Cy27NkG9O
X-Google-Smtp-Source: ABdhPJzuL2+fzVC78Z9pEdc5ORcVZEwJAqOmtAdORpe3kHYq4M0bJk0KZSyfqie2KFGEJ6y7C2rEtg==
X-Received: by 2002:a63:2319:: with SMTP id j25mr3946103pgj.75.1601399645297;
        Tue, 29 Sep 2020 10:14:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y126sm221637pgb.40.2020.09.29.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:14:04 -0700 (PDT)
Date:   Tue, 29 Sep 2020 10:14:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Linux-specific kernel hardening
Message-ID: <202009281907.946FBE7B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

The work of improving the Linux kernel's security is, of course,
and endless task. While many of the new features come through on the
kernel-hardening@lists.openwall.com list[1], there is a stated desire
to avoid "maintenance" topics[2] on the list, and that isn't compatible
with the on-going work done within the upstream Linux kernel development
community, which may need to discuss the nuances of performing that work.

As such there is now a new list, linux-hardening@vger.kernel.org[3],
which will take kernel-hardening's place in the Linux MAINTAINERS
file. New topics and on-going work will be discussed there, and I urge
anyone interested in Linux kernel hardening to join the new list. It's
my intention that all future upstream work can be CCed there, following
the standard conventions of the Linux development model, for better or
worse. ;)

For anyone discussing new topics or ideas, please continue to CC
kernel-hardening too, as there will likely be many people only subscribed
there. Hopefully this will get the desired split of topics between the
two lists.

Thanks and take care,

-Kees

[1] https://www.openwall.com/lists/kernel-hardening/
    https://lore.kernel.org/kernel-hardening/

[2] https://lore.kernel.org/kernel-hardening/20200902121604.GA10684@openwall.com/

[3] http://vger.kernel.org/vger-lists.html#linux-hardening
    https://lore.kernel.org/linux-hardening/

-- 
Kees Cook
