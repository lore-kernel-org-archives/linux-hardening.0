Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26163D529
	for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEJKJlI3"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B227C6
	for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 12:04:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a828bdcfbaso48558577b3.2
        for <linux-hardening@vger.kernel.org>; Mon, 30 Oct 2023 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698692674; x=1699297474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VzjnyJquTGOFDWRTCwIsnRPKQd4yoRAbd2BHiNTCYPE=;
        b=EEJKJlI3j02hbDoFlIPRQJC5wSuF3SlQNHQ4XVNv2VVn8dB1YtDyWRHgh9s7e4j136
         Ms+iUGkcFpCRkMUtcrvXpdTm1pgmINLMif64cGkftgnd+6NseVTOSrJ8IhtPaG4IwRc/
         ItTCD4RcQ28Hw/JqhAFEoXnlXx54c0pDZ3d5aJpS5KXN79UREtGnQh4r4sCXUpOKo0sJ
         rIqNjHVEh/QF47YL39bP9uckW1fRfYz0PTPsEvZWPRI7fnkGVfiJds4ikx4fu8UwEHwd
         ec6tJ3dIhvm+wGv/zem5nzmH2ymJ1vzwW4da165MsLED0w3BqkEAuwmlJBG8V/H6uB5e
         p1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692674; x=1699297474;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzjnyJquTGOFDWRTCwIsnRPKQd4yoRAbd2BHiNTCYPE=;
        b=KFOge1BhCUBgh4vILvMwnzUrgIBRz93ESIcwcfTzHX1qCu+bC6N9kb0TAz22JI22IN
         t5kHVHN+KEgXXYkIqkPA/RjkOt9tAGIGMfWY0/LR7VL1QNQH1lDwTuOqm1334nR3ERuu
         MHmDj8XZ4R2ZQZLFmfPnvHAXbWLoUaTSkcv1GQY5n6UhRiSU4qFoU0j8cmta6eeehGuM
         4y8QztjYcpPlauVA7YqdLzYEMz+7GOzyb1JsjSJuFBCUkSrycPl2h4Ln9SVYhXkkTlwI
         BZrrSrn7ILEgt3TNCyvSTZHsmrxUZAZwD2P7scJCFD8ArIa+Ifgi9BgsG47WGYHQbtE4
         jTGw==
X-Gm-Message-State: AOJu0YzcSnhkAsTwBihEeYpasDFBLl3QGlSowI5FnKTmGgS9vX9CaXxR
	IjLTFfquIKH5hOyTJ0aWzN37mwxYjmGENuoCew==
X-Google-Smtp-Source: AGHT+IGs9hKG8tQnq+Kf3PiCNiCsBtpBmbVL7oN4YtYcjhYgkAwIvgGyw0USxYueImjqREofzsC5LZCxvaMlUQpNyQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:2d24:0:b0:d9a:4e29:6353 with SMTP
 id t36-20020a252d24000000b00d9a4e296353mr218208ybt.0.1698692674494; Mon, 30
 Oct 2023 12:04:34 -0700 (PDT)
Date: Mon, 30 Oct 2023 19:04:33 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAED+P2UC/z2NQQqDMBBFryKzdiAmBKRXKS7qZKKzaCozEiri3
 Ru6kLf5b/PfCcYqbPDoTlCuYvIpTYa+A1pfZWGU1By882FwwaHtWmg7MKlUVkMjE5T5Xe+RCRu UiYOPMcUR2tmmnOX7Dz2n6/oBR6DxKHgAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698692673; l=3539;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=72GgGEwj5Ps4pN3RPFU4tntY2mPxjof123VGlstKADQ=; b=zhou5EtC7CO55iMzjZDC3sTtF8LQi9QWb7YsZHwNRpQImsTgbFvjV9qobc8UJI22pNUZTB22k
 UiJOp9DK74sDASAGgsMQXEHSs+ldJdpEAf29LQBBGDrJByfvj0X0ISh
X-Mailer: b4 0.12.3
Message-ID: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-v1-1-5a4909688435@google.com>
Subject: [PATCH] scsi: ibmvfc: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect these fields to be NUL-terminated as the property names from
which they are derived are also NUL-terminated.

Moreover, NUL-padding is not required as our destination buffers are
already NUL-allocated and any future NUL-byte assignments are redundant
(like the ones that strncpy() does).
ibmvfc_probe() ->
|       struct ibmvfc_host *vhost;
|       struct Scsi_Host *shost;
...
| 	shost = scsi_host_alloc(&driver_template, sizeof(*vhost));
... **side note: is this a bug? Looks like a type to me   ^^^^^**
...
|	vhost = shost_priv(shost);

... where shost_priv() is:
|       static inline void *shost_priv(struct Scsi_Host *shost)
|       {
|       	return (void *)shost->hostdata;
|       }

.. and:
scsi_host_alloc() ->
| 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);

And for login_info->..., NUL-padding is also not required as it is
explicitly memset to 0:
|	memset(login_info, 0, sizeof(*login_info));

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
 drivers/scsi/ibmvscsi/ibmvfc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index ce9eb00e2ca0..e73a39b1c832 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1455,7 +1455,7 @@ static void ibmvfc_gather_partition_info(struct ibmvfc_host *vhost)
 
 	name = of_get_property(rootdn, "ibm,partition-name", NULL);
 	if (name)
-		strncpy(vhost->partition_name, name, sizeof(vhost->partition_name));
+		strscpy(vhost->partition_name, name, sizeof(vhost->partition_name));
 	num = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (num)
 		vhost->partition_number = *num;
@@ -1498,13 +1498,15 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 	login_info->async.va = cpu_to_be64(vhost->async_crq.msg_token);
 	login_info->async.len = cpu_to_be32(async_crq->size *
 					    sizeof(*async_crq->msgs.async));
-	strncpy(login_info->partition_name, vhost->partition_name, IBMVFC_MAX_NAME);
-	strncpy(login_info->device_name,
-		dev_name(&vhost->host->shost_gendev), IBMVFC_MAX_NAME);
+	strscpy(login_info->partition_name, vhost->partition_name,
+		sizeof(login_info->partition_name));
+
+	strscpy(login_info->device_name,
+		dev_name(&vhost->host->shost_gendev), sizeof(login_info->device_name));
 
 	location = of_get_property(of_node, "ibm,loc-code", NULL);
 	location = location ? location : dev_name(vhost->dev);
-	strncpy(login_info->drc_name, location, IBMVFC_MAX_NAME);
+	strscpy(login_info->drc_name, location, sizeof(login_info->drc_name));
 }
 
 /**

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231030-strncpy-drivers-scsi-ibmvscsi-ibmvfc-c-ccfce3255d58

Best regards,
--
Justin Stitt <justinstitt@google.com>

