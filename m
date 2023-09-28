Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23719CA6A
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 21:45:07 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563E199
	for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 14:45:05 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59e77e4f707so165831207b3.0
        for <linux-hardening@vger.kernel.org>; Thu, 28 Sep 2023 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695937505; x=1696542305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d53VmuoWKktNI02x/f4SVOnb4OpZ9AYZl6S7M2mENOQ=;
        b=nzty1U2pWLvDqcpqJ94rU6HFEx3DmdPGnkI/X/B6+uoyETWQgoH7gxY4dLSiQ6D3qv
         JXvoVUz/PkK8s601b7l6pG8fGZ0CYYPO3oet9Xycc8voX15G8ay6eh4f8WMRzxSGm/Vj
         /InXsaVuxKp/ND3f4oxcHNTrw7okKArHQ/vsr+nmsvWc1EzZE4fdM1u8AeNtR8CvlR8J
         udfTBaP3g9x7xgVfFe6al9fVs4XqCQPBj7iLuevmdt2IkO2TURezw6W24HHYlTHfqlUI
         jhCIc+rSDKRxtaakqqic3q4Q+ZIYa0EIvbxonMWQf/dOSMjvyI9LCEzPJy8FcrpoPsam
         6Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937505; x=1696542305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d53VmuoWKktNI02x/f4SVOnb4OpZ9AYZl6S7M2mENOQ=;
        b=djwCaHycGKleZQ7t2JlCUKHoIlL3enpzj17HwZmkPvZoXoiMobgl/tr7llV8tVf5jA
         3nbz5cM9rfyl0K+2Bko0gyGfkxjVTiIdTp7I7RyCGwnfHuLGyGeXBO6SehX5TcjDeArQ
         1/sBVTlmDpYh6tr2zJ8kzS4BRfr9Ip308RZHN/xtDGBUghlOCl9B/TDfqDYc2hLkF6BD
         z26fdXX3SuqaVD5iQcXDzjUPe9bIPokPkwsVqU+Uy/9Zvuk8J5aJc7MzUTnXU5giulFz
         sFVxBGvTmZxq2wtsyP4tf3v0CAt6GnrZ0cemk7VWghI2f9MbQQF+GjtkfJfiUBao6RF8
         DLWA==
X-Gm-Message-State: AOJu0Yxj53RI7yHd3SgssLHaktt8TOf4R6WOwkQXt/J7PzoBZhLvbRB4
	BTdfir8/hTh5UEeCfXujwUBsF2PWIzS97HXq91p/zA==
X-Google-Smtp-Source: AGHT+IFmD0TeY/RAzzjpTHUvmIzABRZnRZfjdrG+rUh84QC2EVS0feP28y/RWjO81DOkItfuirnotVhBhAFKqW22Cd8=
X-Received: by 2002:a81:72c5:0:b0:59b:2458:f612 with SMTP id
 n188-20020a8172c5000000b0059b2458f612mr2417694ywc.28.1695937505000; Thu, 28
 Sep 2023 14:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927-strncpy-drivers-mfd-db8500-prcmu-c-v1-1-db9693f92a68@google.com>
In-Reply-To: <20230927-strncpy-drivers-mfd-db8500-prcmu-c-v1-1-db9693f92a68@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Sep 2023 23:44:53 +0200
Message-ID: <CACRpkdaPvDFvxSVHeLZ3Bxx5yVH3LN1OOpGm78cJ+wp7q3C+Vw@mail.gmail.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: replace deprecated strncpy with strscpy
To: Justin Stitt <justinstitt@google.com>
Cc: Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Justin,

thanks for your patch!

On Wed, Sep 27, 2023 at 7:10=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:

> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect project_name to be NUL-terminated based on its use with
> pr_info:
> |       pr_info("PRCMU firmware: %s(%d), version %d.%d.%d\n",
> |               fw_info.version.project_name,
> |               fw_info.version.project,
> |               fw_info.version.api_version,
> |               fw_info.version.func_version,
> |               fw_info.version.errata);
>
> Moreover, NUL-padding does not seem to be needed.
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Let's also change `PRCMU_FW_PROJECT_NAME_LEN` to just
> sizeof(fw_info.version.project_name) as this is more idiomatic strscpy
> usage.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Well analyzed, well patched, what can I say! Hats off.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
