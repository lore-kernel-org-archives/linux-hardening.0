Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AB39850
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gInKwQPE"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC8115
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 15:48:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7ed6903a6so112051147b3.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697669330; x=1698274130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bSQ7qSQqMVz/tkx7lIyl6/3Dlp40FjkhjBtPKLDoWc=;
        b=gInKwQPEan85wo+wHCJe1s91K8I/+OYBZigEUPoAf21eDXGWzAIBMH2J3nf5kqd3g7
         yKn49VFOaPzGPlZzrXVG6vT788Ngics3kvSkIiIdYxwDB/yD31OSAaMN21jGybJnD89x
         /938DYxr0UcAmdPfeSykAYcgByOFQDNDlS4M4LtZ3yc2Y9BMQ0Ri2WGeklOYf+Tj/wJP
         RMGLphqBHbTrS0IMk3tBXJjKVCF99bJ+h+2RIaGmrEo4kwLdMhj8IGajfKquEcJj7PS+
         WFikqZ1PXePbzZMY0bGcMDyhyp+XZ3T0V9TfzP6CE3uoqOO6RF/WhvEDPEfM1iMUTE93
         SAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697669330; x=1698274130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bSQ7qSQqMVz/tkx7lIyl6/3Dlp40FjkhjBtPKLDoWc=;
        b=g78fWxaFjHVGKP33jKONlffPKuwxvmVKS/rRxyjGIqIG19mk480uH7j/0WWFUhziWJ
         KNRLIsngDAPYH2H941/tCYo9BUytFJtrVpC+7QWizDc+BE7igsbWpe44NZ135hiTXCVr
         MKfNaDNsCTM/UHBLj5EcZgDAdchb3eRksCD+/dM0bdZLOnOd4D9P46tsdfMuHwcXt7RU
         ovAu7GXOdACY/8twyYGiMeN44Y1qHEctz2zF9GtmN/XtNRiH5v9vPkL0CVXm/K51AMTb
         e0F+MyZ88R9777srssHaPTMqQUuJunuOxTnLPQU4wqlDUBpM/gHckNMqqXt79jx2Sexg
         sTJA==
X-Gm-Message-State: AOJu0Yz+zkJIVdgDs+JlZzR8Wvm3fpJWLGC/AyJGt6H4dhy2MoJA0gsf
	3viBJyKP720q4MV2C4kEvokokZONZASTSFX/lg==
X-Google-Smtp-Source: AGHT+IGqdbWqQ7PEH4cUhxYJPzQti8rdqGeesI2OpR3f/9GfHYGXO/4kPNJHLV8sRzDs+qy+E+CBZAMToF2ahSILCA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:5217:0:b0:57a:118a:f31 with SMTP
 id g23-20020a815217000000b0057a118a0f31mr15075ywb.7.1697669330350; Wed, 18
 Oct 2023 15:48:50 -0700 (PDT)
Date: Wed, 18 Oct 2023 22:48:49 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANBgMGUC/x3NMQ6DMAxA0asgz7VEDFRpr1IxhGDAQwOyUdQKc
 Xcixrf8f4CxChu8qwOUs5isqcA9KohLSDOjjMVANTWudh5t1xS3P44qmdUw5S/jstqOUxhUomH E1j2p84Goe3kopU15kt99+fTneQF0i0XsdQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697669329; l=2668;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=eTZl8RLmSTRi1g6HBFXiHkDVcGwMrh/QN3Blnb4tlGM=; b=NqNL716tMxkz9di1bgPcw2w6eC4c776nurW+wFygYEOGZYbyCCVOYleoxDFKohV9u1XrQ7RvN
 UxB6tgf9Ik5CsmgFtVwMYknNxVzD3Jah1eF23yTnA5oMSFhciN+z9AP
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
Subject: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect both data->subsysnqn and data->hostnqn to be NUL-terminated
based on their usage with format specifier ("%s"):
fabrics.c:
322: dev_err(ctrl->device,
323:   "%s, subsysnqn \"%s\"\n",
324:   inv_data, data->subsysnqn);
...
349: dev_err(ctrl->device,
350: 	 "Connect for subsystem %s is not allowed, hostnqn: %s\n",
351: 	 data->subsysnqn, data->hostnqn);

Moreover, there's no need to NUL-pad since `data` is zero-allocated
already in fabrics.c:
383: data = kzalloc(sizeof(*data), GFP_KERNEL);
... therefore any further NUL-padding is rendered useless.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

I opted not to switch NVMF_NQN_SIZE to sizeof(data->xyz) because the
size is defined as:
|       /* NQN names in commands fields specified one size */
|       #define NVMF_NQN_FIELD_LEN	256

... while NVMF_NQN_SIZE is defined as:
|       /* However the max length of a qualified name is another size */
|       #define NVMF_NQN_SIZE		223

Since 223 seems pretty magic, I'm not going to touch it.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8175d49f2909..57aad3ce311a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -386,8 +386,8 @@ static struct nvmf_connect_data *nvmf_connect_data_prep(struct nvme_ctrl *ctrl,
 
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
 	data->cntlid = cpu_to_le16(cntlid);
-	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
-	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
+	strscpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
+	strscpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	return data;
 }

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-nvme-host-fabrics-c-416258a22598

Best regards,
--
Justin Stitt <justinstitt@google.com>

