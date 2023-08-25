Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5101EE49B6
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjHYWM6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHYWMZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 18:12:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A052120
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 15:12:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5007c8308c3so2150567e87.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693001542; x=1693606342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiWB9v97HWraryvHTLxgc+CEYJjrfdQeQMgf9JwDwYo=;
        b=o1abNyuclFO15A/6/McYne+QOGIvn+XTYDY6EIdUqTY7Uv72XDgslSh4NIBvaPwrky
         VefCSgOlljqAYmvca33GNDESWnr8NjwUtptaxUI7HSp5I4f7L+qS8ObI9awr+xXDNFJq
         OT17UeWtSdtNMigelavMdMQ7qsP1EFFGutJfQN0MNi1kmp9XMF0h1UrQsw0nNm3O3rIH
         ZYGWjlbDXdumPqFAfFSlsc9NRMs0hEAIOp2L1WihyC94uiDt44DsNRdtNrdZm3UakEo7
         5UxbuKT6LL/v1kdfL2NOj0u8INTOOqDCuKNZ97EbAnejSfI2lXJlEgSOHvehrCVynpgk
         BPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001542; x=1693606342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiWB9v97HWraryvHTLxgc+CEYJjrfdQeQMgf9JwDwYo=;
        b=UBpJwwlAEYcCX6ECZ8r/rLQMmJhQxUiV+O4hodDmJ+ETza2wDOqr4s6Z06XrIhsjy3
         ZCNLweRCCeOmJEQTOlDbX4y0AbsG1ngvMXfqCP46Qu7J+pSGnnoMklRLkvkzwL/8myea
         rYp8aXcQzkm9ykozcfSSiNpjDzkVgSrozkQsKZgBM/XAJXgtgxkbCd91GM2Kswm4GLj9
         mshdNcb5pVLW6hkdMQIbZxPbXnJTRClGem8S91eH1Z7w1PIOKwUb8UIC1SSfKIuFVl/8
         kv5o3Q0IC/dWxtsru4t1hr+CIfspDsgr79/ko3f6/kaz+PgrYOsoaVfgj4Ut8V6w6o5u
         9J+w==
X-Gm-Message-State: AOJu0YxNtkfYO9in+KBf4ajuODkTc0at21x1+o57yNzvbg+RlOGds84Z
        qjJ1oHEOCM2zH7XwgFXRSO8l0nffXNAqRjNrWJDmYac/FR05JvzsttmbCw==
X-Google-Smtp-Source: AGHT+IEh37w7GhGca8NdEFatO+jxjw3lxK9RNgllGYwXHOM5rh3j9u6rw1eIsrbFwWS9IZn0hsI2lv3Fj8ImeK3KR9k=
X-Received: by 2002:a19:ca44:0:b0:500:90d1:90a6 with SMTP id
 h4-20020a19ca44000000b0050090d190a6mr7433122lfj.63.1693001541950; Fri, 25 Aug
 2023 15:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com>
In-Reply-To: <20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 25 Aug 2023 15:12:10 -0700
Message-ID: <CAFhGd8p-8a4SGQgcN=3LGA4Ju2tyxnkBf9yUTQSBpsXcZ12_7Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/goya: refactor deprecated strncpy
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

This patch as well as two other related patches were combined into a
single patch [1]

 Thu, Aug 24, 2023 at 1:49=E2=80=AFPM Justin Stitt <justinstitt@google.com>=
 wrote:
>
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]=
.
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
>
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-n=
ul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/accel/habanalabs/goya/goya.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/goya/goya.c b/drivers/accel/habanal=
abs/goya/goya.c
> index 7c685e6075f6..d0ac7065f3d7 100644
> --- a/drivers/accel/habanalabs/goya/goya.c
> +++ b/drivers/accel/habanalabs/goya/goya.c
> @@ -466,7 +466,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
>         prop->pcie_dbi_base_address =3D mmPCIE_DBI_BASE;
>         prop->pcie_aux_dbi_reg_addr =3D CFG_BASE + mmPCIE_AUX_DBI;
>
> -       strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
> +       strscpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
>                 CARD_NAME_MAX_LEN);
>
>         prop->max_pending_cs =3D GOYA_MAX_PENDING_CS;
> @@ -5122,7 +5122,7 @@ int goya_cpucp_info_get(struct hl_device *hdev)
>         }
>
>         if (!strlen(prop->cpucp_info.card_name))
> -               strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAM=
E,
> +               strscpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAM=
E,
>                                 CARD_NAME_MAX_LEN);
>
>         return 0;
>
> ---
> base-commit: f9604036a3fb6149badf346994b46b03f9292db7
> change-id: 20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-2a05a220=
2c78
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/r/20230825-strncpy-habanalabs-combined-v1-1-da=
a05a89b7e3@google.com
