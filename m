Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEBDC77B7A
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFASZu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjFASZs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 14:25:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4FE7
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 11:25:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso836959b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685643946; x=1688235946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOWrCIIhxQP/v9l3qMkwCSylYdgGBfEpugzVcIgxuXE=;
        b=nuA+3VumfoEo4JKEcQjfZ794l0EgspWV4ZFLh4TQbrXPOesyWBWh5jpk4BCx7GwHHy
         ItoQ5+a/PTklHO+8cKT/U3aXtDQmOEVIbAeIaKI2ju3OTbL/E+G0AZ3e6UQz1cr2u8Nj
         PEhLnevX0o1rauHum1SjTTkN/gqBaTagicX7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643946; x=1688235946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOWrCIIhxQP/v9l3qMkwCSylYdgGBfEpugzVcIgxuXE=;
        b=brmZsogTiSPbexPEhXHUu0CAIByLZJvIpJfXHHFslUmMYF7emCXFlCkqmbAPETeaNd
         cjV/4K4J9ahVuGz53AOyrfMYyN9wmNneSw4F+L2KBVPTPR8WYTRF/5ZiNiLHWxuUuHIe
         Fv/RKVq4F2RYij5cfzZZAt3MGA2SYHbP6haX6G+W8yLSMWgG/NqGXpz/j+LP0ORPgG1x
         5XtlvvrDrcTKvxfDQAkHCrzOJU2yjfA4wzhBNUaGE4CVvftk7mPwL+rxtLCLvCuRK110
         6xkcfsHj+XYWNRs2C1zA694nVmqqnPrQOGvFhVB0mE173gQBpXajeyG7aplEvyaYHqlf
         UxKQ==
X-Gm-Message-State: AC+VfDwG1yeyE0XTRU0l8Zg8ebPVt2WbOBEGyqChoSoE7OaAAEX1iE5N
        jWlTX+Sq261p/XGMksAdi3r1VFMLBpZqPi0xM1w=
X-Google-Smtp-Source: ACHHUZ4ZFmMIHRDESy+YKkGQgetI7n6zLXjasm9QSIkdWizL2x1K2PXwhw0KfBdZrVZEzqtVDlVnLw==
X-Received: by 2002:a05:6a20:8f02:b0:10c:6dbc:2806 with SMTP id b2-20020a056a208f0200b0010c6dbc2806mr13586689pzk.46.1685643946705;
        Thu, 01 Jun 2023 11:25:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b0062d859a33d1sm5362906pfn.84.2023.06.01.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:25:46 -0700 (PDT)
Date:   Thu, 1 Jun 2023 11:25:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     azeemshaikh38@gmail.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202306011125.D66A54586E@keescook>
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
 <168548796310.1350188.6990158151809298087.b4-ty@chromium.org>
 <5d9cf207-7984-6dd0-731f-e301aa7b25c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9cf207-7984-6dd0-731f-e301aa7b25c2@linaro.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 01, 2023 at 07:03:41PM +0200, Krzysztof Kozlowski wrote:
> On 31/05/2023 01:06, Kees Cook wrote:
> > On Tue, 23 May 2023 02:20:23 +0000, Azeem Shaikh wrote:
> >> strlcpy() reads the entire source buffer first.
> >> This read may exceed the destination size limit.
> >> This is both inefficient and can lead to linear read
> >> overflows if a source string is not NUL-terminated [1].
> >> In an effort to remove strlcpy() completely [2], replace
> >> strlcpy() here with strscpy().
> >> No return values were used, so direct replacement is safe.
> >>
> >> [...]
> > 
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
> >       https://git.kernel.org/kees/c/4e4424b20cc4
> 
> Please drop. This was already fixed and is in linux-next since almost a
> month:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git/commit/?h=for-next&id=5dfd3c73ff81618fee0ef682b6fd7779863f41e4

Thanks! Dropped.

-- 
Kees Cook
