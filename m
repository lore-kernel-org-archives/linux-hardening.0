Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0C45F6F
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 17:24:47 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C5C311D1
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:24:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso794549276.2
        for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317058; x=1695921858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YIjCOkiBe6G45aEBYQSULZ5zzwzapCnaNAVKzWT/a/I=;
        b=WTKoh7H2fGarNFbKOR9/u+lvCaFx4PM8bXiZz6/brEuQx7ClUrH0xFeNlK93CCZgjH
         GYpAmxHGpZ4hFEoToUt6NTG9UoOxW9ShaFwu7GxIC23T5NbTWpNtzqIPNaUfqF8mw6xE
         PDC20ISPSp5jxstM81n6Lug1Ias1+dIixkv4t4vPzTF/33rdSmljyfUj9Mi5uuuCfh9C
         MtEA6wLpmiaMTMWM/Tf3Vrr4GHuKTvThY7w5Ymu2CsChVutivlHh8LMJk/HNUEgeVHK9
         5KZJhPl+eu1hDYAJ1trlZEfx+tpNotMMXxofes+Zu8QCX5FS6hM4uflJe0yygVCop8/D
         Qnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317058; x=1695921858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YIjCOkiBe6G45aEBYQSULZ5zzwzapCnaNAVKzWT/a/I=;
        b=I8taOB+d5a9pOYu6mxnO4P7xvzE6DK8nURU2hMEIbArSiBIGrtJ6Z54knYu+3LQ+ti
         yg9Iaoukblsbs1NNWlQKO2Vp8y5C4w2i3Uz7LOJlW/TD6rMx4La2D9opwtIXQXVpZlin
         C379wYgMxX7+E0KF/FE6Bbq7525YVeYY1vS73kLt3Kt2DxYdD2euNcLjklrKmgBNa3Fa
         rq5bxrU9+TwRvZpBhzHY5T0ox5ImdotELC75EQHYnU6r7nL0AnT/LoBukS4keEaNA5Z0
         gwYmgFhMihxiIqyFpaUoS/NHXzupeRKmaas+v7+soq4yTmNHyGJGGqukr6BBW/aOcysV
         hX4A==
X-Gm-Message-State: AOJu0YxhsBBdTu0iBcN7X6YH82OOL9Dcpk183cSgoJcfd0cpz5xS4TWM
	5UlLevf4Yps3oOvuYvgosbCbwwUQqxQn8J3OZw==
X-Google-Smtp-Source: AGHT+IH0fcnvvWbCy3tA1NPToTyzyqCok+/lRZ+hyvZgNHTbvdwmOOhSJ8DZQCY6OR97NUJ1S9CgcsEA9JZ3kY2F6A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:848e:0:b0:d82:9342:8627 with SMTP
 id v14-20020a25848e000000b00d8293428627mr65500ybk.6.1695274907625; Wed, 20
 Sep 2023 22:41:47 -0700 (PDT)
Date: Thu, 21 Sep 2023 05:41:46 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJnXC2UC/53NQQ6CMBCF4auYrh0DbRHqynsYQ7AM0ERaMiVFQ
 ri7hZUudfne4vsX5pEMenY5LIwwGG+cjUMcD0x3lW0RTB034wkXiUol+JGsHmaoyQQkD93UOwu
 VHkw5uAmp7HFEAg1aNbwukkw8sGGRGwgb89pTt3vcnfGjo3kvh3R7/4iEFFJQScZVLnPVYHFtn WufeNKuZ1sl8E9Z/SDzKBdCFlLw+iwl/5LXdX0D8+S7ATsBAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695274906; l=2206;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=KXXNR06fDm8CjylUce2un2Htp6ByU6W92dU8RA1crQ0=; b=tRLI7Wgpm3CdsY5jEJd3FjvprLZLD8Phcapc19BeFcZk7gq7oTTv/7ibAxYIwzP3dYb+qpKyy
 lrJy6DcBeL0CVRcBMo3/zxp4L1fKyeXVokEzzyyqcYvL35mdA/5lfZC
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
Subject: [PATCH v3] hwmon: refactor deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
more obvious behavior and is less error prone.

To avoid truncating the last byte supply `...length + 1` to
kmemdup_nul() as `element->string.length` does not account for the
trailing null as made obvious from it's definition (and associated
comment):
|       u32 length;	/* # of bytes in string, excluding trailing null */

... this is precisely what the original kcalloc invocation did as well.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
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
index fa28d447f0df..146c4f09c897 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -796,14 +796,13 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 			goto error;
 		}
 
-		*str = kcalloc(element->string.length + 1, sizeof(u8),
-			       GFP_KERNEL);
+		*str = kmemdup_nul(element->string.pointer, element->string.length + 1,
+						 GFP_KERNEL);
 		if (!*str) {
 			res = -ENOMEM;
 			goto error;
 		}
 
-		strncpy(*str, element->string.pointer, element->string.length);
 		str++;
 	}
 

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef

Best regards,
--
Justin Stitt <justinstitt@google.com>

