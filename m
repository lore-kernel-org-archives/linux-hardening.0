Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC247349
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 17:49:28 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04BC89221
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:39:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e758d6236so17867407b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317982; x=1695922782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEI/FE0LzaOE8LB3j/EPmAsW/lNDHZXMlP+MK6JtiH0=;
        b=Zq8osfNW9ZuQVHXy57hD7l8yOjMIKlmgBaI6Eb5O82TYxx7PuzR5F5GyEXuWyqg7Ez
         gYCbTUYgZ1k/L5AL7pZ2W0yWycwVk+GYWv1AeDpzjCLQmEIWUCb4cz9glUU+6mtpTKg0
         IaHpaLzonmZk/XZw5nKFIzmsRu9nJhmtBDqJXmct5DGSbBFrc+g5sQBr8NlwJotNKM06
         RAHOtD1raNDRBhzLQcVSNidMmC6MsdetTktJzkgIaAOBsD9l2Sx7k16tyq+BYShAmX0+
         I0qIrxmAA/JSSqK6cnNgKBILw2XmmYw7ZQG2BwJyOPAowFEM5fbIblRts9WyS3z7xNMT
         tosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317982; x=1695922782;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEI/FE0LzaOE8LB3j/EPmAsW/lNDHZXMlP+MK6JtiH0=;
        b=GbuIP+EdjZYW4Nl9eudAa3tNQSSNtTaI3l0vppi48WU7MKyYGgvzb4D7CEcj8T+bsJ
         wmTnVziVYQfuWi91vjnZ740qewVo2rNWBmQ7H5xnCXHDpzCX2mp7d8iwQAqQbG4lfYO9
         GqsjmWZuWUIGZbnXdUFyMHUbDERKtYStzv/lra3YRj6BWFhDjImAMXJA/bI1uamGbbeh
         C75RN3ymFSywxvxBy9WGXv2TM/sc/j2srzX1A0DtuB7PBpKht5QUxfLaLo1fsfvQ5lP7
         SUvIz0O0kBOCv6Ebc8yhgvlxsjfMDQcIYQRPRSITkjM6HGd5rfVgubqBxB0gxAnD6yBP
         APdg==
X-Gm-Message-State: AOJu0YwValTf57pxPO2HLtMBHrUkwdFQC3+HbPf0lQErrSaCdvMAWc2r
	aGF6ZxgxuJOn87+O84+/CGBqqHP//e9WF18FyA==
X-Google-Smtp-Source: AGHT+IEYzveRK4DpKaBvTcozNvLOzlrpzzHF+TShyi7tBIAI7apmqP3Y8DUHUTwq86i/Sw1IZExa+IRloVCK7eDaOg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:848e:0:b0:d82:9342:8627 with SMTP
 id v14-20020a25848e000000b00d8293428627mr63851ybk.6.1695268265522; Wed, 20
 Sep 2023 20:51:05 -0700 (PDT)
Date: Thu, 21 Sep 2023 03:51:04 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKe9C2UC/x3MwQqDMAwA0F+RnA3Yyg7dr4iHkGYzB7uSFNkQ/
 33F47u8E1xMxeE5nGByqOundIRxAN6ovAU1d0Oc4jylGNCbFa4/zKaHmKPOjDt5E0PGnCQ8IqV ATNCLavLS790v63X9AcxwdSxuAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695268264; l=2236;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xRRL8ZZagoPuEYpnmLvMHfqr3+/4b42z9ovF8TORhlE=; b=pVohjE+m58JPvLT2c72pPRI1bHXV2c7QOlM9qXaA2xrrnFGjQsCWYX+d7O882U2GpU1hdFZVW
 yLLUEfbE8+rDkX3sbp6f/QeKPamXfHchETunk7iwfC0o7f3mbtu7FJs
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
Subject: [PATCH] i3c: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

We expect adap->name to be NUL-terminated based on i2c_adapter name use:
| dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);

NUL-padding does not seem to be required as `master` is zero-allocated
and `i3c_master_to_i2c_adapter` simply returns a field from within
`master`:
|       master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
...
|      	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
...
|       static struct i2c_adapter *
|       i3c_master_to_i2c_adapter(struct i3c_master_controller *master)
|       {
|       	return &master->i2c;
|       }

This means that `adap->name` should already be filled with NUL-bytes.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 87283e4a4607..8573ca507708 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2309,7 +2309,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	adap->dev.parent = master->dev.parent;
 	adap->owner = master->dev.parent->driver->owner;
 	adap->algo = &i3c_master_i2c_algo;
-	strncpy(adap->name, dev_name(master->dev.parent), sizeof(adap->name));
+	strscpy(adap->name, dev_name(master->dev.parent), sizeof(adap->name));
 
 	/* FIXME: Should we allow i3c masters to override these values? */
 	adap->timeout = 1000;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-i3c-master-c-d9e152a91aca

Best regards,
--
Justin Stitt <justinstitt@google.com>

