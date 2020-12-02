Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB27EC64E7C
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Dec 2020 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691D82224A
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Dec 2020 19:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgLBTCQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLBTCQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Dec 2020 14:02:16 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24FC0613D6
        for <linux-hardening@vger.kernel.org>; Wed,  2 Dec 2020 11:01:36 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so1846799pfu.1
        for <linux-hardening@vger.kernel.org>; Wed, 02 Dec 2020 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xm4VGai40mVfU1KDiOQQ0ruatOar3xR8M6PEtESptL8=;
        b=BOTDt7cxNAex0LeSeJ0Bd0epvVBMchFl+S3d5BAw4jBe6cs8DEJyHSf+DkFhiosw7s
         lkaLbQ7Yt+dfQBgaizkChhWc0pKV3yes/+T/4oY/CzbjnpcXPIQF6n9TgnAor+JYXJXi
         oN2RQYGGl9SmfzExNN0ok3gT3iXCUoUzwQ4Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xm4VGai40mVfU1KDiOQQ0ruatOar3xR8M6PEtESptL8=;
        b=G+czrlDVakAL8/cSFsBIgo5EbE6YYKftp3tes3h45dJ9cEXi60f6LeJzZ1Q8BWYBD0
         2y3yZa6IEkbvSRlji1hz/MHTXIkyMYXRhJo2ftNTYIZcK1aiQINo/3WSKexOJhGWsNaZ
         E6peYAfFXx03W1sjQV70RgKsp5duWWx3cQHMh0QtKiWCDGWVuunJGac67Em3BhbT6o/v
         BrdaLY+0CGXvWQAi+1WlPQFoC+1k40icidTVOpIH9oku4/Mw2mIF4lY9NruzoNubVfIH
         SgycD0+VJg7oUrNNy5o14aHHQIDvXg5/Ma+Opt3do3fV16ZkU5lkfBe4eldHK0OC5/Hx
         ViZw==
X-Gm-Message-State: AOAM533SbqUVDiHfax3fKQjfkvl1S7GBq7iPr1BSbE7+pSTT5hrBod1b
        IPO9wc53HWGqrVqkas5lEhbSDA==
X-Google-Smtp-Source: ABdhPJx3VqSsGJkmnkbKOrKvM3mPguRPfGXpejwNXC3FxfcOsVcXUkpKD/QpYIAX3BR4LaEu03malw==
X-Received: by 2002:a63:171b:: with SMTP id x27mr1199959pgl.70.1606935696197;
        Wed, 02 Dec 2020 11:01:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j16sm448198pgl.50.2020.12.02.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:01:35 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:01:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Emese Revfy <re.emese@gmail.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: remove code for GCC versions older than 4.9
Message-ID: <202012021101.E0BAFC3B@keescook>
References: <20201202134929.99883-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202134929.99883-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 02, 2020 at 10:49:29PM +0900, Masahiro Yamada wrote:
> Documentation/process/changes.rst says the minimal GCC version is 4.9.
> Hence, BUILDING_GCC_VERSION is greater than or equal to 4009.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

Do you want to carry this in the kbuild tree, or would you like me to
pick it up?

Thanks!

-- 
Kees Cook
