Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69454C001DC
	for <linux-hardening@archiver.kernel.org>; Thu, 27 Jul 2023 17:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjG0Rat (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG0Rat (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 27 Jul 2023 13:30:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC94E61
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:30:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5222b917e0cso1633532a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690479046; x=1691083846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZmBNPq0bcXUflBuXMJNXmIiGvqz8QlpNJrRgcAYdfY=;
        b=k1AoEeqnaDAhamA5/3mqdn9o9WLTG22yhIz3U9J5jwTK3toyvtph9Mf/0C0bKlgjSg
         r1OxHfUWrHoLj+UMge42IvP81qaA/x76m+f3oKamrpKEfCXzx035NddYa5NRX4Qscg/j
         qugtlwmkQ//IT3mRHlRVO/zaAzWWvjqRHM2Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479046; x=1691083846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZmBNPq0bcXUflBuXMJNXmIiGvqz8QlpNJrRgcAYdfY=;
        b=hF3nlaySrByHk6/COMj+UD8C34IvQBbEx0kACe6MMvETPAeObzV7be0lsCzahMhgW5
         cDoITpjoFdOK2Fkdpvk+OYQEu8I5Zbl06KU5pPPAH7cJz8Bv/DYGfQYXi6wVDjjSqivi
         lPe6+IKCrUV8TOe4/snwnWxyKfEVsqMLF1awUKGPsnPtoyb3pigg4o35Z4Wf9pQAuWpN
         igTa05kfK7z6Q+EwzCyBmd7Sx8PoaVXqXvExtTea1za8D1MTgRsyzhM2QJS750CK8Aev
         1lhSpgFZ38bXOHOD+4m8DfBuwVlksw7G9aJ8Y0V2HxV7kRrbmkfvx99BJFqpxugrjV49
         esKg==
X-Gm-Message-State: ABy/qLY+8g1lA/5Wht5I888QOIgX2Fo9HzS3UVx0JPrfrCLGenE3FRYy
        KkZFU/cy4bdIy1h3ex9fJFikTgzTm4PMp8KiDqNZWA==
X-Google-Smtp-Source: APBJJlFVbx+FNXj1rdObq2B/cHMxTxvmt1PFIWIsKN/5jQQaJzW1NYo4wWoInbfpadz2HH265J3uFQ==
X-Received: by 2002:a17:907:a0d3:b0:993:e752:1a6a with SMTP id hw19-20020a170907a0d300b00993e7521a6amr2542689ejc.21.1690479046328;
        Thu, 27 Jul 2023 10:30:46 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709064d9100b0098e4aef0791sm1012891eju.66.2023.07.27.10.30.44
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:30:45 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bc0a20b54so166217666b.1
        for <linux-hardening@vger.kernel.org>; Thu, 27 Jul 2023 10:30:44 -0700 (PDT)
X-Received: by 2002:a17:906:3f16:b0:994:3207:cddd with SMTP id
 c22-20020a1709063f1600b009943207cdddmr2507999ejj.34.1690479044218; Thu, 27
 Jul 2023 10:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230710030625.812707-1-azeemshaikh38@gmail.com>
 <169047317161.2400214.15246406234885315012.b4-ty@chromium.org>
 <87pm4dz6js.fsf@kernel.org> <202307271003.BCF5F3597@keescook>
In-Reply-To: <202307271003.BCF5F3597@keescook>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 27 Jul 2023 10:30:29 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPak0M4zSwiTFpkRxw_WOmBmKJUTi9i5wCOY89fiP1vng@mail.gmail.com>
Message-ID: <CA+ASDXPak0M4zSwiTFpkRxw_WOmBmKJUTi9i5wCOY89fiP1vng@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jul 27, 2023 at 10:04=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Thu, Jul 27, 2023 at 07:02:31PM +0300, Kalle Valo wrote:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.=
git/commit/?id=3Dcaf9ead2c7d06fd7aa4cb48bd569ad61db9a0b4a
>
> For the patch you linked to -- it's okay to have lost the overflow
> detection and warning?

It's a fixed constant string being copied into a larger fixed array.
It really doesn't matter functionality-wise. At best, the error check
would be useful for human readers or automated tools. So I didn't
bother complaining one way or another, as it took enough tries for the
submitter to get things right in the first place.

Brian
