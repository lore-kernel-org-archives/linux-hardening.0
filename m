Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F712D743
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681684; cv=none; b=CSu492DR2+hGuEaR+DI5x9kiZH+UuuHTHvAH1YvPD8JKdD6HV1CpLsBs+tMFZzA9O1m412pbLT55nTHOa86JFNHIZWkIuv4JnIpOx94hP4pu+vph7YrqXxvguaJ9Nu9pdIZQdDT75z1+sioEjm39dl0xW2Bkt9qw3yqXcA0ZPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681684; c=relaxed/simple;
	bh=S2o1sUo5KPLCPT2eyiGeGCz4MtuFwjosW26PC//SCFw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JGKCg1eMxA8H3cDRBKolhZwxyrUE6zvGYDgeBXlo12kgzh4UmPoO1asMCjmDkm9zTVNG+V5Sp3B9QIhScXagrTO5PuMh4gl4Qp2JX20Kwf3eyxXqLAQ7gh8KDcM8xP6OCIYOz64ozrqBLGqCDPnPk/nXgG0zizTwRDjIolcqnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmN1ZzW9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmN1ZzW9"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64f63d768so2175454276.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 15:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709681681; x=1710286481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fm3EeStFIzAk85+vETH72VSgC7KPPApaIiaC0eURHqc=;
        b=RmN1ZzW9FdcuR7PVuB/v7qcXHrQFO0w5STOiKBtu4S+YuYNxAL3kO4wiD2IBNpx1zj
         mr9hy/1d+92CxI0Lkaz37cMlcmonqqk/P2J5pA3yR8YWUwRPAn1rUWL5MHZZ7nK6r7Ny
         IikuzMXR1g3GphqN781L1EjWKFIafm1qlyoqk+rAnysaa54OlQpRUXI8e/KKeIPgpuxy
         xOnDgDXCe/dIHmDfaSodMS7G6HeYs27nJgyvtZlfmRo762lv6aBBv7wsL7QApuMw/Zv3
         RFUW6a3MVh6KN1MlMmsGz8jyIXSWQysyP49UXwG/F8NS6ohCTMp1IlKLo16+2aq+2qZX
         9Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681681; x=1710286481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm3EeStFIzAk85+vETH72VSgC7KPPApaIiaC0eURHqc=;
        b=eL86ZRprrwxeMCS80v8T/M8gLf5wUc/GCqAnOiyRjdOiE56QaH7xRuAiBKO5HcJay0
         V+i4TxXoIHvLri+3pBWTd4k9he3RL78xw9NCPNHwcuBYpMQ/gj7G1b0eUNKfZfIIJDgq
         CD6oiemonBLIpOAov+DRTet0j3xmJQK5lLVyfxbX/qp6rYw+NfJDn8lLWQg7+Ln543/F
         JSvXHkaSQKihHPoMG/8b+rtB6yvWv+3VgajWHIeahYRinY+0uIN2ICcxC6SfzUtfnVJZ
         wl+6H9g+bCYH+ypbpf4hm6lg0n2iFPTni8jvxV51Q0wOglO85vdh7qqHsorVKLwgr8ud
         JDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsfEheKTdpETWriM27eaSWr7LCK/4BHfYn6xmc0W19Vu2OnDLkoYI+owU5hC6++xVVf6KJ4eNliJtTUfncLkLdV/J/ZdxHayrJ4lDBxNKt
X-Gm-Message-State: AOJu0Yx0vovARe9Sdz0D/p+F+NvWFPk/aHW7mBtuTZUOUNgN3yKcF9p8
	sNoGIf5NPCLsXuHY8z9EiuZtaKvkFOVYUXsCbgMl4+RjqfQB1lAb2mBm1ejPccPJkKLTmeC90yJ
	hBkU2w7oBBPYzmrKwv2iSpw==
X-Google-Smtp-Source: AGHT+IE+EhihKFp1AV0Ks/kBpof4c1iU4PMM+jPwxyvoWQq6aQK8OKeCF5YhNVfPqDUvBkRb9ZGIsn+AXaILjgfRtg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:100d:b0:dc6:cd85:bcd7 with
 SMTP id w13-20020a056902100d00b00dc6cd85bcd7mr3654071ybt.3.1709681680784;
 Tue, 05 Mar 2024 15:34:40 -0800 (PST)
Date: Tue, 05 Mar 2024 23:34:35 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAys52UC/42NQQrCMBBFryJZO5JMFKsr7yEi7SRpB2xTkhIV6
 d1Ni4Luuvq8v3jvJaINbKM4rl4i2MSRfZdBr1eCmrKrLbDJLFDiViIixCF01D/BBE42RIgUGdq
 edRs+c3V3IFCV0tLsVGWIRLb1wTp+zKXzJXPDcfDhOYeTmt5vQy9uJAUSDmR0UaCTeylPtff1z W7It2KKJPwVF8vFmMWmJFsZ7ciV/+JxHN/chAtgOAEAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709681680; l=1992;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=S2o1sUo5KPLCPT2eyiGeGCz4MtuFwjosW26PC//SCFw=; b=7+8qHAZ3oM99JvbuQ8eRN3JlnaRULZJKRxqW9xULkS6m9ejvTAmpvoT4okFTNUEmqyWppEJMS
 /ubJMnIj5IHBaWp0g/NyZfEQ9Q/5xWAYcIJ7VQlBmgLtDPyP70qCPpJ
X-Mailer: b4 0.12.3
Message-ID: <20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-0-5b78a13ff984@google.com>
Subject: [PATCH v3 0/7] scsi: replace deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

This series contains multiple replacements of strncpy throughout the
scsi subsystem.

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. The details of each replacement will be in their respective
patch.

---
Changes in v3:
- update trailers (thanks Kees)
- Link to v2: https://lore.kernel.org/r/20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com

Changes in v2:
- for (1/7): change strscpy to simple const char* assignments
- Link to v1: https://lore.kernel.org/r/20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com

---
Justin Stitt (7):
      scsi: mpi3mr: replace deprecated strncpy with assignments
      scsi: mpt3sas: replace deprecated strncpy with strscpy
      scsi: qedf: replace deprecated strncpy with strscpy
      scsi: qla4xxx: replace deprecated strncpy with strscpy
      scsi: devinfo: replace strncpy and manual pad
      scsi: smartpqi: replace deprecated strncpy with strscpy
      scsi: wd33c93: replace deprecated strncpy with strscpy

 drivers/net/ethernet/qlogic/qed/qed_main.c |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c            | 10 +++++-----
 drivers/scsi/mpt3sas/mpt3sas_base.c        |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c   | 18 +++++++++---------
 drivers/scsi/qedf/qedf_main.c              |  2 +-
 drivers/scsi/qla4xxx/ql4_mbx.c             | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c              | 14 +++++++-------
 drivers/scsi/scsi_devinfo.c                | 18 ++++++++++--------
 drivers/scsi/smartpqi/smartpqi_init.c      |  5 ++---
 drivers/scsi/wd33c93.c                     |  4 +---
 10 files changed, 49 insertions(+), 43 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-1b130d51bdcc

Best regards,
--
Justin Stitt <justinstitt@google.com>

