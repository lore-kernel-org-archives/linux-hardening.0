Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01961C433F5
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD311610E9
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 19:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhKHTX5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhKHTX5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Nov 2021 14:23:57 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65BC061570;
        Mon,  8 Nov 2021 11:21:12 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so16426210otk.13;
        Mon, 08 Nov 2021 11:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpRGr3jpvIFQhzvW4MxJKqtBZrUJ5oRccS3rsOZFPrg=;
        b=CTM3ujxULM809hJxzOJR5rsG6Nf/+ASek2zlC5aYe6YCfmQ/C66zS1AZdkA0YX486F
         WlFJS7Pr/VvYOd6PhSulFv66bePGyK/h6/9sZ8dsiGPx7ICz52AICdXUlbq9Qzah/KVw
         k9InznOWVtioSOnzIF1zVullcDGbWyXANCjNYiBq2lSJ9+7zJSkvSq/X/j8jGByppY53
         V216Zbv2Ctnj9O+CCOMnlbwLZ6n4AwX9uDk2dDh4D7skET4WcyT/9Lxs0z4pWY3/VOcr
         buYQ7RJMq8oCGDrz3bvCruapcwS+0Z8Ze6Mk1c+Iv3NJnFaHge6Roz2wRg1zGiZDdlZC
         8UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpRGr3jpvIFQhzvW4MxJKqtBZrUJ5oRccS3rsOZFPrg=;
        b=BEtegIoU6Srsxaq7adHypvyRGi3WmcjWgs30KTenlRTvjPzyImijqKqLUENuq+i1ZA
         gFGMtviwzawsBE8jp3K4xRA5TR20nlmgbq1z0mKTSfLlt2/GkoG2ESnSV2/HaVNDwcPI
         xoSC/AGHc3PdsrrFRMiesKKqmXrH7RfqjpFWksaFAynHQRcgRODMUuINokHDxu6iWwvM
         DFidsgQBdqed3PO20BdQ3ugp99ZU+vGcc+MBjOOPpGJY6hs+OyVg/DgGjO5tDKcIXWWv
         hhew6DwYl+iFVahSZH/SBqeRYSuMduYbrgXl+XOd32lA9v3h41qqob0cFojYJdK3+4vu
         be1Q==
X-Gm-Message-State: AOAM530dnJ/kVaacmUGHjWyI00NwOr8ZozgYCG3zPiFdo0uVFmSEuZ8v
        5kctvnNtJH1EMf4sfi++oUC2+HHLfS+2PrzHing=
X-Google-Smtp-Source: ABdhPJxN9HNj3rKGYq/3cvOZ/DzpmSQ8BQzXfQg/URy7qDl/nZNIA6k/PKqj7kC+WUwlE0WLxV+LwzXGLjC0qbZ1vTA=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr1078377otl.351.1636399271854;
 Mon, 08 Nov 2021 11:21:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <YYkWb4GQAAtZJNsT@kroah.com> <CAHP4M8W2H4V=qgAeVp76GwfVUBzR3erZxJiuhm6jnyMo+gvknQ@mail.gmail.com>
 <202111080954.B97F7B4C@keescook>
In-Reply-To: <202111080954.B97F7B4C@keescook>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Tue, 9 Nov 2021 00:50:58 +0530
Message-ID: <CAHP4M8WnLA0780yN+bpuuCtir+DLJRxe0atAiLbZO0bTGf6J-Q@mail.gmail.com>
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy and strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, andy@kernel.org,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks Keen for your time.

>
> For the specific fs/kerfs/dir.c case, I don't see any problems --
> nothing uses the result (cgroup_name() is the only caller of
> kernfs_name() that I see).
>

I am not worried about this single case as per say.

My intention is to make the lives easier for clients in general, who
have the simple motive : to copy as many bytes as possible, and then
consume/propogate the return-value containing number of bytes
*actually* copied, without having to resort to the identical
4-lines-per-check-fix everywhere.

I think you and me agree on the pain-points of using strlcpy/strscpy.

The general consensus is that no new string-functions should be added
as of now, so I guess every client would require 4-lines-per-check-fix
as of now (wherever applicable of course).

Maybe, the RFC for new function could be discussed in the next
opportune moment, which would then be a simple drop-in replacement,
resulting in 1-lines-per-check-fix (wherever applicable of course).


Thanks and Regards,
Ajay
