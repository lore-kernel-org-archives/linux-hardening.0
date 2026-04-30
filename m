Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349928851C
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585074; cv=none; b=qrzUqQbBGbtRUDjpfGygw7g0dt76YGFYXAOpQU5P6MgkOtPLS/jtHVgMVDT1k63Y+8WrLlSuVvar/YzGQTCIl13jq0q2whsdGLOGtFSfD+tG9B7cRq8kwmcEHzbijynvkUFmwMNQgTh1/y90CZ1rMu0RzbsTmqFvNNh6633Gk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585074; c=relaxed/simple;
	bh=c2Ue0d5dnQuSgdhyZTErCXmSWET+7z2AcM46R4grQiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p49Eh8cblR639BdruWvFsBS8pYx3k9YOznWBlCe4EKk4mc2eo3No+IF4UAw4koUIsmtBC8FLz6OhtOFGdGolZ37jMmxbJ0ZW3hYe9mqYQLqNun2336fv4SYXU2+nBhNc5YL6EGtkZ8dGUpgnDL1+PsrpwXq0pZu8pkLkFsLK7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sD8Y+TDa; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sD8Y+TDa"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d736211595so99072085a.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 14:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777585072; x=1778189872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHJoDDBr2oAx8wtDzL3IYfvbd18fgZiJD6KgdBMVEpE=;
        b=sD8Y+TDaDC8j+WlMpMnW/frQAtMujBnUG6StUV6oLXa5wxQW/dyYCg9iBQMmYkFKjx
         E3Opv4WtnLQHI6H0hbB8i65DkHzuwF1sZADpzy2XmeV9q0nTLgzMvYNGPSoxksqPCPc1
         LpoRwl8y25BSdWmBfHB/dGG/PZDjb4RMr9wDUEMi+nibAP0VBCUdGYnuN8UmacdXdQ4Y
         8FfuwbXa/BHGHwcJhxOUaJMAyU2iQm6nTv0KZDI0UJzz/C5HZeerU36E/Tb0UEvvjuWD
         bSkgbXOUYq3sxaDINsoPUPqnI5VWhCQr3PYauSD5f/QC2IAxeYbQujYMsb+kL9AbVyrA
         UEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777585072; x=1778189872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHJoDDBr2oAx8wtDzL3IYfvbd18fgZiJD6KgdBMVEpE=;
        b=Kjc+AAtICrxyIkpsuuV5NEfce/BXMeLj9+9hGO8LxG3wVq7WbbnEOgQmmsZUsInBYb
         o3ZUo1xpN8+rwF06UmOZFlTvaAuGvA2/2/PNCbvNIXMOX8tGXU5psHikih86fL2Sg+Yy
         JHN+q5K22xmMI+GIazJ2Mc1B+G1U8sS7S7eN0wzE6NsCivqyp29tWAwemck3lmznf5tT
         MIIxUnuGujx67DqfN6Xf/xucXmd+vqEspgVnPZZV+o3LId/+jsl2B2GciqGl0d31oVQn
         7c+wWXfSyaGD7UbdHFyT2IvA0ZxzbZSB+ihmq7K9RlXKnUtEQDSbddc50LMaWuEj+/q/
         +Pig==
X-Forwarded-Encrypted: i=1; AFNElJ/Oh5DJ9PQZJBWMdmOC9JUP8evzlJW6tihpfm30MhOQIqZmYvM7H5M2ZLl5Mnx+LgCOpwY10sQYabkK0SUdm9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNwYLxURdDqyoRsSPCREMyWsMDUBpdLFNGZCd8Wn4kch4nfK9
	MV/tL82eNzu8PtyRw7nUqFEFQYwyk++UeYGwkhHYOBaEl5kSNsuoAvn/kNDCDQ==
X-Gm-Gg: AeBDieuXw56uBkkZMZwnoa2sty9Iys/B6wvyTZ4FqPkp0d8Yq0iIHGQqhAXW9TXukC9
	mpJuSy0uppfDCIoo1TvgpQNPZFo31L2KtX9trWk6645d5lINpU3wtS9pCkMZ8iZuM2r6k2UDtdE
	vrfSGOtNXSIsssff95Ew31Mp51RWbovfKFHlrwpbb76uc1XMji1SIh7xNmsgfYHNs+/XMnlWulo
	nLZlRDjLrV41bs9HzbZe4ySiwvul5ybbKajFUcMx+VxjRbFy6WPYSeJ9QAzuM7emAjXaZ8ecYv4
	9rK76dHV5JpUWWCk2JctxVc1i5nNpxUk0Ia0IwTlumF6Joz/8jfiQs+nVFTB5bN1Q5CaygLmwpT
	QakNJJd7tUyj7YY7neBGSohZZloGqDuVezckadIBzI6I/upCnkwOU3gNJWIP0r+akxjKFZUSRid
	/PTLimkLGlCOlIRKsqA0JfKiNvomrmFKebO9aOizwuCI/Uafp5+9YEm1tqt6KygLGfb4zR7xH65
	1/VOUt3ny/6ZA1aHuPHUpvCcSCKE9d1rZUt3LrYH57hUA==
X-Received: by 2002:a05:620a:f15:b0:8ed:c0bf:2c24 with SMTP id af79cd13be357-8fa8a0e1779mr743357285a.62.1777585072297;
        Thu, 30 Apr 2026 14:37:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fbf078618csm28281485a.8.2026.04.30.14.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:37:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 0/2] scsi: be2iscsi: kzalloc + kcalloc to kzalloc_flex
Date: Thu, 30 Apr 2026 14:37:31 -0700
Message-ID: <20260430213733.54840-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split up previous submission into two patches.

v2: fix unused variable warning.

Rosen Penev (2):
  scsi: be2iscsi: simplify cid_array allocation
  scsi: be2iscsi: simplify hwi_controller allocation

 drivers/scsi/be2iscsi/be_main.c | 33 +++------------------------------
 drivers/scsi/be2iscsi/be_main.h |  4 ++--
 2 files changed, 5 insertions(+), 32 deletions(-)

--
2.54.0

