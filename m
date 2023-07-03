Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B1BC001B3
	for <linux-hardening@archiver.kernel.org>; Mon,  3 Jul 2023 07:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGCHUu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 3 Jul 2023 03:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGCHUt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 3 Jul 2023 03:20:49 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C9E44
        for <linux-hardening@vger.kernel.org>; Mon,  3 Jul 2023 00:20:48 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b3a8635d80so394660fac.0
        for <linux-hardening@vger.kernel.org>; Mon, 03 Jul 2023 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688368847; x=1690960847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5wOEeEqZxs/53QPFBAeYmLrF3X4waeqXDqE1Qr5s1oo=;
        b=K4Fk0wgl41urJ973GedutT6AJySQVRpM7IEAeH1DL3A0K5cftuzCamKRTB9DPS99mD
         nA2nj+JvCX7ToqPkiXrqneN0AFk6tdTwfutFdtsVKkSIPottw7M/tR3AATLz4IgyfIl5
         3uIT+BmwDiCixsnU59nodSwDjHwYO1qhwePVV9/5uIAGIE8HgjGzSORacDRfTQN9o+A4
         RK189ThZg7KIFV/i1sqW4r2TYZBTb/6fmGM/KM32273ABzhuloTOaX+mqNyy/elVoy8H
         x0NV4f9dVSDnPrOCSmBeOuSYdtx92ccMK5jyz2fExYMyn5NXHnQPrd9uQwVYLUOJFjPO
         p98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688368847; x=1690960847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wOEeEqZxs/53QPFBAeYmLrF3X4waeqXDqE1Qr5s1oo=;
        b=gJ/OkvKWHe2dkn7fOYm14fuLhJGdiQEzs8mFxVuRSVui9bff0t1FN5Bk9w2GKxKnwQ
         SRCA8pps3/y9vjfkcZ15Zh6l3mymzWn1WmUpFhcRBHiAI0cMUjQdbggYu0ORsizrAw6K
         sSh2Wo3wTq6cpqJtP5PDsvcU/UEXYD4d1XrID6RntpDjDeA2eOwEESoCRJxwxFn2oDoJ
         A3EVUURf7B3mQ7Duy9o9HT++2Bh9e/WxRi+AwIr2K6DX6xxMvhvAC+8ds3Y4vM6NwyOf
         8j+6xDgM/SdTHEbmRxLjnMhP5KTZcNh7YBnSqMD4CvRws+lFDsEQpf26Ra6kxBgzBqTN
         nYPA==
X-Gm-Message-State: ABy/qLbz6wMktefSvCxztLOsi2Rq4fGhS3UKb86f+B5nO7S4H/Vv8rZQ
        lsphPRDAkVjsM6FwYxk46zh807oxYpo4qFahVVwuNw==
X-Google-Smtp-Source: APBJJlEb+AJ0CavHV/EY5o02uXm03FgkhsSGBahp5rgVjQwn4oDUf2oZLdvfrUiaO5BwJCpHYi9SurP9PwIS6yl4hW0=
X-Received: by 2002:a05:6870:f150:b0:1b0:3771:736c with SMTP id
 l16-20020a056870f15000b001b03771736cmr12943732oac.41.1688368847232; Mon, 03
 Jul 2023 00:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
 <CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com>
 <cacbbb02-732e-076e-50bf-292d20a4d722@quicinc.com> <58a26b9e-a48d-d567-c310-193a2c52521e@linaro.org>
 <5447f9f8-55b4-8bed-66a6-1c9d62b02c79@quicinc.com>
In-Reply-To: <5447f9f8-55b4-8bed-66a6-1c9d62b02c79@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Mon, 3 Jul 2023 09:20:35 +0200
Message-ID: <CAGE=qrq0CuO4J-6yC=YZ4xjL67o9QTqpei0ovX-X_8MLVeEH6g@mail.gmail.com>
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops binding
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 3 Jul 2023 at 08:22, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> On 7/2/2023 1:42 PM, Krzysztof Kozlowski wrote:
> >>> The big difference is if firmware is not deciding where this log
> >>> lives, then it doesn't need to be in DT. How does anything except the
> >>> kernel that allocates the log find the logs?
> >>
> >> Yes, you are correct, firmware is not deciding where the logs lives
> >> instead here, Kernel has reserved the region where the ramoops region
> >> lives and later with the minidump registration where, physical
> >> address/size/virtual address(for parsing) are passed and that is how
> >> firmware is able to know and dump those region before triggering system
> >> reset.
> >
> > Your explanation does not justify storing all this in DT. Kernel can
> > allocate any memory it wishes, store there logs and pass the address to
> > the firmware. That's it, no need for DT.
>
> If you go through the driver, you will know that what it does, is

We talk about bindings and I should not be forced to look at the
driver to be able to understand them. Bindings should stand on their
own.

> just create platform device for actual ramoops driver to probe and to

Not really justification for Devicetree anyway. Whatever your driver
is doing, is driver's business, not bindings.

> provide this it needs exact set of parameters of input what original
> ramoops DT provides, we need to keep it in DT as maintaining this in
> driver will not scale well with different size/parameter size
> requirement for different targets.

Really? Why? I don't see a problem in scaling. At all.

>
> >
> >>
> >> A part of this registration code you can find in 11/21
> >>
> >>> I'm pretty sure I already said all this before.
> >>
> >> Yes, you said this before but that's the reason i came up with vendor
> >> ramoops instead of changing traditional ramoops binding.
> >
> > That's unexpected conclusion. Adding more bindings is not the answer to
> > comment that it should not be in the DTS in the first place.
>
> Please suggest, what is the other way being above text as requirement..

I do not see any requirement for us there. Forcing me to figure out
how to add non-hardware property to DT is not the way to convince
reviewers. But if you insist - we have ABI for this, called sysfs. If
it is debugging feature, then debugfs.

Best regards,
Krzysztof
