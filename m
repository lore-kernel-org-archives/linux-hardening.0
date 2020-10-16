Return-Path: <SRS0=j6/H=DX=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF4CC433E7
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4165E20878
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glM6o2qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411398AbgJPX3L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390881AbgJPX3K (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Oct 2020 19:29:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F676C061755
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:29:41 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 23so83194ljv.7
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRWcsR3ErDLuNj359nwTctyd82652QVm18mOoOerApw=;
        b=glM6o2qLH6c8Gpu68ZhGdnB71TGm1rhJM9RLS8ET9uxXwJ4xOgqjx81BF9HFkdCf7L
         SqndWcTiIwKGkrN9Z6SsDOHpafJcaz14+GuYzCGp/hYDRpWUpljOiJM4RiWoReLZqCKe
         rN4sn00vLe9D+IeAEe5AOhDuDW5NvgvyRX/FApCZiRqRQR2Bf91fB2VCF6hbZA7elG/k
         fNDOoeNCQbVeFXjBnSqp5DCWzI2uJdJPo4jK2vyD0phYlqcbM+3hd0+T2eM6hzIK6UZj
         VGIAyFXMK96Cinr1fl536RylzWZqhK8yGpBE0evBE7gc6K6TxWV6+wB1SlR6L9ALKc5R
         nPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRWcsR3ErDLuNj359nwTctyd82652QVm18mOoOerApw=;
        b=UYyy45TsM0JDefdWhNmLJLv7ky43T/BWp1zs+4zrCdYB82NE0deuRgX6LcgWZpbWDi
         +0JzJ8j8C+/l0RFbPYimfSWnBBwf4F97U0bMDiXBgVCSMMbp5ny9mSSNuR4OsGpX9aVJ
         luNerAptERJ3YoTCHnJLLVkjigB6xC3aHIEQg3rtE7bPx7RXND7zPHYyP6pGUSpid7G8
         d/Qi2P85zG12j/ZhyJ+610v1Ndeknoh7VY9BliGhNvwNoJF3hfRDwrGt2A9uH0lwJfhn
         JTCq2I6C+ePgZ4vUVRbD0DzXDDNFL+SkzfruBKQmdYToSOCfudZaNAiZuVDBtHgKa5r5
         XSAg==
X-Gm-Message-State: AOAM532tDDsmnW38C5rXG6gp+fhsl9S36R4AZ8ncP0P7jU1Vs/AGTFqL
        IsGkEyJJnK+UljCVOXPmrY3rDmEjugRmxYH2eW/bkMIkwX0Gng==
X-Google-Smtp-Source: ABdhPJwkfCc9LVtK7gF///Kob/b9vyj6UvjHM3xR+ox22i+AmVaVnhUI5dUVtT2d6uiUOkBLV2jogttYhekhvAKQDu8=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr2414999ljk.160.1602890979235;
 Fri, 16 Oct 2020 16:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201016125216.10922-2-laniel_francis@privacyrequired.com>
In-Reply-To: <20201016125216.10922-2-laniel_francis@privacyrequired.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 17 Oct 2020 01:29:12 +0200
Message-ID: <CAG48ez29c0yG=5O9CV8_+8e0LyqJfCczpQVm89uv19O=Fq+wKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] Fix unefficient call to memset before memcpu in nla_strlcpy.
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 16, 2020 at 3:02 PM <laniel_francis@privacyrequired.com> wrote:
> This patch solves part 1 of issue: https://github.com/KSPP/linux/issues/110
>
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  lib/nlattr.c | 2 +-

Your patch touches networking-related code; please include the
"NETWORKING [GENERAL]" contacts listed in MAINTAINERS when sending the
next version of your patch series.
