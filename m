Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D4354E5
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDrru/Ap"
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0984F119
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 10:45:03 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-57b78a20341so10476985eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737502; x=1698342302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qg+otgUOPQR+8G/4uV/TUAnZUyW51Jn+plgzCktzBuA=;
        b=XDrru/ApZi0UXweUD7gr35ntg23Lt6QbrC+gaMYzlj6SB+gYOAjz3t7R5ockw+MHY5
         nAI8oYvVYUrtmsr7HZwamZqKxvQqafGaVIb0TBm9XjC5nGmARMH2nIyJL/D9g1OERy2K
         2qlHmwyJ01x9qs5JsEZlpmr7+T05U7DMFoySaqPshFPCbwRuKld6h/hDhCGLtYHvuafi
         To94gucsbTQwVuDc6Q3VzoDuh92fNEzpiGUAFO3ti0fBGfIA/d+ECCCbs2vGNZXXiNvM
         j9q9D5SlqVSP2b3IJJYv4SNXHZGOgdTOnAXFMwmbZcFIHf7guo/8duT4QwWtp6qXC0GJ
         xZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737502; x=1698342302;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qg+otgUOPQR+8G/4uV/TUAnZUyW51Jn+plgzCktzBuA=;
        b=h+sGYhBZNttWMtFjzzCmbynMu4gdPmfphFuRvynpqv4tMVNhk6aDVhQ4Q9G9VhIGDh
         7/LItSKU9nInySeKVBP0ktHbSuLWHRyfRWoVYSt574ldCtywhyhmTX9aDHZ2IN2EfIyo
         +0aYj5PkYnzfhrNYRINK3eTNIAKvdr3yj/wSme5Xw0vS2j5VEju9Q0EGeYudnU8c8b1R
         OE+BDdDzX08o19ws4Od7jtehu6vqDohVnTs9iQylXlQAGcYDtOhqIiyxB98gd/Bv5PEy
         eGTUtjJcsr4B11qaccuywKsreWVih6P1nYoDxDzr3NWQ/vZZeFIqcNFaGl2J9ZyCDzq5
         TxEQ==
X-Gm-Message-State: AOJu0YzSeuQlfg7UyADmlBEsO31S+i1DNR+apUnWR/vMQLHnJC8ih8IC
	Owx6RuETYOigiWyvHysWXk8C9VBsXPmiOI3EUA==
X-Google-Smtp-Source: AGHT+IF/1XWODGKQ3tILQKxRsLwEu1ZDsY+BIBDOaGIwchVda0e1YeB9gM+pNN+BK6LJjMlqq0ITrFJ7PPV61+TGJA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:6c15:0:b0:581:f8d7:e4af with SMTP
 id q21-20020a4a6c15000000b00581f8d7e4afmr1090598ooc.0.1697737502309; Thu, 19
 Oct 2023 10:45:02 -0700 (PDT)
Date: Thu, 19 Oct 2023 17:44:59 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABtrMWUC/6WOQQ6CMBBFr0K6dgytRsSV9zAsoExhktqSadNKC
 He3cgWX7y3++5sIyIRBPKpNMCYK5F0BdaqEnns3IdBYWKhaXWQtGwiRnV5WGJkScgCHETIxWgw
 ByEW0QNlmMgQmwzhMoEGaa2vqerj3CkVZXhgNfY7qqys8U4ie1+NEkj/7Xy9JkDCYW4u6GeXQN s/J+8niWfu36PZ9/wL0GBhH9wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697737501; l=2408;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+j1ZR4eOwaN2eWhtI6Or7popX8JK/RP2CN1CNyJtMuM=; b=BJyGQKERL2LGGUnreMt73sxdVT2rdOk9iwAulRF+/ouCnd05D/W3ZTM6a5zobWDvA04d1pUyB
 RMDmJtVuIm/DdGrXlkpaGZ8jYNcg5qsjcAjsQrDmYemRAMmAxa9iYGi
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
Subject: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Gregory Greenman <gregory.greenman@intel.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
both dump_info->dev_human_readable and dump_info->bus_human_readable are
intended to be NUL-terminated.

Moreover, since this seems to cross the file boundary let's NUL-pad to
ensure no behavior change.

strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
it.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- prefer strscpy_pad (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v1-1-bf69ec7d1b97@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3ab6a68f1e9f..7aa282592cdc 100644
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
+		strscpy_pad(dump_info->dev_human_readable, fwrt->trans->name,
+			sizeof(dump_info->dev_human_readable));
+		strscpy_pad(dump_info->bus_human_readable, fwrt->dev->bus->name,
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

