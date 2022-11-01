Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3805C4332F
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Nov 2022 22:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiKAWrY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiKAWrX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 18:47:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F91F2E2
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 15:47:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k7so5193826pll.6
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksO/1o1BhIzE4SsfOIUs7zxu3Erb/eLFTep4apIgRAw=;
        b=D20PIvH1BHu5njgDPzCx60DympS69ZgpbmXpXi+nQlXKBq8o17e0F/beS8GRCG5Lao
         R0kW2cV5tSEJTOMwlSLwrtG7lTWZFPWjR5EzEtNtLfeOny32RBuHDoadgl/C8ZMtK8ml
         40VmpnsWC2oUgisaDM/Wv7rrYrP3zekplVk68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksO/1o1BhIzE4SsfOIUs7zxu3Erb/eLFTep4apIgRAw=;
        b=Jdm/rRAWUR5JMC+dseWh6LP7qXfBdzVFmxVopOBMkk8olNEzsEsG4iCUIOccH4gjke
         JCWVVINb3U3q4RJ0Nr+LRCBgy6QrOpfvwoixwsniYe+TEk3Rh34DoJYRRkng5mXTB0AT
         CLs2omxvme1es94bi0rGUbEl5seZXBIQG0CkRbK1BCy7HB6Ss+ERO4y/5N2750Dsm9Ds
         bFzWuDIK3bArqgNc6YhZ30MpxbuWLqWAv6CPIeiCZdB+Wb/IqJFnsGW7GvXER2dLmV9t
         c3zOfiQmMH1Fb/FkqqyakgcGQzpCEXs1+Qn/eGTiJST/6Q8xFT2i37JU4Q+y4bsCxtU9
         kwdg==
X-Gm-Message-State: ACrzQf0rpNuhmD/W46IPun/eTvQCwP34d8WWR4H0a1mTwD2JZ386XhKO
        AkXRRXi4iBvE5Iv63q0/xIqnaA==
X-Google-Smtp-Source: AMsMyM5u3nuWvNn0ECPBs1EaQXXyP85rU7+pHq9IxMRQruYWSIVY8JDFNZv4t+RXdDCYleU33I356w==
X-Received: by 2002:a17:903:289:b0:186:a8a8:e99a with SMTP id j9-20020a170903028900b00186a8a8e99amr21389283plr.104.1667342841715;
        Tue, 01 Nov 2022 15:47:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709026bc800b00177f4ef7970sm6859012plt.11.2022.11.01.15.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:47:21 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:47:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 21/30] mm: Use kstrtobool() instead of strtobool()
Message-ID: <202211011543.20ACBF9@keescook>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 01, 2022 at 10:14:09PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
> 
> The last patch of the serie removes the definition of strtobool().
> 
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/

This seems in keeping with the removal of the simple_*str*() helpers:
https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
