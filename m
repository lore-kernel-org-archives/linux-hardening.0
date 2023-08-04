Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04451C41513
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Aug 2023 08:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjHDINf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Aug 2023 04:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjHDINd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Aug 2023 04:13:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AF4684
        for <linux-hardening@vger.kernel.org>; Fri,  4 Aug 2023 01:13:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8b4749013so15525185ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 04 Aug 2023 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691136810; x=1691741610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VL7MGYaWLHKrafJNpDNrQV+kq/3HdTXOCqcOC2etLW4=;
        b=CJLYGjD0bhLHh1OXkkRsreZPkeVsxE7+g11O/hc8izookwuSJgZi9I/8JSNHysqXmK
         9eIDgpbjmiXH+IZ9+bUuoPUZagmJcvLEUULJN0R5fE/lmyhtXs8CDzi3T152BXMjoxcN
         7kaoXRTCpVWYZnWuspUM74X52V0EsOSSPhB/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136810; x=1691741610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL7MGYaWLHKrafJNpDNrQV+kq/3HdTXOCqcOC2etLW4=;
        b=MmvMz86Taassrvnu6y2a5BwJpNk+TzjltQrWlnVrAAMtysYu3sbThlTKtzDAJ9vv4r
         3qyVowu17BLwsqbQPsAnFfyqIUzPRR651ZKCeadU2eElXh5ntAruLTdMEBcfQVqctNNA
         vdg7hMjR05WnFOfnCXj4R2DjA4rMO+ZVBNr29NLaPVfrIV8Lwy5ecw3vm1FFGG3+zH+5
         4SG198pFN6gZCAGssiLgy4M/kGlnQdt1Cc9wLDa18IGb+MYbzU79yxbnNPNqs2zUbbbp
         Ak93EBbQ8DbsgrdnCKjqpeWJfvYo1VJiKY/Kb4j5tehLw/4i/FPYHMzK2dbdHiS2sEpj
         aEOg==
X-Gm-Message-State: AOJu0YyKq0GAW5j5sB+BpKUH6+5gcVNcEe8lnIkqr4O8ca6tcqzJVpcK
        VmT1PJZjVrL1XuYeHY+P9LVZqQ==
X-Google-Smtp-Source: AGHT+IE83P9NE4z3R7foSEJsWYLcP/0QXiKnenMC8MJ7cfoR2ZxY4Mv/zhfiFYz+DdY0Sn/WVJ3P5g==
X-Received: by 2002:a17:902:bb82:b0:1bc:4030:1fb6 with SMTP id m2-20020a170902bb8200b001bc40301fb6mr1099637pls.21.1691136810155;
        Fri, 04 Aug 2023 01:13:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001bc445e249asm1128036plb.124.2023.08.04.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:13:29 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:13:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        yj.chiang@mediatek.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 04/10] ARM: syscall: always store
 thread_info->abi_syscall
Message-ID: <202308040113.5A35E32B4B@keescook>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-5-arnd@kernel.org>
 <202308031551.034F346@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308031551.034F346@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 03, 2023 at 04:17:24PM -0700, Kees Cook wrote:
> Anyway, I'll keep debugging this, but figured I'd mention it in case
> anyone else had been seeing issues in here.

Okay, I think I have a working patch now. Sent here:
https://lore.kernel.org/lkml/20230804071045.never.134-kees@kernel.org/

-- 
Kees Cook
