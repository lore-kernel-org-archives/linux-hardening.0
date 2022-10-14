Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDFC4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Oct 2022 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJNRld (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 Oct 2022 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJNRl3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 Oct 2022 13:41:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02E1D2B75
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 10:41:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o21so2985236ple.5
        for <linux-hardening@vger.kernel.org>; Fri, 14 Oct 2022 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeL1nS8vd13W1beG9Y8nl+BAYPvf19LEhLug4v6bWi4=;
        b=SNm3j8u41fb+3dP9Ar8IxfGNRtifKe9pEmJVQtHSN7nWwcRPJmPpzKIdZNA6UpEZRA
         OivXuR+azXhWrnVLlBR32VLP8k2Ciew6ItIY4vnwbW5feed873r6MIHSWUkxJYMm67ea
         Upilyz5pWrND4gd+QuXUCLTptKU0vXEQAqG7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeL1nS8vd13W1beG9Y8nl+BAYPvf19LEhLug4v6bWi4=;
        b=SSmILzq4ldfNrPI0KnrooHGyZv07xL2VIG33/6psAkreeYoUVS57ILPgXIqoWiMaZW
         XsedPxO5XE3GuSa4tUEgl+LEwq9GIrA67WgBJQq3tOaPQBv91mhMHLm13c/4kb8PKFrf
         SS92nLVa9T3yeCyL8VByGZP8kYk2eCmC5TdaZ2HOvAVWj87rv2oVzdz6FEFQPZNCm7tU
         vSu4X1WI6d1ipoGym9TvPjozewx9tzwv0gIFQGWbWlHQoxFligIVOZsyjAjPOvFeXi12
         wSfUPQBwEQ3LssallhW7OUUloyVbNeqSkeG6LVkBkKjvBuW9X7Y2zmRLt9C4MNXPLFl0
         /6WA==
X-Gm-Message-State: ACrzQf1rZR1ZVrVksvz6+ANXb6AYrXuiaX6HarguNFxZu9x1ViIheyGX
        qceHUl99AuRnE7WuGKq2tZBlaQ==
X-Google-Smtp-Source: AMsMyM50b/KKDY+/bGbIoTGRY9NKmHEI+Wx5+Jp3Wpd0Yd+UEA04lNAdA1wCZgoJCXH5vrbYXlwudw==
X-Received: by 2002:a17:90b:17c7:b0:20b:7cb:9397 with SMTP id me7-20020a17090b17c700b0020b07cb9397mr13134377pjb.191.1665769280757;
        Fri, 14 Oct 2022 10:41:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nk7-20020a17090b194700b002086ac07041sm1731834pjb.44.2022.10.14.10.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:41:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     gpiccoli@igalia.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, ardb@kernel.org,
        linux-efi@vger.kernel.org, anton@enomsg.org,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        ccross@android.com, kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: (subset) [PATCH V2 1/3] pstore: Alert on backend write error
Date:   Fri, 14 Oct 2022 10:41:06 -0700
Message-Id: <166576925933.1456464.14312248515298828648.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013210648.137452-2-gpiccoli@igalia.com>
References: <20221013210648.137452-1-gpiccoli@igalia.com> <20221013210648.137452-2-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 13 Oct 2022 18:06:46 -0300, Guilherme G. Piccoli wrote:
> The pstore dump function doesn't alert at all on errors - despite
> pstore is usually a last resource and if it fails users won't be
> able to read the kernel log, this is not the case for server users
> with serial access, for example.
> 
> So, let's at least attempt to inform such advanced users on the first
> backend writing error detected during the kmsg dump - this is also
> very useful for pstore debugging purposes.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/3] pstore: Alert on backend write error
      https://git.kernel.org/kees/c/f181c1af1385

-- 
Kees Cook

