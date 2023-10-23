Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF51B26D
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnZYaIDM"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBDD10E
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 13:12:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so46765177b3.0
        for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698091943; x=1698696743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TaYzqiDcDWKgPy4uGsQmrLXLk2sBD/yDm1Jxt8SJs8M=;
        b=LnZYaIDMWg7IVK3lRjrc4+EjjUnh2MqiMWJr6ZhH+lryJnEi0uAS0ExJiY2S3qaiRi
         lvj1k9OzrDh7YRMoSDet2GGQdOYCAMqcFl+nfTNqWfnDZ+6t7SHF0y+4TF9ia4VY/gNk
         k8UEY9gH1DYd/HaaLsTbimpBvZhz0TIl/RUyHJZJgMEi9O4E+d80sGONz8ibFO6V7VtE
         U7IlvLtoUcRY/PNfMLM/EIM1mdlKrRfkWM5Dj8X1DTnwaNV7HyCWzvjipyTL9aYR82c9
         +R4yo0XTvm7pGEz0RLLzwJRdH4N5Q/aDpRMeuO3Jz5MhVDQxcPZZKubPPp9h75GJGZH8
         XfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698091943; x=1698696743;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaYzqiDcDWKgPy4uGsQmrLXLk2sBD/yDm1Jxt8SJs8M=;
        b=bWsCynPnELXNKgW5wY3gzvd9FfFQJGcfZG8Y/cdECNXzqi/gI6rswgr7si5Jl6X0oX
         QHvs5Z0SRtl0+fADdN5t8kvnHly53DYnez2PA9z6dFvuUMvJzRmwsZDia7xyzk6PdqsD
         3zerO6GEbGBqBguHXAgv+FyyK8hrNmxEgEbn9fuEo76QLzvQYa4OxIPdMY5PcycREgge
         X6xFq5PL3aWNG9GmPbqtg+THvEFH5Jha044BjGocdyGhUtOusg+CdV5uPZedZ1/Rpc74
         QxC1JXIlH5n7/g09yTNmCwnc4kakjnBBlNbJPAnGm5Hq6GuVKOWpxWN0lhNKUTLU5y8D
         mxSA==
X-Gm-Message-State: AOJu0Yz4KDXeQ9sYbky7/saRTuxEwT9eamsjo2ojUamAert2O/Qmq5Qp
	7dTTtnvVpQkdmzz6+LvllwHNRa2Xgy2jSm15ig==
X-Google-Smtp-Source: AGHT+IHDcQhZF3S6ev46PsP31VJ143R9m5nA9+25vhWXz518arOoV43l0DM3lCYGWdXUSli8kfuj4DTuRkUgpAueEw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:8485:0:b0:da0:394d:7e19 with SMTP
 id v5-20020a258485000000b00da0394d7e19mr3980ybk.12.1698091943613; Mon, 23 Oct
 2023 13:12:23 -0700 (PDT)
Date: Mon, 23 Oct 2023 20:12:22 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKXTNmUC/y2NQQqDQAxFryJZN6AzjpRepRSxMaPZjJIUUWTu3
 kFcPD5v898Jxips8KpOUN7EZElFmkcFNA9pYpSxOLja+aaA9tNE64GjysZqaGSC37S7SPf0kRZ Gwuha78Oz7dgHKH+rcpT9ar0/Of8B91Q6OnsAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698091942; l=3749;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=nllTzTiPjRT5s2K8r25wvqMnTGFjjYXsOSJyrZ516eA=; b=Cfv7kTFGU3by66ZpqIYT0fT+2TqTsEGOn7q86guhmaK5u4xcxkPzCD4nMiXOHBYWA55tKtuJG
 u/PgjCIgPA1AJ7eSIxsqoVNfvWZeb5i6SozixjafFpQAGDMsEsAhjTE
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-v1-1-a3736943cde2@google.com>
Subject: [PATCH] scsi: bnx2fc: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect hba->chip_num to be NUL-terminated based on its usage with
format strings:

	snprintf(fc_host_symbolic_name(lport->host), 256,
		 "%s (QLogic %s) v%s over %s",
		BNX2FC_NAME, hba->chip_num, BNX2FC_VERSION,
		interface->netdev->name);

Moreover, NUL-padding is not required as hba is zero-allocated from its
callsite:

	hba = kzalloc(sizeof(*hba), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Regarding stats_addr->version, I've opted to also use strscpy() instead
of strscpy_pad() as I typically see these XYZ_get_strings() pass
zero-allocated data. I couldn't track all of where
bnx2fc_ulp_get_stats() is used and if required, we could opt for
strscpy_pad().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 05ddbb9bb7d8..3ebfb09329ad 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1737,32 +1737,32 @@ static int bnx2fc_bind_pcidev(struct bnx2fc_hba *hba)
 
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_NX2_57710:
-		strncpy(hba->chip_num, "BCM57710", BCM_CHIP_LEN);
+		strscpy(hba->chip_num, "BCM57710", sizeof(hba->chip_num));
 		break;
 	case PCI_DEVICE_ID_NX2_57711:
-		strncpy(hba->chip_num, "BCM57711", BCM_CHIP_LEN);
+		strscpy(hba->chip_num, "BCM57711", sizeof(hba->chip_num));
 		break;
 	case PCI_DEVICE_ID_NX2_57712:
 	case PCI_DEVICE_ID_NX2_57712_MF:
 	case PCI_DEVICE_ID_NX2_57712_VF:
-		strncpy(hba->chip_num, "BCM57712", BCM_CHIP_LEN);
+		strscpy(hba->chip_num, "BCM57712", sizeof(hba->chip_num));
 		break;
 	case PCI_DEVICE_ID_NX2_57800:
 	case PCI_DEVICE_ID_NX2_57800_MF:
 	case PCI_DEVICE_ID_NX2_57800_VF:
-		strncpy(hba->chip_num, "BCM57800", BCM_CHIP_LEN);
+		strscpy(hba->chip_num, "BCM57800", sizeof(hba->chip_num));
 		break;
 	case PCI_DEVICE_ID_NX2_57810:
 	case PCI_DEVICE_ID_NX2_57810_MF:
 	case PCI_DEVICE_ID_NX2_57810_VF:
-		strncpy(hba->chip_num, "BCM57810", BCM_CHIP_LEN);
+		strscpy(hba->chip_num, "BCM57810", sizeof(hba->chip_num));
 		break;
 	case PCI_DEVICE_ID_NX2_57840:
 	case PCI_DEVICE_ID_NX2_57840_MF:
 	case PCI_DEVICE_ID_NX2_57840_VF:
 	case PCI_DEVICE_ID_NX2_57840_2_20:
 	case PCI_DEVICE_ID_NX2_57840_4_10:
-		strncpy(hba->chip_num, "BCM57840", BCM_CHIP_LEN);
+		strscpy(hba->chip_num, "BCM57840", sizeof(hba->chip_num));
 		break;
 	default:
 		pr_err(PFX "Unknown device id 0x%x\n", pdev->device);
@@ -1800,7 +1800,7 @@ static int bnx2fc_ulp_get_stats(void *handle)
 	if (!stats_addr)
 		return -EINVAL;
 
-	strncpy(stats_addr->version, BNX2FC_VERSION,
+	strscpy(stats_addr->version, BNX2FC_VERSION,
 		sizeof(stats_addr->version));
 	stats_addr->txq_size = BNX2FC_SQ_WQES_MAX;
 	stats_addr->rxq_size = BNX2FC_CQ_WQES_MAX;

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-f24335846e35

Best regards,
--
Justin Stitt <justinstitt@google.com>

