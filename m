Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7641493AC
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726995; cv=none; b=UbPnuismjKW+fr1rZ3uLo3cxSeowT0cKC1aJv6iG+sZ5Wm/B3Uw8JhZrmePS4x7H6+bQQf8sJ/7OMP69uVe8YTb0WwouZ/ZGjPXdDnSJl+OU/xDrOcR6DorXChsCLFF5hbrHTjSMZk7WP/IW2ZSHx5qJGWF/Ern9qiV/JGdRfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726995; c=relaxed/simple;
	bh=jZLUyLw+PYly8jkRw97FHtiAlxLeYw/ruqpi5XPfw0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TlUYCcBZ5Af/u4Y+15De8e7PSksvk52cR13mgBZ2ZBVn2w8aMLd3z54iSwN7f1pKo0Cr2xOkGn+zYQpKEsz7Vg+dQ6XDAviE5/+E2iDVNX5UMofoR9RLGrBCU8MpInIF0+T/APStcEdDtllKA02QXwoy3c4tzPt1CDcnBVfrp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hY1blRTU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY1blRTU"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2227816276.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708726992; x=1709331792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+qlm5aO/aQ4uIkmSxxKlZZ/tyfKC6M+ie/SGRsUmdY=;
        b=hY1blRTUIu/7qOkJO+c+Mx8xrzFy8m3C4BfImk4ERUZLeBrmqReZ4BKI6Sd+j650CK
         pTuDfL+n/SWYEB3Qrps1id7GSCoIc/74zw5ziizUb9w6JcSFTQKsWVbEZG7gaXmPXgcl
         gxEfueKbdrdzKoQwOT4ndWRR0XV7vO39pquNcqo8fJEOe5TJM6juQsxChOf3sArCIVkH
         QC0JVFIQoLycFBQ6wXaAu8RrfX9mAy65gr6EKryWk2Ui2D4CPzTMu5YMb5LH3cY9FPFB
         ZSNLyJGsW6Gb8mo11uwCvQw51+UIi80x2QH8pT4TUMJZMdh01TFl0djdBidcm9P7/NdY
         J/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726992; x=1709331792;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+qlm5aO/aQ4uIkmSxxKlZZ/tyfKC6M+ie/SGRsUmdY=;
        b=fqWYXfHr4MG21FNgynsFf9FnkKOp2JPJWFzdoVF5uhEFmYjW023hLDmojXoOOOLjow
         5rm63MSXnzQitKnlFvsbRhPw/qP3E0A0hjFHgrCFooS8BweE7rhtBsF6cQUzroWh0T5Y
         gMXV1mHe9xJkZ3RkX+kBaHgEViwh7bDk2Je0W0eAw1LbZIXVPDK26Fm9DuVYh0LYM+Jt
         6ma0l7QOt3ExA3QnIQMzyigNB49nQU564BSkHrHZ9+wcPch3b72JJKSnOL7Y9W/dBfqP
         eCk+qC+Wc//QdaTbPFOvSXNeLz7HDl5OjEBQBntZtKnK35zXW/hn/ENVsGioXJb0AHBc
         lAig==
X-Forwarded-Encrypted: i=1; AJvYcCXSO1JU6Cn38ifcGBaGnewDnrIMaFfBIeJRZ1GczBIc9t5TxZb+faXzQ/lFDIilGSs3I7lHkSqTJAQqQydRg1Ev9QNmuBB5E4YIH8MUfQVT
X-Gm-Message-State: AOJu0Yw6p5iqPFZ/38JUAUwRmYCKoi3lhVGAM0c+w+k5UQlVT+JJwwD6
	iJfGyyhsNGsBluqGruT+Wv0kXFSpv05GVdkq8JsyxN4GV1fd3S0hsNlX8NBynb8YZB2wsbzhkC4
	YJGgsfhCxuSlKngx2DyrrZg==
X-Google-Smtp-Source: AGHT+IG0uQbPxc1yyNgunzayUFgBE0inCJgcThk//nbvp5YWKlRWOsmqTc7k8Sg+UNpvKbR9RzLmjRurmL8xIB+Cxw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:188a:b0:dcc:6065:2b3d with
 SMTP id cj10-20020a056902188a00b00dcc60652b3dmr305504ybb.8.1708726992262;
 Fri, 23 Feb 2024 14:23:12 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:05 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMka2WUC/y2NQQqDQAwAvyI5N7Ab9eJXpJSajTUHt0tSbIv49
 y7S0zCXmR1cTMVhaHYw2dT1mavESwO83PNDUFN1oEBdICL0l2UuX0ymm5ijsyuuRdvV/rjNb2S MU2xD6uOUmKHWismsn/M0Xo/jBwE0zgZ5AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726990; l=1611;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=jZLUyLw+PYly8jkRw97FHtiAlxLeYw/ruqpi5XPfw0s=; b=wIzkR9ttslj+b0wOPreTc5A7WUjUtgLZ2xJXIkoRRFJsTFFrBDRhsGJXQELHXar8zcNXJPLEG
 QWJPhdh/60KA1FJbeNXbShCZBnrhP5rvNT8yLUyTqCnRH04Xdhxj2KG
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Subject: [PATCH 0/7] scsi: replace deprecated strncpy
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
Justin Stitt (7):
      scsi: mpi3mr: replace deprecated strncpy with strscpy
      scsi: mpt3sas: replace deprecated strncpy with strscpy
      scsi: qedf: replace deprecated strncpy with strscpy
      scsi: qla4xxx: replace deprecated strncpy with strscpy
      scsi: devinfo: replace strncpy and manual pad
      scsi: smartpqi: replace deprecated strncpy with strscpy
      scsi: wd33c93: replace deprecated strncpy with strscpy

 drivers/net/ethernet/qlogic/qed/qed_main.c |  2 +-
 drivers/scsi/mpi3mr/mpi3mr_fw.c            |  8 ++++----
 drivers/scsi/mpt3sas/mpt3sas_base.c        |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c   | 18 +++++++++---------
 drivers/scsi/qedf/qedf_main.c              |  2 +-
 drivers/scsi/qla4xxx/ql4_mbx.c             | 17 ++++++++++++-----
 drivers/scsi/qla4xxx/ql4_os.c              | 14 +++++++-------
 drivers/scsi/scsi_devinfo.c                | 18 ++++++++++--------
 drivers/scsi/smartpqi/smartpqi_init.c      |  5 ++---
 drivers/scsi/wd33c93.c                     |  4 +---
 10 files changed, 48 insertions(+), 42 deletions(-)
---
base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
change-id: 20240222-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-1b130d51bdcc

Best regards,
--
Justin Stitt <justinstitt@google.com>

