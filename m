Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E30CE79DC
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Sep 2023 14:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjITOdT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Sep 2023 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjITOdS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Sep 2023 10:33:18 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66905D7
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 07:33:13 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c504386374so4493363fac.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 Sep 2023 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695220392; x=1695825192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0M1U7qooz1MSsev8bUf20ajQA/cHs54guIocLK69iQ=;
        b=NH7fwnRZnVpv3Tszg+nBTlfR42h6U3MBPKyVFbN5w7ehPfhDznLe/fjfplxJxpYw87
         PEz1d+xcJe0BxqjmLrbeGAT3t5wq/CImZ0reqXVVP64sz/sInoy32plBOFPHPImNSp2R
         hHHkhjPE2EmJpNn0SIRfnt/68xtraFyj7cR18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220392; x=1695825192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0M1U7qooz1MSsev8bUf20ajQA/cHs54guIocLK69iQ=;
        b=od53v0nXxv6ND+LJsTzyDF2Mu+CSFT+Rdw9xU0/4Xw8C+/ranr+xYF0HWAKvsJKzLP
         Rayo+/cc1V5wceec48wlZTCBLAncyMRV+fG7T5tu1yhmf440LD3gotW4pt2QtWohE4kP
         mAoWP8XjZNOxLRic97xgBobKPuuad4fWuDbDkHwZcQJII/P8F4nAwZJhqjB2WUeLen/3
         BUUHCf9kGnHu5KD7TBhF3yj3mHtHGZpzisN3PMrsESSLPra2YZDpx6JTrtu6zwoFp9LV
         5yF0SVF2Ryqq+vZzczABG/oPkHNEV2O4zVm5r+oj9n4xkr/i3KoFQTBtoRtBPhRPz+Km
         hraA==
X-Gm-Message-State: AOJu0YxA73iLoLaHFRWDOl6QSdlwgemO4RespoQmE0XH8RHG+QtB1ZFJ
        ct3wzt8t7DBl7daG5LNHbBMOuQ==
X-Google-Smtp-Source: AGHT+IHnG2fdejIvfQiUN3o+flnl539Mq0RwoAuzUXucWVFbeZV6npGQfTNnuQS5wk243vtr8CwbVA==
X-Received: by 2002:a05:6870:8926:b0:1be:f4b3:7f49 with SMTP id i38-20020a056870892600b001bef4b37f49mr2879591oao.23.1695220392694;
        Wed, 20 Sep 2023 07:33:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t13-20020a63954d000000b00564be149a15sm9614073pgn.65.2023.09.20.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:33:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:33:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: replace deprecated strncpy
Message-ID: <202309200732.29C44010F6@keescook>
References: <20230920-strncpy-drivers-i2c-busses-i2c-powermac-c-v1-1-0a3e9a107f8a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-strncpy-drivers-i2c-busses-i2c-powermac-c-v1-1-0a3e9a107f8a@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 20, 2023 at 11:07:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `info.type` is expected to be NUL-terminated judging by its use in
> `i2c_new_client_device()` wherein it is used to populate `client->name`:
> |	strscpy(client->name, info->type, sizeof(client->name));
> 
> NUL-padding is not required and even if it was, `client` is already
> zero-initialized.
> 
> Considering the two points from above, a suitable replacement is
> `strscpy` [2] due to the fact that it guarantees NUL-termination on the
> destination buffer without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks like a straight replacement. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
