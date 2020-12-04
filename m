Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21677C4167B
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Dec 2020 23:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000BA22D75
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Dec 2020 23:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgLDXrX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDXrX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Dec 2020 18:47:23 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD3C061A51
        for <linux-hardening@vger.kernel.org>; Fri,  4 Dec 2020 15:46:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w16so4490198pga.9
        for <linux-hardening@vger.kernel.org>; Fri, 04 Dec 2020 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGD/RRlJ9qYcjJKn7WhBQr/iddBUcMbCKVBFUtvDryw=;
        b=W8nYbzW29aK5BI9b3s/HSOzJYye5fofwtRGf/n08NAYFqTAnms5MDGLkVxvQuvia7+
         8lYvKlc7hfU3yjVEqUwwHVXeutiagN4yzJLeVYiNWpjJHD0a/Nl9HfaHBtd3nxPp2lve
         mQVzqhP3egC18W9DwiyAoc7E6BOq0rAXrJ0ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGD/RRlJ9qYcjJKn7WhBQr/iddBUcMbCKVBFUtvDryw=;
        b=tDl4N1/CcoKMwMzMPIp807hGvNUA0EY9+5ieY0yFXbJRvF3gnPYtdtlUJOatX2iW3/
         y4Qjx2AoDKsz01RODWnMoNXYAQDfAqxkTBc0r2/MFk2V6YgUm5MuCt1sZ7i82EQHl3z3
         lk94CLgmD1/vqglmapTxQfEB8+IB5rZ5tjJijxzoYmMRh6Y62aOa8NkgWxUFLBMB2EAR
         egpiskDqhlc/5l8KlYGJDu31+9dMRtzt0BrnxBXjAnhrCl7kCrrxVNPZacVm8d5KjSjO
         lUf/GinZ4Qupix+MI8a+GTgStyYsqFqI1KGIsInZuKEl0UjV5EeTrflYUHdv4VkGqmEz
         mGNw==
X-Gm-Message-State: AOAM530kqiKDaHpHd6nUaPp9iyu18vYRlcj+V1x8Vk0069sKNncW7R3j
        5jNSroe9UoubV8kZmwccfMwCBw==
X-Google-Smtp-Source: ABdhPJxst/88x4vpS1tQ3o1+yZeDoCO32pjKEs+qGoYQW6uKQW2SDAJq6pQ3PklTgGowiEbbpxN2MQ==
X-Received: by 2002:aa7:8090:0:b029:198:39d9:23e6 with SMTP id v16-20020aa780900000b029019839d923e6mr5896075pff.45.1607125602602;
        Fri, 04 Dec 2020 15:46:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm5732915pfu.23.2020.12.04.15.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:46:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kbuild@vger.kernel.org, Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] gcc-plugins: simplify GCC plugin-dev capability test
Date:   Fri,  4 Dec 2020 15:46:29 -0800
Message-Id: <160712557572.2401125.2412248759980660312.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203125700.161354-1-masahiroy@kernel.org>
References: <20201203125700.161354-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 3 Dec 2020 21:57:00 +0900, Masahiro Yamada wrote:
> Linus pointed out a third of the time in the Kconfig parse stage comes
> from the single invocation of cc1plus in scripts/gcc-plugin.sh [1],
> and directly testing plugin-version.h for existence cuts down the
> overhead a lot. [2]
> 
> This commit takes one step further to kill the build test entirely.
> 
> [...]

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: simplify GCC plugin-dev capability test
      https://git.kernel.org/kees/c/1e860048c53e

-- 
Kees Cook

