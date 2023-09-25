Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D9EC0
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 06:35:57 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7799EEE
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 23:35:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so111609407b3.1
        for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695623755; x=1696228555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bcrp0ZXERhmGEwBm/uzVnD0KZhCDXIgRvCKxEA2CEAk=;
        b=ZYoPrP7prgqoMG+F/VdEmJgvQfssIWp+3Za1kea+ThT7jy5rWM8NP7QgrALyluSX1S
         Z+C9wuMAle2wGCIG2SGs9b0B5VlzDwncbNwaUKPp1gTxPnPMpf3186EnzuGmOSvT+oGq
         Rwf5Vf3Az28gEdHO5TDo++mrUy5MmWKAtN/1MZJq3GT0tPx76Paq5tWRsYnug7B8CLga
         y6kkMQtRMeRUk0eID7Hpp1RfdesMjjvSgK9X7o3+eI/S+C35qj2kzHAVaij5OYn0OL8T
         J/1OGrMCjsrifafySkxBnU+TQk90vyT8Q5EfzRX67R+iNS08QZiSuBkRV+pVy39SmHaW
         Ibxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695623755; x=1696228555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bcrp0ZXERhmGEwBm/uzVnD0KZhCDXIgRvCKxEA2CEAk=;
        b=bm+hMj0jVityBi5hcIBU3B9Ue/a4SxgX79qv8iomcS3BGE9OzXPXOaM1eLJPAN1qrZ
         qqZNdjG0yhcAkKqqSWp5XAWQcJUb6YkIXRV70rsajavY8fDHjWXQlcLcDz6lcm4NImj6
         4fMybyke/cDaU8dMSASzDcm/hqRMnbTaMZJyHg0CrHt+bNMvVvuZH6NLcoArRJ5jQH7h
         3PrCeuFJSc9uXkiEBJ7doFQoXdCLSKk+HHvnAENgeQzuNf0Qx+6d8lCMB0V1y/5jDnW8
         w2Le+bIFWF64QQNnK1xooHCSEsdEEqRY5Q+CmbarzT+ntw45pLrvIKPQVxXZWsTFto1d
         h/lw==
X-Gm-Message-State: AOJu0YxIbr27lIwxMcxD5Mu/C2K4HQJIKBlMKktxXq1EGWjdLVbNKNyM
	p3mh0+s7/MBD8k2bhdyZc1H9wU9pWO1ixxceog==
X-Google-Smtp-Source: AGHT+IEL+v1AKm/ankIjajUpkORjZ9CG55V363ptxL+fCbeQnS97/LMJgSUav90kcBtnIjOjc2USO1BqtT7+Ykf+5g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ac17:0:b0:59b:ec33:ec70 with SMTP
 id k23-20020a81ac17000000b0059bec33ec70mr62785ywh.6.1695623755612; Sun, 24
 Sep 2023 23:35:55 -0700 (PDT)
Date: Mon, 25 Sep 2023 06:35:54 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEkqEWUC/x3MQQqDQAwAwK9Izg3olqL1K9LDNkk1B7dLIqKIf
 3fxOJc5wMVUHPrqAJNVXf+poHlUQFNMo6ByMYQ6POt3eKEvlijvyKarmOPMyDOS7XlBQo5tw13 77YgJypFNfrrd//A5zwsvv404bwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695623754; l=1489;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=JzUgrhuHr9AIb+fIgjCoX4OAuDxhGR+xHWRbaTpyl7I=; b=sT93N+bGfSIOi1sfnFt85uF+GI0tMjBiB+kioUutRn1Sju1ssa2QNCZUqxcrTzj+gGFqgTzPt
 +W7ks6UvmCLDpC5diuhueOkl7nJyKmMWRREAquuJd6gWCqbGMqbJZEE
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
Subject: [PATCH] dm crypt: replace open-coded kmemdup_nul
From: Justin Stitt <justinstitt@google.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kzalloc() followed by strncpy() on an expected NUL-terminated string is
just kmemdup_nul(). Let's simplify this code (while also dropping a
deprecated strncpy() call [1]).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
Similar-to: https://lore.kernel.org/all/20230925-strncpy-drivers-hwmon-acpi_power_meter-c-v4-1-3bac7534f10f@google.com/
---
 drivers/md/dm-crypt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f2662c21a6df..8a03b3590733 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2858,10 +2858,9 @@ static int crypt_ctr_auth_cipher(struct crypt_config *cc, char *cipher_api)
 	if (!start || !end || ++start > end)
 		return -EINVAL;
 
-	mac_alg = kzalloc(end - start + 1, GFP_KERNEL);
+	mac_alg = kmemdup_nul(start, end - start, GFP_KERNEL);
 	if (!mac_alg)
 		return -ENOMEM;
-	strncpy(mac_alg, start, end - start);
 
 	mac = crypto_alloc_ahash(mac_alg, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
 	kfree(mac_alg);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230925-strncpy-drivers-md-dm-crypt-c-da71d87b8cdc

Best regards,
--
Justin Stitt <justinstitt@google.com>

