Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE63EC874C
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Sep 2023 18:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbjIGSRz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjIGSRs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 7 Sep 2023 14:17:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C11BC7
        for <linux-hardening@vger.kernel.org>; Thu,  7 Sep 2023 11:17:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a64619d8fbso154811566b.0
        for <linux-hardening@vger.kernel.org>; Thu, 07 Sep 2023 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694110639; x=1694715439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDPtIqRa9KhP+Q4GO0CUVTyJACCkZW6CDP5L78rGp/8=;
        b=CRO78rZP0W+O3ZB94RaO58PLoBnJw2u03Rdp9VCRtGFe3v3Nno64teEAZ4vdeCZ5xT
         stPX6cpw8V/ElI0bFYEA6A+OECkWEP0Kj7Vfm2599v4985XeceTAAERmAXR+KfLxyWdT
         NqJFDr7UCFbIZiGGSIWhnV/UM5RHKagcDFV8vo7+mGldgKAI/yzkwMXUb72CJs5UeI/T
         ZpHu+Ws5IApWIbbxNpGgDfkWkFZT70RMn9V5zPxSGT3yO6c0Xo6vnQ5QUuvSdnfHN+kB
         zS6p6y5vnVvDyRDLt8474aZaKJSBFep9Y7g0rrDO1Kl2R7iSMe6ZQClIt24ma/dR0X8x
         kyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110639; x=1694715439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDPtIqRa9KhP+Q4GO0CUVTyJACCkZW6CDP5L78rGp/8=;
        b=AtKH4n9+NxQsFKhUSPRRxput6Rmo6MIe5mt9ZNGZ0TfOlKJIbKKl8uLv/yvfx2zlyU
         GjOYtkwYcQsJy7scKrYXiQ0iy6WMvP0RC+NlSvi0CisU6Du4An/WLcMOYCsBeAZ5fWFo
         Jpp+AVIOABzl3sS+XKqQWf0XYSfx8MrymS1A4Nujk9GtAAhYD2wGWYh1qCDvCeLRavCT
         u7ryqa/nlyNC++Q7YRnzVpv0fRbIa8KrUSU2XPwURDD63cHv//BUSBrDYevGIr0jNl0u
         BqRXy5VkzXt2JwtpvOcLvfZWTjcw0uC2QxzOJuU16bR3QRRgkSkwLg+le1TuCauwJ3iD
         JZ0A==
X-Gm-Message-State: AOJu0Yz4PgQXqtu8m11CHgUoG1DuEl/SPP+bW1Aj17/OalT8/RKI43O2
        pp4WVTiPR9rpyw0DxsYc+T8fS14U2kgauGEapESYoQ==
X-Google-Smtp-Source: AGHT+IFG1xSKke0CRIQjuPuE+RTs8E4Z46EDtLFpNt/QqqoWQcSA8uhvKIJ7x4JGRAP/N6MiFolen7PkHPuoysGq2pw=
X-Received: by 2002:a17:906:10dc:b0:9a2:eb6e:2cf1 with SMTP id
 v28-20020a17090610dc00b009a2eb6e2cf1mr139764ejv.5.1694110639377; Thu, 07 Sep
 2023 11:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com> <f08f590a-df05-4d83-984f-41b4d60af971@kernel.org>
In-Reply-To: <f08f590a-df05-4d83-984f-41b4d60af971@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 7 Sep 2023 11:17:08 -0700
Message-ID: <CAFhGd8pMeTuvn_OqzYtRbfAM7L_-Jb_hFA4WY0hMap_eG=F7RA@mail.gmail.com>
Subject: Re: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
To:     Konrad Dybcio <konradybcio@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mostafa Saleh <smostafa@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 7, 2023 at 10:37=E2=80=AFAM Konrad Dybcio <konradybcio@kernel.o=
rg> wrote:
>
>
>
> On 5.09.2023 22:10, Justin Stitt wrote:
> > strncpy is deprecated [1] and should not be used if the src string is
> > not NUL-terminated.
> >
> > When dealing with `cmdline` we are counting the number of characters
> > until a space then copying these over into `buf`. Let's not use any of
> > the str*() functions since the src string is not necessarily NUL-termin=
ated.
> >
> > Prefer `memcpy()` alongside a forced NUL-termination as it more
> > accurately describes what is going on within this function, i.e: copyin=
g
> > from non NUL-terminated buffer into a NUL-terminated buffer.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> Hi,
>
> some form of this patch [1] went into -next and it broke booting
> on at least the Qualcomm SC8280XP-based Lenovo Thinkpad X13S.
>

Thanks for the heads up! The previous versions of the patch (including
the one that was applied) had some errors. This patch should be good
and Will is looking to apply it to arm64 fixes tree.

> Konrad
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dd232606773a0b09ec7f1ffc25f63abe801d011fd
