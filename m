Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9BEBE
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeVtC2BS"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958236FA9
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 13:11:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so46359397b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697573489; x=1698178289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=46uGEBVZYP60+QlvEII0CTGZBlglU94CwFi36yzEJK0=;
        b=AeVtC2BSNpT8MtYUSkZrW8w/3ODWpmPxbbm5cApqPOQSvPO7gpWubgFc7NY0L3fe+9
         5vLqEngKLXZHvJ7u+ZfDE3jKt/Z19nQKMaLQHmgoNwPChNVCWtDELGtkrkS0kLAhk+ho
         tMti36yuHPrk9yCcbfgcOUOVqlaLATBWM6H/orinkDfqQLl72QEanTne7tjBgV+BxYiZ
         0dxKlAbBum/K6cBAdc3+QtCJkXOOo1x4yGOCUjgRnfSbupkj+BNLxpcEWKrZoG/UHg6J
         jq70bBYizPgNKFEvzj0Mb6X5jPvnFN8JLmuTRPMDQ+cUwgtppx+LN048rBK96bmQ6f5W
         x41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573489; x=1698178289;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46uGEBVZYP60+QlvEII0CTGZBlglU94CwFi36yzEJK0=;
        b=weX+tCGBAh+p2XHwj++dXE0wj9J1z5WMmFIAeYJi8q2oYSc0lLo2Dbtj+G2nYGfcKt
         BGqry6t7BrizNxLD66mj+7ofP4QTKv+/niGPXl+jB+57Rx6lqvInQHfemXit+taW4Wy6
         w0PbUSC8xjfuXvSF7X7Ee2neLSJpXAWcy259ctFlGM8nlXdfMWd//lV05jz+lStpvSbI
         ZEYgt6qxKsfAwEjiMBBWo3pXLw4AxAcMeZHF9PgsCP0UytZ6LBlANd/8BIrucj1ETbvN
         C2Hpm4acnL1DudgpKP3Z0VF4hGT0svplpFzoqR/pioRYOFzJljPNIsFv+IAYzwxuklPt
         qKIA==
X-Gm-Message-State: AOJu0YwY1zhSze+hNMCJq7H5RBbvbedtW3QjXiGWsDw0o2B3PsSxDEBy
	kBoPPz3UQcHhwzEY5b/rC/3MgLmdyEnIGXPhRQ==
X-Google-Smtp-Source: AGHT+IEfJLWMLoOm4C5rtgg3wHRXpdPuCDymBXGKzRp1SsYn6OfhPJ/L9Vc3+vwyzmjrpHdHSKS0VUjS83Q/Y+1Wlw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:2e87:b0:5a7:b95c:a58f with
 SMTP id eu7-20020a05690c2e8700b005a7b95ca58fmr71164ywb.1.1697573488855; Tue,
 17 Oct 2023 13:11:28 -0700 (PDT)
Date: Tue, 17 Oct 2023 20:11:27 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG/qLmUC/7WOwQ6CMBBEf8X07JpuQWg8+R/GQ10WaALUbEnVG
 P7diifveps3yeTNU0UWz1EdNk8lnHz0YcpQbDeKejd1DL7JrIw2BWqsIM4y0fUBjfjEEmHiGW5
 eeOAY4SLBNRTGHGi02iCuqR0dAbXdpyFwRqO2pcHK7lU2XYVbf19fnM6Zex/nII/1VMJ3+1t/Q kAoTVFaXZPTNR+7ELqBd3mq3geS+YPUZGlF9b6qGZviYr+ky7K8AFHQlQeMAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697573487; l=2149;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=IYHa4GmWLvGCvatbI5bBzz5yNCmTjMuR/IQRybWbAVA=; b=92S9SAvX+VpKkETDSsphUKuxpQoOMQ38sXOjPqap5XFBJDgU6idJpjDTsAT6xQE5WhuPekvyN
 ZGd3Vn32yiOB+ntaW9DlkyRHaWbxMNkQ7hltpgq0KkZV8Pz03ozInsQ
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
Subject: [PATCH v3 0/2] wifi: brcm80211: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
	SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This series used to be just one patch in [v2] but I've split it into two
separate patches.

The motivation behind this series is that strncpy() is deprecated for
use on NUL-terminated destination strings [1] and as such we should
prefer more robust and less ambiguous string interfaces.

In cases where we expect the destination buffer to be NUL-terminated
let's opt for strscpy() as this guarantees NUL-termination. Other cases
are just simple byte copies with pre-determined bounds; for these let's
use plain-ol' memcpy().

Each change is detailed in its accompanying patch message.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- split up into two separate patches (thanks Franky)
- use better subject line (thanks Franky + Kalle)
- Link to v2: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com

Changes in v2:
- add other strncpy replacements
- Link to v1: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com

---
Justin Stitt (2):
      wifi: brcm80211: replace deprecated strncpy with strscpy
      wifi: brcmsmac: replace deprecated strncpy with memcpy

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c  | 6 +++---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c      | 3 +--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c     | 4 ++--
 5 files changed, 8 insertions(+), 9 deletions(-)
---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-a20108421685

Best regards,
--
Justin Stitt <justinstitt@google.com>

