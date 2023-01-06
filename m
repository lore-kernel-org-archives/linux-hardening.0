Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7549C54EBD
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 22:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjAFW1f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 17:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbjAFW1T (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 17:27:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1D85CAA
        for <linux-hardening@vger.kernel.org>; Fri,  6 Jan 2023 14:27:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so2089597wms.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Jan 2023 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EMQOzwmfuRZl552G69+pCqsXxQZTt1N1oJx/8nrVhvU=;
        b=L8b6ctlnXzv5qRopWOZuNC8OcoxVT5s+SS1wp75LfHRZhMDwxxizVYWgi1QDlHRNeA
         qlZXTyp2cHOMXcPOO0t5U41sRF4VuYKyiE8Kv24cY9HoF19o5q5CXOMu+l+rbtqDukgS
         Xh1URH2uJq18iu/KgMLYx3WQWEl1vk41h0jfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMQOzwmfuRZl552G69+pCqsXxQZTt1N1oJx/8nrVhvU=;
        b=wami/ANKlf9HTNzwb5fiW2hmKdeIV81Wc4EpiMyXilD2p8r6qMzmtabTR1w8ixAYkq
         wrl9xg030ShRp/SpfoEo5WPajIe9YL4eBf9oKBGGHtZXOYUOVrr5b9qIgxUmef8ZN252
         bV0pFqyeMJl6s5IJ+R7ziGJfUP4lcHd5JMJ5R01TBgIO4dRvl7ArLAYPF9kvuYrHDbJ/
         xS1nJ38ihARI02Dp3FYy/xbaEde5E+dFXV1R1eT2be0tj5vcL71nSJ3lJdVvaykunoyB
         mntQ8VHiUNqTbKqvMgxKoKCRcDXxHWQ4g7E4yfGQhJAki06N1tN3JWFF2Iaujjx+ZCFo
         eouw==
X-Gm-Message-State: AFqh2kqkLBSPMbSQTZejDMt8YxYd0fobgefFfuEHlustLgvntbYQFfFf
        c2pzQtAMJbY+XXnFiEy9wHHh6rW6gqqU3Bhh+fCH8g==
X-Google-Smtp-Source: AMrXdXvGiqtx4OP9tf7Dg1vIM7dQN3Foq/M6hy40hKYPkPEposJNKfVCPl63IUt5Wc2pxvHBEfkGB8T3Z11tjmWnEmI=
X-Received: by 2002:a05:600c:4153:b0:3c6:c182:b125 with SMTP id
 h19-20020a05600c415300b003c6c182b125mr3731572wmm.145.1673044036338; Fri, 06
 Jan 2023 14:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20230106045327.never.413-kees@kernel.org> <CAODwPW8kXZ107kMuVGya9Y=i+8QwQzQHokXCpybzMBjd_w_83w@mail.gmail.com>
 <202301061234.D15CF0E627@keescook>
In-Reply-To: <202301061234.D15CF0E627@keescook>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 6 Jan 2023 23:27:04 +0100
Message-ID: <CAODwPW9bM8+V+JphjpNHS9YRmb+AXNQUi+VRjORkGZP6gY=ynA@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Check size of table entry and split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Yeah, exactly. Isn't that a bit simpler? (I wasn't aware of the
flexible array member in union issue, but it sounds like we have a
neat solution for that already.)

On Fri, Jan 6, 2023 at 9:35 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 06, 2023 at 04:03:35PM +0100, Julius Werner wrote:
> > Have you considered adding the flexible array member directly to the
> > union in struct coreboot_device instead? I think that would make this
> > a bit simpler by not having to copy header and data portion
> > separately.
>
> Are you thinking something like this?
>
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
>
> --
> Kees Cook
