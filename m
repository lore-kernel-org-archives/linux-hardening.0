Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB387EEAA7C
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Sep 2023 23:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjINXVN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINXVM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 19:21:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E361B8
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 16:21:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d818e01823aso1590058276.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 16:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694733667; x=1695338467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4BixPSI6K4mFdvHjP22A4GYUb6n9IBpB9f1xvsMH7k=;
        b=e0wVhOi64Sny8sVdEfpPEtHTV/fR9FWnHmeddV0l9GMAD+uWOLQ28c5NA2LLbelWZY
         rnSuVIGuyPLYM6dYp90NOGyrr6qG541NgfPOuZO765/WJ3rsMCYKo4jUVYAOM3yEQGQM
         cwpQOaO09fXWFN93J+x3cO9Z5TTOLUE1TjySdUwTv3XJvyY7Sf+gFZ1e3afS52AAN3/l
         1o11N5J32JJ6k9M1h4uruNR+DBitlOaY66wwqf/zldspxmv2tLR1EFXPR++PShcg8aRt
         FSHYYjlh0JXoo+eqNl/jA3+vdsad+Tl0x10pcaUMtUy5Ilzkf5s9dTfE83UZIbg/mBqG
         +cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694733667; x=1695338467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4BixPSI6K4mFdvHjP22A4GYUb6n9IBpB9f1xvsMH7k=;
        b=ZmUsrcdgLNaiswH3ZqTasIpObEDr6zhmQUGDwjj9J+r5DHF12L7cxyp3nLWILacX4G
         Q38m5hx9sP9zL9+wZHxEr7wNHkipIvGECVvIb5fONb+YtQlp5NJNCyAz/YNTxNwZBwjj
         QmU8mtFS7xqiitfUQiYVbvu7oEewRpFJgSS9mZNYRWvJWwBmfJwswzXnzaYVQn+YeHoB
         BCs0mZJkhMkvtJZwYgCawXFfLGgAj9MWr4JggCla3M59fplkyN0DOuUWxbhsWPc82F55
         zAA6zh4N2oxs7MZP+vsFdcx735JGFoDUo9H3mOZrOWj5Co/t5SopNp7H72GHmSWFx6RJ
         bg4Q==
X-Gm-Message-State: AOJu0YwoTYw7cMCP938XAyJ3+CEd05cgMaFhdCa8u7Gbk7+FboWxe07f
        7RhSsJCECpVn2p10IPILDLuB6LMLLS0lrFLV8w==
X-Google-Smtp-Source: AGHT+IFq3p2ctNKfynOgDkjxwZcw+cwOO3eWZyDO7yA9WDMfkjmAMvoMpTDs7Uz247dBLv6Bmcx4o1fQfc3Tnq8V7A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:cb:0:b0:d05:98ef:c16b with SMTP id
 d11-20020a5b00cb000000b00d0598efc16bmr208490ybp.5.1694733667417; Thu, 14 Sep
 2023 16:21:07 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:21:06 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGGVA2UC/x3NMQ7CMAxA0atUnrGUNAhRroIYQuJSD3UiG6Wgq
 ncnYnzL/zsYKZPBbdhBqbFxkQ5/GiAtUV6EnLthdGNwkz+jvVVS/WJWbqSGy7YWQX6utWyk0jD h1UUXZn/JU4jQQ1Vp5s9/cn8cxw+ObRsDdAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694733666; l=1418;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=EQqFhuW6eyqVcI+2qvkN1RrCgJ3Q+ZXalbGWG4ulzH0=; b=zl7/VHFqVwFRJkvIBYDgTR3z8vsBLvP/9HPrgIpXao92oev7YfIZMtLc+vTpq3+YfxHy/8tSV
 gQhyQ2VQBRIAJjn6FVAwdCVZDDTwvbnJgKbwaEimBGIqyZmsAX2qbOq
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com>
Subject: [PATCH] hwmon: (ibmpowernv) refactor deprecated strncpy
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

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding since `buf` is already zero-initialized.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/hwmon/ibmpowernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 594254d6a72d..57d829dbcda6 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -234,7 +234,7 @@ static int get_sensor_index_attr(const char *name, u32 *index, char *attr)
 	if (copy_len >= sizeof(buf))
 		return -EINVAL;
 
-	strncpy(buf, hash_pos + 1, copy_len);
+	strscpy(buf, hash_pos + 1, copy_len);
 
 	err = kstrtou32(buf, 10, index);
 	if (err)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hwmon-ibmpowernv-c-80a03f16d93a

Best regards,
--
Justin Stitt <justinstitt@google.com>

