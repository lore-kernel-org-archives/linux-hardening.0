Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066220307
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 17:26:09 +0000 (UTC)
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EDF3C28
	for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:25:30 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-77407e21d49so101886985a.0
        for <linux-hardening@vger.kernel.org>; Thu, 21 Sep 2023 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317128; x=1695921928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCRMmvveaVcVSR15oJLrWC1xgCD5rCKuEjC1MAuPd54=;
        b=BddOajUv+wU5uKZSLX+BZTC8P3yzyxRTOIQE+nkgKcMn8zsjQTEARt5tu6rtKC+tvt
         98+NV3Um9HIk3NIlVsp11BN97iBpykz60vplFeWMczkKN91TzYmim1jmKIXCVL0AvnRg
         M0gUxxbhQeQMsOUakHQ3dpJnUNj+yEhiVceOEvYegKRu1Qpt+0jWxYGM/ApUfh0Qrcu2
         NJMPu1WDEg3yO1GlUM6ggw3qJ0yVWsAGVqCFqYylDgQY4fjH8Hc1YrWwv6QITlMn0IPZ
         I0hP96oAl8+PZdp81Q9zf1JtN6RzDOO2+a6svv1HmVTeezh6XYd5h6KdxTlo8C4h8zrN
         cgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317128; x=1695921928;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCRMmvveaVcVSR15oJLrWC1xgCD5rCKuEjC1MAuPd54=;
        b=W7elsVQp7w6ZncwZ2Kf1Bem6Zou5HsP9o6HOxk9fCPGY+XxLdEtRIBfEXGm42rcv72
         Ufxxd56Gh0MlGYuQaC+i+ZJT37LdXSXxbeTcxORXMhrAGOxCgbWydYVB9BRQ6+T06voE
         ioJHptyQZ8bbaJPLKTojExh0LiMaE9U77eaUnl04/SDwwWy7Ry9QpVNyba6K+HTGgFmm
         kawbnen1OWPsXysYJsa915Zi3/UOGjTZcWbpsjdPQBn1E7XQuyg0muAj6d/l8f8GodaO
         sF4rhcHKqGErUNzOczO5ZgP7OAJ5E0ykkSwQ2qDEOC0mqyjKFhF8MvP6EThSEOCJa59O
         yt6Q==
X-Gm-Message-State: AOJu0YwIMpL5a1EclJc8ntNl0pnmvzW93Dwd+CFQpentc+fDAkEOfxp9
	x9+6DMHEbhpynezUzI3HQkDf9HQ7bHbh4c0hIw==
X-Google-Smtp-Source: AGHT+IHDyKp3cW0YeVyd0vhCpme6YAoecIObStizWMW7RFLYKWXmo/R2pTAhUCAwSHys9UXUTSOhS+KIcqAGjnZGfw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ce49:0:b0:d80:ff9:d19e with SMTP
 id x70-20020a25ce49000000b00d800ff9d19emr63960ybe.9.1695279663292; Thu, 21
 Sep 2023 00:01:03 -0700 (PDT)
Date: Thu, 21 Sep 2023 07:01:01 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC3qC2UC/x3NwQqDMAyA4VeRnBeojei6Vxk7jJptOawtiUhFf
 HeLx+/y/zsYq7DBo9tBeRWTnBr6Wwfx905fRpmbwTtPLvgebdEUy4azyspqKJKxaK7yl2VDq4H 8gBHvkQaaxml0FKDFivJH6jV6vo7jBIHQTo14AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695279662; l=2848;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9jDyBMkgavsnNjxewPyVtkova19FE84VVZK9Pvb/rDk=; b=e5TEjYsjowMhf9fPiePv9hrz9ZlUb1GRwFyDE70vdQLcICQkLpAoogAgOXukubFmfNkqyHkBm
 i+6F0QbTVSPBtqz25d/Mw5nxuJ1Y4S/g8IQULtXS2wdUiW7lNb3r3H6
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com>
Subject: [PATCH] iio: sx9324: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

`prop` is defined as this string literal with size 30 (including null):
|       #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
|      	char prop[] = SX9324_PROXRAW_DEF;

Each of the strncpy->strscpy replacements involve string literals with a
size less than 30 which means there are no current problems with how
strncpy is used. However, let's move away from using strncpy entirely.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Moreover, let's opt for the more conventional `sizeof()` as opposed to
`ARRAY_SIZE` for these simple strings.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
FWIW: It seems fragile to base future `prop` stores on the
size of it's default string.

Note: build-tested
---
 drivers/iio/proximity/sx9324.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 438f9c9aba6e..25ac2733bcef 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -937,11 +937,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-			strncpy(prop, "semtech,ph01-resolution",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph01-resolution", sizeof(prop));
 		else
-			strncpy(prop, "semtech,ph23-resolution",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph23-resolution", sizeof(prop));
 
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
@@ -1012,11 +1010,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_PROX_CTRL0:
 	case SX9324_REG_PROX_CTRL1:
 		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
-			strncpy(prop, "semtech,ph01-proxraw-strength",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph01-proxraw-strength", sizeof(prop));
 		else
-			strncpy(prop, "semtech,ph23-proxraw-strength",
-				ARRAY_SIZE(prop));
+			strscpy(prop, "semtech,ph23-proxraw-strength", sizeof(prop));
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
 			break;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039

Best regards,
--
Justin Stitt <justinstitt@google.com>

