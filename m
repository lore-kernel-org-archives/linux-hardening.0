Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEB39B
	for <linux-hardening@vger.kernel.org>; Tue,  1 Oct 2024 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742393; cv=none; b=XiKZEnwf+CahpvE1402X7eYHix8y7vfIqsLSlHk6twAP9pYBPRhZfuhErqt5ZF/u7BkE+ugJa3zTFsgGamrkJHhkLe2ZQO1wYTsDOTUQSOjT/anmfkbdVBsjPblJKNmNAZmmCqgXtWFFaPyb+5lh5f0oyJoNrscWl5IzskhBWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742393; c=relaxed/simple;
	bh=kbMFnzagpQdusXtPFCQNh4LtOtnG1FrlUx+fANLHKoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8jPcrvAjYSUk6l3zrgouozEgkKWnItO35FfJt2Bw6sB1eu6lQS+8MoQ5YKH4RFSFkzsvRb5MFro66emQcUmfOSi/Ve+rbWZlJFaJSKRSTkEXr/r+kAcIyvznGt4gTMtIpezhB+iZuabYLE7SqnEFshy7hYkAnvexDMgmikr7Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FtwptL07; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtwptL07"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e084dc44bcso825254a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 30 Sep 2024 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727742392; x=1728347192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Ah0ZMWQ8huX6PXrR+FitgdByGuh4bQ4S4OQRetSRI=;
        b=FtwptL075N3oWlxT29mowa4HN9e5VBHTMbN4Qe58L9+aGcOhtyX38miG7/Jp/4fu2D
         pp+wz8sej3/94fHiIB1swTDKO+5qfTMWZCMWXOYSCkuV/BKXsJ/Kagvykz+h0JelDHVW
         gQoYOhnK1ygvtspr0TZlCO+/4ytzj5bvx31RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727742392; x=1728347192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+Ah0ZMWQ8huX6PXrR+FitgdByGuh4bQ4S4OQRetSRI=;
        b=hmbYDo31x9246RteAPxMBzbuslFR6ShhArEEz5Aug6Uvysfk8KioCYouYxjT5dpnfT
         65c8S9ojizWPzLuBsplGI7CW6ngfZ9JUQM67XsTteWdFoXZ7od4ibRWz1gvtzoBpDlGc
         ifCo41P+8sIPM/FPgks7VeSIwOhC94CdOTVSpbxKWPfpcmEkjbzLW0nF4MKTV90VTk2P
         WC9NmhJQTdZRXJMe4r6NrqPx6ktyjFHrquoOGmq7QfJiNk5iSsONYxOHeG6+auaKBAAH
         7zpoNTasT+4NaYHqMcfLFxFUcqBE4MRzALNT4htmuXkc1chL3wyZaK9+iosFAQPYyCn7
         s8kA==
X-Forwarded-Encrypted: i=1; AJvYcCX0+Cj+7QSy7B9eDkyicCFc5XX3pzhHq8fVpvCUpDQ0fnWSnntJt3cwWr3SeCZXSHPhw6Zp8tZYhChuTP8wnEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsAxPC+Vg9yMtByzI4z5dVLciOkG5jatWGDzdtxGdUPSHJElW
	hT3m02wmgvo3uB+uxC8wYoj0bIMn2X6HYa+GLNobamxxnSoaoPILmbTBL6eZrA==
X-Google-Smtp-Source: AGHT+IHaC8TRH+0CqFL8ePmOQQcQjHt2DWzOtlbUiQVAZBBhzUk+OWDYuAMRBsTobNPtDc/8lsuUIQ==
X-Received: by 2002:a17:90b:4b41:b0:2e0:72ab:98e5 with SMTP id 98e67ed59e1d1-2e0e63a5a38mr5503246a91.0.1727742391881;
        Mon, 30 Sep 2024 17:26:31 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e0b6ca4a4esm8734399a91.31.2024.09.30.17.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 17:26:31 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] update mseal.rst
Date: Tue,  1 Oct 2024 00:26:26 +0000
Message-ID: <20241001002628.2239032-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Pedro Falcato's optimization [1] for checking sealed VMAs, which replaces
the can_modify_mm() function with an in-loop check, necessitates an update
to the mseal.rst documentation to reflect this change.

Furthermore, the document has received offline comments regarding the code
sample and suggestions for sentence clarification to enhance reader
comprehension.

[1] https://lore.kernel.org/linux-mm/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

History:
V2: update according to Randy Dunlap's comments.

V1: initial version
https://lore.kernel.org/all/20240927185211.729207-1-jeffxu@chromium.org/

Jeff Xu (1):
  mseal: update mseal.rst

 Documentation/userspace-api/mseal.rst | 304 ++++++++++++--------------
 1 file changed, 144 insertions(+), 160 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog

