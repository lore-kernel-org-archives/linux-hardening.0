Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB820327
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lR0PKqHJ"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B3D65
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 11:59:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5836ab12so1440436276.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697828378; x=1698433178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aC7KxLBec/eSA4myIMpLcsC0tK2N6BssGDn4X++BO/4=;
        b=lR0PKqHJ0uJgeTJrrffRrc6cYcn29O+LJl0AFNCO7ByvoJqcCeJ1PP3ZEJAAMzULe1
         NBnk9QEOzoKJa9iN85Ixim6MmHQ5lzY8dmiK1V1GMiR8/OM7wRyiCbW6rQmWiphYz8lh
         x/bo3x/oVc3LlzMzId4F1hY6vR/sLsTNyYlYuFVDjvqDRZ7jexIetJYmyKjKIB8523JM
         XT1QilTSnCFHbivl92ujcjn8ev3ln2QDWHXpjHAoHxKLhjLbAKeYXtI+743+cAd97HNk
         mYsK8XUbS/zc4eo6xcnYpSGNokVzavTUNeiDBIAybBioY4BdIiknOukCMu1qchu5LkvC
         EJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828378; x=1698433178;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aC7KxLBec/eSA4myIMpLcsC0tK2N6BssGDn4X++BO/4=;
        b=EzxsoAObxjqJv6HBfXqviQ8C47CFdlc53Zx3BC9lVjKa7R+yzeUdzMHxLkk3sI6RrX
         ILWKmsO+qjbb1KE3kRYCf+Y5tnqVI0OTohWANJp9WBfXsU/5AXgx8STihvwY8R46c1rx
         OxCbuUwRKYFZ6Ubj0jXzRTqKpAQlol5UkcRTlmoJC/TcgUqcEGL48QnqQK6d2oyHUTM3
         UF+lFV6zABQ6jr+8pqBqDVheYOznPP4oAjUtMvGNu6fvPN90EmpMzESXxTB4HL3lHF5p
         qgfEsnFZPSQbolr46IKnY05doyzGh2nE+wxJ9DityBc9M2Huh4ndGIyTfj1viVzGhbUv
         Cu6g==
X-Gm-Message-State: AOJu0Yymj2Tg5tn2IM9Rl+zDezhxMlegdL7gc00pveV3R63M4Rbs46Q7
	Ep61T2W8Mwr0K43k29mFS1iMc0paXd8hmPbnkA==
X-Google-Smtp-Source: AGHT+IEQpDs7hpOqRDtFDbh4OM23K8uXHQtjIsWC4jrd/lhbtU2hEf9NOXi6sVTehUOiNBV3H+BHO3UoNbsCMYHd+g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d7d8:0:b0:d9a:da03:97e8 with SMTP
 id o207-20020a25d7d8000000b00d9ada0397e8mr53942ybg.2.1697828378406; Fri, 20
 Oct 2023 11:59:38 -0700 (PDT)
Date: Fri, 20 Oct 2023 18:59:34 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABXOMmUC/x2N0QrCMAxFf2Xk2UDTbiD+ioi4Lp0B6Wqic2Ps3
 1d8PBfOPRsYq7DBpdlAeRaTKVegUwPx+cgjowyVwTsfyHmH9tEcy4qDysxqWKYfK9q3lNeK/dt 31C33qupY54ixT3QmCqFNHuppUU6y/IPX274foYe/1oAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697828377; l=2719;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=T+2bP/VZordKJivg0WULS6xpMGyCh5PEFbjppJMYDyw=; b=wfeBrFDrlPg11uAXCMlr1FrdbFjab3mH++hd8n+V8J6m4i2+5fSu+wTfIKW7ADNr0aV6HkBe9
 dAIOowSQjgXD6wkWvunWsFVJIEBXYJV97Ryx0HNqH5J9WFFJxzHyBii
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com>
Subject: [PATCH] power: supply: bq2515x: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect bq2515x->model_name to be NUL-terminated based on its usage with
sysfs_emit and format strings:

val->strval is assigned to bq2515x->model_name in
bq2515x_mains_get_property():
|       val->strval = bq2515x->model_name;

... then in power_supply_sysfs.c we use value.strval with a format string:
|       ret = sysfs_emit(buf, "%s\n", value.strval);

we assigned value.strval via:
|       ret = power_supply_get_property(psy, psp, &value);
... which invokes psy->desc->get_property():
|       return psy->desc->get_property(psy, psp, val);

with bq2515x_mains_get_property():
|       static const struct power_supply_desc bq2515x_mains_desc = {
...
|       	.get_property		= bq2515x_mains_get_property,

Moreover, no NUL-padding is required as bq2515x is zero-allocated in
bq2515x_charger.c:
|       bq2515x = devm_kzalloc(dev, sizeof(*bq2515x), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
sizeof(dest)) as this more closely ties the destination buffer and the
length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com/
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/bq2515x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index 1dbacc9b015d..b4ea1707304a 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -1092,7 +1092,7 @@ static int bq2515x_probe(struct i2c_client *client)
 
 	bq2515x->dev = dev;
 
-	strncpy(bq2515x->model_name, id->name, I2C_NAME_SIZE);
+	strscpy(bq2515x->model_name, id->name, sizeof(bq2515x->model_name));
 
 	bq2515x->device_id = id->driver_data;
 

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-bq2515x_charger-c-cbf1811334f2

Best regards,
--
Justin Stitt <justinstitt@google.com>

