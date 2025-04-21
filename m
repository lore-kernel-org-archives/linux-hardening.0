Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8D06B3FBB3;
	Mon, 21 Apr 2025 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216697; cv=none; b=YMDeITsW6msZXcodTVbQgcfP/EWDxTOmbbTez0IzVZZ1fniJexVhanRrylRfhLTgIE6F2yq56eAGWt5gbUtlzXJCsHocg3ow2vldPqtZuepEsoLi3Or+dhStsugNv+JN0xtP8ulAXe0NOCnBH5XzrpjSDe1+X8beCk+koAeN0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216697; c=relaxed/simple;
	bh=Xz2sYyCnNEl5/tPFd4aknG/vUR4x+vy6S0MLkgKEH2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HX+r9s8UBccGLxn8cZI8mRiGCCwAfTV1/QQFhpDKBfVmSSlr8h9UppaJESoIIQG2ID1mSGEyt/uXURbQwDuJuuS5ElpvTvnxagRHL1S8C/hNU+zhCic/JaKsdKkqsEZmpDcDw65+aQvcskVOVgbylNmPOGKpzaxBDQ9MmAK6c/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 548ED602549D3;
	Mon, 21 Apr 2025 14:24:49 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: Su Hui <suhui@nfschina.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and size_add()
Date: Mon, 21 Apr 2025 14:24:24 +0800
Message-Id: <20250421062423.740605-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's safer to using kmalloc_array() and size_add() because it can
prevent possible overflow problem.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 23b562df0839..79220aba436f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
-	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
+	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
+				   GFP_KERNEL);
 
 	if (!path)
 		return -ENOMEM;
@@ -2035,7 +2036,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
 	if (!memcg_path)
 		return -EINVAL;
 
-	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
+	path = kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
 
-- 
2.30.2

