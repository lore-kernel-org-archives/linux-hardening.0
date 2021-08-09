Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AA8C432BE
	for <linux-hardening@archiver.kernel.org>; Mon,  9 Aug 2021 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48B060EB9
	for <linux-hardening@archiver.kernel.org>; Mon,  9 Aug 2021 21:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhHIVYn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbhHIVYm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 9 Aug 2021 17:24:42 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA9FC0613D3
        for <linux-hardening@vger.kernel.org>; Mon,  9 Aug 2021 14:24:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h11so10376580oie.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Aug 2021 14:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x7djV8cU9LbMV7kajT88pgm0cyo38YSmnH16cnh0+6c=;
        b=IQnIucvNHK0pfJNN2pnmEFU/wNLWyA3Qq2owDANrdlt2wnUmmlqmJ0h0UzI5GV53Xj
         SmkwwalgbcnonkWR2ftVHdWq6N5PvSo8LlW2U2q4z6uZbJefgvN7lGVojUr4edep6OW1
         P7RW6Su7ZYx3s8DWXw1RQRIJYFZu4e7KY9qfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x7djV8cU9LbMV7kajT88pgm0cyo38YSmnH16cnh0+6c=;
        b=NIe7n2k4A+4GEP8oOq0WfEeLLJkZgndwg20vjUkXnKXa6QYFHxgmyQeNlByTycanVv
         YXQYymLpT2xqXepHlLXXWch2c/MQND2SBYR2ndhzlNAucB4b+/5QTihySLcCo0p9jSSG
         QtjuQrJwcP5VzblVNxfC07aLIichQbSRxXE9IX4XOP65OK2krMRO5Tbj7VVVjefCfosT
         vo1mZyv02NPry3kK8vkkt1aWWoLbjWDyMB6eh0D0Jchij7RjbJB2K/E2F8hbJBrtHh/C
         2/FNgOa5kdbiR69haF196yzpntg9XO/PpjYUiD0tLdVp9j+Y5jyNTYj8VbXEQ5rjL/uL
         6RSA==
X-Gm-Message-State: AOAM530gfr5R43ym41uQCO/FsPz0n55O893VbqGUYIItGXx/bNOXa1fi
        PzSUfDXt+V2MtihSS/CqDCHLOeBUwN5Cgg==
X-Google-Smtp-Source: ABdhPJwCBc0s/XxxD1CCWoSoHEUoBwbBjmyJeQfDk7+InPDX+R7eny9XNCrhFl76gmRZB4gO7fyHAQ==
X-Received: by 2002:a54:400b:: with SMTP id x11mr934257oie.38.1628544259627;
        Mon, 09 Aug 2021 14:24:19 -0700 (PDT)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id w16sm1016776oih.19.2021.08.09.14.24.18
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so4770413ooc.2
        for <linux-hardening@vger.kernel.org>; Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
X-Received: by 2002:a4a:4c55:: with SMTP id a82mr16548740oob.66.1628544258286;
 Mon, 09 Aug 2021 14:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210809211134.GA22488@embeddedor>
In-Reply-To: <20210809211134.GA22488@embeddedor>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 9 Aug 2021 14:24:07 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO+GbP_WWVdO0=Uavh036ZhZiziE8DwGRKP-ooofd2QVw@mail.gmail.com>
Message-ID: <CA+ASDXO+GbP_WWVdO0=Uavh036ZhZiziE8DwGRKP-ooofd2QVw@mail.gmail.com>
Subject: Re: [PATCH][next] mwifiex: usb: Replace one-element array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Aug 9, 2021 at 2:08 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].
>
> This helps with the ongoing efforts to globally enable -Warray-bounds
> and get us closer to being able to tighten the FORTIFY_SOURCE routines
> on memcpy().
>
> This issue was found with the help of Coccinelle and audited and fixed,
> manually.
>
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-le=
ngth-and-one-element-arrays
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

An important part of your patch rationale should include determining
that the 1-length wasn't actually important anywhere. I double checked
for you, and nobody seemed to be relying on 'sizeof struct fw_data' at
all, so this should be OK:

Reviewed-by: Brian Norris <briannorris@chromium.org>
