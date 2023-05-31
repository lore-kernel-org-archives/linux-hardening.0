Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1499AC7EE23
	for <linux-hardening@archiver.kernel.org>; Wed, 31 May 2023 13:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjEaNcD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 May 2023 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjEaNbm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 May 2023 09:31:42 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A61FC2
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 06:30:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bad041bf313so8091106276.0
        for <linux-hardening@vger.kernel.org>; Wed, 31 May 2023 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539797; x=1688131797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itMAWlEVGbKwEk4rvkPhIkKoGJ+D+wP/v3giQWPxtxE=;
        b=TKCUTBNhaMHi5eEwlnd8h2q+kD82oaJbKs2k83VnkFN/LAlkS5QIqyaEEiuaw+aq6u
         LixoStQwyq04QLXTSmPDys2uR2TCA3/U4ubZVeqo0+ffYdGszIF/JuiUF8pvgOVMF504
         bucgsWzvisZPfQVRXgJJ/DepOGZ6EOyDovqUQumwdIltz0mDRkPY6TgbikvaFwRc9IC/
         xCRJ2taW6FATuHjTWctppSmYAU9kftlV3iq07JDkueaa5A1JhNnNBQe+iPBqWZakSHB1
         Ph7q8ACJfKXxN/XM0vHaWmI1DM0bldtPVV09gEvgJYJzcWe2ZHKnKqm53Qg+5kuWdYqU
         2xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539797; x=1688131797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itMAWlEVGbKwEk4rvkPhIkKoGJ+D+wP/v3giQWPxtxE=;
        b=N5FBHAM+kwY2G6DQYpVHdw8YkXJSM/93VmJZisKIDVl30rgQpkHKQxMjnYXOadE8JG
         9ICfgXsh/z8M+rT4euzJSX9q1lSTb6p2JXfrwd9DqlfdkGps+DxY/lWfkxQCxB5Fv42C
         TB9QgENBShk95susK9Z/wo1I7ZhqJBhhERRdEwsQUBauMvnSGtn9x4hhy7dho4tMUUJx
         Msi/VmI+q8V7aMqFR2HfdzXqK1+5O9+L91zyVcorhq3M6qOLlVnq41+L3qQq9Gs5JKP6
         IxIM2kP1EIYQoHZfw/6+WceEHjc7FsDjMe4ERjNEOAL1VCLFjHk6+WJV3y88H8UVGlSn
         Z8Yg==
X-Gm-Message-State: AC+VfDyqJSps2QEE8Vhj/I3YMCse+Dd/5GIjnloRANNZU/Fun13fBCoo
        DZUaet69rfoItoygJt01ZXLfNgu19FP1VTyKxRB3XQ==
X-Google-Smtp-Source: ACHHUZ4Py4Uo3YiGtvPZ/kUjXKdiyOhcEX0VVb0BTsQkmbteSEWWazQWYqFQhh8JSeV3efIYepXV/ugoOYAZMdYFtLI=
X-Received: by 2002:a25:addc:0:b0:ba8:4bc6:7918 with SMTP id
 d28-20020a25addc000000b00ba84bc67918mr6555542ybe.32.1685539796988; Wed, 31
 May 2023 06:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230530155501.222213-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230530155501.222213-1-azeemshaikh38@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 May 2023 15:29:46 +0200
Message-ID: <CACRpkdbf_biFPFC62uF1byXrMnK=0XbbBiZpJwT=GVnx5ZpP=g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Replace all non-returning strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 30, 2023 at 5:55=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.c=
om> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker:
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
