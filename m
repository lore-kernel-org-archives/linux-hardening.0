Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3439850
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2p2deGNH"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F04114
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 15:35:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d99ec34829aso10185596276.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697668548; x=1698273348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U1aLFdy4LtlPdLdmsrELCrrPTI/o77pTc9HEh1RET2I=;
        b=2p2deGNHebLT4omQqAuYtJ4sY0mclka+JFK43mbygOfC0S3ELvUQIZJy2zK8/e0xau
         htu9nWxPiycgejEvsZhGPBgA5GBH27pu1j0qirCXPgQeO1fWl9aLh+qcCiO+x1baE22x
         jhWuDcbkIM+4occcsxqZ4u4j8E4FQ8BzRZgeL0DBSNkcoF3U55iqT7OvlSMyEaOR1HCF
         +ixVsEtDtDdPCsoZGath00LU4eXoC/m78Mh6Vz2KWlCEL/vGJtIkOZlk59i+34N46BHc
         fHExU/qYYf7CEzND76rpM8W/HQ60Iwx+WVghUWB+l+qXf6MDsaj6/bWxCCbW8fnaDQd5
         wCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668548; x=1698273348;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1aLFdy4LtlPdLdmsrELCrrPTI/o77pTc9HEh1RET2I=;
        b=if9SGd3xnKZt1BmpG6IwRA+KAQy6vfH9rdSgzgrqDDMVy8aSzPcxU/MW++lJzB3ypv
         RZEMpWPM0KuBtNLgbNJwacd+qGmWs2NZx/lPrNJDDQnAdvbtpx1JeO3YxVZbspwObj95
         pPya04OMvsySt8SbOshDVBdIescLFvS6k3Vb6iRZ5P9qQh8hlX3xGDYu/gKqM+XI3YWg
         9I8byAtIRX6baSRQmvPEarKghxAL+lRKpsAs4jftSbGTfS0bL/AKzTA/CWSGRF+IGByJ
         RKZJ77VEXk6QAnVht3lwc6w8KekugRTfIiu06gICR1TZ2ddLoWZcOlpXwWf698NSR+yJ
         sTAg==
X-Gm-Message-State: AOJu0YwiVE0/rof1qHIMNdk1ZD4HlqbbzsTUBKskYSMIqR5ZVAE0hbqg
	VOnVdta/OOufgcezmagGz3EEg3PQ+SZWE4O7dg==
X-Google-Smtp-Source: AGHT+IHwV2J0r/LBLvfNxSR2yGnXuXn3OeZ4+CSobU/6GKBkVZsitkQV2vNVMQqnN+mNHOCCvKr7NZw07FSmbv3F3g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b0a8:0:b0:d9a:3a14:a5a2 with SMTP
 id f40-20020a25b0a8000000b00d9a3a14a5a2mr15465ybj.13.1697668548155; Wed, 18
 Oct 2023 15:35:48 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:35:47 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMJdMGUC/x3MwQqDMAwA0F+RnA20yljrr4iH2cYth3aSlOIQ/
 92y47u8E5SESWHqThCqrPzNDbbvIHxe+U3IsRkGM4zWWIdaJIf9h1G4kijmGjklXEvBgPax+dE 9vXeeoBW70MbHv5+X67oBjezIGm4AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697668547; l=2405;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wIXUkCLacDcvyYmWwXYlHGDFUt9BdHJS6MZL7uBj9BA=; b=n6GHlGhf250MWDnVuic43BVfEnftE5cYh9pXrKoHjqf2BnIxPPqvucB7iOWWF8tO9siLtvPfq
 0GZIeKqaZp+DOlGpq6Beb706YYhYEaXrCt36mqglIArldQsjrnrBK+2
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-nvdimm-btt-c-v1-1-58070f7dc5c9@google.com>
Subject: [PATCH] block: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect super->signature to be NUL-terminated based on its usage with
memcpy against a NUL-term'd buffer:
btt_devs.c:
253 | if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
btt.h:
13  | #define BTT_SIG "BTT_ARENA_INFO\0"

NUL-padding is not required as `super` is already zero-allocated:
btt.c:
985 | super = kzalloc(sizeof(struct btt_sb), GFP_NOIO);
... rendering any additional NUL-padding superfluous.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also use the more idiomatic strscpy usage of (dest, src,
sizeof(dest)) instead of (dest, src, XYZ_LEN) for buffers that the
compiler can determine the size of. This more tightly correlates the
destination buffer to the amount of bytes copied.

Side note, this pattern of memcmp() on two NUL-terminated strings should
really be changed to just a strncmp(), if i'm not mistaken? I see
multiple instances of this pattern in this system.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/nvdimm/btt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index d5593b0dc700..9372c36e8f76 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -986,7 +986,7 @@ static int btt_arena_write_layout(struct arena_info *arena)
 	if (!super)
 		return -ENOMEM;
 
-	strncpy(super->signature, BTT_SIG, BTT_SIG_LEN);
+	strscpy(super->signature, BTT_SIG, sizeof(super->signature));
 	export_uuid(super->uuid, nd_btt->uuid);
 	export_uuid(super->parent_uuid, parent_uuid);
 	super->flags = cpu_to_le32(arena->flags);

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-nvdimm-btt-c-15f93879989e

Best regards,
--
Justin Stitt <justinstitt@google.com>

