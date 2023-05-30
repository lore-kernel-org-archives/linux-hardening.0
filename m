Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D2BC7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 30 May 2023 23:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjE3XR1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 May 2023 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjE3XR0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 May 2023 19:17:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3810E
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b01dac1a82so28670155ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 May 2023 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685488643; x=1688080643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=On+FQfGbR+8Ii8Eys7nptg115kLyMdrhpZBqAuKx0+A=;
        b=GKpRmVNc9L0TDMOju0I9bvnRlrNJw43AMPsnzVHZeEP1yyQVupwi+w0ysa9vUvyG6/
         wcig/og16wFMUHJjuRIvwyV+SCZK4yqf0UO0xpsIxJtMBpSQynjTHvJNeVrJq+9ElFg/
         +BdB0zomT3Uypxw6HssDmild0/uud4HJtR5zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685488643; x=1688080643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On+FQfGbR+8Ii8Eys7nptg115kLyMdrhpZBqAuKx0+A=;
        b=HUn7AwygPJH8N5WYm8yjmd35NeIIKYrxh9OVRMo3FGL56QOgUQC/5G5NG0MBZCA0MA
         FHXVFBRHje0Xn+EssICpO+EmQdJ3cZjX2RSwm3tvXsp99S6GKJns5C+1VDjDDel/DVDR
         WEYx+p5Nrei99gkrzUAneiZO57jf9wGpS9awPEmcTSGRSFWeBcOY/xFhbd094DQJmMwV
         mioB/t4Cz01AIRyin2axK7vaOJyHMGdNDN4H47ROOzBCBwajj3R6y83sLzwwasDW5Cw/
         rnrCopBtomJUCNOjFNVdg1qGfPWnaRzvozFon2bAm75vW//bnu/1iidbzhCZ/G2ZH7Yd
         dXFw==
X-Gm-Message-State: AC+VfDxShvNj1jAwiBE3/8VcBKUxod2F0/AzqNBlm591fljd5exOXSni
        SnxjlY1EmHsHAYZTaP3IcihYUw==
X-Google-Smtp-Source: ACHHUZ7ko2RUUKseYSndQOTaEGaqJHscWF8CwX3Qf9+d+6/JHqGs0Dfy+X614hMfGmWpEyOaxb/iZA==
X-Received: by 2002:a17:903:32d1:b0:1ac:7260:80a7 with SMTP id i17-20020a17090332d100b001ac726080a7mr4793068plr.43.1685488643322;
        Tue, 30 May 2023 16:17:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001a9bfd4c5dfsm10741486pll.147.2023.05.30.16.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:17:22 -0700 (PDT)
Date:   Tue, 30 May 2023 16:17:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] ARM: Replace all non-returning strlcpy with strscpy
Message-ID: <202305301617.FD31A8E9B1@keescook>
References: <20230530155501.222213-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530155501.222213-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 03:55:01PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
