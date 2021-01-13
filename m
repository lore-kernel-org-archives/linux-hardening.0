Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B4C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4692339F
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Jan 2021 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbhAMRKN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Jan 2021 12:10:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbhAMRKN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Jan 2021 12:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610557726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dBJZ81CGbY/T2uu6zdnM2l18Be2O3areGBYQ7b4wX0E=;
        b=ThQu634AbRQQ7ZEpfC3wAR8prKHlCD5jeS/QN+/EBemBvsMHHjxQ76FB0v1UUe/kj7mZqS
        HpOO7wJbdoiztXSXPzKKsbOOzci51yMHR0O8bEQSMIiyzwHQHbGW5OBtWiwbNdXxlQtCAu
        RvF7+E6LaiJ8fhoWgTLGHufHidINDek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-DFo3Y19-N3Gx7znpD8ULnA-1; Wed, 13 Jan 2021 12:08:43 -0500
X-MC-Unique: DFo3Y19-N3Gx7znpD8ULnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6C5107ACFB;
        Wed, 13 Jan 2021 17:08:42 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C183E5D9DD;
        Wed, 13 Jan 2021 17:08:41 +0000 (UTC)
Date:   Wed, 13 Jan 2021 11:08:36 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gcc-plugins: fix gcc 11 indigestion with plugins...
Message-ID: <20210113170836.xvlq5xlmkjpi4zx7@treble>
References: <38485.1610500756@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38485.1610500756@turing-police>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 12, 2021 at 08:19:16PM -0500, Valdis Klētnieks wrote:
> Fedora Rawhide has started including gcc 11,and the g++ compiler
> throws a wobbly when it hits scripts/gcc-plugins:
> 
>   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> In file included from /usr/include/c++/11/type_traits:35,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
>                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
>                  from scripts/gcc-plugins/gcc-common.h:7,
>                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
>  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
>    32 | #error This file requires compiler and library support \
> 
> Patch is more complicated than would otherwise be needed, because
> older gcc (4.9, 5.4) have gnu++11 but throw an error due to a gcc bug
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index d66949bfeba4..cc779973724a 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -21,10 +21,13 @@ always-y += $(GCC_PLUGIN)
>  
>  GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
>  
> +# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
> +GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
> +
>  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
> +		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
>  		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
> -		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
> +		   -ggdb -Wno-narrowing -Wno-unused-variable \
>  		   -Wno-format-diag
>  
>  plugin_ldflags	= -shared

The first patch has already been merged into Linus' tree, so this
probably should be an incremental fix on top, with a Fixes: tag.

-- 
Josh

