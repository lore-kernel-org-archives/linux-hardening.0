Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB67C4708F
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA4A6135D
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhFATWk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhFATWj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04710C061756
        for <linux-hardening@vger.kernel.org>; Tue,  1 Jun 2021 12:20:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d16so246186pfn.12
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jun 2021 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m15CB+ejyy1cEkOR8H2bWbxrq91PVD9VpCzkcmHk69k=;
        b=MOHL6Rg4BBPH5wiP7w1yra4HQYcxXWk5JaXhb8kOdJlrkaBNrVv7mmwsmtvCStcM1A
         OhKOQmGxSkEQcMAOjxfYcUHNTyz+O+AwoIjUhtVBIWwrbKhgzUiaGszsQnOPvxlZMj9S
         029lEjbq00R7EtmOTsV6VUMYldCmtYhQvZud8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m15CB+ejyy1cEkOR8H2bWbxrq91PVD9VpCzkcmHk69k=;
        b=NXDrMHquwGFIdgTT057pIeYMqdOVc83xZcbIu5PFeesv8Mg79cTAKaxNSDek2nYlSh
         +WGJzDfHuO35U15KDlJMaxq/z8P+1vqkwAomqZrpn2rLbykMHiNQim4AkvGuiVaaTf1F
         on8IMvpq6/z30GiKqhKs+LMocsZCz9pQXJLYsZql1G+drA23b94WMaO4KqXgo5VtrTXn
         8crIilSj2zOWVJBN03ibboXaUzjUPWrhqMZGgLekvcsTeE1rmtnygHd1O9GKTnxybsP/
         +u6ih0i/PKe+tsGqqXp7klEM1OP4yqXz2zFWy7o7zpcIaS6B+Fk7E+TkjruPXOlltcAc
         ha+A==
X-Gm-Message-State: AOAM530nrQqJCVhEH2KxWoMVh+f/I/sQjOaZxg7HS93HvNKpgRjlyjNd
        Qc9z9EIBXdq/KzqGx+4rABDGaA==
X-Google-Smtp-Source: ABdhPJynQ1oAhjuOu6Yt5pPtGgDrZIwV5A6brhRT0bSHWLsB1ZGgvxq1cMuCHenAxXt3FQZ4B20oLg==
X-Received: by 2002:a65:4d03:: with SMTP id i3mr29670528pgt.422.1622575257623;
        Tue, 01 Jun 2021 12:20:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p26sm2507483pfw.178.2021.06.01.12.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:20:56 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:20:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: ti: davinci-mcasp: Fix fall-through warning
 for Clang
Message-ID: <202106011220.82270074FC@keescook>
References: <20210528202047.GA39602@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528202047.GA39602@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 28, 2021 at 03:20:47PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a goto statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
