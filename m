Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF663C41513
	for <linux-hardening@archiver.kernel.org>; Sun, 13 Aug 2023 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjHMK4o (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 13 Aug 2023 06:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjHMK4n (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 13 Aug 2023 06:56:43 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444611710
        for <linux-hardening@vger.kernel.org>; Sun, 13 Aug 2023 03:56:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so3345029276.2
        for <linux-hardening@vger.kernel.org>; Sun, 13 Aug 2023 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691924203; x=1692529003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nnCAXcHQ5YbbgyoTwMdYIMHDBrk3F+4fVGdkjI2OoZM=;
        b=iOuIxXiPcej0r67OfAA+KmyeRoR8tl1Qzg8AzJ+Q6x9HfQB9l/fmQ3m0RIawpKYpXI
         Fn+XK/OhY67bvUOpfo/L66cS1zHhXwod5sVb+GnOiMtbK1qXZ5l4QWLFxk464KaxWNls
         Rvm6cKFKFzjvRMXs2q774ImxcLW6otu+bVydg6MpW6Sd/fkE/AaKhbVXowUQyk1oWFA5
         ZoT0T9qJRLKbH1ED9KINRrajkDSFaowxHUTuwoV7LpqMpRNjjLNjkmmdnHMqzK74kzei
         QGf3Zr1v8fA0ZAOBqVp1tC0I9n7SUSCyozN/zv5rXTbdhpHddZQuL+XulTKa5EK0mL/p
         Cg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691924203; x=1692529003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnCAXcHQ5YbbgyoTwMdYIMHDBrk3F+4fVGdkjI2OoZM=;
        b=MZc6ynzkCDhrt22cF3Zd+aEPtrDZ/JYrOtfGf37XvDyT9YwL+TNIdT9BWR239fc0wK
         82QrfvXbQapHD+Uqlv89nDfsMlMX5/V/3EfJqgByOI6J1dafmjH23VyNWRRFgcseZM9C
         mvrfmZm7eaXermGc7hA7F6CQPXHGGstszzUJX1Jn4EpAlvUmls0Kpu0p5fe5xtCeUdJM
         C4TNm8Vn9pYYu7+jsfVIuC0HYyJKfX1yfsUOQY7OvEJdFy1Q5y2hJY2UiilNBv55Cibc
         noM0H1O6TucVrDEkV+xlnkMEvmAhnWm92RZaDgYtE8cnCR4zQylAyrcGjO0vF9YF7P2O
         8/KA==
X-Gm-Message-State: AOJu0YwFgKF6diwyYAXeEvN+D4t/DqHRJ7QDCqF5ehb8aIRUwjLmHYkR
        9c6hQ8RSZzokHjHlVZZlgUIaHDHvpXCXT+Rl39ICjA==
X-Google-Smtp-Source: AGHT+IFB1bUAZwI2DUr/FWaK8qZnieSurYZeAHm5xX+MszEu4nGhXFgKs4+dBfm5GfEVDJZKeulaCwIjwDWANu1uE6E=
X-Received: by 2002:a25:dad7:0:b0:d62:ba45:539f with SMTP id
 n206-20020a25dad7000000b00d62ba45539fmr6989446ybf.43.1691924203356; Sun, 13
 Aug 2023 03:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-1-0c384e8b5737@gmail.com> <244d165a-1e53-401e-be36-6bb3f4f260ae@linaro.org>
In-Reply-To: <244d165a-1e53-401e-be36-6bb3f4f260ae@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 13 Aug 2023 13:56:32 +0300
Message-ID: <CAA8EJpqiaEamZ6u9D_Sn-bgn8qdpqsQ2EMt7Tb9hKr5kNO2JFg@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: qcom: pmic_glink: enable UCSI for SM8350
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     wuxilin123@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 12 Aug 2023 at 14:12, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 5.08.2023 19:03, Xilin Wu via B4 Relay wrote:
> > From: Xilin Wu <wuxilin123@gmail.com>
> >
> > UCSI is supported on SM8350. Allow it to enable USB role switch and
> > altmode notifications on SM8350.
> >
> > Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> > ---
> I can confirm this is also required for my SM8350 Xperia 1 III.

Last time I checked it, UCSI was broken on the SM8350 HDK. Trying to
enable it caused pmic_glink to stop working after some port
operations.

-- 
With best wishes
Dmitry
