Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C5ECD379F
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjIOTm3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbjIOTmU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:42:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A9019A9
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:42:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2356263b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806935; x=1695411735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFE1F3+kydQTQojTUb7prmfEOCJq3WLONO+sPWEJMCo=;
        b=h38ZcxOqWwCMHk2cL65uE60F0C0YUQdFXGSjn5YM4z/sbkkqRAKpN7N8C0XpegO6cw
         c2UagfzmMXtWz3MuMZ9O3TEYaEWJfvjaI6qniL9tuqrfhXZampXd7WTX72bjb4h1LLPI
         1u4LWhkpW4LmoBf7pprnlw6+1Zq1wWhGXTfeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806935; x=1695411735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFE1F3+kydQTQojTUb7prmfEOCJq3WLONO+sPWEJMCo=;
        b=GZyO2f2mUD7kVdaeDNi7X27j0Krd8YFt3zz57j6NWgrjVeo6wuJhCjhdnIcy5wtC6u
         /cJyb7ss86+AZ5rbCcV1b5Nid/3Ke483d7MnLiZvbi4KNPzEaYdkRFvBu9o5F/ws5o55
         y3CuHoPpuZZq1Dr7Rp0k2RhuY+F0aeznAklJe1M+g9dn5JN3xl6KbvDJ52+fmPB9PwZi
         tfy+XYzmxYUMSZG1bu9i7JB5thJ1WRyFw0/f+iGf/d9ohEK8yOcIeShS/34BwAGyx/LM
         XjkGko8g7muNkJnFNxBmwJKr4Heop1ChaGB7kdMuXqRV3fclPHrUnKjEX6jkMNcqq1Y7
         DGhQ==
X-Gm-Message-State: AOJu0Yw6+bysBvcSjDwPtm3uZxtrWcZ8Sd6pjxbt/ISpy78OaqZN0xp8
        EAdQJnY04x8kwr1369ygzp5z8A==
X-Google-Smtp-Source: AGHT+IGpdxeoMFg927wqPjDXncgi6Ri3SO4sv6EPXygbD0EnqTl0JEaVe8KWeIG5/O1y9sFbXRwVKA==
X-Received: by 2002:a05:6a21:7189:b0:153:39d9:56fe with SMTP id wq9-20020a056a21718900b0015339d956femr2593392pzb.47.1694806934963;
        Fri, 15 Sep 2023 12:42:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b0068fba0f5f32sm3417615pfa.90.2023.09.15.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:42:14 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:42:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] mlxsw: Use size_mul() in call to struct_size()
Message-ID: <202309151242.E732735FA@keescook>
References: <ZQSqA80YyLQsnd1L@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSqA80YyLQsnd1L@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 01:01:23PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound, the
> protection that `struct_size()` adds against potential integer overflows
> is defeated. Fix this by hardening call to `struct_size()` with `size_mul()`.
> 
> Fixes: 2285ec872d9d ("mlxsw: spectrum_acl_bloom_filter: use struct_size() in kzalloc()")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
