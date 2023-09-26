Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D45224
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 06:59:24 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA8FB
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 23:59:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so15745509276.1
        for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 23:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695711563; x=1696316363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+nMD7o5PWsEvgu0yQwljZkcod7HvATgSWdAFYmTAx4=;
        b=JMJ36pedV06u4rIIxWngWv74moobNEuXt8LlDgdwhp1Hz2Q23iUE87uLKVBEf3CCpb
         PfnBhGYMTwArCgAvtO9VfFeMWlDsOEaIobG1UiXPVhDGAtk6niBlUKf9pKVYgQfLYT39
         BbCERnf1t38hXvRWzP2ox3Wdo0B8UWBTIEGqzUlSujnBpjZKmNVfnrzydJFPwAJrGT+v
         xwnc2fKRkgbltEVO4FoxQZvgbQSNbyjD7VmBDQUL8O6IGvyWFvOV9JF95C1KaGGrgP7E
         CpPpz4C9428xj+8h68yh5yShNKqfUZMXXy1Qs1KJ2zc0mzWRTFEpYEVdRQF4bCfZ93oh
         JBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695711563; x=1696316363;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+nMD7o5PWsEvgu0yQwljZkcod7HvATgSWdAFYmTAx4=;
        b=J3ycDzVQbEvtYhCjGF7g43i2boYWBstZzmNocedc1fidWEM067lINmkvZUUbWgUYqT
         nlbEAXnwq02h6hqk7EUjSn9RMuW6XkZfZB7L9n2JKo+RE4tGVQ4xJssogp99FpmQd9i3
         44oeQhdJLjGByKwt+QNhem97YW0FJ4GyzqiM6FVmq/8fP3b1mGwotFy8s1lijMwJRQSm
         hOljlfoeVeNPhRjb+0B1SyHjIpVTEB6vMN4BDo/arWvbL2II6Zpfg+vrggZYcIFF3QqK
         NZma4t5zaBGwVAwm08W/xZVbi9BkY5G5BFzmrOaFMngGqg71PBmYm1PlcugylqAFv9rS
         bRWw==
X-Gm-Message-State: AOJu0YwaBIndHz3Vqi+uHQwK3XGAK6gGcTAGSdveEXwD/HZzd8BQrpm1
	6Uz5FiwD04Q4tnLJFfGYvwuaZyfR/xW8yuyY2w==
X-Google-Smtp-Source: AGHT+IEalOsuOkrw0PFbRbPepFJKIdXUdRSVW3fSIYT0u8PgtBxCC7b1X9J/XpGmhHFvrr7tPLt9Cv042105vVEcSQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1085:b0:d7b:b648:f0da with
 SMTP id v5-20020a056902108500b00d7bb648f0damr32014ybu.6.1695711562907; Mon,
 25 Sep 2023 23:59:22 -0700 (PDT)
Date: Tue, 26 Sep 2023 06:59:15 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEKBEmUC/53NQW7DIBCF4atErDsVDBCbrHqPKoocPNhItbHAI
 oki3704K1dZucv3Ft//ZImip8ROhyeLlH3yYSxDfxyY7ZuxI/Bt2Qw5Sm6EgjTH0U4PaKPPFBP
 0tyGM0NjJX6Zwo3gZaKYIFqxx2NZcyys5VrgpkvP3V+r7XHbv0xzi41XOYn3/EckCBBiu0VSqM
 o7qry6E7oc+bRjYWsm4lc0OGYtcS1Urie1RKXyT5UZGsUOWRZa80hrtkax0b7LaynqHrFb52th KS+UE/ysvy/ILL0f0+e8BAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695711561; l=2263;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2U9Nj4BmlrBIbcimiE1QZuM/UADBB5VoZJZ4/Ueo3o4=; b=PJIyqZcfUPI3uGAZNaGrFzr6nWv8+WcrrjFCp55EuwvjiG33+XJ3P9t8fs6cCaCoeyXmpwQC+
 Z8S44VtvCGkDKT0oXjksgmxMWD55HBnSW2VEKzzHia5zdb8jK2RQTK3
X-Mailer: b4 0.12.3
Message-ID: <20230926-strncpy-drivers-hwmon-acpi_power_meter-c-v5-1-3fc31a9daf99@google.com>
Subject: [PATCH v5] hwmon: (acpi_power_meter) replace open-coded kmemdup_nul
From: Justin Stitt <justinstitt@google.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
more obvious behavior and is less error prone.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v5:
- fix indentation (thanks Kees)
- Link to v4: https://lore.kernel.org/r/20230925-strncpy-drivers-hwmon-acpi_power_meter-c-v4-1-3bac7534f10f@google.com

Changes in v4:
- drop +1 from length arg (thanks Kees)
- reword subject line (thanks Kees)
- rebase onto 6465e260f4879080
- Link to v3: https://lore.kernel.org/r/20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com

Changes in v3:
- refactor to use kmemdup_nul() (thanks Thomas and Kees)
- change commit msg to reflect ^
- rebase onto 2cf0f71562387282
- Link to v2: https://lore.kernel.org/r/20230919-strncpy-drivers-hwmon-acpi_power_meter-c-v2-1-8348432d6442@google.com

Changes in v2:
- use memcpy over strscpy (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com
---
 drivers/hwmon/acpi_power_meter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index fa28d447f0df..8db740214ffd 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -796,14 +796,13 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 			goto error;
 		}
 
-		*str = kcalloc(element->string.length + 1, sizeof(u8),
-			       GFP_KERNEL);
+		*str = kmemdup_nul(element->string.pointer, element->string.length,
+				   GFP_KERNEL);
 		if (!*str) {
 			res = -ENOMEM;
 			goto error;
 		}
 
-		strncpy(*str, element->string.pointer, element->string.length);
 		str++;
 	}
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef

Best regards,
--
Justin Stitt <justinstitt@google.com>

