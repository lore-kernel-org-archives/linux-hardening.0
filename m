Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D7BC433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Jan 2021 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B30A60C3D
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Jan 2021 20:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhA0UQ0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Jan 2021 15:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhA0UP7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Jan 2021 15:15:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E3C061756
        for <linux-hardening@vger.kernel.org>; Wed, 27 Jan 2021 12:15:18 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id j2so683210pgl.0
        for <linux-hardening@vger.kernel.org>; Wed, 27 Jan 2021 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rfc/2fu+jV4Y5Req1cfjWzlvMY5mjBf+ZjHlmUUlplA=;
        b=mkn8g+DPcE+P9ZHpSGdxa0lZ2FyqRfqCz5gkrp03Mu294CFlxpINMFkWZClZZxFwji
         nbpfuOPPQp/NskM0SFSH4N3J0no7fQHUz8qeknNA00/WmYcIa1GZknwTSym9u+ZJnk0i
         AJG83f+7/BRWeD7NNfH3RYwjWF1fN24T/49Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rfc/2fu+jV4Y5Req1cfjWzlvMY5mjBf+ZjHlmUUlplA=;
        b=Wg/x30JhS8MeunX/5gEAiHZ9+vosljTLPIuUwcF83IoX7qz0eNplVCkFa5RAznzOcM
         Tl6BCv2/CNGpxp8c/WtzCGRx0SDq2Ictw7NETgnqEL1rAvr8fJe+y2ro2qab0S6MZHQi
         iOED/CNnckMk30Kq6jzMFjuf0YKRQ3h6bappjimeqy4kQIOyN6ofyMlWP+FE+j8t6eau
         2PDK7BvUjacN09/gHjNfm3hsTt+21M90zvz6TlCg7TrmtUXhfAwuA5j5ccAJhNw4HGjD
         PE+GGCmdEcjnbIp1o/Ysvh0Yh2teQMtU3KV47/DnZRkJ1c6Bqe0125EQxV2klHOVsBVe
         wqnw==
X-Gm-Message-State: AOAM531FQpN1FubKIA+72iI+aITXi+D5Z5N7Gn/IuRtG46oARdpwo4aa
        oGtSQbu0o2IbD+W1QWdAfylQCA==
X-Google-Smtp-Source: ABdhPJwNbF5F9lJRqlNNpRY4DKaANGQ8Tnz+QvPHifxBkVhtS6VwHcm/a1ce+BT/lzcHxME9MDaSlQ==
X-Received: by 2002:a63:3e0c:: with SMTP id l12mr12813988pga.165.1611778518426;
        Wed, 27 Jan 2021 12:15:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w7sm3250094pfb.62.2021.01.27.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 12:15:16 -0800 (PST)
Date:   Wed, 27 Jan 2021 12:15:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [RFC 0/3] kunit vs structleak
Message-ID: <202101271213.4F331332E@keescook>
References: <20210125124533.101339-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125124533.101339-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 25, 2021 at 01:45:25PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I ran into a couple of problems with kunit tests taking too much stack
> space, sometimes dangerously so. These the the three instances that
> cause an increase over the warning limit of some architectures:
> 
> lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> drivers/base/test/property-entry-test.c:481:1: error: the frame size of 2640 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Ideally there should be a way to rewrite the kunit infrastructure
> that avoids the explosion of stack data when the structleak plugin
> is used.
> 
> A rather drastic measure would be to use Kconfig logic to make
> the two options mutually exclusive. This would clearly work, but
> is probably not needed.
> 
> As a simpler workaround, this disables the plugin for the three
> files in which the excessive stack usage was observed.
> 
>       Arnd
> 
> Arnd Bergmann (3):
>   bitfield: build kunit tests without structleak plugin
>   drivers/base: build kunit tests without structleak plugin
>   thunderbolt: build kunit tests without structleak plugin
> 
>  drivers/base/test/Makefile   | 1 +
>  drivers/thunderbolt/Makefile | 1 +
>  lib/Makefile                 | 1 +
>  3 files changed, 3 insertions(+)

I think I'd prefer centralizing the disabling, as done with the other
plugins, instead of sprinkling "open coded" command-line options around
the kernel's Makefiles. :)

For example:


diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 952e46876329..2d5009e3b593 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -21,6 +21,10 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	\
 		+= -fplugin-arg-structleak_plugin-byref-all
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 		+= -DSTRUCTLEAK_PLUGIN
+ifdef CONFIG_GCC_PLUGIN_STRUCTLEAK
+    DISABLE_STRUCTLEAK_PLUGIN += -fplugin-arg-structleak_plugin-disable
+endif
+export DISABLE_STRUCTLEAK_PLUGIN
 
 gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= randomize_layout_plugin.so
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)		\


And then use DISABLE_STRUCTLEAK_PLUGIN.

-- 
Kees Cook
