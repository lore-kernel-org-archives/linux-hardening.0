Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89972C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 04:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiKREXK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbiKREXJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 23:23:09 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992673414
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 20:23:08 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so3965469pgc.10
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 20:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGvu/t6VQHvFZoFQJP8begGit+q5T35vmLy7YY+7LqI=;
        b=QqJ6uhZH0VMF13hXEnQkDFf+EfQH2axSc37xch8zbO2zI9cKfuGKl3Ob2gBsFaiOem
         2gHR2oUlTXKFG3fxjaDUaoqy1/q77lzJBANBisXqov1dM/mVmsr4aPTRlVXp3LR8Ktxj
         FyLnXitq1z8TGzcm/qUOOzXDiwl08t1TZfWc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGvu/t6VQHvFZoFQJP8begGit+q5T35vmLy7YY+7LqI=;
        b=xRpdvZNTd2NCY7OVgvaHoa/7jSDUPV7PsDd3o2aDraj7SvRTUwHwI57pWa2x4DPDml
         1F9csTSQvQHJGV6LolF2d0S8NiOQxZkk2B8uVzhiGt/3+x1pgeCuOONYZOyR1VXGJTxz
         yWlkZCnsuii8J4Ogqkd0EGHGJOsf46mWreUeZEfRo6J0vAkNeX4tGwOhxA7oFHjwAZRg
         qGPGnubteTfpDjrO4PXoFQE+UQPzmGgMkwq33togIZL5EHNElHV7+TP6micyxSlgDgG2
         LYtcAbYVIZTTciw3Wpr/Us6JPEG0wOCyIrWP0lnjFeFJtwoPovln6D1vjiOVEnh6tNLt
         RKoQ==
X-Gm-Message-State: ANoB5pmbxXUCKKSk57+oakTfGVJ2kotFCA/e5SGAKiWk0gYnWdASasL7
        quE64OD5tC9XRvdNjhsidEZcCQ==
X-Google-Smtp-Source: AA0mqf6aUof28Q+DQar0DVId1qX2RKIiKVV8Hi3uE/487MrpnBdcIuRllUGrx2Dri7iiaOPuKZAJsg==
X-Received: by 2002:a05:6a00:21c8:b0:560:e4d1:8df5 with SMTP id t8-20020a056a0021c800b00560e4d18df5mr6173779pfj.39.1668745387902;
        Thu, 17 Nov 2022 20:23:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g197-20020a6252ce000000b0056e0ff577edsm2015438pfb.43.2022.11.17.20.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:23:07 -0800 (PST)
Date:   Thu, 17 Nov 2022 20:23:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hpet: Replace one-element array with flexible-array
 member
Message-ID: <202211172022.43C0478D6@keescook>
References: <20221118034250.never.999-kees@kernel.org>
 <Y3cB3MqiM+KFJHNm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3cB3MqiM+KFJHNm@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 17, 2022 at 09:54:04PM -0600, Gustavo A. R. Silva wrote:
> On Thu, Nov 17, 2022 at 07:42:55PM -0800, Kees Cook wrote:
> > One-element arrays are deprecated[1] and are being replaced with
> > flexible array members in support of the ongoing efforts to tighten the
> > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > 
> > Replace one-element array with flexible-array member in struct hpet.
> > 
> > This results in no differences in binary output. The use of struct hpet
> > is never used with sizeof() and accesses via hpet_timers array are
> > already done after explicit bounds checking.
> > 
> > [1] https://github.com/KSPP/linux/issues/79
> > 
> > Cc: Clemens Ladisch <clemens@ladisch.de>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Such a sneaky 1-element... ~.~

Yes! This one made my system unbootable after adding
-fstrict-flex-arrays=3. :) All better now.

> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!

-- 
Kees Cook
