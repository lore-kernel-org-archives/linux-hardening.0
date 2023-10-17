Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6C2E41C
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fX1WOxuM"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56667B0
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:58:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7dd655566so95822267b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697579929; x=1698184729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtA0QmfTazD4bejJUvxhW4u+owAfFqWpqMd8aiBPDi0=;
        b=fX1WOxuMpKW1tvMyO4Aleww+sSym9wGDCa/ORANY60YXXEbKr7se7bxsRoSIOi3cWv
         Sva/Kjm2n7l+GzUiGPirCKlelh8BwrODtmdXjAxCfa4zjDORuRCShlxqPsmwXMvkHAdF
         2SF/8TZSNYCZJ/svpNG+qrkic75vth7PVMkKED6fxCDEJ8wOf50kCpUREOeKbej2P0sg
         UyaLok7GBxfJLVEzmgJ4nddpVSHsv5aymQQSRnf0GWKWO2JncfZ73RVbd54yLtfBLuHu
         ltYEapBgQ03ks7TiyMvJCJgRB4k5mnRwMdjntGqCLbIMhkZHEijCcOv9qQOxfXmhlos5
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697579929; x=1698184729;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtA0QmfTazD4bejJUvxhW4u+owAfFqWpqMd8aiBPDi0=;
        b=TJPp7LvUrKQu1gnTW9Mmb6oSzmXSPm5lSD0ohRXc3yimfadqI/TwCMHGJHyXWsNt5J
         8QiLNbF2kUfDsxgKl+XCmEwDjg8Q6golRGQ9KAqaGywADh2vuTbK5OyJEmvsyA5m7uCZ
         1skM4ov+Etv828zwhruCAXPbEJEUyeaANeJDeuZk78euTSez05519DZ7QCWb2f/l5w7V
         qkNmBK3B3JbG39RWoY/wk7EhOf4pMn15wXDNx/GbBiEUqBbsIYlbB+d1J+6UBdIljg+M
         IxgMmJCoEbnRu1OhGfT8BUl9HwEjDgVcQ7juY1oUhBkKK6tTnQPb0SX2ndpLFWFyse78
         09gg==
X-Gm-Message-State: AOJu0YxkiPy944e7vxnfMymlxkvSClZuM2cmNRNqHayVfNDdMCzgPTlv
	GmZ92xx8izqAcaaKabytvGZVMgEc/FjmAWzr3Q==
X-Google-Smtp-Source: AGHT+IHDs3y1E7k+8uXlkij8vcC0qgc1jSTYg965KjyTu12FZPFdJux12EXTyV9h27znP+YEVJYXB6E2gitoCo3PCg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d787:0:b0:59b:f863:6f60 with SMTP
 id z129-20020a0dd787000000b0059bf8636f60mr81791ywd.4.1697579929629; Tue, 17
 Oct 2023 14:58:49 -0700 (PDT)
Date: Tue, 17 Oct 2023 21:58:44 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJMDL2UC/x3NSwrDMAwA0asErSuw3UI/VyldJLaUCowbJBOnh
 Ny9psu3mdnBSIUMHsMOSquYfEqHPw0Q32OZCSV1Q3Dh7J2/olUtcfliUllJDQtVbKKUyQylVMo oLTdhQW6Yphkjer7c2bnpNgaCXl6UWLb/9fk6jh8QFOZMhQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697579928; l=2481;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ssxs2Jsrs2hPLtwX1Sk+1Tw5TTVcJVG2jRbLqY3Nmzo=; b=euoX0Jg9LbRcp6r/+6JIqUrfaDAKuWxPOT7SWUWCkFd9tCFkFL1KEXgYs5MQi+IMRc0kTTReU
 jDmNrXF5LRuAIyY/fyEHQCdk0cZLzPa3Qi6V64hHwnsB9k/dZM+P3Tf
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v1-1-bf69ec7d1b97@google.com>
Subject: [PATCH] wifi: iwlwifi: fw: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Gregory Greenman <gregory.greenman@intel.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
both dump_info->dev_human_readable and dump_info->bus_human_readable are
intended to be NUL-terminated.

Neither of these symbols seem to be actually used after being assigned.
Which means our replacement doesn't really matter. At any rate, it would
seem NUL-padding is not required so let's use `strscpy` [2] due to the
fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding. (but maybe these should be
used or removed).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3ab6a68f1e9f..5455f8d1aab0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -880,10 +880,10 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 			cpu_to_le32(fwrt->trans->hw_rev_step);
 		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
 		       sizeof(dump_info->fw_human_readable));
-		strncpy(dump_info->dev_human_readable, fwrt->trans->name,
-			sizeof(dump_info->dev_human_readable) - 1);
-		strncpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
-			sizeof(dump_info->bus_human_readable) - 1);
+		strscpy(dump_info->dev_human_readable, fwrt->trans->name,
+			sizeof(dump_info->dev_human_readable));
+		strscpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
+			sizeof(dump_info->bus_human_readable));
 		dump_info->num_of_lmacs = fwrt->smem_cfg.num_lmacs;
 		dump_info->lmac_err_id[0] =
 			cpu_to_le32(fwrt->dump.lmac_err_id[0]);

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-1f49f00b8a2e

Best regards,
--
Justin Stitt <justinstitt@google.com>

