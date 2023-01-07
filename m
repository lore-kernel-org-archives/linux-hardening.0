Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A3C46467
	for <linux-hardening@archiver.kernel.org>; Sat,  7 Jan 2023 04:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjAGEjV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 23:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAGEjU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 23:39:20 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220B84629
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 20:39:19 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id a64so3514831vsc.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 20:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=soxPkCXSgF66wtzGQPY+AblCoXmgckFkRYZ+m8JoLcs=;
        b=XaMCznScnyS2mvU02NMSHL9Fjvnrbj9pBDlhXknXEhwbo8/JaE4/8Qc0Yvu3vvHy9z
         qRRicRpMMcd5nu2GFyxkQV4EvNvpS1VBwwsqMrPEn3nqUgSlZZN065iNpkLDuKGGlW01
         h3NWlJa2tu2QwiBEqXRm1Iip/53l4Dcw19H5ww2LDLQha8TaVpRidpjym+URsj8aEO5h
         dpXynh4s7xX6F1eXSjRbMR8IN9aMB5irVf9QDwYPJPvL19wcBdsTCTXm8d6T4TDhcTih
         7UraAehyw5d4IaYtvgNCpvm5U9qDL7Ho2DGystANQaKMIP9BmWq7Tf29TFi2mYD8k8Io
         Sk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soxPkCXSgF66wtzGQPY+AblCoXmgckFkRYZ+m8JoLcs=;
        b=RCXDqkbB+4wedbQ6nEUfXQQ4o46tkWVYByGs8Bstbda7cWlnzqMT/7lUpZON+jfJUH
         FR5wt/zwmLlCpNoFBWuKybacJL+uUVnakcCHd8B8C52GbIDOX/p2/pyOsOqafLxovyty
         aaUxouvQCXoVO4UG5rim7AOwFDYRiBQmrOzhf1+p6IRxLmetQaS5EmCCd4hKGDjkVtFy
         VxvswTzTiDZzrMn/7yTXE5dtMW57RkCu+mhJTIzOXflAfoJz/a81S3wUyfMYTsrRv7Jv
         lYhiVmCRmfSOKBwibCyDKSuq5Gs/fY3lR4H1dRpwnX+t37HmHuieDKauLXUOYQMeKH46
         KQXA==
X-Gm-Message-State: AFqh2krZMpD4EJU5eVf+zRCLXVZCOtN6H6Maw48rpIVleJNMrVIvP/Tb
        tJyZVwunsxDcRWLK1phQgxu81qDh2galr7XadZzs6w==
X-Google-Smtp-Source: AMrXdXtEwkNBrCD3dpAe8T6gjukdKQRc59k38VHtyEyhN7uFj+ljim3SvU0JbYzWgOg/PECYH8yl/ajKIvGbuKtYN8k=
X-Received: by 2002:a05:6102:f8c:b0:3c9:8cc2:dd04 with SMTP id
 e12-20020a0561020f8c00b003c98cc2dd04mr5292950vsv.73.1673066358124; Fri, 06
 Jan 2023 20:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20230107031406.gonna.761-kees@kernel.org>
In-Reply-To: <20230107031406.gonna.761-kees@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 6 Jan 2023 20:39:06 -0800
Message-ID: <CABXOdTfENiCZF-G4TW7=hy7eVJSQJ5t63GzW4_mtezZzTs+18g@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: coreboot: Check size of table entry and
 split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 6, 2023 at 7:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> The memcpy() of the data following a coreboot_table_entry couldn't
> be evaluated by the compiler under CONFIG_FORTIFY_SOURCE. To make it
> easier to reason about, add an explicit flexible array member to struct
> coreboot_device so the entire entry can be copied at once. Additionally,
> validate the sizes before copying. Avoids this run-time false positive
> warning:
>
>   memcpy: detected field-spanning write (size 168) of single field "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/all/03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de/
> Cc: Jack Rosenthal <jrosenth@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> v2: move flex array to struct coreboot_device (julius)
> v1: https://lore.kernel.org/lkml/20230106045327.never.413-kees@kernel.org
> ---
>  drivers/firmware/google/coreboot_table.c | 9 +++++++--
>  drivers/firmware/google/coreboot_table.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index 2652c396c423..564a3c908838 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -93,14 +93,19 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
>         for (i = 0; i < header->table_entries; i++) {
>                 entry = ptr_entry;
>
> -               device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
> +               if (entry->size < sizeof(*entry)) {
> +                       dev_warn(dev, "coreboot table entry too small!\n");
> +                       return -EINVAL;
> +               }
> +
> +               device = kzalloc(sizeof(device->dev) + entry->size, GFP_KERNEL);
>                 if (!device)
>                         return -ENOMEM;
>
>                 device->dev.parent = dev;
>                 device->dev.bus = &coreboot_bus_type;
>                 device->dev.release = coreboot_device_release;
> -               memcpy(&device->entry, ptr_entry, entry->size);
> +               memcpy(device->raw, entry, entry->size);
>
>                 switch (device->entry.tag) {
>                 case LB_TAG_CBMEM_ENTRY:
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
> index 37f4d335a606..d814dca33a08 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -79,6 +79,7 @@ struct coreboot_device {
>                 struct lb_cbmem_ref cbmem_ref;
>                 struct lb_cbmem_entry cbmem_entry;
>                 struct lb_framebuffer framebuffer;
> +               DECLARE_FLEX_ARRAY(u8, raw);
>         };
>  };
>
> --
> 2.34.1
>
