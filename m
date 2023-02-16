Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A473DC61DA4
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Feb 2023 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBPKUq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Feb 2023 05:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBPKUp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Feb 2023 05:20:45 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC73C17
        for <linux-hardening@vger.kernel.org>; Thu, 16 Feb 2023 02:20:44 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id x4so1620343ybp.1
        for <linux-hardening@vger.kernel.org>; Thu, 16 Feb 2023 02:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1LFVu/Jq97eDG/VSiKN+fBOIP5O948QZ2+duJcCNi2c=;
        b=mUvNMAhzJSIC2qlZfOXMYaE22ATnOUg72eef+Egey3YKMDV0/XessAYBj5n5RGf+5l
         SYNTbHKUxsxq+O0ZPlI6rhixwTHw7nrAfA1gk7aLMpL39Tvlpg2IxZ0x+00VrOofqCOl
         e/YCqgXyKwgM/xUDD3xEiXj3x5I+iV3fiARGWCKjhu4sx097rkFrWiMfb97ZifRAM4uN
         BEne1EGi+S7ru8qepX3q5Dqn9jz+kUvYXKs/0aq9fwnCLMF+ADv+g9nQ7/YLJRaJp9a8
         +/pksIEeHbbGZIwc+TsEl4jn3pHvY5x0f8DQx8iubsiS69PkzZZzdu/jw4PzXcO4wuRP
         nkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LFVu/Jq97eDG/VSiKN+fBOIP5O948QZ2+duJcCNi2c=;
        b=w6mxsruMwH4YaigA234oREovHFUSA/m6NtMX8UFIE5QYhI6kq6NX5T1cwxdg22fAPq
         SdyG9bh+L+ZG75o+vPzQxfu91hfn4PlLqkuRr1YS4p8eOCqPIgjLEnhlPEIh5tLLz19O
         i4++EF+2579FAq8OUm7rAnHr9sE0uXp/CuyepbSKJaZnSbZPILh1mjZyucSvk5T1gFyY
         woT96Mhw13TsgaNoYbq/UN7XIHDhwjp6l+6l6xR2x2ARaVqOiYtki1QIMZCRPOX7f6aR
         s6/N0WHxDKeyZp08b7lIwMuN1YdbMSz4oPb4YOCsUCc6keFqIzP00v7GZ0kAvAO3Cdgx
         y1TQ==
X-Gm-Message-State: AO0yUKUWGGEpWWcnLjCV4fA7qFgd+qWv1fH9wgiimKhRbs57Luv8a2Rx
        sQ2MSBV9K21ZCdSq2ys0l3A1b7vlzW5S+RT6QqxbgQ==
X-Google-Smtp-Source: AK7set//9GiliBNMnBKujZOrjDQmGKeILf6av9Y6BwR/JtQulMPc4CNAMTP+cbMcZpIUz+eN5ebyNDWNoUuf+XrObHM=
X-Received: by 2002:a25:9983:0:b0:883:cf5:1553 with SMTP id
 p3-20020a259983000000b008830cf51553mr544086ybo.28.1676542843273; Thu, 16 Feb
 2023 02:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20230215224110.never.022-kees@kernel.org>
In-Reply-To: <20230215224110.never.022-kees@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 11:20:31 +0100
Message-ID: <CACRpkdbqoiCpj=-stVm0fG6xfLvuK+1BCm6PVnROqyKD9UNn_Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: p2p: Introduce generic flexible array
 frame member
To:     Kees Cook <keescook@chromium.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 15, 2023 at 11:41 PM Kees Cook <keescook@chromium.org> wrote:

> Silence run-time memcpy() false positive warning when processing
> management frames:
>
>   memcpy: detected field-spanning write (size 27) of single field "&mgmt_frame->u" at drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1469 (size 26)
>
> Due to this (soon to be fixed) GCC bug[1], FORTIFY_SOURCE (via
> __builtin_dynamic_object_size) doesn't recognize that the union may end
> with a flexible array, and returns "26" (the fixed size of the union),
> rather than the remaining size of the allocation. Add an explicit
> flexible array member and set it as the destination here, so that we
> get the correct coverage for the memcpy().
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
>
> Reported-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Colin Ian King <colin.i.king@gmail.com>
> Cc: Brian Henriquez <brian.henriquez@cypress.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Us having to deal with this kind of stuff is why we need Rust.

Thanks for doing this Kees,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
