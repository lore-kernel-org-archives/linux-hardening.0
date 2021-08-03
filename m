Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDF3C4338F
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Aug 2021 19:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5EB61037
	for <linux-hardening@archiver.kernel.org>; Tue,  3 Aug 2021 19:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhHCTq0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbhHCTq0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 Aug 2021 15:46:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B06C0613D5
        for <linux-hardening@vger.kernel.org>; Tue,  3 Aug 2021 12:46:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so339051pjd.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Aug 2021 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJ90DUqMvbv4wla/gnl3TcP0CoOTBbniBpXeAQ3Q+oY=;
        b=JP1QQA9eF9nGhWYlu1wCzlIVD7rcEeCW1LCkZGcKWweOZ+z6ldh5xlcm9G8Ym0woaf
         zfR98TGj4DCv32Vs1NQRUblCm/nsus7dh70f5Z7nJ4FCGzfO74S1S3UEHl6uEyBZTzFa
         c/6fESEVSobdWr+EW34Uds+RdcJo+uX2xm0IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJ90DUqMvbv4wla/gnl3TcP0CoOTBbniBpXeAQ3Q+oY=;
        b=OET4dpHiFMuPdQtsbBxzKny58HbumGEryXFzFsmTZ1fPfjNY5A3GiFUXGg14ZDsAYj
         UxymOaaIeYRZjBZRahz7SQTG+SYa4cdIAgtk+5/V9H2wpJhzQpseQGQcdjX3TYiR5/8i
         ig9SANjIZHWeGniyI9L7bTNxj71s7h3Lstzgp7zHV1SknF0NUZDG6ib8SIMQmTNzph23
         8ES9pBK2m6jkwI1Gt0HYv+PsaSvKuPpcHNHxApvjknchYUH8e85SHjycFOZPMxNUlt2z
         aPPwyaYGr3tK3zuUC+AAz1+8F1ys9a/Ngtjvlv/82l8MsbBhR7Hs+f1iFrHyPCyoP1Wt
         lwPQ==
X-Gm-Message-State: AOAM531K4XuYrC4GK/6HORLN5lT1mZ/izDi77HGvxV9IAub2L7Y3Hipm
        cwJZykqAVcPBF/tIzCeAGNhjfA==
X-Google-Smtp-Source: ABdhPJxyF+4OgHXelOOHSdp4vUz34rcph+Yrir0NAkIpf0Ugk6o/kaC4Wumt1elOVq36LLK0j+xGbQ==
X-Received: by 2002:a65:4244:: with SMTP id d4mr981837pgq.83.1628019974268;
        Tue, 03 Aug 2021 12:46:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jz24sm11359353pjb.9.2021.08.03.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:46:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] media: si470x: Avoid card name truncation
Date:   Tue,  3 Aug 2021 12:46:09 -0700
Message-Id: <20210803194610.326030-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803194610.326030-1-keescook@chromium.org>
References: <20210803194610.326030-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; h=from:subject; bh=pk5S9HyUZuKFzWnjx5RWPHnxnnea4OwXR05+OF0bTmo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhCZ0B3xXj+4dTzAtDK9PitipXlqRzSf3d5bls5vkI 5KZ65k6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQmdAQAKCRCJcvTf3G3AJjsbD/ 9xaSsEGzVMifCJSncpaC0EkQ43SYFaN0uvajKxkhZQRFy6xlEZ4DISJP+Q5+oBi0JIEWxBAlKpLATD lj+SCgsY6BBF9WvPPi2MlRJtDHYGuMq7VZsmvRxlbB6+JEjkoZstlORxbCigzIzpv8bVxkmHfvrx1r VgQ12cg4TiPiQ7DI72GOD0IWbCMGWtxEmAWbiDYFexL6Y7CQ8kcVrU6x9vfmfHfulyYP0/eB1+wm6U gf5+q9ExPo12lNNQHLPKUn3Ak65InydAbBNZRLQ73nklaOdAqXXPvsQHwLZ/6P9ZFIH35QwDaX8jhM vUAC9akCqbJDLrBea56Ggjc7bPNKjKHSv/eukA0jIV68sXD81P+kwC6I9TM5v1VXHbMGKvxfyRh9NL KpY/yJjFAPi4v/eaNyKaY6iIZEjlszIH7UdZebv4YKXlrk/u26pzxPr/pNpygWeg6NiZqRbvOrbqC6 W0L/f8L2QwSoGE3//ghjGSgwm6vcLh9AW0d5zjNxRA09CpYxqzDa/WJauSUCUxwmM2l20cQijuA4fr Viixe1QkB6WB6xMAs/eKWsqvA4ItQbruKuApFqiekGI7bkQcxiWPPuxZSREJbqq1SWBjGbdAVfJ8bK 6t+oxgqAc/JWGSEW8S+gvMNmksj839lbi9PRvN40rkNjNI8mlgutS0daCXOQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The "card" string only holds 31 characters (and the terminating NUL).
In order to avoid truncation, use a shorter card description instead of
the current result, "Silicon Labs Si470x FM Radio Re".

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Fixes: 78656acdcf48 ("V4L/DVB (7038): USB radio driver for Silicon Labs Si470x FM Radio Receivers")
Fixes: cc35bbddfe10 ("V4L/DVB (12416): radio-si470x: add i2c driver for si470x")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/radio/si470x/radio-si470x-i2c.c | 2 +-
 drivers/media/radio/si470x/radio-si470x-usb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index f491420d7b53..a972c0705ac7 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -11,7 +11,7 @@
 
 /* driver definitions */
 #define DRIVER_AUTHOR "Joonyoung Shim <jy0922.shim@samsung.com>";
-#define DRIVER_CARD "Silicon Labs Si470x FM Radio Receiver"
+#define DRIVER_CARD "Silicon Labs Si470x FM Radio"
 #define DRIVER_DESC "I2C radio driver for Si470x FM Radio Receivers"
 #define DRIVER_VERSION "1.0.2"
 
diff --git a/drivers/media/radio/si470x/radio-si470x-usb.c b/drivers/media/radio/si470x/radio-si470x-usb.c
index fedff68d8c49..3f8634a46573 100644
--- a/drivers/media/radio/si470x/radio-si470x-usb.c
+++ b/drivers/media/radio/si470x/radio-si470x-usb.c
@@ -16,7 +16,7 @@
 
 /* driver definitions */
 #define DRIVER_AUTHOR "Tobias Lorenz <tobias.lorenz@gmx.net>"
-#define DRIVER_CARD "Silicon Labs Si470x FM Radio Receiver"
+#define DRIVER_CARD "Silicon Labs Si470x FM Radio"
 #define DRIVER_DESC "USB radio driver for Si470x FM Radio Receivers"
 #define DRIVER_VERSION "1.0.10"
 
-- 
2.30.2

