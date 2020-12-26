Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D518C433DB
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Dec 2020 18:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EFD217A0
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Dec 2020 18:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgLZSWm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 26 Dec 2020 13:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgLZSWl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 26 Dec 2020 13:22:41 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFD1C061757
        for <linux-hardening@vger.kernel.org>; Sat, 26 Dec 2020 10:22:01 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z9so4550217qtn.4
        for <linux-hardening@vger.kernel.org>; Sat, 26 Dec 2020 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=D+kHeN95QvK9fHDBFMsaUzhC0Fat+pl46x/ZsCCKvVg=;
        b=Li6CrAmLLj+LiFS8xFdtBy897Ivll7m+VGUGT0z1O0Qx4AdGLaKOlQCzsyepC6UxZq
         Rth8NRk0f50lz9SzWxWTZmhzVy6oO7y9ILYNgo6NsahwffnRQtuLdE+AaD9CE94BF5rJ
         h43AGJJNib3EZUzPu88WuPfw8STAaqZ0KiCuf332iRzIQz3YABEbdPW5KWDXBzLP43de
         x5O4BOB2eKc+tfUAWFi4siwTfNMdbIudkbhn1dCXLfSKCRXbg37bP8vPUab4BVJ/KrPi
         RAuD7zokTCp9ceRY6mQleS4m+J14cwbFwkOW0nBVBbcReNaFhXFRWAInweSwZ6Q3R3eQ
         r1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=D+kHeN95QvK9fHDBFMsaUzhC0Fat+pl46x/ZsCCKvVg=;
        b=YTZTcqlKbxYDOghhmjKw/2+Q5ZImBFzJnEsYgFrrjI45zIvhAe9ZIsCoKPVaUtPgN2
         lxSiRLSMRI5e321En+Y2M1L+SyDBqu24szn17BatEuOm5SsTYRNZqr/Xh52mHQ2rA8D6
         a7kBiya8tsuH8ocM1XOy013tiKP1jSyIqo7PXit5JVUFWD3u574BBuRO9PmOiostjDp1
         JeMH+vw3bhVVSZdz5Pf42fN4RLZiNMlvoH/rMb0HcgqrzcO5rzsfyDcGlVwJYmXD1szH
         zjNpZEIonEI3gg0qLTuhgWB5i/qYMwKAGGDuFDhBenQysy0nd7gaP8WG6tO5MUlfYgyV
         z5yw==
X-Gm-Message-State: AOAM533J6rIXSFD5drYPwsw9Q446qelhUgUsz6PZ1zE2BsESHUHTMWhy
        ZSYsOguIPdBKuXk03SmSPcvX9Q==
X-Google-Smtp-Source: ABdhPJzRJ16SM6uIhDPPf4YVXOVvMCiGGLvL5rf/hc24QNdy4pOu2ZcccwXRWpNkmOyU5+m5tHodvg==
X-Received: by 2002:ac8:590f:: with SMTP id 15mr37721763qty.249.1609006920310;
        Sat, 26 Dec 2020 10:22:00 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id 193sm21176086qkj.105.2020.12.26.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 10:21:59 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins:  fix gcc 11 indigestion with plugins...
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1609006918_4356P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 26 Dec 2020 13:21:58 -0500
Message-ID: <82487.1609006918@turing-police>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

--==_Exmh_1609006918_4356P
Content-Type: text/plain; charset=us-ascii

Fedora Rawhide has started including gcc 11,and the g++ compiler
throws a wobbly when it hits scripts/gcc-plugins:

  HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
In file included from /usr/include/c++/11/type_traits:35,
                 from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
                 from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
                 from scripts/gcc-plugins/gcc-common.h:7,
                 from scripts/gcc-plugins/latent_entropy_plugin.c:78:
/usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
 C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
   32 | #error This file requires compiler and library support \

In fact, it works just fine with c++11, which has been in gcc since 4.8,
and we now require 4.9 as a minimum.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index d66949bfeba4..b5487cce69e8 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -22,9 +22,9 @@ always-y += $(GCC_PLUGIN)
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)

 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
+		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
 		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
-		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
+		   -ggdb -Wno-narrowing -Wno-unused-variable \
 		   -Wno-format-diag

 plugin_ldflags	= -shared



--==_Exmh_1609006918_4356P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX+d/RAdmEQWDXROgAQL+QQ//VlQ8W9zmlGGNw9N87wt0a73K7ttGSb7e
ZZZNDroD3jM77BtJBpJ99p/6M98NNMsUktOATnTvUdWMy7JrSenDr0DReZPGdI84
qjRV0XQM0LDx99Osc0D+FuQGuSeLrtyHmFI7bBH893S8SX4DpKjL4614GJ6eespi
qBYFV99f3YgN9RXg6OZSMwTcWKMMcmsE9wyYmR4H02TMr+ajqx1dv+mp9JnmYNhO
/CamaxFicoEPwAYoQHuw2xWVszP4JV8Zta/K5eHnwaOYeXHfkh2qwP1+KbbYTEzL
PSXHQPauO2psGIfxIIBVw8xb6pXrncWc3wzg1D/nr6VVzEDk1c7fwT7DMMnXWO6X
3zsnAk7509L9hdxVbYBFbFby8V47xnDrH4tVvOCvTjzUh8ujFb9K7m89e+hKaOGm
yCfqRUvUy8m9CZJQNOHmzNKvYoOahIEWSjkVIJN0DBiK57y3lLfkA7BU0G73kN49
aj4gpwbzSXe9iEvP1fa8ntq/amrc/nItNFwW0eIMzuMT9aKDIUupqfhD6VWRG4ve
nYBOoeuSaddj0UgpY28q4ZH9Xd2/BZSKKfInYd5Fy8kNfiGilNGWpLeVEJ3QH77q
JMWHW7N1ZxPF4umPhfQ+Pw1eR2EZof+n4Iqv5EWKoJxenNU1Wxw96wyMXJsVm5C7
hm7B40xKJuo=
=F4DK
-----END PGP SIGNATURE-----

--==_Exmh_1609006918_4356P--
