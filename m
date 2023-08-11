Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1256C04A6A
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Aug 2023 21:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHKVZs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjHKVZk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Aug 2023 17:25:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E00D2129
        for <linux-hardening@vger.kernel.org>; Fri, 11 Aug 2023 14:25:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so4971423a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 11 Aug 2023 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691789138; x=1692393938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86JGYZ3ry5mveviksjcn/qEvMtmvc4Ix/xUvNeLXEDs=;
        b=yp3x6i43BD8RlV322qJmJKCChEAV4UH5GzYm+QKTIbEfh7XUtrsq+1zAx0sNg+t1d+
         5Wdx8+yD9PcpjFm6EwHkertYyul98NZdT7eMM1xpNAGQvsovbk+87Q0wdMIbXOqYfONq
         6YuGbb337lL0MnSOZ+zkCGkXtOM0YWf5KDk6wCBq61CXXtdyV10ODW7oScEWFrfKV1Fb
         gHshtevWMATpYNZmgU73KijInvpPplIazRtamhNz+s/hZNupYZjFG3dKpshD04LAQR3b
         +hhD59qaxfiKGmC3EzhWXafo2eDdjNVkhYcLndoGmpPabWfR4zaRjXU/jERrCpyxvtNP
         At1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789138; x=1692393938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86JGYZ3ry5mveviksjcn/qEvMtmvc4Ix/xUvNeLXEDs=;
        b=Squn3+fw2rMRKMI1FNyXkhnzLjoOFCU2zQqEuNGCrIAHw1tQkLoj+N09uwTPHFNivx
         6Wjrr2KBe1s+IUGIk6taKYhHWl58PBHecIZKXlRdLIX2ybegqL/J9rUBd4F7zFIxhrrj
         QMAypKP5+ZeY6zjqKYPjllf+BCquTPBW2PxQbnasgPdKRo13/YS+/2hg7eRgwqtcAUX4
         nubnGo2QeOfKaZp0LtsALd4/lcHaJF5ydamBiDaTF/4K+C5jvDXuhKoZHJCIZb+UYenQ
         6VxLk6GYS8voq9/JUZJlNc16bX0ThaA4TLcW0kROIpOGHX8lWXGQEIe2r694mvRbqX8+
         xe7w==
X-Gm-Message-State: AOJu0YwxZgVMXoV2ASKzjcr+L7vkA+ZlHdoxnzUqfIkkYCSZ5LYfr5TG
        lRiTApjLReu7QMxL3AuQpUfMp25UTtNQqVt7kxj3yg==
X-Google-Smtp-Source: AGHT+IHsxCBP/w9r5NRNaDnfZRytZV75kWryG4q6b+1hs+BKKLWWPj716c7QrOT8uP1DUmE3xa+OcLdt4WGWk5ajISA=
X-Received: by 2002:a05:6402:268e:b0:523:72fe:a3c4 with SMTP id
 w14-20020a056402268e00b0052372fea3c4mr7852202edd.0.1691789138513; Fri, 11 Aug
 2023 14:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
In-Reply-To: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 11 Aug 2023 14:25:26 -0700
Message-ID: <CAFhGd8oZLTaFNg3pQSi=zX121HPfY9_v-H5e3_+27W3=1fXxmw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] powerpc/ps3: refactor strncpy usage
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 11, 2023 at 2:19=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Within this RFC-series I want to get some comments on two ideas that I
> have for refactoring the current `strncpy` usage in repository.c.
>
> When looking at `make_first_field` we see a u64 is being used to store
> up to 8 bytes from a literal string. This is slightly suspect to me but
> it works? In regards to `strncpy` here, it makes the code needlessly
> complex imo.
>
> Please see my two ideas to change this and let me know if any other
> approaches are more reasonable.
>
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Justin Stitt (3):
>       [RFC] powerpc/ps3: refactor strncpy usage attempt 1
>       [RFC] powerpc/ps3: refactor strncpy usage attempt 2
>       [RFC] powerpc/ps3: refactor strncpy usage attempt 2.5
Errhm, It looks like the diffs after attempt 1 came out poorly and
probably won't apply cleanly because they were inter-diffed with the
first patch. Is there a way to let b4 know I wanted each patch diff'd
against the same SHA and not each other sequentially?

As it stands only attempt 1 is readable.

>
>  arch/powerpc/platforms/ps3/repository.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> ---
> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
> change-id: 20230811-strncpy-arch-powerpc-platforms-ps3-57a1cdb2ad9b
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
