Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A728CD37B0
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjIOUKS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbjIOUKH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:10:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50589270B
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:09:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1593413a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808591; x=1695413391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Muy93PhGxQI637LkltSivczIg7w0S2HDIxF5V69MsXg=;
        b=dzET6Mf7ItbFD+1q0E/MlzjwZ5/hOIYZnbPK3zSQZlyKUpk92E7FjXdNiMY5L0cvQf
         TtUCGQfRvjQlyVgkRTk7YnFHCXLwR59HQNKyX5lnrTO+Ath7zWcBB+aGhwEsJjkmXRgQ
         wHtD16Cy/LEYbAhS52ji2k1IVqaMPnYgfclVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808591; x=1695413391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Muy93PhGxQI637LkltSivczIg7w0S2HDIxF5V69MsXg=;
        b=sMqT3y2z1FxcXk/YNHESyYPYeYieIhwwr+8PxuuxiBu3qvi4oxw88bDk4HyJug7yFo
         egQ4phG4n/4q+qRJN7TtHDbx9E2cDtNI5OMkUpH9O0iI01eWfTV2ciRTgrYrL2ko0IfP
         ijXJYgUFfFsCKAPJVhS0PaeTOq9R30ihomY95El2td2r1E4ZayouBENNG/MaZTw1vbze
         7gOC2St4IoPtyJGL7SEzjxw+zXv9LX4nwr2W+yobIfuSfnqo9iUk4pUeKnLCsAuK7WvQ
         Eu+WiKCkRVnTqpAzCPTm8ngmYCUZ3ThpR1Sl183sRNY4wiMpExvGJlCfLpudB8BRwIyt
         zGPA==
X-Gm-Message-State: AOJu0Yx5JAMY7j0nXMvjAXCd1P67n17fqVDuvk49v2XCPGAUXW6q5P00
        JDLVGmgfIOXuv0C9acfwQwdpsg==
X-Google-Smtp-Source: AGHT+IFrv22jckxNyFPHk4wkul59BZWPHDh4KeyX5yWqIvjMYexwtkhmjNCln5KRyZogKvg66UkBMg==
X-Received: by 2002:a17:90a:130c:b0:269:621e:a673 with SMTP id h12-20020a17090a130c00b00269621ea673mr2603231pja.1.1694808590812;
        Fri, 15 Sep 2023 13:09:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090ace0200b002749fee7984sm1439060pju.22.2023.09.15.13.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:09:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: cr0014114: Annotate struct cr0014114 with __counted_by
Date:   Fri, 15 Sep 2023 13:09:48 -0700
Message-Id: <20230915200948.never.728-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Ay/S96r+TTbAZJCf/FmudMqBXZB0z8bluDuDqSyybAY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLoMRK4HKwbRdA/dQbibTN2neXE8kbK2imD47
 OJ+4vPf9VKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6DAAKCRCJcvTf3G3A
 JgeFD/456XBWPDEoi/0lXVUiOYdHq9R99vQdrY+GKQhMNhO2/WY8oM+OfE51KIc6dW8iAM2/i7F
 SChkpSp3hLfJ7uYdd28ESePEquipBhWrrBb/q4/fS9f5jGNvW81W8QMRcVskWtj5Uic+kCnzf8V
 jK3aModQKGLsYkj2F6z0mYZV5w8mXznoG3ndXPezz6jsGsuTuBEMagzXvOaXr7KCDkJJ0UOG3gU
 GaSQN5EQydQ5CyAWpL+SjS/TYSniIgF9eqsEoZ4xiOPBmR91woy6FQn3Z4hrlir5Izm+Pmn2RvL
 QsUBHiY3uyWfNzyfg8H+yPhjUx0JNpQlUoLis7NUidDojd1bRSkXjiEKKkywOSEWS94XQRqoM9A
 EnyL7jM0sh+jJYgZNqNxYdXv2yONd77E/9+TVYG4ntdl5/CBbo9iUw5XAr6n2KO3bBsztkJ4KOO
 OP1DUkOvmelWQRajNYgxjsi3RWvUyMhOd3fipXAe5bex0BOiEIg+mjS5nuuHKEcj+mJ++dIzhLx
 t6Txfb40SANvVUZVgr+3KTXpkYgNAKWDKDqwI0bmWboS2HWzyAr2OzFbBvBh6Z5UpEdZWUhn4Q5
 Dj4geW1zSzfm1s0T9SL9D8tCJAz7WEM1mt5hRQgDb9mLZMYOc6K1EpgPA1SrKaiBtXgIIDOnekE
 Yw0266w 5tKVbWGg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cr0014114.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/leds-cr0014114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index b33bca397ea6..c9914fc51f20 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -56,7 +56,7 @@ struct cr0014114 {
 	struct spi_device	*spi;
 	u8			*buf;
 	unsigned long		delay;
-	struct cr0014114_led	leds[];
+	struct cr0014114_led	leds[] __counted_by(count);
 };
 
 static void cr0014114_calc_crc(u8 *buf, const size_t len)
-- 
2.34.1

