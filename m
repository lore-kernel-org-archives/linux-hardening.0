Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB99CD343B
	for <linux-hardening@archiver.kernel.org>; Tue, 19 Sep 2023 05:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjISFXF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Sep 2023 01:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjISFXE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Sep 2023 01:23:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E85FC
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 22:22:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c240e637aso40058427b3.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Sep 2023 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695100977; x=1695705777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oNNrBnYfOYV0KaxSsoYAY7HFcM1nxRdVcxEdAxuQSek=;
        b=X+qwkmjrE/m6Y3db1xSgyl7S3kPbEGcalxftA7fkNKww/+j3oG2nC+qCVDMT6/mseQ
         Wi6AhHSmeLIMc7GR9I4i2vlQAXVIksyrOvifL5k+byDfZcshn2JyFVtBTXdRy48tEyJm
         HpS/om+iLyrB18/P3Gwhpj3FZhNipILnVPUu/mkVvP5hOxdMuZJIRlYt7uC45Pf9AKtN
         zXHd64CMMOlzHC9kUzeupQCAeZDi2Cqqa5uN0Uy5ZH50Jgu8LNlXXcFVSAuHqgJOiNRe
         ZuD0NXROCCVTiXMWmaZ5+tbUuJJxrdtnfzWX7FGV7pSMM+PWpQgzaN3Ea2rgi026lxA1
         930w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695100977; x=1695705777;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNNrBnYfOYV0KaxSsoYAY7HFcM1nxRdVcxEdAxuQSek=;
        b=SoOA0wP+D/AP1JnLWBAot7Eq3x4fJ3cIHeCIfd7aZ4SSK9YNBdX6MxjkAK0Nn2nZDu
         VkDydlerkv4HF7anf/MI+CA3B1bQjbGmRmB2ZHQXoNRS8WuQ6h5DVqrZW/oZUMu/JOYe
         r2Qy1H2CTvkfXnRb9ITAEwN+8IF7GLBUhMmEVkK4yR0GwP5YcTONVAnHDtS9eln0M6dI
         f6rl3a+aw4DZp7pNya1pv8ZeVHrbUpw7rMRu1edOUID81OiClOgartSqDKbzKHF2mocs
         UTIUcE848anD/M0qt3px1q5f3qfK2TXcPMZitd2RyUF7rJcJVykqnP+f93gjEBCR+W3F
         hIDA==
X-Gm-Message-State: AOJu0YwHQztrQ+TyrNCPN12ja+8okkDcfzZNoQyIR/yVRj8oVIsAidfK
        cVNUKPlaomPbQ+/NQgiaV954n0DI1JVHVEHNjg==
X-Google-Smtp-Source: AGHT+IG9VOZ8zzSUvNNcCsXcq/7ZmSP6vcfwDpombAcNa9QU+2UY0m040xo/bdOp7q8pB9p79XxGurEYq/YEnQlOsw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:cbc3:0:b0:d07:7001:495b with SMTP
 id b186-20020a25cbc3000000b00d077001495bmr246617ybg.11.1695100977385; Mon, 18
 Sep 2023 22:22:57 -0700 (PDT)
Date:   Tue, 19 Sep 2023 05:22:51 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACowCWUC/5WNQQ6DIBAAv2I4dxtAY7Un/9F4QFx1kwpmMVhj/
 HupP+hx5jBziIBMGMQzOwRjpEDeJdC3TNjJuBGB+sRCS53LWhUQVnZ22aFnisgBpm32DqibF78
 huwgWKmlkPqiyr3MjUmhhHOhzTV5t4onC6nm/nlH97F/5qEBBZ8ruMRTa1pVtRu/HN96tn0V7n ucXgTQnLdUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695100976; l=1508;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OAz/JRiRID2OTRUyttHDX/ZpXIkZrNearv6uLWj/7bU=; b=x26VBNt6hCJK6tE9iCypOq5ZUv1fkpkRwGDtfS8IE17RETDDR0O83LqmzEj+caTfyJBrLb4x5
 WBI5kzz6P7aCpbLgI0Es1r5kYhqhQdKrtYkMYnrEgathKQdL8i+TK6m
X-Mailer: b4 0.12.3
Message-ID: <20230919-strncpy-drivers-hwmon-ibmpowernv-c-v2-1-37d3e64172bc@google.com>
Subject: [PATCH v2] hwmon: (ibmpowernv) refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `memcpy` as we've already precisely calculated
the number of bytes to copy while `buf` has been explicitly
zero-initialized:
| 	char buf[8] = { 0 };

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- prefer memcpy to strscpy (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com
---
 drivers/hwmon/ibmpowernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 594254d6a72d..70ca833259ab 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -234,7 +234,7 @@ static int get_sensor_index_attr(const char *name, u32 *index, char *attr)
 	if (copy_len >= sizeof(buf))
 		return -EINVAL;
 
-	strncpy(buf, hash_pos + 1, copy_len);
+	memcpy(buf, hash_pos + 1, copy_len);
 
 	err = kstrtou32(buf, 10, index);
 	if (err)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hwmon-ibmpowernv-c-80a03f16d93a

Best regards,
--
Justin Stitt <justinstitt@google.com>

