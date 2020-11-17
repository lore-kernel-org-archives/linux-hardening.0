Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE1BC2D0E4
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 22:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0966D241A7
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 22:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lZfw16iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKQWGR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQWGR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Nov 2020 17:06:17 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15888C0613CF
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2020 14:06:17 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so40477pfm.13
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2020 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMzHGfgKgHH9Q7DYJZTvY9huOKnhq3Uw8YTha6ix4Dk=;
        b=lZfw16izALKPSwU9E2uB5wHjIyBKog7bB9SFuyG61JvYDxMmIiKSfudz7kkmduanaJ
         QMkPzmtzWxVKFx8+qvH5jIM99Ix82HS3Ag7yXw4octz0t3RgdTSXhoP6HRXmsD2IJfTA
         Y7C9RG10oO3WCi++8Cb/UawaqfcwgS6cOjc8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMzHGfgKgHH9Q7DYJZTvY9huOKnhq3Uw8YTha6ix4Dk=;
        b=F2AcHxi1E+gs2OHcs2H8YnOtOh19pV4SavP7/BIedcS3+ZpcgzO19o8BLhEYsXKJ02
         NE2va9wu6Byu3oDq0puuSeyY+qqzYCoyWNPOXpZPJ/YeElwdauPajpitHIyc/uGaXDVs
         Tkmm+NWSFwtBg0NjTeJkk6tHyg+VuQpPW4Qgo3Mfr0dGd2m+JOEuYL/wTjKgHKQgab60
         33wq2+0ccBpDeNUWeb6gmqI8I+HQqMCLm+Vs5CeMcslIqyMBtH4DlHe1p+HzCoz/XaN/
         6R/HczHAsso+aJNdPQQ5Y+a/Wt2TByuJYUYPOukpSuw+ZFGa2DVysbtqOD2ejJJuXrZz
         7feA==
X-Gm-Message-State: AOAM530+iNPMQnKzVaze00hPB316l3iXBnU2FBc01gbEO45e+QRICWgb
        U01bBdExvmCy3ju3lmlzQI/Cqf821sCQX20O
X-Google-Smtp-Source: ABdhPJzn7DDz10g8h9OwN+shzffrUwfJHAKqR9KfIYwYKmcX3HSnw2Z2R6QRbhbhdCE1JS142B51JA==
X-Received: by 2002:a65:6a50:: with SMTP id o16mr5302169pgu.292.1605650776612;
        Tue, 17 Nov 2020 14:06:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e66sm7006000pfh.102.2020.11.17.14.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 14:06:08 -0800 (PST)
Date:   Tue, 17 Nov 2020 14:06:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC PATCH v4 0/5] Fortify strscpy()
Message-ID: <202011171404.2CFCB24344@keescook>
References: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 16, 2020 at 03:50:07PM +0100, laniel_francis@privacyrequired.com wrote:
> This patch set answers to this issue:
> https://github.com/KSPP/linux/issues/46
> 
> I based my modifications on top of two patches from Daniel Axtens which modify
> calls to __builtin_object_size to ensure the true size of char * are returned
> and not the surrounding structure size.
> 
> To sum up, in my first patch I implemented a fortified version of strscpy.
> This new version ensures the following before calling vanilla strscpy:
> 1. There is no read overflow because we either size is smaller than src length
> or we shrink size to src length by calling fortified strnlen.
> 2. There is no write overflow because we either failed during compilation or at
> runtime by checking that size is smaller than dest size.
> The second patch brings a new file in LKDTM driver to test this new version.
> The test ensures the fortified version still returns the same value as the
> vanilla one while panic'ing when there is a write overflow.
> The third just corrects some typos in LKDTM related file.
> 
> If you see any problem or way to improve the code, feel free to share it.

Thanks! This looks really good. You can drop the "RFC" parts, and for
v5, please use

	To: Andrew Morton <akpm@linux-foundation.org>

and add to Cc:

	linux-mm@kvack.org
	linux-kernel@vger.kernel.org

I think going via -mm is the most sensible, since that's where the other
fortify pieces landed.

-- 
Kees Cook
