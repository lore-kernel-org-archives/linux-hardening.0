Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49FC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiBPUgm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:36:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiBPUgl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:36:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB5E0DF
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:36:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id m22so3117840pfk.6
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eJd4aXWZIs0H49MCtqJDRq40asV4LB3JVz3vZfyzy20=;
        b=OvLwuaJuN7jjsoupZQzejUUIvEYxeqr4xggnf7tf1QsjL7U4I4Sk1BL6szewkbe2B/
         /0w8twYBe+GunMFYIdW/zex0RHhv6VkWc/yZkGVN+oySOgamBUK5CawVK2MAm7IGrXSn
         r7nae5JYy8waRlLGEPFtqssZEk+ajbIkBAhyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eJd4aXWZIs0H49MCtqJDRq40asV4LB3JVz3vZfyzy20=;
        b=qf/DFrQf1JirbODZimu+uMiA/5zrrhFKAyI6gNCM2iOQ8tOVyfUSGWdKiCJWwHWCqZ
         /5mwL91qKsN+be0ddU0JNKmGELUDf4pi86nkjAQ6SgRT8T+jHj6H5ajrgTSOU9t9Ub//
         uMB6E+SOxLBT5/dkGA/pKX3YABwvEoKS5ddNn0LNacrA+91gwT+Ilsssg8liCaNZoMsk
         5tXcFrD/zwNERGv8LlCEdvZ7ICFPn9fotXQ+cZHuQXrOgLJIQkvKzubE2hWABsbBwQYN
         WMzHaqOCkAJbgGhXmV0UXTW9Go/+vsGFHj/558zOiieLpwSmkwcoBaFl4BCy2AchtNZM
         iVgg==
X-Gm-Message-State: AOAM532mz5ysoSmmlE3s9ScjswQ9hPvJL+asHrP6s1H2AddexcabnMZL
        sdS0w2uYgPxC8LeFQRuKvf696w==
X-Google-Smtp-Source: ABdhPJxsqD2mY2NkmwK/BmEBgmiqpQQgFKtDkVDGkFZkejCndwQ4eKwb8c4Y2tNYoyYnZCkX2Ulaqg==
X-Received: by 2002:a63:490c:0:b0:372:c378:6686 with SMTP id w12-20020a63490c000000b00372c3786686mr3696180pga.295.1645043787861;
        Wed, 16 Feb 2022 12:36:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11sm44576546pfu.50.2022.02.16.12.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:36:27 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ; Johannes Berg <johannes.berg@intel.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;Johannes Berg <johannes.berg@intel.com>
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
Subject: Re: [PATCH] uapi: wireless: Replace zero-length array with
 flexible-array member
Message-ID: <202202161235.C593433C94@keescook>
References: <20220216195306.GA904220@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216195306.GA904220@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 01:53:06PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

This UAPI change should be fine for any compiler that understood the
older "[0]" syntax.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
