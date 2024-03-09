Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA44F8A2
	for <linux-hardening@vger.kernel.org>; Sat,  9 Mar 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710020915; cv=none; b=dp7yHAhYsar//0nBhPcdyWTSezLv7iC0phIy6GAhjseOUukezvDF4ray/6u73C2CYKctjVppxG8GgjYRxQ0YrDdkoSM0ztCUs/bAcfEbVoMUu6aVgWcPCWMwhkHBawD74uqn0JEiLk2hQ0sEz1TAVJ/r+FrpuqRATw7imspmeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710020915; c=relaxed/simple;
	bh=TlbeLRS6KIxUGIuaEwI09g/BKrurDk428JKg+03aOWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dshfwtBCHUymIusL9QDL22qcm3otWZSUFHkCPEPQiWhVEC7T71rsfROk22kDYNRq6NdAGnId/i7JBaMazoTaX2n1ZRcrMZ2wI81g80Ft1aoGHlOgsDZCyYV6qBQ7k0ACjCZ1IAH6CQzsXdAs/pP67l9mt1ChAVvnRMwSqhpZtVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=am4H5s3i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="am4H5s3i"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so20484125ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 09 Mar 2024 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710020914; x=1710625714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ij4dl6s+fU5V8GRSIdSDyUxEbjNq2rinUUwBlPc9zv8=;
        b=am4H5s3i5gsv96Zqq4crWTeB9+EM8EF5wLsYzbI019n65LOBuVxM9Ji01cwmdX2qCC
         glhU+chp+IG65qcPFmFp+HTM5vMw3TPuClv3qvnP2bSMyE+wPCBLcCeUadTiXN+mIuZF
         VwbfjmCbNZWY6ndooJvFJ9fRi6w223DfhoG44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710020914; x=1710625714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ij4dl6s+fU5V8GRSIdSDyUxEbjNq2rinUUwBlPc9zv8=;
        b=EVlANtgLIq1PXwT9dDAN8jk+xglgWzs5UV/QYFgVBsXjX+/a05Ci/vZXgf+0jhsy+7
         fPESw5bUzSK0WdW5BiVuXdhbVZAAqCZmjHVk0RCED1IvKr5ZwWKc4AZCQZCgppMqdV1f
         W189DQ6xO+TY0NRg0q4vmNevkOF5v9jozRVgdt0UP+Mrop0eFU2JewU2Y4sZ8sGRZ42R
         /l1bwN7bXpsb6IGVKiZYsoGTVttbA6RHEKkrwKSvaMBk1xQcyGc/6N6GrNeUKcCDQZT1
         +5Vm0H6w3xCAYKJmbj8VAUi7DYC5KQtQkZfXyKeV0VWgazgss9NtvVEIl0lpEwjW2pn6
         2s0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmVrAhrXrujBgt3XO7Af6g5xqSSPfmzAkrfGKOFlBPU/aa47yknLGtxslvAoacZ72cAm8CuiEYalDhSRH6x9VCi9n7e6r0sxeMb2N93n7D
X-Gm-Message-State: AOJu0YxxpKQPVwxsinYfNWEVb3AGLWfQEo95BdG5/HsTti0O+e+5oaCz
	7Elfj80GWIw3FiJ2PgjnczibiOVJDq22CDH7srkiVED/A4OeDr9I5tHMuRIqkQ==
X-Google-Smtp-Source: AGHT+IE03Bnsaj7XifM5/uMKxOJjyFpeQ9/fOFvr/AdwuuzOscOuC+xbByKTNfiifwemz2iFWjiZxQ==
X-Received: by 2002:a17:903:2305:b0:1dc:b64:13cd with SMTP id d5-20020a170903230500b001dc0b6413cdmr3672457plh.27.1710020913729;
        Sat, 09 Mar 2024 13:48:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b001dd621111e2sm1729518plr.194.2024.03.09.13.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 13:48:32 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Simplify remove_arg_zero() error path
Date: Sat,  9 Mar 2024 13:48:30 -0800
Message-Id: <20240309214826.work.449-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=keescook@chromium.org;
 h=from:subject:message-id; bh=TlbeLRS6KIxUGIuaEwI09g/BKrurDk428JKg+03aOWE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl7NkuHimbUFvP3Wujjd+L1DSMiaEMK4gLNVck8
 Sc0MmkSs/OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZezZLgAKCRCJcvTf3G3A
 JgXtEACOtfBcv83tcJRDanJKvoKkTfWWrjQSKpdkksCWC6yENNwJql9scRvASM5S6DzURuhkq2d
 N7/W42guz9FpQ+L1UDXoskzaaVCzXOwq3YzF/xTmtrRyXE6GC9NIUJVtE+S3vQGA8WzDo6y8uT2
 WGHvgzK8ddIuVI4SkIr1K0hGRNUyu41RamOTeoLSdb8yQgF6x7Eew0Iukiloqi888aKm7Qpje+S
 +zM4zlnvwtVfmxZzVrszoxqrYJtldziDtD0Pfn9L5wU8lC5BeUw5Dj402JtJeKTP251+QY5MqH4
 NgFGPzm/+xgntTpVCtsqBuiqmqozIOfOPByEycZWnYGIaeA8ICgCkwQEdQbP5ynYqHikt1JG71Q
 2z3rZHyt3ESV387UNCRVbmaPXWE1Erx0hLLfIppSPltc8zNi9wz8KsnRVdaSDKZ1stl3/IHCr7V
 pPGOf9pbrMW4J55FC7s8KbxiTMiUNjOLFb7a24F9HBB6zfnONbPDqkJKKTp/TfeFbr090JYw8lk
 reVExDRQdz8TVr756XON8JmKFpty+iaTzNDKtz/ip7qquwfy3PrgIwtIx6ESfGWJxDRQIsKBrBp
 QcPjLoqkeYf2/HHpBGOgv+3pgBWJtKdxqyiXbp8F5sc4dAVPZm+XFcfJshWtCQ8OHMM3D8pzAxk
 dFhwp4R FAveH4jg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

We don't need the "out" label any more, so remove "ret" and return
directly on error.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/exec.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 715e1a8aa4f0..e7d9d6ad980b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1720,7 +1720,6 @@ static int prepare_binprm(struct linux_binprm *bprm)
  */
 int remove_arg_zero(struct linux_binprm *bprm)
 {
-	int ret = 0;
 	unsigned long offset;
 	char *kaddr;
 	struct page *page;
@@ -1731,10 +1730,8 @@ int remove_arg_zero(struct linux_binprm *bprm)
 	do {
 		offset = bprm->p & ~PAGE_MASK;
 		page = get_arg_page(bprm, bprm->p, 0);
-		if (!page) {
-			ret = -EFAULT;
-			goto out;
-		}
+		if (!page)
+			return -EFAULT;
 		kaddr = kmap_local_page(page);
 
 		for (; offset < PAGE_SIZE && kaddr[offset];
@@ -1748,8 +1745,7 @@ int remove_arg_zero(struct linux_binprm *bprm)
 	bprm->p++;
 	bprm->argc--;
 
-out:
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(remove_arg_zero);
 
-- 
2.34.1

