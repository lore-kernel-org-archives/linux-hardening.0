Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C442C77B7E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 08:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjFAIhC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFAIgR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 04:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6792192;
        Thu,  1 Jun 2023 01:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B517641D5;
        Thu,  1 Jun 2023 08:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6921C433A1;
        Thu,  1 Jun 2023 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685608514;
        bh=+YUAD//YlVKY5+gBa+79P7cJwXwdOQ+Jp7VlD1PAbyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P4bEPbdddBPCb87kzpJv07aaMARtLmWwzjkiom41+hsHBrl62JD1r1aBz8cKHjU9c
         X9iu9Wm74cvVi+piVFvjrw7RVk0QYFoTynZ3NC6QR2BuP4tDEL8RlNr3ZPur330cOE
         Q6uVHeKmiYvhBPIOugw4mRA7dnNrWHiZzN/9fuX0WChgHkQocHT/uKqzmvR8j8a3xw
         dANIclAdTMyw005A1Kw25L9j1KqzX2r1j9bLbYGOxFPlY0SXFBFdPb7X1uyBilfPr9
         +pNf2rydGlsyZHIev0KsctUhTFsYOZvW3tt6L2NCAtgArx6weXCnZIr4u9vMZ31IeT
         +ckxpbqXZSRow==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f3b9755961so598204e87.0;
        Thu, 01 Jun 2023 01:35:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDwG8OUV65sSOLepcZtLPNJwOI/zgGdQPBSrfQsgACF0xvXj2iwe
        jgA7Le8A73OIEWq2DtcM7Weg1x/jUqEENch6P8I=
X-Google-Smtp-Source: ACHHUZ6xuvvb5BPVfNACe6MUpNkE8UndZ+3fIhVFWcRPk2HabAj3IPXudsw5v84/8PYDOGj4ekJgWMf32Q1K1poixK8=
X-Received: by 2002:ac2:59cf:0:b0:4f3:7b3c:2e16 with SMTP id
 x15-20020ac259cf000000b004f37b3c2e16mr887897lfn.39.1685608512676; Thu, 01 Jun
 2023 01:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230530155501.222213-1-azeemshaikh38@gmail.com> <CACRpkdbf_biFPFC62uF1byXrMnK=0XbbBiZpJwT=GVnx5ZpP=g@mail.gmail.com>
In-Reply-To: <CACRpkdbf_biFPFC62uF1byXrMnK=0XbbBiZpJwT=GVnx5ZpP=g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Jun 2023 10:35:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGETX_zD=Us+E3+c0f1Cs3OA3gmZrR3Q-xhdh047V3-TQ@mail.gmail.com>
Message-ID: <CAMj1kXGETX_zD=Us+E3+c0f1Cs3OA3gmZrR3Q-xhdh047V3-TQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: Replace all non-returning strlcpy with strscpy
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 31 May 2023 at 15:30, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Tue, May 30, 2023 at 5:55=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail=
.com> wrote:
>
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please put this into Russell's patch tracker:
> https://www.arm.linux.org.uk/developer/patches/
>

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=3D9300/1
