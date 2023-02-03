Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A908C05027
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 17:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBCRyR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjBCRyJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:09 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D148635
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 09:54:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z3so4267450pfb.2
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 09:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LLnqCYAl80KX/AnP1MJvwNbR1JOT9Aa+XpKrlSinwlU=;
        b=gFMT+46x88hehfxt5nx2SHbG2j17btymqYVEISu7Bm/njCyE3UWdBByqE0ygnOpqbq
         RyXlYuL4F5rbEaCNn+aV31qhLuDPXngVVgCbE1BKV6mZgSIgQh9L8CMbZwo8khDT5YyX
         x/M7eOzHzP5TXUSTLQ1ZMWBgXCRirXQmAIqoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLnqCYAl80KX/AnP1MJvwNbR1JOT9Aa+XpKrlSinwlU=;
        b=1qnCFuzG+19R6I/IPWKp91Z1RU0eZ9SCBI8Vb3D0HNwjyPgtqsUgNAn7ZJ1Wz7+sgC
         mCYZPoVlmHFy9Um5sTY5yRfLNu+KoaVK4V6Qt2J3+jRDjfUyZ5mjknJkoB51acBdu63s
         Xb9NpOrhXOGAZHxca2nPbRcdvvkJguZPuB2hcl6qbEgKZtaTHUwmw8V1IS+94oH1Y2ra
         crxR7/fg71mHA7RIUkhTlDMGmNCJ32Dwo9TMVvv1BRcNF5Kg3eDxgoB0/m+wPyJzBWiz
         +EmjESWkc6zdsQkyQEWJ1MEgTpWL2S92CcMo5XuSWJxYGP0hLZ0jbs9BIBGVqiTpcjLj
         20NQ==
X-Gm-Message-State: AO0yUKW8H5m3DZENuVoQMunANNEUp9EccOfQPRQ4PbLKEyddfCJkTzOH
        VRBVC2LaFf4KAuJjabBjGKp/+cneHTTUe7l9
X-Google-Smtp-Source: AK7set9g3wK6cBF7u1oZ+DgClsdvFB5iS6W2QtUSeUf14md3Qq7pBO/9xIF/z0HeTuuWMIvw3W6qcQ==
X-Received: by 2002:a05:6a00:22cc:b0:58d:f20b:5f2e with SMTP id f12-20020a056a0022cc00b0058df20b5f2emr14077223pfj.1.1675446847523;
        Fri, 03 Feb 2023 09:54:07 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p21-20020a056a000a1500b00593d7db7f29sm2068958pfh.216.2023.02.03.09.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:54:07 -0800 (PST)
Message-ID: <63dd4a3f.050a0220.fd05.3c7a@mx.google.com>
X-Google-Original-Message-ID: <202302031754.@keescook>
Date:   Fri, 3 Feb 2023 17:54:06 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/vmwgfx: Replace one-element array with
 flexible-array member
References: <Y9xi7nFWRV3S9gCg@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xi7nFWRV3S9gCg@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 02, 2023 at 07:27:10PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct vmw_view.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/254
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
