Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D244EC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C2960EFE
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 15:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJRPsj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 11:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhJRPsi (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 11:48:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C965460F9F;
        Mon, 18 Oct 2021 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634571986;
        bh=rvQv9P/Tr9IQeyrtF20/KMfdi6OiCCGfgGnZYK4YN7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vBnzxFy5t0zvqVPxZXTKskPiutZBBlnQimjDagHpTlReeAogosu+geXtpqkY6C+rL
         rLEs5hWnW4Pr/T4o7uQgwQnnPyCt5Ru9uWRYy3GORGIHHqfMHUP5zSsxXeQEr+C7r8
         w1HTNthbN5pS4YmGDpCPAeNz13A08NMxyyJpLUsySmqlRG7BI86v85pChl46Jr7Pkn
         Uycjq2nnNLSgfmsRzOt/etBdITSmXdIUYERxM1ltJKzEIpQrjsTCn48CBpjToSkjnl
         U8xUNcWGHdH52n2kSxvWbwxybx3ADwd3qCgEXOiJ5VfKgUxxnFS63rDJC3qOTIdbcE
         WK866GkeR87OQ==
Received: by mail-wr1-f45.google.com with SMTP id k7so42051407wrd.13;
        Mon, 18 Oct 2021 08:46:26 -0700 (PDT)
X-Gm-Message-State: AOAM533xVvJc3jBLCYHx1Naj9ikSxpljc6YUVImOjb72xRv5wcRIiSIE
        gociNgHTYoxqIWewZObilWMt7kBVUhWeKE1apMU=
X-Google-Smtp-Source: ABdhPJyVSTym0arEJ6ZwtHU4fs5OSXOHeSmEtNbviOiBmtgXR11Ca2zcAFNb/orCjHKR3vegA/Xk2elZ8RZ8MhXF1+w=
X-Received: by 2002:adf:b1c4:: with SMTP id r4mr36465681wra.428.1634571985240;
 Mon, 18 Oct 2021 08:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210822075122.864511-1-keescook@chromium.org> <20210822075122.864511-22-keescook@chromium.org>
In-Reply-To: <20210822075122.864511-22-keescook@chromium.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Oct 2021 17:46:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1o58qeUsn9_+o1v1POZ9=3p17TCEba4-TRQ7Hf5mRg1A@mail.gmail.com>
Message-ID: <CAK8P3a1o58qeUsn9_+o1v1POZ9=3p17TCEba4-TRQ7Hf5mRg1A@mail.gmail.com>
Subject: Re: [PATCH for-next 21/25] lib: Introduce CONFIG_TEST_MEMCPY
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, Linux-MM <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Aug 22, 2021 at 9:56 AM Kees Cook <keescook@chromium.org> wrote:
> +FORTIFY_SOURCE
> +M:     Kees Cook <keescook@chomium.org>
> +L:     linux-hardening@vger.kernel.org
> +S:     Supported

I had added you to Cc on a patch because of this entry, and the email
bounced. It looks like you need an extra 'r' in the address.

         Arnd
