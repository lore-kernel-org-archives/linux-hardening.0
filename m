Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475D2032B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edobgOcE"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A872D5B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 11:14:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b10c488cso15612667b3.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697825697; x=1698430497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NjxtAigxI0HmCKPvB9UmZgA+mMJTBsPd7/Wkgi0tm4s=;
        b=edobgOcEo2DQnIYa3i60Q0paZQLOBUFFJAspGON0iKv3guCLgQnv3MoUyA5m4XC6B2
         1NnYrYOXf7ldJY7MtDeGWtmXcZF9gbcimkmUKsw4Tc+/ZndpptNZzqzFc2INZef6xm0S
         /RPkQNIfekKCAhsQeQyPYpRiEfVlt9Y+ca0Rd0NKmzHNBrEir/weWKIrwLexMzg+b/em
         uTi2rvaIE1haxah05bSE9QMepMX8j88AYAS3WXIXfMFnU4ehq2hiBJUE9kQ8VA/ylj4L
         P1eh2Z9KYUc9mDdpZ4aruyzZZzflvk8I95vWb8Nd8z0LiZSHIiZzBpJKO83k2jNizmiA
         fhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825697; x=1698430497;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjxtAigxI0HmCKPvB9UmZgA+mMJTBsPd7/Wkgi0tm4s=;
        b=acxHBS1NX5ulatE7PqRjHKiNe41+sHbDEeFy1/X2/YvImW/oeA0PJX3i3ezTj6lzDZ
         0x7GLsmUBEY0h4DFPXsj3zloUkp8FxitfaKzfzHLe6B6MWUhIdGdCmkkPkEtM/qqmojL
         nvDKT1K5CNAPTKGLdY4+nLGwYDo7k+txi0osoo5ct+qgTZOCOTL52gcuHC4feytAwCtz
         q2EdBkIafQCuelqDzviWAyvPNVZ13bI4fcFxPMx/eOHCIEatVAHeGnx/utfMhhBFsMSN
         niQjbfbVc9F2pJoqzbN2pyBpfuciMCOuuaFnM3GGlHuXT8vHPjdua6Q1+83z2pj7F0cF
         Roww==
X-Gm-Message-State: AOJu0YzIo/FT55wDZ6uztUQG255sbnQn4NAsq8zQUDiL4eHQkrEYvC2o
	GwPqtIuf9ZVgFht6lXs60jwZvlp8Q73+CAXROw==
X-Google-Smtp-Source: AGHT+IF9SRE85ngks2gCtXwLYmkhJ3/uV8+grnXvrUYQkNHVHLP3fosnqqpIA3GEUwLdiQJy9CtyqVgplrjQH9jIsA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1083:b0:d9a:6007:223a with
 SMTP id v3-20020a056902108300b00d9a6007223amr82297ybu.8.1697825697460; Fri,
 20 Oct 2023 11:14:57 -0700 (PDT)
Date: Fri, 20 Oct 2023 18:14:47 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJbDMmUC/x2NUQrCQAwFr1LybWA3VUGvIiJumtaAbNekVkvp3
 V38nAfzZgUXU3E4NyuYzOo65gpx1wA/7nkQ1K4yUKA2Bgrok2UuC3ams5hjGT9i6O9SngumF+3 jKdyqakOdGY+JOYZDz9QmqKfFpNfvP3i5btsPUwdLHoAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697825696; l=2477;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=JmvkYA0HtU/j7JDgpCDudlk1OJo4lvEUsupF7z8hezA=; b=reN8ZCf+oaoqlz7W8BUFLMQjlrdg0RWOzYHkUPRlg80x9tWDd0LI/VU/0C9F7Cv4z62I3vr4S
 MgzW8oVQ0SgAYcyQOaq0PxhkKmOjOEfBBehIC/R/ncW9Ox0M3ys31Q7
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com>
Subject: [PATCH] power: supply: bq24190_charger: replace deprecated strncpy
 with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect bdi->model_name to be NUL-terminated based on its usage with
sysfs_emit and format strings:

val->strval is assigned to bdi->model_name in
bq24190_charger_get_property():
1186 | val->strval = bdi->model_name;

... then in power_supply_sysfs.c we use value.strval with a format string:
311  | ret = sysfs_emit(buf, "%s\n", value.strval);

we assigned value.strval via:
285  | ret = power_supply_get_property(psy, psp, &value);
... which invokes psy->desc->get_property():
1210 | return psy->desc->get_property(psy, psp, val);

with bq24190_charger_get_property():
1320 | static const struct power_supply_desc bq24190_charger_desc = {
...
1325 | 	.get_property		= bq24190_charger_get_property,

Moreover, no NUL-padding is required as bdi is zero-allocated in
bq24190_charger.c:
1798 | bdi = devm_kzalloc(dev, sizeof(*bdi), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 3f99cb9590ba..1db290ee2591 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1803,7 +1803,7 @@ static int bq24190_probe(struct i2c_client *client)
 
 	bdi->client = client;
 	bdi->dev = dev;
-	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
+	strscpy(bdi->model_name, id->name, sizeof(bdi->model_name));
 	mutex_init(&bdi->f_reg_lock);
 	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	bdi->f_reg = 0;

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-bq24190_charger-c-6bcc105fc23b

Best regards,
--
Justin Stitt <justinstitt@google.com>

