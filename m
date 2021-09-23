Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A1C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 21:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B14660F12
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 21:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbhIWVbP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbhIWVbM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Sep 2021 17:31:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA527C061756
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 14:29:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w14so6936208pfu.2
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akDNRAsaTK+uQtKFIh1ydvOrMyhhLnx/OM5ln2Z5MNk=;
        b=G2zaNqchvtAWfw4Jj4sXEQH3Rxruj59sBcBHK26bUenW3LAHOm12rDMlvkvu/2+FcZ
         G6xVVmrEGQskoPPkhckLcf3G2+8mL1TXBchadNnRGz8TN0Fj7xOrO4aOP7b78n4g+Naf
         Hda0lx7r1brORiS5MkWU4K2OKdGe1Z5QABtAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akDNRAsaTK+uQtKFIh1ydvOrMyhhLnx/OM5ln2Z5MNk=;
        b=yzN7zyfChA9AAF6z2Jq0VKaGt3FZA2Uo9miaXsGEGTt47smCwP1oZaLp5NHSpQ1WXX
         A0xz5PVbjDF4Cj4xMAmpzOV4e4ErJ7h5GB58T2yK2zFhEnV7Q06R8WfDBfLVCHoHq7FZ
         6wZYgqeiEU/Eej4k5t5lkLYSY1RCcTgXivh4kYNEA+UnPRp9tR0BLXP1NavpfhoUU71D
         P/AzciAeXgmJLJTGk86iylpJ1ppCBWs46GbG7unl7pUf5pZqgF622Ud7/HdQrUQIqiRv
         kvklbPo0qgs65cmTPwusI+JmffLUxGjFEPZe7kcvJ0UR+eqz4M1txatU4iLR0jzdrdmO
         SYHg==
X-Gm-Message-State: AOAM532GgA2kkO2H7ZuNwSsXNM4lvZYP8h1I7C1WI5JNmDpW/CCko4ZU
        UzJZZ+uGpuT9rtnuM/MdGkUXnEzGUEs42g==
X-Google-Smtp-Source: ABdhPJxmeWGw+d3e+reNftFm9QVIN4uPJYjxAGxk/3gd+aiz8C78IF30myFtnICwLuQ1yF0ekbVCbw==
X-Received: by 2002:aa7:9e0f:0:b0:445:636b:3305 with SMTP id y15-20020aa79e0f000000b00445636b3305mr6442000pfq.38.1632432580235;
        Thu, 23 Sep 2021 14:29:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a4sm6422046pjd.48.2021.09.23.14.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:29:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ross Burton <ross.burton@arm.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
Date:   Thu, 23 Sep 2021 14:28:49 -0700
Message-Id: <163243252379.3933826.2645114887075876479.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210923152811.406516-1-ross.burton@arm.com>
References: <20210923152811.406516-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 23 Sep 2021 16:28:11 +0100, Ross Burton wrote:
> The GCC plugins are built using HOSTCC, but the path to the GCC plugins
> headers is obtained using CC.  This can lead to interesting failures if
> the host compiler and cross compiler are different versions, and the
> host compiler uses the cross headers.

(I changed this from HOSTCC to HOSTCXX to match the other invocations.)

Applied to for-next/gcc-plugins, thanks!

[1/1] scripts/gcc-plugins: consistently use HOSTCC
      https://git.kernel.org/kees/c/ef5ecb129791

-- 
Kees Cook

