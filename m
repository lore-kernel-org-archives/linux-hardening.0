Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40480C63798
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 09:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D702084C
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Nov 2020 09:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVO6DSBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgKVJ0V (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Nov 2020 04:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgKVJ0U (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Nov 2020 04:26:20 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF9C0613D2
        for <linux-hardening@vger.kernel.org>; Sun, 22 Nov 2020 01:26:20 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n12so9604161otk.0
        for <linux-hardening@vger.kernel.org>; Sun, 22 Nov 2020 01:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cAfiTUIi51Zz1nSxKjmyN2eOu7EUD/alyMpW55bSe4=;
        b=nVO6DSBoAw/G5phgnfeDSdFqoUccaAFQGv6ZWl8MNh3tLuDIcDxEOkatRdqudo03x0
         xZehrlP83C7fSvTirhyj6tsvMI+UkhmMR2N+WHNR9ctdctG0Ez7y6DxNjndy0thYO5zu
         LIN0tNGOXE3nYq7KGuJMiT3fSmVUqy0aHceQCbWAz1l/gDZsCENQUQkomyicMkYvGBo3
         efaELh9etcDLIBVJg1QSKhu6YWNSJeuvpkeMAsyukqEVuZ0ReJqCTX7LzAsZr+Q/pLLt
         mjf96x3DmJF9A6ur3Vf04oXbzsyv609cA8irt1MJLtCysgtV7zJK98Srsb+XAmZeRZ2Y
         231Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cAfiTUIi51Zz1nSxKjmyN2eOu7EUD/alyMpW55bSe4=;
        b=He2CUEmemkICn8sYUbOq9QUBDIfMBGNZHFYNJQrIfC2mBns9RC0M2I6upHjKuWgmN9
         8ZhMReU0S2Oa+qaqwRMBaJgrtobe0TdWeMndUzhRW1DYDZ/5TrKf1rP5ibjBDSRIzRoG
         drCl14kUEFvtmh/Xo9WTahNnx96NrtzZYNU+Cuh5vEGDFpnfzNnnd3092pDcJF9AuO5l
         jBnF/fZq7v8rGZTAjHUGT4qykXY8CCFPB3o+KB7Jfc28VkfYE7Va5qCZXQAJhp6IAU1Y
         qxUXE20p3FYjEvJA1vi7ZRc8kx4Zce0A2106p+31w9QeJc7UpcR4yBKPZlqvUnptmRPn
         XJQw==
X-Gm-Message-State: AOAM530hVvYFzWdjAE993It1SP+RuJLMLY5tBXPetEfGNIfOj+MU13I6
        HtY4WSFsHD3mR4SJ9j9+N47t+AH0fPw4u3kGsTA3/g==
X-Google-Smtp-Source: ABdhPJyAFibWOCLIaKkVKGwSOtGD6nI0mtsN1dU6rQR2CZXLXD5JnFVkiZxDBFr1vol4PHRP3TNJKH4IDX2AJyCZNUU=
X-Received: by 2002:a05:6830:1c8:: with SMTP id r8mr19676586ota.324.1606037179862;
 Sun, 22 Nov 2020 01:26:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Sun, 22 Nov 2020 10:26:09 +0100
Message-ID: <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/tee/tee_core.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens
