Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C48CC433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  6 Feb 2022 17:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbiBFRpO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 6 Feb 2022 12:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiBFRpN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 6 Feb 2022 12:45:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92190C06173B
        for <linux-hardening@vger.kernel.org>; Sun,  6 Feb 2022 09:45:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so4959280pjv.5
        for <linux-hardening@vger.kernel.org>; Sun, 06 Feb 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iudmqcl5RL2lQzHd0+d84A6aJxrG2FU7tnHbVKt7s9k=;
        b=jXgqIveXbXfpHK3xZxh/iFoLfYWzklnzuNiAqRi1M+xplyO34XhyZ6i3el9bRS51ml
         fScaTHsC91beuf45vozaI3/cUEzRJx3wHCeT01NlUV2bRx39uaXx/LTH3qFAPFqXQfoc
         WKB2Okq5DkJ2C1Ox13Lsoz7QacLNUbk7LZYBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iudmqcl5RL2lQzHd0+d84A6aJxrG2FU7tnHbVKt7s9k=;
        b=uVnJ0mPTJxiH+SGtoikkDXvhQM09ymjf0m4QiwNQuIds8vZdZe5CxavXiXNKtkqn/p
         ZvGiLV1FuVhbsEX1gpG5zj2PrkIcG1TDNcE9KmoxMj8ZE+yqGb9pMjHbrA3ijHpnY/Vo
         9bvTnkoIYOwFuY9RkaqUnXiCOUDtKhxrXZwKfUxPjHkn5ptpw3pA+lKJwljmclIwTd+7
         37wFcsEULXEKzMWAPl/rBzgX0Y2ZANU1sS0iTD4NhDGXsLlPzYt7EcZEW90h2AD9e3+y
         whZLm9Xzs3oKRZ6cr78alvrgI34nFcZBwF5uO6AHjtF6EG4ZmXZCYSijVxBrG5wt8fHt
         c7nw==
X-Gm-Message-State: AOAM530nRG8CxWiCyGXOKtQS2Ji8UAw1VQIFUKB0QXpakd/vvJtnY6lT
        nKd5K6eAWl40f5TE6+M+0QZ2lg==
X-Google-Smtp-Source: ABdhPJzssBqvuHlOY2Po/SRruB03uHIsnsc+8+J2nMo5Ouszr2rUP124MvAdZzMkgj01D2PPQPsdjQ==
X-Received: by 2002:a17:90b:33d2:: with SMTP id lk18mr9848966pjb.224.1644169512067;
        Sun, 06 Feb 2022 09:45:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm9253313pfu.9.2022.02.06.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 09:45:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] gcc-plugins/stackleak: Provide verbose mode
Date:   Sun,  6 Feb 2022 09:45:06 -0800
Message-Id: <20220206174508.2425076-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206174508.2425076-1-keescook@chromium.org>
References: <20220206174508.2425076-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; h=from:subject; bh=1OUNCxVj3tC5iJ58yy3moGifQy/0GbUf79O0B7Mmwjk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAAkjOEH6KrQCd8eB3D7TEo0Rrp85H3WWk+DJFvv5 B52WVuiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgAJIwAKCRCJcvTf3G3AJpx9D/ 4y/Zlto2vcMKGRxceFpn/DVD6RFBG5qjSUoyBgqpSxEC3uiXiwOPhXMOZNoWa0qsAgGNTN4nUvrZq/ D3Zgw2GPfHa2XnQEZt0Id4gwrHbB6/p33DMhGutC5nJc7GmkICY24l55ng1sUGon4bemLNH9gsPVh6 LIMW7n3QHHpIxOVba+tUVY37DBlTBqZf2ZU6zoXi6KfZhvF5iTzJlkp9jw5RrmOYmqWXJn3Rhj4CcQ ImRxpFtkcBfWfffBMLjSA/w+QssSM8VDFVYSWP4a8OlHU54yiYh/bJydMrxKfUhyAEMzfCs4zKOgfi 3CIH3vNSO+/CsWIiSFbkPYqCEwn/hfgTAAmZWnUV+0OmGg5JkZI4LxioLaowIHLfU8sx+gq8ZmBAby A/YQpL+LbRW/n4URyc5oVZGf1+X0kZ9ELp4IvBlo4ILBGbEJGjnPj9OD++rXt/uBKucybbXP/Kl1oF GgxTWvz17Rlocl/NrzaQw6M0BvLvUQIBcVClTsoIcTW58YPJydRPuuj0K+JTu8af0yWNU0dwRpwU20 xUO5Vcb99Qvh08AZH5Ob8kWKwl0LR6JB1FEsAaXzLjJaPBgMan7qHCrPLPOPG2GY/Km4ROeNuoIU5k KNYvsRd2bPBDGAQcGLgctfStVUGMaq98IErpU7QZUJ8d1yDttI0Rbf+cvyNg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to compare instrumentation between builds, make the verbose
mode of the plugin available during the build. This is rarely needed
(behind EXPERT) and very noisy (disabled for COMPILE_TEST).

Cc: Alexander Popov <alex.popov@linux.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.gcc-plugins |  2 ++
 security/Kconfig.hardening   | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 1d16ca1b78c9..f67153b260c0 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -37,6 +37,8 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 		+= -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 		+= -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE)	\
+		+= -fplugin-arg-stackleak_plugin-verbose
 ifdef CONFIG_GCC_PLUGIN_STACKLEAK
     DISABLE_STACKLEAK_PLUGIN += -fplugin-arg-stackleak_plugin-disable
 endif
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index d051f8ceefdd..ded4d7c0d132 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -174,6 +174,16 @@ config GCC_PLUGIN_STACKLEAK
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
 
+config GCC_PLUGIN_STACKLEAK_VERBOSE
+	bool "Report stack depth analysis instrumentation" if EXPERT
+	depends on GCC_PLUGIN_STACKLEAK
+	depends on !COMPILE_TEST	# too noisy
+	help
+	  This option will cause a warning to be printed each time the
+	  stackleak plugin finds a function it thinks needs to be
+	  instrumented. This is useful for comparing coverage between
+	  builds.
+
 config STACKLEAK_TRACK_MIN_SIZE
 	int "Minimum stack frame size of functions tracked by STACKLEAK"
 	default 100
-- 
2.30.2

