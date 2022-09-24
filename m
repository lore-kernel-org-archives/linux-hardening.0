Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D83AC07E9D
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Sep 2022 05:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIXFej (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Sep 2022 01:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiIXFeh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Sep 2022 01:34:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3ACEE18
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 22:34:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w10so1862453pll.11
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 22:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mz4Rd8XWjT7uEpyICKIeRorRz31JPqdwkS3WoVtgZ1E=;
        b=YAnoJQHThRucbW61ua/u6xNobwvjSMsDBhWmagFZ+jbbrBjAwyHJJyB9yeBIr+6Zy/
         ovycT5eSDOxv1lYHVmEGovIeFd7IOJFrk7sEGwNL9eQXPQAHd7IXayXmzOpmFR/tDDzV
         192WwYusYzo/demCP5XvZzv+K+L4jFJ3cNbzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mz4Rd8XWjT7uEpyICKIeRorRz31JPqdwkS3WoVtgZ1E=;
        b=0W2IbYgeUQ1HlREjU+epSQA6bvHVdjPd/Z+EDqoIfX+jZ9uwjr7anZUNj/Q5FnBYaW
         wnKZR3462YAKc5XC1Cq41jcA8DaKBhl++XeVmzPVs2u9pSaVh3d52pSKApN9o6jRwglz
         fC2rl8Kbwm5sKxH8MM21DDJZzjdtL+XVe16Co4F6Uuk34PcTrdyDPYPPjgDg/9WUIvfw
         PGUaP6nzX9VW3/RqIdSGVj6VQwi/d2i0baY4NXZHgiDOAGGVqzvn8y8QhZ17X0jMBNbA
         jkni17pu9Mdn4Q8FvRMsB8xqmwvNnl8t/xhlaGzAp87+4t398c3txyCOzpMy05fz7dh8
         +DQg==
X-Gm-Message-State: ACrzQf2Hs7pX7WcgsobJfkWQrECERET9eYigo7wLsx3cEngUL6gzle5L
        VASLWM1rEdPZeKVfRzGnDRyFZQ==
X-Google-Smtp-Source: AMsMyM6eKPkiP7tFNEPog0WIlIXL+zDxpnUgG9qnl3Zw/qL9B1ZDflmlKJ96AswT2LjX30R8TtwzBg==
X-Received: by 2002:a17:90b:3ec2:b0:202:b123:29cc with SMTP id rm2-20020a17090b3ec200b00202b12329ccmr25574626pjb.167.1663997671985;
        Fri, 23 Sep 2022 22:34:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21-20020aa79515000000b00537e40747adsm7346146pfp.36.2022.09.23.22.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 22:34:31 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:34:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: hptiop: Replace one-element array with
 flexible-array member in struct hpt_iop_request_ioctl_command
Message-ID: <202209232233.0C4FB343@keescook>
References: <YyyUvuId7dAZadej@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyyUvuId7dAZadej@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 22, 2022 at 12:00:46PM -0500, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct hpt_iop_request_ioctl_command.

I see no binary differences with the patch, so that's good! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
