Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CD9C433E6
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Jan 2021 23:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C846123142
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Jan 2021 23:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAFXK6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbhAFXK5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Jan 2021 18:10:57 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4ECC061786
        for <linux-hardening@vger.kernel.org>; Wed,  6 Jan 2021 15:10:17 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 30so3292070pgr.6
        for <linux-hardening@vger.kernel.org>; Wed, 06 Jan 2021 15:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axakR3V8Px/scAgH93voC/mtIO5dG1PShrCOBx0oSuQ=;
        b=csHjke2t8Ll0E6OubejG57TgVe6VHXNFpLMhiBdQRRCutar+xa87WJc5VHGZMcT1j2
         fJ7I6HDt6nYZRqBjwBfNp7OhvBj6P65MhLHnhFYk/Bdzi+OttQAl1K+Krw4eE6EHXKhf
         JP9rvM3eh3NcxiiWj6GrEqbrziuWNlVcED89c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axakR3V8Px/scAgH93voC/mtIO5dG1PShrCOBx0oSuQ=;
        b=aO13VMfJPDQmYOKjB6KTYQ9qUltkMM3lpUog5QVlFse5WX/JYZDgVdiCLxRZg2txWb
         W8DQy5rUkCpESU6p/d8MIU8Vlo5NcuhWS98aj9NsyzIkOKZwxAkEcdIu2XKhTRuLGEjh
         pbvtHkNu9GOgsrcwaAVOACdhaBSJKQ8QVR92nm5ce9Vi8Ua9TsIEQwIQgh8k3kE7hj0t
         0vCg1Tz5jm8JQaKUtNMAabf8FnllRnLJf9LVVFTEfSLHWY0DdMny7fMjGPIZIpaJqFhK
         ugGdAW/Z4k+bnlr3GEuCQLveTLwIfwbRBZQr6EaJxrX4Z0ZHmxWlq+KtgIT1yCSkOuML
         T3JQ==
X-Gm-Message-State: AOAM533ofdn588nogQbLY+B2X82d4OjcAOiBLjy5+gOMhUc6oVYCqSMQ
        AMpM8wSTa1M+7vG9+9bI5otTPw==
X-Google-Smtp-Source: ABdhPJxKgVI2vxQQnj6Y2VwwC48vKM49s7TZmuVnIrPHI7UEvLlX/5hkXht2F4PdIa4y51aCwp5ttA==
X-Received: by 2002:a63:2265:: with SMTP id t37mr6720232pgm.336.1609974617144;
        Wed, 06 Jan 2021 15:10:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm3469752pfc.112.2021.01.06.15.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:10:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
Date:   Wed,  6 Jan 2021 15:09:42 -0800
Message-Id: <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <82487.1609006918@turing-police>
References: <82487.1609006918@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 26 Dec 2020 13:21:58 -0500, Valdis Klētnieks wrote:
> Fedora Rawhide has started including gcc 11,and the g++ compiler
> throws a wobbly when it hits scripts/gcc-plugins:
> 
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> In file included from /usr/include/c++/11/type_traits:35,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
>                  from scripts/gcc-plugins/gcc-common.h:7,
>                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
>  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
>    32 | #error This file requires compiler and library support \
> 
> [...]

Applied to for-linus/gcc-plugins, thanks!

[1/1] gcc-plugins: fix gcc 11 indigestion with plugins...
      https://git.kernel.org/kees/c/67a5a6801305

-- 
Kees Cook

