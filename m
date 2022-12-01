Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA8C4332F
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiLAXVk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiLAXVj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 18:21:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F4AC8680
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 15:21:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b21so3093937plc.9
        for <linux-hardening@vger.kernel.org>; Thu, 01 Dec 2022 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8fV0JLFD2/Rj3gFozDpPt6akgqe3c/uNAz9i68e/Ns=;
        b=irGAoFAzu0KV2LWJLDt6khSgbUR9v1U0syF34+yTJCoS8bB/v3VBjQ4vn8GiJ/NImP
         SpQH4mGgKrrwElMOUJlTEvfsU+eqlA4zUXh0I2g6U3bmEpiqLQv77Bd0VkzpRdlzoydh
         xw9kHifI4gaIMAmxfe2lEWbQFhfZriZ0KgKRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8fV0JLFD2/Rj3gFozDpPt6akgqe3c/uNAz9i68e/Ns=;
        b=yRuvEQb/9d3fZ4YoBVkl/mwBC/SC5v5t11+zy4+xMQdPvGsSuZFftoEnCbHrIBQx70
         of0jPfxk1809XiGxfbTlhWcwXpn/ohGVJxVbkQLPVTNKRYdCjs3aDTRYzHV/HCmrl8z5
         eDzgQfndejCIM7km4Wje/Gui+tx8Ye8a+bu8ow3t+7e/lkB1DP6f9bCzRAyDBGddX5pJ
         9OTjArVWxRcrSof79Y8Hs1ZOV8gfibSVA3SHXPH0Oa0LUfCB2QJ2RUPPCW/wSkTdgFk+
         llJAONa58O7Ve+3fN57GiTgIKT8ekrHGzI/m9OYtgmjgAt4sqPXp5Dndc/djZw3Pabpq
         efgA==
X-Gm-Message-State: ANoB5pmV7e9jxf2gvd+h8G05aMHrTLB4m3A86kDHgfRw9PW6Y1jNw/eP
        uG/DwF1ELplJUyXhikDInp8qqg==
X-Google-Smtp-Source: AA0mqf7Cx5IGen6d2/oau4vpJ7GD2N1BTLjfZZxHShOWSrBCuScbfeKEMudxRcgY1ZxyX9tKrwPFQg==
X-Received: by 2002:a17:902:e949:b0:189:7a15:1336 with SMTP id b9-20020a170902e94900b001897a151336mr28155708pll.122.1669936898649;
        Thu, 01 Dec 2022 15:21:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056d3b8f530csm3771504pfc.34.2022.12.01.15.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:21:38 -0800 (PST)
Date:   Thu, 1 Dec 2022 15:21:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stefan Bavendiek <stefan.bavendiek@mailbox.org>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Reducing runtime complexity
Message-ID: <202212011520.F7FE481@keescook>
References: <Y4kJ4Hw0DVfy7S37@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4kJ4Hw0DVfy7S37@mailbox.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 01, 2022 at 09:09:04PM +0100, Stefan Bavendiek wrote:
> Some time ago I wrote a thesis about complexity in the Linux kernel and how to reduce it in order to limit the attack surface[1].
> While the results are unlikely to bring news to the audience here, it did indicate some possible ways to avoid exposing optional kernel features when they are not needed.
> The basic idea would be to either build or configure parts of the kernel after or during the installation on a specific host.
> 
> Distributions are commonly shipping the kernel as one large binary that includes support for nearly every hardware driver and optional feature, but the end user will normally use very little of this.
> In comparison, a custom kernel build for a particular device and use case, would be significantly smaller. While the reduced complexity won't be directly linked with reduction in attack surface, from my understanding the difference would make a relevant impact.
> 
> The question I keep wondering about is how feasible this is for general purpose distributions to have the kernel "rebuild" in this way when it is installed on a particular machine.

Much of the functionality is modules, so once a system is booted and
running the expected workloads, one can set the modules_disabled sysctl
and block everything else from being loaded.

-Kees

-- 
Kees Cook
