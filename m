Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E069CC25B0E
	for <linux-hardening@archiver.kernel.org>; Tue, 16 Aug 2022 12:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiHPMSB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiHPMRm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Aug 2022 08:17:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BFD77540
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 05:14:36 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s11so7905260qtx.6
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yhRepLOuTqhC1k9FZzrru2j5eZeHN5AMK0pdGwM28xw=;
        b=YoF9dm6yH1cSrDTScq/KLos6Pb0xCjNlhR7PNPwkiYizA5rZ9sTI/6ASizOeRePrIt
         vdk901fZZ1JI8CXEWNZ5vxjosCVOcWtBBSrEG+IbYs8vvCMV1845yZmxiuOc6G+Bf71F
         oK9JqQ9ZF1haq8DpqeBUHhT/ISij/N8Mirvmti28VeHrrbc0CdxXfDf2vv4lSsVrOkUG
         EJah+geQUTMJmzKPIEmaNx5Tn8JJOCL+t+HStEFKnTyt3GOId86oYNeeVbafzPITyy54
         B2xAFn8hCgR2Ca25OI5Lf3N+Q4RLgOEro/CuAap1UPFqdEiKLXcYVyoOMBjN5cvR9atG
         okGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yhRepLOuTqhC1k9FZzrru2j5eZeHN5AMK0pdGwM28xw=;
        b=wcK4v7DMpBx+mb+Y4tkgC7teTZ6SpN8LB3xPIKjAVkR6VFo12LSOI0hwQw2rVI4BtH
         ROgX3S7ZxqTizTW12RkSEFTQaLBm8Ec5hoMn2FrkPOa/YIPncT9u6w9qHpf33IIhMgBL
         FhrgIIwZtxAWj/dbOVv7TnJ84R5/7HcrI7WnaWOscEB88YJ+8nYmYCCWbfSAUVKYQJPl
         2Z7SUH4WbhLvAlO2Ic4Vgbaw+lsLt/Yr8c7fFeIECSdO7aYT6HMBzwJ/MwCoygTg2eY7
         ReclRoBveWSXnEmq5seddyvfTfkjuFn/oveCPeRyFMxJrWXNmtV41lrUqCXhjUbhzwX9
         7t+g==
X-Gm-Message-State: ACgBeo23SCyudLTM+a5f+n71F4rGhu5n9Vn0Lt994mISYnmkcBffGkZb
        qvjt0XENYqzlaSCiFdwkLtk=
X-Google-Smtp-Source: AA6agR4iukqv2XH/ykJObpRXWAXyBdFlc5IsXFpY0lEsNEPLqNCWeW+sMlqunle/62PcnUcUJt+VlQ==
X-Received: by 2002:a05:622a:447:b0:31e:ea5d:34c2 with SMTP id o7-20020a05622a044700b0031eea5d34c2mr17440034qtx.604.1660652075633;
        Tue, 16 Aug 2022 05:14:35 -0700 (PDT)
Received: from localhost ([98.242.65.188])
        by smtp.gmail.com with ESMTPSA id b32-20020a05620a272000b006bb296e3298sm5510964qkp.20.2022.08.16.05.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:14:35 -0700 (PDT)
Date:   Tue, 16 Aug 2022 05:14:34 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Emese Revfy <re.emese@gmail.com>,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] gcc-plugins: Undefine LATENT_ENTROPY_PLUGIN when plugin
 disabled for a file
Message-ID: <YvuKKngQ/l24+7rH@yury-laptop>
References: <20220816051720.44108-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816051720.44108-1-ajd@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 16, 2022 at 03:17:20PM +1000, Andrew Donnellan wrote:
> Commit 36d4b36b6959 ("lib/nodemask: inline next_node_in() and
> node_random()") refactored some code by moving node_random() from
> lib/nodemask.c to include/linux/nodemask.h, thus requiring nodemask.h to
> include random.h, which conditionally defines add_latent_entropy()
> depending on whether the macro LATENT_ENTROPY_PLUGIN is defined.
> 
> This broke the build on powerpc, where nodemask.h is indirectly included
> in arch/powerpc/kernel/prom_init.c, part of the early boot machinery that
> is excluded from the latent entropy plugin using
> DISABLE_LATENT_ENTROPY_PLUGIN. It turns out that while we add a gcc flag
> to disable the actual plugin, we don't undefine LATENT_ENTROPY_PLUGIN.
> 
> This leads to the following:
> 
>     CC      arch/powerpc/kernel/prom_init.o
>   In file included from ./include/linux/nodemask.h:97,
>                    from ./include/linux/mmzone.h:17,
>                    from ./include/linux/gfp.h:7,
>                    from ./include/linux/xarray.h:15,

As a side note, xarray can go with gfp_types.h instead of gfp.h

>                    from ./include/linux/radix-tree.h:21,
>                    from ./include/linux/idr.h:15,
>                    from ./include/linux/kernfs.h:12,
>                    from ./include/linux/sysfs.h:16,
>                    from ./include/linux/kobject.h:20,
>                    from ./include/linux/pci.h:35,
>                    from arch/powerpc/kernel/prom_init.c:24:
>   ./include/linux/random.h: In function 'add_latent_entropy':
>   ./include/linux/random.h:25:46: error: 'latent_entropy' undeclared (first use in this function); did you mean 'add_latent_entropy'?
>      25 |         add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
>         |                                              ^~~~~~~~~~~~~~
>         |                                              add_latent_entropy
>   ./include/linux/random.h:25:46: note: each undeclared identifier is reported only once for each function it appears in
>   make[2]: *** [scripts/Makefile.build:249: arch/powerpc/kernel/prom_init.o] Fehler 1
>   make[1]: *** [scripts/Makefile.build:465: arch/powerpc/kernel] Fehler 2
>   make: *** [Makefile:1855: arch/powerpc] Error 2
> 
> Change the DISABLE_LATENT_ENTROPY_PLUGIN flags to undefine
> LATENT_ENTROPY_PLUGIN for files where the plugin is disabled.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Emese Revfy <re.emese@gmail.com>
> Fixes: 36d4b36b6959 ("lib/nodemask: inline next_node_in() and node_random()")

I think it rather fixes 38addce8b600ca33 ("gcc-plugins: Add
latent_entropy plugin").

For the rest,
Reviewed-by: Yury Norov <yury.norov@gmail.com>

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216367
> Link: https://lore.kernel.org/linuxppc-dev/alpine.DEB.2.22.394.2208152006320.289321@ramsan.of.borg/
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  scripts/Makefile.gcc-plugins | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 692d64a70542..e4deaf5fa571 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -4,7 +4,7 @@ gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= latent_entropy_plugin.so
>  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)		\
>  		+= -DLATENT_ENTROPY_PLUGIN
>  ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
> -    DISABLE_LATENT_ENTROPY_PLUGIN += -fplugin-arg-latent_entropy_plugin-disable
> +    DISABLE_LATENT_ENTROPY_PLUGIN += -fplugin-arg-latent_entropy_plugin-disable -ULATENT_ENTROPY_PLUGIN
>  endif
>  export DISABLE_LATENT_ENTROPY_PLUGIN
>  
> -- 
> 2.30.2
