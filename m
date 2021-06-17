Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA29C49361
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 19:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3ABB610CD
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Jun 2021 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhFQTcO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Jun 2021 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhFQTcM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Jun 2021 15:32:12 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD01C061760
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jun 2021 12:30:03 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so7294027otl.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jun 2021 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96aOqFV+Msept1aExEkb8x6Rqhfeyqwt0lWHBevMNvo=;
        b=oIB+8RnNPZyuKWRqD2bU8tkh/BghW1F0ppi6t9hKA1zF5buiMYjTkXkIhwTvmKhdxm
         IGq5N8xt3LwhgoEG6ydIYCuY/1sQwkMdTD8fQsrz0Be+jZIMtY+Vsq78m4XdWHmKznN1
         1c/XxoKiFU7kyNBAhN8hjv+3S0KhkfFo5cNok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96aOqFV+Msept1aExEkb8x6Rqhfeyqwt0lWHBevMNvo=;
        b=RkXahxi1iaaefAORUQ6qsZcThaHqxW3WHyvFPrkXihtqJgD4pn1Z6BX6bIk+wsavXT
         oyX44hB0jBkUOQA8dEy/YFB0O2Mc2/CNLGkrXTwoMGeMZ8/5zfrt+1riG9uPiz1DP920
         xixnqs8p3y96CYRf3w2AM452DBFxpy1nph3FBJxJkIa5XiaPvoWDWfGEEmOrxLdMntOm
         Tsaj/P48C84EnIRrDuRbvhtuZSJAu5hLSWO8A1m64LOZuLXjdpX0w0PnYTappYXjwYeK
         KkslwRKHv+y3PjT4x7f5I17qlBoE2aPUZ+bGH0v+ijAt2qsV6z7XpE4Xh+bjX7XbNAjF
         8BEA==
X-Gm-Message-State: AOAM531SZVc2ohjfXonQcWp1NScjVRcWpWFUgxGKZz6LG0G7DstPjHH0
        KVpEoJ/4XT5UhV9dxIbpLDe7RWqu2sgReg==
X-Google-Smtp-Source: ABdhPJzifIkQgPrp3LYBk7A5dKgnWhiAueVSKOv64/0JNY1bSCHvJFdtajn4vVxqUptiF33e8jWB5w==
X-Received: by 2002:a05:6830:1254:: with SMTP id s20mr5687798otp.265.1623958202627;
        Thu, 17 Jun 2021 12:30:02 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id v203sm1282235oib.37.2021.06.17.12.30.01
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 12:30:02 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id s23so7712504oiw.9
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jun 2021 12:30:01 -0700 (PDT)
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr11266904oih.105.1623958199878;
 Thu, 17 Jun 2021 12:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210617171522.3410951-1-keescook@chromium.org>
In-Reply-To: <20210617171522.3410951-1-keescook@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 17 Jun 2021 12:29:47 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOE2EgkiqyqkiXrUCMas+aVU1hJy4uDwafhWv6REjsefg@mail.gmail.com>
Message-ID: <CA+ASDXOE2EgkiqyqkiXrUCMas+aVU1hJy4uDwafhWv6REjsefg@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Avoid memset() over-write of WEP key_material
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 17, 2021 at 10:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring array fields.
>
> When preparing to call mwifiex_set_keyparamset_wep(), key_material is
> treated very differently from its structure layout (which has only a
> single struct mwifiex_ie_type_key_param_set). Instead, add a new type to
> the union so memset() can correctly reason about the size of the
> structure.
>
> Note that the union ("params", 196 bytes) containing key_material was
> not large enough to hold the target of this memset(): sizeof(struct
> mwifiex_ie_type_key_param_set) == 60, NUM_WEP_KEYS = 4, so 240
> bytes, or 44 bytes past the end of "params". The good news is that
> it appears that the command buffer, as allocated, is 2048 bytes
> (MWIFIEX_SIZE_OF_CMD_BUFFER), so no neighboring memory appears to be
> getting clobbered.

Yeah, this union vs. the underlying buffer size always throws me for a
loop on figuring out whether there's truly a buffer overflow on some
of this stuff...

> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks like a valid refactor to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
