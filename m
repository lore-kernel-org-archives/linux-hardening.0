Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C9CEEAA7C
	for <linux-hardening@archiver.kernel.org>; Thu, 14 Sep 2023 22:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjINWu0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINWuZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 18:50:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856F826B7
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 15:50:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59285f1e267so47696197b3.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694731820; x=1695336620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wrenr5WHs2dK5hnlbbyL0EycRKjoEDbDNwq7CnxxIaU=;
        b=BxugndSsenTM9NF1aOCW4ZO/a1jXQgUDDQ9ubb3sKS1Ev0pBTHSqm//oPKCUZG33dn
         +IDUP66N300o9+XksnMg5cDPIFDFxkcsPwO2j+tzjfvqooIFtT61kpn2waKHY164Bgsg
         dFgkaZzbCbvTJsGmT2sQ79BXa4Ns1A/gSs1VZFHipi7fzgvaCLBeDxDKFjY4FY1EPqsy
         3dEmTXoLOBlv6XJVimtn6xD6xix+mSWXcbD3goZCRcw0ftb6DoPrqdngHUk+j+NeqbsL
         rPFs63g3CQlzsY9Gx+TF9cQ+wqvv6x/G3jgAmhXDbhyiFrH3SbMi17bZxVurW/BLWAAS
         81eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694731821; x=1695336621;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrenr5WHs2dK5hnlbbyL0EycRKjoEDbDNwq7CnxxIaU=;
        b=adXXmMW4yrwQ88nWPMfGqNFjdJ9fUrz/ZU9PB8d0E9TdXox7A2DWEH4c7mNoDYSX3+
         Wi0G7kIsN5C7MSLrO93ptEbeD/5qdr6V0vnsWPXQkd/yZoG3BUX6wnsPldGI46pXEk+c
         6ErPI43Q5SRqTEovqaG//LnzhllwOAyatKeXQzBUpJAYUNZBTlxvdUryNAU6LOZr/9xc
         Pp6vbxTO7poYAUEWKomgbAx507hM2mKGbhs6Xpo1tcxV4RQseffmxvMBrbah4MB37mgz
         OlG6eEEJ6xSIZKP3ZBYw9FrjwIc/vjUftMhgXd/Bn/7g+IDIyNLZd+eXNsSlZlfV0fFp
         9dAg==
X-Gm-Message-State: AOJu0YwSw6VF4TfTi393uj1cvc+58GWhN90h2Aj99+7XYN8liG7DQny2
        hwHD92h8dyaNaQMy7ZYxhX46n3kqeNd881U5MA==
X-Google-Smtp-Source: AGHT+IFqrDocdDDYwMpT4qE4iWOo5ZoiN4++kHE+CY4yKvqynUceKA1T5/Jq8WXi8hvg81Z+gTnwNQ1IpfMPouoe0w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c748:0:b0:d15:53b5:509f with SMTP
 id w69-20020a25c748000000b00d1553b5509fmr85146ybe.2.1694731820834; Thu, 14
 Sep 2023 15:50:20 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:50:15 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACaOA2UC/x3NwQqDMAyA4VeRnBeodYO5VxlDXJrOHGxLIuoQ3
 31lx+/y/wcYq7DBozlAeRWTnCraSwM0jenDKKEavPOd69sr2qKJyheDyspqOG1zTjhSkaHkjXW YeWFFQuqjD3d3694coeaKcpT9v3q+zvMHDxSl8XoAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694731820; l=1404;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=K3iZ/hNNCktU+LFT+e2eCRR8wtHujlZPGvgREL3k5N0=; b=AMgFe1H+bSBII/rO5u6ibPsdFEANAgzsVzlwm/0r26kBLn7wO36XET/m1sJz644C8oxgiiZ7R
 YlZOH5dfwGzCrRlgTODJ7YveNEm/+t8Y38//F6Nts1+INz+B7Gxxjzc
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com>
Subject: [PATCH] hwmon: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/hwmon/acpi_power_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index fa28d447f0df..9bafe7c85ff7 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -803,7 +803,7 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 			goto error;
 		}
 
-		strncpy(*str, element->string.pointer, element->string.length);
+		strscpy(*str, element->string.pointer, element->string.length);
 		str++;
 	}
 

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef

Best regards,
--
Justin Stitt <justinstitt@google.com>

