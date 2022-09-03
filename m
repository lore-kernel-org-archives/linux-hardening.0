Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5957ECAAD4
	for <linux-hardening@archiver.kernel.org>; Sat,  3 Sep 2022 05:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiICFKI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiICFKH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 3 Sep 2022 01:10:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFBF2A957
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 22:10:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z187so3744062pfb.12
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aOcDSKXlp0EJ6t3kZwqTuaD2pTzkFcj1dQ5Ha/6SqwE=;
        b=i3ztzSid1AsHGEQ246ZoUt18dJ2RfGY6Su/dIYUVyB3Zvl2oeioAtwvdwtZMszaMev
         Pwjx+rKu5ojbHnkpdEKrMW8T3Ukcf+6YOTriKmJsz1/nLHBSzSYOViUnsURhU2kmekB2
         zmhmYrgwLYhHDRIi3IQYfiZbEMW5Wbs/9pm7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aOcDSKXlp0EJ6t3kZwqTuaD2pTzkFcj1dQ5Ha/6SqwE=;
        b=xKdoB9yB0A0KHEyUhNUszKTCD0pSEeD2aQ7KBkyb6AJiGHbynNHDUlyglpGB2qMBnE
         ptIorKjnCW/0Mq7YTJqoEJGZK3+FJt9T3DW0TsfK2EpLYsGr8RgCVyuOjz4u3NPB3rLi
         v5x82j6kzOSvZpEfhmYJ/I549fVfyl+vAiYCmuurWFGTf2oWyjC2UmWb3CqovxfKUDZO
         ZDy3/2TU+3I/5BvXpJD/x0P1wpAE3nbWNlgA920mU+PObeGQ4+hl2LmcWvqJLIIoMfHe
         aZvCC46ekCGp7Q4fEDw6Z5stNdhPyBafbKpPS7uht/wpTrPCCGZ7COynqwA7uX7ae71r
         ojpw==
X-Gm-Message-State: ACgBeo0q3pYnOtxQKq3lZaFZ0GRDfchspSRnINMzbgFaEEwOY8Z2wXCT
        WvY9+1DFCC84ptFppbZXFDMRhA==
X-Google-Smtp-Source: AA6agR7hj5LdKaxooA4zyBk6NlsbsPsKSPfupmfzoKtd0brgGX3zgS/v9zqJPwxZxtXjN6+Xu5J67A==
X-Received: by 2002:a65:44c1:0:b0:428:ab8f:62dd with SMTP id g1-20020a6544c1000000b00428ab8f62ddmr33545276pgs.211.1662181803523;
        Fri, 02 Sep 2022 22:10:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090301c200b0017545ee859esm2610168plh.8.2022.09.02.22.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:10:02 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:10:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH][next] exportfs: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209022209.ABAD4C8899@keescook>
References: <YxKNA/3add4wxI3R@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxKNA/3add4wxI3R@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Sep 03, 2022 at 12:08:51AM +0100, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members instead. So, replace zero-length array
> declaration in struct fid with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/197
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
