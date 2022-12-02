Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF51C4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Dec 2022 23:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiLBXaV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Dec 2022 18:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiLBXaU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Dec 2022 18:30:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DADC852
        for <linux-hardening@vger.kernel.org>; Fri,  2 Dec 2022 15:30:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id jr1so7359232qtb.7
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 15:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofSHfJEl53nBxTKL7kEN4Zg0gZG24eP3ZO/twC4u+1k=;
        b=HeigGMHv29ce9DCaTPYVM3dw6G+hA6RazCRkjT3KQZLg25j/kXIJzVk1CREUf4Tnjy
         ObHsN/+LfiA+cHa5FGu5yq1n8lo5ofkI8FlaEx18YFuhsuonRWe5rGWezpeJ+mAErWcz
         bONfAWoJMb2gN0IP5FjGges9W5cH/wdhI0L3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofSHfJEl53nBxTKL7kEN4Zg0gZG24eP3ZO/twC4u+1k=;
        b=UvvFvgZysAHfk8DhI41MoNjzP4luTW37J8YcINE7dpdduwgz8A4s1J+NFmaR+OB+4C
         4Kde7xxNRCmymPKeZN1DDChXtPnCfshbpCk+zr8AQyDDCx/Xt7zF86DpAQbKqbaKM/xW
         E7e6/g4KFoWhxT4qjtggGte2XTnDCNx02ah/Wk3k409ob3ouiM20zlR+v/FM6HmIxA5L
         HwZxKMS/idVYwzTwzrHWAhh7yKsqjnsBDCbObTrzxDRlv3p0P7s5mTaNe15GKgK16a8o
         nTBZ8vdB12kqEwTayPTL22KozeChjclgFtzo1y2iTGwr5DIgbME+ki7TVkjiS6sdSMMM
         ckkA==
X-Gm-Message-State: ANoB5plw+R/fuIyplHKQE5nzkNHLg9fafhDP3ie5Z9V9LVI9ZxKX+2f6
        Qsyz3UM/QYSVLgah2eTpbqPzbKM3UPwdyl01
X-Google-Smtp-Source: AA0mqf6kNjEDg4KOHjQAeWP+RqCoz6+2hY35+HwgADcUIHcQWAfsxgRocodu89nha2t8I25/MqNCUw==
X-Received: by 2002:ac8:4998:0:b0:3a5:7062:b8a0 with SMTP id f24-20020ac84998000000b003a57062b8a0mr50123622qtq.82.1670023818715;
        Fri, 02 Dec 2022 15:30:18 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id bb4-20020a05622a1b0400b003a51e8ef03dsm4859243qtb.62.2022.12.02.15.30.18
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 15:30:18 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id p12so4430356qvu.5
        for <linux-hardening@vger.kernel.org>; Fri, 02 Dec 2022 15:30:18 -0800 (PST)
X-Received: by 2002:a17:902:e807:b0:189:117c:fcfe with SMTP id
 u7-20020a170902e80700b00189117cfcfemr54885077plg.124.1670023447808; Fri, 02
 Dec 2022 15:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20221202013404.163143-1-jeffxu@google.com> <20221202013404.163143-7-jeffxu@google.com>
In-Reply-To: <20221202013404.163143-7-jeffxu@google.com>
From:   Daniel Verkamp <dverkamp@chromium.org>
Date:   Fri, 2 Dec 2022 15:23:41 -0800
X-Gmail-Original-Message-ID: <CABVzXAkoGoypAs86EG5RsJZ=CXPu3NtTHb7_2=byQt7A7p7krQ@mail.gmail.com>
Message-ID: <CABVzXAkoGoypAs86EG5RsJZ=CXPu3NtTHb7_2=byQt7A7p7krQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memfd: Add write seals when apply SEAL_EXEC to
 executable memfd
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        hughd@google.com, jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Dec 1, 2022 at 5:36 PM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> When apply F_SEAL_EXEC to an executable memfd, add write seals also to
> prevent modification of memfd.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/memfd.c                                 |  3 +++
>  tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 96dcfbfed09e..3a04c0698957 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -222,6 +222,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
>                 }
>         }
>
> +       if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> +               seals |= F_ALL_SEALS;
> +
>         *file_seals |= seals;
>         error = 0;
>

Hi Jeff,

(Following up on some discussion on the original review, sorry for any
duplicate comments.)

Making F_SEAL_EXEC imply all seals (including F_SEAL_SEAL) seems a bit
confusing. This at least needs documentation to make it clear.

Rather than silently adding other seals, perhaps we could return an
error if the caller requests F_SEAL_EXEC but not the write seals, so
the other seals would have to be explicitly listed in the application
code. This would have the same net effect without making the
F_SEAL_EXEC operation too magical.

Additionally, if the goal is to enforce W^X, I don't think this
completely closes the gap. There will always be a period where it is
both writable and executable with this API:

1. memfd_create(MFD_EXEC). Can't use MFD_NOEXEC since that would seal
chmod(+x), so the memfd is W + X here.
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to !W + X.

I think one of the attack vectors involved the attacker waiting for
another process to create a memfd, pausing/delaying the victim
process, overwriting the memfd with their own code, and calling exec()
on it, which is still possible in the window between steps 1 and 3
with this design.

Thanks,
-- Daniel
