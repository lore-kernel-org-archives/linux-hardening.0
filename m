Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E400EE49B4
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 22:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjHYWNc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjHYWNN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 18:13:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1526B8
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 15:13:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so3018190a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693001590; x=1693606390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRGLhCJxk2YfYhkw71kLVJLLsM+bnOcMS87gS/EBB2k=;
        b=B1jyrIcDb5DFQ48F/wCw3Jn5c7WHjXuwf5BP1lJtcMO+KVxCfURnBNUQcgZinLsSG4
         MWWmbKrsLRZ7d2z2GYjUZrbwSkUZ+uiL4VORl65hWJcy05qfidHY5FhdbTu02H1duxsu
         dBkaVaFu2jF2Z/V1zI5ILQ5REyW0NvlittLUsR8TOk4AttvI4Nw4dxClmD9XbFIH6wH3
         0daKqwS9GEGTwFOZt+Cg4twvoIxR0oXUJoOq+WscXB2P0F+FfOuRfsNRuc05V2rI3jOJ
         clxqpmVRw4KHhMKIL84kO8kfVOxYhyyImaKXawwnkgeYJPDnwmNFUvzBrj3g8XuumtTN
         nHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001590; x=1693606390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRGLhCJxk2YfYhkw71kLVJLLsM+bnOcMS87gS/EBB2k=;
        b=QQ4jdZ3b7srg9jVyor2pjTClF7XZNnmDb+RnFeVXYOBwR4PKUsof6CGj0YJNK1A7mB
         vqeID/cdwpDyBSzGINzl8ezyRh0qHih/LkttW8sKxtpVsXP2ovQ2prrWnJu8/Tzmk/H0
         lqUrEvBizkI+BUgoZGGm52D3kEATp+80bJPdD5I7GFNPxU/Rr4XTsNcWhLImQCYDUxrn
         bXD9NdYAAGA4HpaMFKS5fZBQrZNvS93EFJkYsY0uGpBMOFUZL9aQbd9J6GzFlhPVvsl9
         aL0qh0caaAHgVZ6FUfpWRaNinHLyErtQDMNbWPh89QiVM/dmMRe3gEwpML5vHtNwFR31
         l1fQ==
X-Gm-Message-State: AOJu0YzGNpn1c9729dxrVO9BEi9+6GOdLCDMQOer+a1jswyosniFIsIo
        jH1eV54mLzxgS3yMnz6na5QYmp301diG3Wq5uT6j6Q1QYReiAemkzPMOeA==
X-Google-Smtp-Source: AGHT+IGCmYRo7hllh+m7oORH9Z9Xh45QNBFb7h4WVFR4TG7CAw4ipcinmyISbGr6gmCiXUWeRCLxdyZgBaPZPc7K9kI=
X-Received: by 2002:aa7:c384:0:b0:522:4764:8baa with SMTP id
 k4-20020aa7c384000000b0052247648baamr20833831edq.12.1693001589840; Fri, 25
 Aug 2023 15:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com>
In-Reply-To: <20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 25 Aug 2023 15:12:58 -0700
Message-ID: <CAFhGd8r1ADbYRg2dF5wwS4Tf1Worv-zR6CTrzBPHxQO2YAiWQA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/gaudi: refactor deprecated strncpy
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

On Thu, Aug 24, 2023 at 1:41=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
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
> Note: build-tested only
> ---
>  drivers/accel/habanalabs/gaudi/gaudi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/haban=
alabs/gaudi/gaudi.c
> index 056e2ef44afb..f175456cdef0 100644
> --- a/drivers/accel/habanalabs/gaudi/gaudi.c
> +++ b/drivers/accel/habanalabs/gaudi/gaudi.c
> @@ -660,7 +660,7 @@ static int gaudi_set_fixed_properties(struct hl_devic=
e *hdev)
>         prop->pcie_dbi_base_address =3D mmPCIE_DBI_BASE;
>         prop->pcie_aux_dbi_reg_addr =3D CFG_BASE + mmPCIE_AUX_DBI;
>
> -       strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
> +       strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
>                                         CARD_NAME_MAX_LEN);
>
>         prop->max_pending_cs =3D GAUDI_MAX_PENDING_CS;
> @@ -8000,7 +8000,7 @@ static int gaudi_cpucp_info_get(struct hl_device *h=
dev)
>                 return rc;
>
>         if (!strlen(prop->cpucp_info.card_name))
> -               strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NA=
ME,
> +               strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NA=
ME,
>                                 CARD_NAME_MAX_LEN);
>
>         hdev->card_type =3D le32_to_cpu(hdev->asic_prop.cpucp_info.card_t=
ype);
>
> ---
> base-commit: f9604036a3fb6149badf346994b46b03f9292db7
> change-id: 20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-f0b581=
4ced38
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/r/20230825-strncpy-habanalabs-combined-v1-1-da=
a05a89b7e3@google.com
