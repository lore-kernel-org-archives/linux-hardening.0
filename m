Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24245C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05379610C7
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Aug 2021 16:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhHYQIj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Aug 2021 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhHYQIi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Aug 2021 12:08:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC608C0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 09:07:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q3so2778633plx.4
        for <linux-hardening@vger.kernel.org>; Wed, 25 Aug 2021 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/l5cLUlCqQuOmI9NOmST1rS3slCz2wAxqBsla1LtrEo=;
        b=ibv558tfKD2EGwE3AuzA/JnRlUcJi1r5X6W78sOo+uBrn56+kdcAIWVg3u2rvY+2Wx
         lr0GXiSLK9To2578biszUzs+RkAMNF9Mrv+UG/qmH54Ow2m2YshzVs4kuTB3OXOQdgT5
         GQShwOY4bwOO6rzdcNiIdXDuHpuPLcM/Okksg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/l5cLUlCqQuOmI9NOmST1rS3slCz2wAxqBsla1LtrEo=;
        b=KNkiBPYmgNiSMcb5xnVA8I58UStGL7BqG1f9wP/wkjWqjTw+JdeU7luFZGNFlazAwz
         aFt5THJNeqqdP4wK/Hw/tbv9ipHfz6PJRmDj3oKpjhlZ1UJEJWOFS9/HJPeHJO54XrCt
         TwUFEFAcNH2g3377HuQnwgMgXMqxvq+oPJmkfZIhZd3n9NFGsJd6ioyPTAer6z/w3W9C
         bP+yku3kih6EQg3E9Ij9DW3lpOwS1+fw5G5g7IBQ4U5wgatKcAykWuNyH+JJGHxBfJn1
         iOenmnPHL7PvUn2wAjIXwS0+m8y67s4+DW1JII2BQF8AX7eEOtE3wPefxC/ttHsbb69d
         iXBg==
X-Gm-Message-State: AOAM532/si1Cr7IdjBfpa9p6OXlfL7553fdhUVYrWP2VjiLu/cyVnVPU
        bl8Hvd09mtTRbIQj8282ZbzIww==
X-Google-Smtp-Source: ABdhPJzcn3M/RGUv2vmIIIjnTPhjD6UJCKPAhfdFZM7OYaXVGFIXicuAZMiX6IY1qGNOTTly4Qq4WQ==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr11404502pjb.116.1629907672421;
        Wed, 25 Aug 2021 09:07:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q21sm434957pgk.71.2021.08.25.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:07:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Andy Lavr <andy.lavr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH][RFC] platform/x86: dell-smbios-wmi: Avoid false-positive memcpy() warning
Date:   Wed, 25 Aug 2021 09:07:49 -0700
Message-Id: <20210825160749.3891090-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; h=from:subject; bh=qXsdfbAnxeyDMKPf/8AeuTAwgsFnkIChdg6LvC6u8KI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhJmrUmxMtdLH2DxKjuRGAk4B4ozE+e7SiCLYZqSp9 DtvjLmmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSZq1AAKCRCJcvTf3G3AJteyD/ 9bq6aea/3GOxMrowBT27fyllzGBBs72gKCYBqk/wi662CuzVNNvJFN0kk4nsNkHssQpZrFn2DideLd IyJ668p6UmrQyfXTMqKsCO86VQ1grM821PgK28F416tdDhZtzB2d+x8k7FHJ1/9W/Sbx6T3qV9kRse IaSJ0HROFAzVCePL+RF6wr6H7T8apjput2yNKjHfw0+7ioQcEMrQ0u6vdXsnGjXBd9XWagCnDJ39i7 KZ6FXWm2pu0POcYgxQlxq2x0tPyme6m5T+ErM+5mlv0MLvQb5PfvOTGKlWcvsGQ0YYXQ3DSnWYuSVQ QMU+cNeGlTjAKprcx6ToUvSx9B9WkxaGK5oALUpZwwed9n9af3v+tTDeuyP5JdMYtUPotLI9Q4/i8n VfoZEzz+M+e/EKyNih5AzXLSrEajPMQbsXhsx+Ix3kklu702f21rdKvacUoI7Qh7qR3UJMXJt12fIJ 7j/ijOvIHh79WuLA6Vfp9TuiQjLiH5bJb6KBgJun0m6v1dTLQKJ+iQe4VZkrfLp8HOSCJbRwdYCs3q 8tkJUY7nbrcdCY3lJ9bjIOiK668or4z80tXNnszrNqPoBsFx08diPFjMDOsVRcjwmPpZ9hajDUQJQB BXY7BFkQLRkIgn2MBxIZKg+m3zTWL9GtdttU6dLWR6OxGYTNncrelEv4G/kQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Since all the size checking has already happened, use input.pointer
(void *) so memcpy() doesn't get confused about how much is being
written.

Avoids this false-positive warning when run-time memcpy() strict
bounds checking is enabled:

memcpy: detected field-spanning write (size 4096) of single field (size 36)
WARNING: CPU: 0 PID: 357 at drivers/platform/x86/dell/dell-smbios-wmi.c:74 run_smbios_call+0x110/0x1e0 [dell_smbios]

Note: is there a missed kfree() in the marked error path?

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@dell.com>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Dell.Client.Kernel@dell.com
Cc: platform-driver-x86@vger.kernel.org
Reported-by: Andy Lavr <andy.lavr@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/platform/x86/dell/dell-smbios-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platform/x86/dell/dell-smbios-wmi.c
index 33f823772733..c410d6d920b8 100644
--- a/drivers/platform/x86/dell/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
@@ -69,9 +69,10 @@ static int run_smbios_call(struct wmi_device *wdev)
 		if (obj->type == ACPI_TYPE_INTEGER)
 			dev_dbg(&wdev->dev, "SMBIOS call failed: %llu\n",
 				obj->integer.value);
+		/* output.pointer memory allocation leak? */
 		return -EIO;
 	}
-	memcpy(&priv->buf->std, obj->buffer.pointer, obj->buffer.length);
+	memcpy(input.pointer, obj->buffer.pointer, obj->buffer.length);
 	dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
 		priv->buf->std.output[0], priv->buf->std.output[1],
 		priv->buf->std.output[2], priv->buf->std.output[3]);
-- 
2.30.2

