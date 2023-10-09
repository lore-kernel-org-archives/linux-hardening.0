Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E761173D
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGgDo/H5"
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316BA4
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 16:19:58 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1dd51b98342so7460751fac.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696893598; x=1697498398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zjHQyvadONVOud3v/rE/Az+3J92aB2vK1iZQZ/OYRLE=;
        b=rGgDo/H5T9gZYLPmFpOQGJVZ4k6OAoKrpALI+biAf+tM24a13+h8KfK3Z04ysSZ92P
         lcuIFq/S4RgiZPrxJP7OmlhmlRU3lP3uCwsV0FXtlKSSIHlYV9rW8AeQO3Xm0MbOsnWP
         J3wfoKZSiXvl/Hq9nzVcR+F5zG1k6TXmEy+eIfQ27mzRP0ueLKEl4shn+W5X9EvW4aF4
         rg8v2ZjME3f2/4jTY7OaPnHOV5IXd6IHVti0q8gKE/J+MLPpVjCSoghcTIQ5Ce8UWkSs
         kcWyqBJ5YQeYo7503/Vv8QxoJTQHr48OQFlXT7ZjBY/SFK8w+WEGP8WlqQyDgLV4KPFj
         +H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696893598; x=1697498398;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjHQyvadONVOud3v/rE/Az+3J92aB2vK1iZQZ/OYRLE=;
        b=hXZRSQJH41G1JHhDmgOCugBtRP3Cz3hw2+5AgbGR4SqarVBkMgRKIVNG8AXOHnQRX8
         QZ6+d1ETMIjm8fVCyAY23A99W8+01EBiU2nK9IQ91f2tNQpRZ69bio4xfQRjmKqJb2GL
         1lnQkzZgiE+L+//+9n4nPiIrc0OEw/QHTMJhpxVV5UpXuk7P/PgqsplOWofNxO8zlzT7
         jY3RZXCckwM1ggVfRtNU9QIL68nub417GYIpHa3+ieOPwCKiiAL7jQG9IeijgnCLdqYo
         E8/tw+ZJtAvW44AHlpXYDS/sTJv4qeZXnHjjNxx+xj+aR8TavbFYe8+i+XtabH3gFjao
         KAQg==
X-Gm-Message-State: AOJu0Yx5IPxJkJJC5jmrGySocMAH2Ckqs7qUJ4cGlpMTGrgJ3dztSYPL
	u0/1f2LctwHpmSgwH+9kMRhp6+n8d8wyigN2oA==
X-Google-Smtp-Source: AGHT+IEJoSw0wb7t9m20c6ZpjKDlOmD783PHpu5vdHPvTTgfWAZC5cRf21JJzRLNwBCQUCa+9r2jjqVtgVy/1uiCHQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:3a10:b0:1d5:95fc:2a65 with
 SMTP id du16-20020a0568703a1000b001d595fc2a65mr6733088oab.0.1696893598255;
 Mon, 09 Oct 2023 16:19:58 -0700 (PDT)
Date: Mon, 09 Oct 2023 23:19:57 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJyKJGUC/x2NQQrCMBBFr1Jm7cCkohCvIi7a9GtnYSwzIVRK7
 27q4sF/m/82cpjC6dZtZKjq+slNwqmjNA/5BdapOfXSn4NIZC+W0/LlybTCnDMKo8ywY+j4Pqh ZEyeGRJFxCBGXK7XDxfDU9R+7P/b9B+1asIF8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696893597; l=1913;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=IQPojGhMm0FWYkhisYrQ00VPkfbCrbcIeRucK9CSAtU=; b=lqQitRgTvDQrS2yNAdU1MwFFmxI/TImPYzq1XkAQrajgWQGjpKNWCOFzZ6AGd8vHFb8Xj4b88
 UcPIIFUP2hSCCsgd+ycewkMTnHNJ1UB2BTMpZXFag89Q1wnWwAwYyer
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-v1-1-712866f16754@google.com>
Subject: [PATCH] ibmvnic: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Haren Myneni <haren@linux.ibm.com>, 
	Rick Lindsley <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, 
	Dany Madden <danymadden@us.ibm.com>, Thomas Falcon <tlfalcon@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

NUL-padding is not required as the buffer is already memset to 0:
|       memset(adapter->fw_version, 0, 32);

Note that another usage of strscpy exists on the same buffer:
|       strscpy((char *)adapter->fw_version, "N/A", sizeof(adapter->fw_version));

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
---
 drivers/net/ethernet/ibm/ibmvnic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index cdf5251e5679..ac15dcadf4c1 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5247,7 +5247,8 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
 	/* copy firmware version string from vpd into adapter */
 	if ((substr + 3 + fw_level_len) <
 	    (adapter->vpd->buff + adapter->vpd->len)) {
-		strncpy((char *)adapter->fw_version, substr + 3, fw_level_len);
+		strscpy(adapter->fw_version, substr + 3,
+			sizeof(adapter->fw_version));
 	} else {
 		dev_info(dev, "FW substr extrapolated VPD buff\n");
 	}

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-ethernet-ibm-ibmvnic-c-e0900ba19e56

Best regards,
--
Justin Stitt <justinstitt@google.com>

