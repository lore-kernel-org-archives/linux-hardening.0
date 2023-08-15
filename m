Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EA6C41513
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Aug 2023 08:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjHOIdA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Aug 2023 04:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjHOIcn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Aug 2023 04:32:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2534F10C0
        for <linux-hardening@vger.kernel.org>; Tue, 15 Aug 2023 01:32:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d67869054bfso3362167276.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Aug 2023 01:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692088361; x=1692693161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZAjQaDsCnRIDl9aQDrjmakMDdJ/kCnfJXWB5dbc3P0=;
        b=jYzRlm8JrziIQLzbP27Eefb+wVJdzOl3JqzSe3PNIOYqLaKHZUWEy8e/X2fPr+dphU
         p6H9WmsjA2NybRl5eoDqM0GBn1gzJhFFsmwJhHcKIJS9zl27YI/l0zmJb4O86z4xLXxZ
         tgE+X4lz+6fZGHoHHcXKawTyxtRQhKYJ/NjzWbCcoGN9jlE4qc34bbdiSZcTZzgULxMq
         iengflFRIFh8HSYfL01OC+8mFf4NDiebrNruLerEws8bjSpp5vFiE6dcr8X1fAxt9Zz6
         9lkk0OdZF0mKHuYHRL3q1vJqTfz8B9hVvBqSDPYYnp7dOJGMV8An7JXlIRqAHxkmyh4U
         jffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692088361; x=1692693161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZAjQaDsCnRIDl9aQDrjmakMDdJ/kCnfJXWB5dbc3P0=;
        b=JXGrkJtQv4RVtmBXvOBmeE4qCwiMxZE0wh9Kz6q9oNWY9rVm7Sj2+SXAyjqVhnCDG4
         ujNfsw/4Hm5VIlCxSV0+zzADCjJ6IvoC8cC2pnWjMpFylNWa9JkzF3beCJVuYohr9uZN
         ePGYAZLdU2c1fv0kmgP6kc6XjZC7bTxXtJ6uhJEC8dv4cJLjVr8BFOrBzuuW5jaHojKa
         wQeulvzkRXuXLKMMYzOsEepFV2kqLME5dfKZNRjSKOLt9LtpgYktKeZ0+sv2ND97AVkI
         hOlqHhtZ4mPs4Sv+KjQPcdQaQfgwLt2g2t4izOy4mxugPbsbQ+pbfRFxlsfIk8YMxC3o
         ac/w==
X-Gm-Message-State: AOJu0YwBVOtW3fO0p9FWxCYYF92cdQloXNCDY+yKvj/mxpIdIxhvsfz6
        WfJV0KEui97gi6XBfkbRj/FT8aGYbHOXDz4RoxgnZw==
X-Google-Smtp-Source: AGHT+IG0H51wCa6PmYWPCyxguFPsNbhjv2lmrIY2yYx1KK/MZ8UDuaCPbLbx4vhaQopqGxG8q0rHVd4001OjOPyHkZA=
X-Received: by 2002:a25:b85:0:b0:d12:25d:fd5f with SMTP id 127-20020a250b85000000b00d12025dfd5fmr12359370ybl.5.1692088361388;
 Tue, 15 Aug 2023 01:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230812-pxa1908-lkml-v5-0-a5d51937ee34@skole.hr> <20230812-pxa1908-lkml-v5-1-a5d51937ee34@skole.hr>
In-Reply-To: <20230812-pxa1908-lkml-v5-1-a5d51937ee34@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Aug 2023 10:32:30 +0200
Message-ID: <CACRpkdbFz-huUHkECKvJec3CpnOjKsu+MJA2ajoAbh1opjtr9A@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] gpio: pxa: disable pinctrl calls for MMP_GPIO
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Aug 12, 2023 at 12:26=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovi=
c@skole.hr> wrote:

> Similarly to PXA3xx and MMP2, pinctrl-single isn't capable of setting
> pin direction on MMP either.
>
> Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and reque=
st")
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
