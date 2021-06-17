Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7147BC2B9F4
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 19:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589E1610CD
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhFQTcU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Jun 2021 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhFQTcT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Jun 2021 15:32:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99FC061767
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jun 2021 12:30:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e1so3460521plh.8
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jun 2021 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hrorq9wqViQmhGOFFkZLIlBQLP9XRCmNAgszGBG5cNM=;
        b=UjhBFmj53egtMyJ00ZkClVrgAfvnWzTHeO08/1NVtWDVFp8yUJq6gbvTejf1cL8coa
         ObV+c50VD3mJAHyHt3uHFnS5r9Zpd7tJaP8Te3HYKJ3f9URNkPVzJ2Uq6wIJFO3kCGKR
         m4ob7/oHFin0TmKke8zNIXawcadc37nU0tdnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hrorq9wqViQmhGOFFkZLIlBQLP9XRCmNAgszGBG5cNM=;
        b=tQ5O8fxQ1+VxUHUoMFoxuSp/aY1ji4ekV44gQuvLe/3LirhKXuNJwtSvlmQGIip3om
         L7GCYp3dxNtMWKgEEHhOc2RM+ke7au0hS8Fe/a+UCztedBljJIM8kprIXUU6m2YEz0Wq
         GcA1JZ2/xhcsGqqKKjMEHerWCYUnNSjyVtG3pMQjGVcFIQGR2AVwNJWnLcnyITWlDB0q
         jXU77T42zCYChwnOV9Zo1g18GM3Ukdt2dDw1ApwDTlMX1dJ9H55/wMzetkIocyFLa+p3
         aEINy3O8coulfX49tZZZuj3tFN4AxICorKKN+i3ChIxDSyLt6GyFOdAWUnonXTc53FpI
         KpQg==
X-Gm-Message-State: AOAM531AB25Mh3EsKWWgw748XDgMJN3td2Hz2jKE0xMORAzTC0oJg/e0
        SKE3L0MXgjwWxjersPsfdpsV4YXZMPcaWw==
X-Google-Smtp-Source: ABdhPJwtWc5aurHGuviL31BSdk7TdiEElg8wfkdeWP/DnCBN+SPkw5EaYw3o2oW7ePgTHEHPnG8XEg==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr17428279pjp.96.1623958209933;
        Thu, 17 Jun 2021 12:30:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm6112590pfc.133.2021.06.17.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:30:09 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:30:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     netdev@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mac80211: Recast pointer for trailing memcpy()
Message-ID: <202106171229.824139CA76@keescook>
References: <20210617042709.2170111-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617042709.2170111-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 16, 2021 at 09:27:09PM -0700, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring array fields.
> 
> Give memcpy() a specific source pointer type so it can correctly
> calculate the bounds of the copy.

Hmpf, please ignore this patch; sorry for the noise. This fix got
mis-tested on my end and does not solve the problem I was trying to solve.
I will return with a v2. :)

-- 
Kees Cook
