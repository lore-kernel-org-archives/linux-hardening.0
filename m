Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68376C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 14 Dec 2021 17:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhLNRFk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 14 Dec 2021 12:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhLNRFj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 14 Dec 2021 12:05:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C983C06173F
        for <linux-hardening@vger.kernel.org>; Tue, 14 Dec 2021 09:05:39 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id iq11so14835575pjb.3
        for <linux-hardening@vger.kernel.org>; Tue, 14 Dec 2021 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A6836gc0s76HSfL2ZiuDjKE+np84sI4oL8Iom/KwxZU=;
        b=Il8Xs0i7yKcGaPdWUSDd/OkT3CZc4f7Sh+8OtZOHt5cw/LrudBWuKIHPYCZV3FTrUk
         ZCxzlJ6YFhcdIDnKAZH3Iqz22CWaTY2lG178hVvPcNC1hDfdjqi6tv0VEcfafKKWKB8K
         dnyvY9pIEtiiYdtB0dnO0Lz00on3mBZZYm2BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6836gc0s76HSfL2ZiuDjKE+np84sI4oL8Iom/KwxZU=;
        b=i93kEWzIj5N2N9upvVgASEBAhxor0V95fp4xU09L0KR/Ppb5BA6KR/n3YITUW2eujb
         6hoK5pdt8GHO3XJY1V8TuvIRQxlAq+wgBmiM+h/v5YyfFEUDNpHpDTvgBjei8b/LmpRg
         G8YNo6mbYXsUOeueQH4smvE4HYiR3+11B3lpDdONbjYNIGE7yGwAYDDnhy0LdXLG2Kki
         G3cXivY2aZQbFXvUIisTBX57qwjGZ1Y5BNju2pAK2rnKW8B1VZEm4jBMdjDdvvAsXuYJ
         JrGE7t1qb0pg1qmY4zwmlpj+WwOYGodiTvtMwp/JBcNjuiY9+2vJFMcDBp41umTyt+v4
         PJWQ==
X-Gm-Message-State: AOAM531gmI5uP66I35mxHzcWNgO3aN1MG7+6BDkz1EQST6UI86lsTOfT
        CpvWe8Xta36lOHpYbqN5Taoj5g==
X-Google-Smtp-Source: ABdhPJyid4WvM6SF/FMb0ie7qooR8i+hL7xAAAtPkfmxyGyhk6umYMIjfNB8BB80oKo2BZX9lXr/IQ==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr2745434pjb.106.1639501538563;
        Tue, 14 Dec 2021 09:05:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6sm436804pfc.30.2021.12.14.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:05:38 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:05:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] ath11k: Use memset_startat() for clearing queue
 descriptors
Message-ID: <202112140904.2D64E570@keescook>
References: <20211213223331.135412-1-keescook@chromium.org>
 <20211213223331.135412-9-keescook@chromium.org>
 <87v8zriv1c.fsf@codeaurora.org>
 <877dc7i3zc.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dc7i3zc.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 14, 2021 at 05:46:31PM +0200, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
> > Kees Cook <keescook@chromium.org> writes:
> >
> >> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >> field bounds checking for memset(), avoid intentionally writing across
> >> neighboring fields.
> >>
> >> Use memset_startat() so memset() doesn't get confused about writing
> >> beyond the destination member that is intended to be the starting point
> >> of zeroing through the end of the struct. Additionally split up a later
> >> field-spanning memset() so that memset() can reason about the size.
> >>
> >> Cc: Kalle Valo <kvalo@codeaurora.org>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: ath11k@lists.infradead.org
> >> Cc: linux-wireless@vger.kernel.org
> >> Cc: netdev@vger.kernel.org
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > What's the plan for this patch? I would like to take this via my ath
> > tree to avoid conflicts.
> 
> Actually this has been already applied:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=d5549e9a6b86
> 
> Why are you submitting the same patch twice?

These are all part of a topic branch, and the cover letter mentioned
that a set of them have already been taken but haven't appeared in -next
(which was delayed).

Sorry for the confusion!

-- 
Kees Cook
