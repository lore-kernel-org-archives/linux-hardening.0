Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C1C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jan 2022 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347940AbiARSUv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347939AbiARSUv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Jan 2022 13:20:51 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A75C06173E
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 10:20:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i129so56586pfe.13
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 10:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8PJ3CA01N/X1/qckVtP/PWbEwqc7I1+Jp5YHt/2gH4=;
        b=k1thwlLR5q4ADZAX5xsSmO/pCwwAe/6FE8vkgTArIgZNoVpSqbXshhc1pPRL5XMc20
         KYQPO21jJyqR/h0gQmDsJ3JNgCSixYm2FlufblLy7y7YBbgAw3F3fgwl2HEk9u53EERb
         gURp1FOPtzkM5qKijfwsQAcV/6KIb9J2hH2y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8PJ3CA01N/X1/qckVtP/PWbEwqc7I1+Jp5YHt/2gH4=;
        b=z/i/eCvXHZRYn+Sfa3rAnKx0X8Ep7ApEWkQj5r/W4UwWvJjIwmywcufICaj6Uhtiz1
         96d+y1iMjEQdLneJiRXvtMcUgaK+fEL9WcXj9mT/domJHtYYkkmjxYqtx4GIdt00eOw7
         jsNPeeED17jmpOBPSp7iBXlqjCUhYXlRkEq5nl68yCvxwbR0auU1ya3Z+I2FbslCy93+
         +le+b6SvpFq+MzyFm9Tcfry9z4oBvgoC7noh11KF6Z9NJmnXN1nQzTSc9ukb3KcJoin9
         od3ryQHWqxNgSezCm92PQx06BKt1drF+KjAIlmlshCS8nACEHc/cH0g/vl3cXyjwNkyc
         BP5g==
X-Gm-Message-State: AOAM533e5/yAf+CXAX8Jw1iHPZgju4PX8J9MrU861EVDtq9GGfNMPKpS
        qfJTwpyCgHEMV0DPtlc1QNa9IATlUPDfiw==
X-Google-Smtp-Source: ABdhPJxSFoMYhB81+XsCGwYCMdjfAwo8XS2qbyKlSShgx99DPp5VlGHUTxK5pEEK6VUbelvndIeWmQ==
X-Received: by 2002:a63:5512:: with SMTP id j18mr11257199pgb.597.1642530049965;
        Tue, 18 Jan 2022 10:20:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h2sm3346701pjc.31.2022.01.18.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:20:49 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Mark Brown <broonie@kernel.org>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH -next] eeprom: at25: Replace strncpy() with strscpy()
Date:   Tue, 18 Jan 2022 10:20:47 -0800
Message-Id: <20220118182047.3385295-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; h=from:subject; bh=m22y2cfKr9juupzmdSZGqyAluEE356lhJNzIX3EGraE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh5wT+wB3EE/QJe+rIEMIVBUGYFcXpI7g12KiRvcfz pbexTyaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYecE/gAKCRCJcvTf3G3AJkPQD/ wMLSN22Voejzdv0hbVyxHw0RGE/REN5L/+BZKGzMMt8Rh3aA7rx0dvk+p3mYzj5tO23faotngqY/9z o578ZTfyRiMIxVFku+zc+VlEWePHThQipVZ5DXb+YawBJavm9R5ElYrv2L8/zPmInyOQRWt+1msbJ8 VqnhANkzbSuBD+h1hVJesOyr7p+6AJKGMCfOLhgtSIfQ/d2cSvMCt0J6c5gMn626OcKO0G/PGpFbd2 mc01zg9R02gpkjKJQ4gdl9mS7OIBQvRnqkDFhsGNo2jNxMiIAlzZ9TPW1gt7q8LEeq73qbH3beAi+p 02msL222EQVhaFODGzHK7RcJYJiNjT6L8qoErftpjLHmMKh1EA28yTrF6ZNLAeDPw3ZdvnkvkNk979 1wPyu4AOwsvlRrbpT5v/l86FS2xnHf3K7nSFEi3D6s4YCVruEL+QAazNuCOfCkgUa0EddHsPBHefSk HQY1Y99Z0T5a1F53AJ86qxBjiBtRs3KCafM2lhaLnlcLUd/xtM/5FMNqu8xRXpZBHCWwRe0wyFTfvf eiNvabEik2jkysjMYQDyVeAYHpSwXvDXSNuk0xlSVCyQEO/tAAKM5gVu/tZNzEsf1pgbZI9ampayvc hlOMC+XQXhLDrpUE6DR/S9VoLf+AtYyoC706vwQjDgk3bWqtpEqqX5A0tkLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Use strscpy() instead of strncpy(), since its use has been deprecated[1].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/eeprom/at25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index bee727ed98db..91f96abbb3f9 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -309,7 +309,7 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	u32 val;
 	int err;
 
-	strncpy(chip->name, "at25", sizeof(chip->name));
+	strscpy(chip->name, "at25", sizeof(chip->name));
 
 	err = device_property_read_u32(dev, "size", &val);
 	if (err)
@@ -370,7 +370,7 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
 	u8 id[FM25_ID_LEN];
 	int i;
 
-	strncpy(chip->name, "fm25", sizeof(chip->name));
+	strscpy(chip->name, "fm25", sizeof(chip->name));
 
 	/* Get ID of chip */
 	fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
-- 
2.30.2

