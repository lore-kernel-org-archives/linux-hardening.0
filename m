Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09DCC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Jan 2022 23:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiATXZL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 20 Jan 2022 18:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbiATXZL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 20 Jan 2022 18:25:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF10C061574
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:25:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so3313120pjt.5
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w1nPkHfyHQXG/nOSFtwlyaLbq3roA1X2sdssHC0elvQ=;
        b=Ix1/w5PwSZaxEnTOSnN8lFHz5BzHNISbYg3o4X/5FfrjAJcYg+Z9AxP1i88D+Iuk2k
         5844byKA5qT/8MjQMo4NTzAahB22GacfkglUSK48eaBjOrMoBg3nLtQn58IL90xpHhst
         OCWKTBx7wJWqWCVt3G3dmJQvfaE4vquRE2J8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w1nPkHfyHQXG/nOSFtwlyaLbq3roA1X2sdssHC0elvQ=;
        b=HoC31aCTIW9F3a+xmmLmts1LGcjbEMGlPpbwZiXGN7KXQdw4JgmxUmxrqRbDE5zzXV
         Ikdg3hxZVLBTAQRwe6tOxmAL04MJsIJ2ZkDMdtXJD5LnxVuQVczuyK09yJBxaVUWlOZS
         WnxlzHJchLWdt2vx2nmhm05QBTlDkPyRT9xcAk6IgYqtPM5gx179XGxSa7jCrWsubhVQ
         rnKgfKgjJXDHkg+6iaYdtk9qrVballbtc9eTjIMoRy+O6QuOlJ5bbjDvTNfKlZ4JvhVG
         atSvE2KewoCBMyB0ojkdIU6j7Hx6m6cxOseHfl3QaREYQb6rGGKPNTKz4U5ox9Vr3sXS
         boPg==
X-Gm-Message-State: AOAM530eXqBdDF7fWh3hhjxIFZikDTiLGdvwiBsxDEnIKNPajmME6esK
        y1d2lXt+SKZuNutf748g+aDrH8b004UpWg==
X-Google-Smtp-Source: ABdhPJxAAzugtPgJMISLYKCZZSbFl8rfDNRHbrnPqXYh5u376l6iBymNZh4HKNGrGrUjYUMc8uDABg==
X-Received: by 2002:a17:902:d502:b0:14a:6d74:7fed with SMTP id b2-20020a170902d50200b0014a6d747fedmr1050546plg.23.1642721110386;
        Thu, 20 Jan 2022 15:25:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm4218174pfm.119.2022.01.20.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:25:10 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:25:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] usb: host: fotg210: Use struct_size() helper in
 kzalloc()
Message-ID: <202201201524.F8A4377@keescook>
References: <20220120222043.GA33559@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120222043.GA33559@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 20, 2022 at 04:20:43PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/usb/host/fotg210-hcd.c:4017:20: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Good-bye more open-coded calculations. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
