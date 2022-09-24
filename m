Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AAEC07E9D
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Sep 2022 05:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiIXF2X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Sep 2022 01:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiIXF2W (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Sep 2022 01:28:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9721449CD
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 22:28:21 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b5so2018531pgb.6
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=n9mIFFUz+T7uzqeFEnuohJ6a+X7KhoEOiIg4sADalFc=;
        b=DMo/kxxHl+Sb+Hj218OrIpHroTvFp5bVZW/blQ+vD2xPuKFvzWV2XfFMYZC1slpkHg
         RKrTtkaoAGI0KeDNQ12tSDjhEm+ho4NrFro1D2Di0rypfTv40/6Fqz49lkpFtSMKXW+b
         q8+2e6If6ow7WCVv3mHzBTuCjepy7Z4j64V4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=n9mIFFUz+T7uzqeFEnuohJ6a+X7KhoEOiIg4sADalFc=;
        b=If6+01dfUYXUTM0VJTgZVOqtp+YVgKvNgg1dKUAVcaG0zinf+iJVvNMDcap07NM7rP
         IgDShNX2sR56Tekhqt/e0gCGBixTDAp6VY3fzYU78mIpUimsDU/cMVVEnqKmxyGEDM+n
         d/lYkOb1P8LyvqvttW4a+2VOj/oOzxzEe6kkC4b/3hvpSq2NiD19eHUKo7cvI1KxG/Va
         fjAQYeF2huykw1rfh0Ngr3GrYa32uohXG3F84ZWacLz1oZ1gg35fSLyYQmWb5DrUTpVj
         1Ji4a4iCXpQ4dU9YW+bdnaKH4AfZvRlKCLcoOd0huhgpzWUn0exSAyqAiUlGH8YIFGBm
         aguw==
X-Gm-Message-State: ACrzQf1WBQik6nWxCOEL5MUW6MYo7zW0flm7UDrne43K2cBqHj76Zjjl
        9pDtzLUKhea7/8LkrY8nBfECMA==
X-Google-Smtp-Source: AMsMyM7aAuSih3DGaIHDIjGNOp3XiITsYugjJXNQV613GX2y2nc6YZcMCh4lpIlCsz/1lj5HVe6+Gw==
X-Received: by 2002:a63:470e:0:b0:438:a091:5a3b with SMTP id u14-20020a63470e000000b00438a0915a3bmr10499420pga.332.1663997300746;
        Fri, 23 Sep 2022 22:28:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y21-20020a626415000000b0053e607a6bf0sm7359583pfb.43.2022.09.23.22.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 22:28:20 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:28:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: 3w-xxxx: Replace one-element array with
 flexible-array member
Message-ID: <202209232227.7D348DF@keescook>
References: <YyyyvB30jnjRaw/F@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyyyvB30jnjRaw/F@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 22, 2022 at 02:08:44PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct TAG_TW_New_Ioctl and refactor the rest of the code,
> accordingly.
> 
> Notice that, in multiple places, the subtraction of 1 from
> sizeof(TW_New_Ioctl) is removed, as this operation is now implicit
> after the flex-array transformation.

Doing a build before/after this patch results in no binary output
differences. Another 1-element array converted! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
