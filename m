Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E19C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 19:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E0D60FED
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 19:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJTTng (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:43:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJTTng (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 15:43:36 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MXpM2-1mBftU0cOK-00Y8F9; Wed, 20 Oct 2021 21:41:20 +0200
Received: by mail-wm1-f49.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso12065212wms.4;
        Wed, 20 Oct 2021 12:41:20 -0700 (PDT)
X-Gm-Message-State: AOAM530FTeOJ8ZAgPKHMFMTHm58gy7HzXuRFIfRrAS8cZ0Zo+5d+AAXK
        dnnz7Mr9QglvFMuAFdDwY5rgUMoCE42OFXnYotM=
X-Google-Smtp-Source: ABdhPJw/qmZadw2YBjJXywRnlYqtqF/ls9kUuZUoyYESsWqynKCNMZR6iD7W0bJOVhnJGZsAaSWrE9XeP5KtPeTLRcQ=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr1373091wmg.35.1634758879800;
 Wed, 20 Oct 2021 12:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211020193807.40684-1-keescook@chromium.org>
In-Reply-To: <20211020193807.40684-1-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Oct 2021 21:41:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0jCxafw2mM8uDGXuZM7PsJa6mBpuHTc7+CkEDcDfeqSQ@mail.gmail.com>
Message-ID: <CAK8P3a0jCxafw2mM8uDGXuZM7PsJa6mBpuHTc7+CkEDcDfeqSQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: test: Consolidate workarounds for unwanted
 __alloc_size() protection
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:a/0gRzeBqDxrmc92VX1Pk+pbaomoedaDSssKrZGF527DDRg8b+Y
 cPvnQ23ajhgL/NZoSJqq9Yhl6S9n0mm8WimVAAc62ha0E5Lwe/PhTLCjDCJ//qyKYzbzCdA
 Gw3sUAw5R/kFRH1KpsGJaEWXvlM8w1y0zbjDRsd/fItq6Yy++sK8P6jeJRl7wQs40BXiZwM
 f2SFF7xkwjz/ssWPhXefA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mXLtkdDt6C0=:6GpbDXhgPLBP9uLw+1ncu/
 P5er/GEHzJI40+DQ5lWdCJrBJ5gPPvAEKEHtFh/y/QtwJRhWNd2XnnVXg4fQd9IiTT0GzIKgS
 DqLUBPnaetsTNIoke/Y6Znaa6GSwPTMYl/OZWbdIuG6PH6Xu+TUYHW363l2gTR1yQeh3Yinxw
 Sev2o+W5hehV2mCuUwxKWbAChToNrDrhqDCYehpvdKKok05LEyiDoJn5Rxd9MNeJFSN0xU563
 mykNO9lZsF2PQzj4Iq0sTJvSaWvwbcB+1nCK0oT7n6rp2SYSbWFdQgPciKR4+PA4l9qxlxpXK
 yQbgek5XbzFcO+1U3PccQugK36cGhMqVEoazBa10vcO+vDNTNVI7y9LPKdAkuYsIDdnkFEIA/
 1D3kGBhBH7GE8WWsuoXWZpPYHQl/Ysbe+gT7/uClU7JiVTxUZrRYlGPkpp1B6StKRym4YbhXr
 h12bSE6ZZXWZw6v570kQFKVTNeXZ0xtPXH7JZy7rVneKOkic7lgBzYI0HwTRB4rLoMuxKoWBG
 vVmvCW27SGEfJD5mhWY0lEkZrjNfihZ7sOaaBNV1p/vbuXFzJuLFpqSYzzCFCXHSfXguWrcMS
 EewQngLWhNlWSSSM+OCNX25WMDAX4Q5ShJotjjwD+rrOi48rDKJLQ6w7RM+rGwdzvT5r8vnor
 8520iCot2nGyXDqNMH+dReV0X5aIdCcRgoSKUhdVsjG1cZ/zueZX7qfVXIujVKmp4sF8=
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 20, 2021 at 9:38 PM Kees Cook <keescook@chromium.org> wrote:
>
> This fixes kasan-test-use-underlying-string-helpers.patch to avoid needing
> new helpers. As done in kasan-test-bypass-__alloc_size-checks.patch,
> just use OPTIMIZER_HIDE_VAR(). Additionally converts a use of
> "volatile", which was trying to work around similar detection.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Yes, that's much better than my version

Acked-by: Arnd Bergmann <arnd@arndb.de>
