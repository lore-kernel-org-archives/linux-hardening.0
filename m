Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3DEC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jul 2021 18:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCE360F9B
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jul 2021 18:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhG1S50 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhG1S5Z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jul 2021 14:57:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42543C061765
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jul 2021 11:57:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m9so4287029ljp.7
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jul 2021 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wz3zSkFzjQntghr6ZqIZrO9ooDQ8NkXIW4sIoKf9LII=;
        b=erh9WZmKaNqQHnCbDmc/UVs3PMxojFdDOnh2teaK7xiadq49gjo61tfLnlD89XfG5M
         bkj9NDS9bdOTyv47cYV1oKYWM7mTogJCf2sLZ7aruoxXpg/bXq+8ZX4UAWWoy8hBb0qD
         kkfEqNi0r/geKhsh/ofHJskphQg6DBJp2cq+571fOPH4De6pRgYcyuSXIzi4boCT2JyK
         rEc3zTIUhFoIYcQkW4wgTtR1FDOpTilTlFoOk0zGZGSO+edUVpxnw/kcahOaiU9WaWsg
         hzSREd9n5DgchC5LT3CoqasYvaWNLWTfMI/MsW12AI+ZV4GWp+ZfdayXl9MCteyw2MH7
         /RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wz3zSkFzjQntghr6ZqIZrO9ooDQ8NkXIW4sIoKf9LII=;
        b=DL+Dk2P94ObqA2Hsuk6VmLww/SoNBys50npUZtdaw4JhJN2gBF0xrUTFt8r0UP9zcA
         E7052ENeTSf2T+Ny16D15vzHdgZiTDbrPjCxrScT/wvAzg9ee3qs+fRxJoD8QFjsw9q4
         B85Br2EM5voaEOtQVfNtzCD9/P4KH2oiBy6jx03ktZH21Bv+SrOAwG/86t26BiSy0TPw
         pymLdmPY9fr4LhwuSMxS7ViaxVENFxX520JbHdtrVfukG7vbOLnlCaGt01JKL8ojwdB6
         j1BAhTVQJlb4Nj3R0Pzbu/AcpI8FZmR8wDQ0sc0xA1wjqtE9WTgiRj1M/wa2Rnv3nJFI
         mnzQ==
X-Gm-Message-State: AOAM531aEZtDLVVw7Zw0F1m3jGe8fOexKt6X8Yyciur+LJG6KffNLW56
        REARh55R5Bdhff4xovN9/+LjJsTYMg1vYmVu4ZN9uw==
X-Google-Smtp-Source: ABdhPJzmD03VSAkTiDzk+W1Cgj85XGNlk2DPLdChRVx0hZZjmdQyZoM+U7EvgM2sc2Yr0a1ObQMzPP1l5SAUXRd4k2c=
X-Received: by 2002:a2e:8887:: with SMTP id k7mr735557lji.226.1627498641274;
 Wed, 28 Jul 2021 11:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210715055923.43126-1-xiyou.wangcong@gmail.com>
 <202107230000.B52B102@keescook> <CAG48ez0b-t_kJXVeFixYMoqRa-g1VRPUhFVknttiBYnf-cjTyg@mail.gmail.com>
 <20210728115633.614e9bd9@oasis.local.home> <202107281146.B2160202D@keescook>
In-Reply-To: <202107281146.B2160202D@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 28 Jul 2021 20:56:54 +0200
Message-ID: <CAG48ez358qhf2m3=WY-ngtQT9SOLkGTGMqeb7seFpNaSiqvtSQ@mail.gmail.com>
Subject: Re: tracepoints and %p [was: Re: [Patch net-next resend v2] net: use
 %px to print skb address in trace_netif_receive_skb]
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Qitao Xu <qitao.xu@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 28, 2021 at 8:48 PM Kees Cook <keescook@chromium.org> wrote:
> How does ftrace interact with lockdown's confidentiality mode?

Should be LOCKDOWN_TRACEFS ?
