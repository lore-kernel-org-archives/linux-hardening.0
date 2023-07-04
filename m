Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B954EB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 16:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjGDQ5I (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGDQ5H (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 12:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85EE5B
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 09:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA9C61315
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 16:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5A7C433C9
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688489825;
        bh=EV0NwTUo2o6vRTi+H1+1OC5TKOUOlPcQ4L9wRlWCsLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZuHL6NKhT98D7kdv9XXSejtTs1Fc2coMaD+U7AX+pIwbJRQJmDgwyAnBKyKeAkG4q
         l/mr+xVNZU0beUrhYaOh+YfKGeeZXa22UgTwjDqBqn2z6XbHnE/kwTQl52f1Fxns9B
         cwSlIp5TSl11RpClO+70pOghnpltPI3YZKairSSvxS3gilh+7b7+jsL4+TRlmFIvad
         Mi4PfoPrsLkikMvpIsYlE8MftxUivz8D1HD+CQF6gLFhMY4s1pAx2r56fayrTDwV0K
         mq5Z0QD/a2MCu3pTpLSfPBUy779urRnLCwnltP/G/5hKjMwceUW9KSTJGA29Td/j1S
         SAKhtGpnqBgvQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fba74870abso6437936e87.0
        for <linux-hardening@vger.kernel.org>; Tue, 04 Jul 2023 09:57:05 -0700 (PDT)
X-Gm-Message-State: ABy/qLb7NDB9LZm7yfYoHFRTXIYlz6w6sYWAwQrkVZNtTHDo+1irF451
        SJ2beJ3eRqTk2nLNwfdmKqTAl/SK9ZDSurzHmFs=
X-Google-Smtp-Source: APBJJlG2sk75tvGZt7fwrsSm67fOU0W5S9S44FJLsmb3NbzLVznT/BPL6iPbhUOSig/ysthNclT5IMOhDMOXMFJ5wuk=
X-Received: by 2002:a05:6512:3703:b0:4f8:68a3:38d5 with SMTP id
 z3-20020a056512370300b004f868a338d5mr8253034lfr.66.1688489823556; Tue, 04 Jul
 2023 09:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230704135211.2471371-1-ardb@kernel.org> <20230704135211.2471371-3-ardb@kernel.org>
 <D690FB7B-BE46-4A56-9BDE-AB84652997D3@kernel.org>
In-Reply-To: <D690FB7B-BE46-4A56-9BDE-AB84652997D3@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 4 Jul 2023 18:56:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGW0kZdSfnNM7oMNt+0Ois8NJS4ZwHmrcvrOP1vRdUa2g@mail.gmail.com>
Message-ID: <CAMj1kXGW0kZdSfnNM7oMNt+0Ois8NJS4ZwHmrcvrOP1vRdUa2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pstore: Replace crypto API compression with
 zlib_deflate library calls
To:     Kees Cook <kees@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 4 Jul 2023 at 18:48, Kees Cook <kees@kernel.org> wrote:
>
> On July 4, 2023 6:52:11 AM PDT, Ard Biesheuvel <ardb@kernel.org> wrote:
> >@@ -217,10 +220,6 @@ static void allocate_buf_for_compression(void)
> >
> > static void free_buf_for_compression(void)
> > {
> >-      if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm) {
> >-              crypto_free_comp(tfm);
> >-              tfm = NULL;
> >-      }
> >       kfree(big_oops_buf);
> >       big_oops_buf = NULL;
> >       big_oops_buf_sz = 0;
>
> I think this is missing a free of compress_workspace?

Indeed.

> Everything else looks great! What kind of testing did you do for this series?

I tested it using lkdtm PANIC in a arm64 vm, and after a reboot,
checking the contents of /sys/fs/pstore, and all looked as expected.
