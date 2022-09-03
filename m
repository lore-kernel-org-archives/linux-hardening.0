Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BEBC38145
	for <linux-hardening@archiver.kernel.org>; Sat,  3 Sep 2022 05:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiICFKh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiICFKg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 3 Sep 2022 01:10:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8D48C8A
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 22:10:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h188so3605478pgc.12
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 22:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yIQQnIRHZ7otgrjUvv6TWdYO7TYHo6foOISWsC2sgP4=;
        b=XgqmCKVxNvdUZqdAM2u2tJkOYfE9IK6qUtsHyIhkGWN1wL9Qe0KOuOAqCe0oMdd2+J
         b0IKH8R/vapBrkcOri0ASjwCPCCl5PNKwjRVqIZ4/8dmNT9IIn+IddY17Mui9T0q0ZgZ
         ITEs0fw1BVpr0RADUrPO5GBSYv2MSm0AmJmt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yIQQnIRHZ7otgrjUvv6TWdYO7TYHo6foOISWsC2sgP4=;
        b=nJsMLBrgj7+LoVBTKBpnrzbU+QIrZrKH5hwBJVvRcFICJn5mUDL/yK+A1Wkjyq9Unr
         CmbVOmh3A0kiOfn2UMMF8WWZWLLW7wX3TzpZViflx56L6LFu9n6qajBeloGox4GuCycy
         KGzCK/Vcv64A4XkAm6qKD1akwKlYWpWpE3gSrHWpxIh0deoT/OqafDstqvbq2nEWdqgO
         KYO/UAh8ShqNNdCfkYi7R+/l9ttb7vKmFb5Oxurmy/C1mAw/zwtIdoZc3RIl5gkHZd4j
         X8k/aH5WrcrO8ZnoSx1GqsHZa8Q+j4dhSPVT8cxityyWXMWsbCMel9/yZ7bcApQWzY9W
         rkiA==
X-Gm-Message-State: ACgBeo1Nb8vj/rtY8TZyyQ0gxElLLe+rMuxazzl7bUwr1c6N1mBshxNC
        D9Wri9l2G8VW2mJt4rcK0CSBUg==
X-Google-Smtp-Source: AA6agR7g7BhQHjXWzii+ZGapa9J0ng7mZjMVRAhkXB39C4MnXU9spkFPJQKx2ogag/9LSabHZdOpcQ==
X-Received: by 2002:a63:5962:0:b0:430:41b4:ad2b with SMTP id j34-20020a635962000000b0043041b4ad2bmr12827552pgm.216.1662181832981;
        Fri, 02 Sep 2022 22:10:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b00172b42c1a02sm2615553ple.83.2022.09.02.22.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:10:32 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:10:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mm/memremap: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209022210.37E37186@keescook>
References: <YxKO/jY1x0xTpl4r@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxKO/jY1x0xTpl4r@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 03, 2022 at 12:17:18AM +0100, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declaration in struct dev_pagemap with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Also, this addresses multiple warnings reported when building
> with Clang-15 and -Wzero-length-array.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
