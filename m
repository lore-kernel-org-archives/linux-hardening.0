Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600072144B5
	for <linux-hardening@vger.kernel.org>; Tue, 12 Nov 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435824; cv=none; b=IQxICfYNzYpdAFydn6ofyaKYGJCbpTfrqO5YovylBVDrXWTTtzqNfvQy6REUw9M0DANLTDQ+vioPFjnGsV60VWoRoJ7TEPCE8fAYTYu5OkPUw0/XBGigDfUfLTQp6dCJ2CVLvIuCNdf7I28Qjd+p5f3g5pvzMmLpL9s8onSMt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435824; c=relaxed/simple;
	bh=0XMQ4cQcnyjFHC31knVVs2kRruBd+6RlpPXxm9B/kg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6fmVg2M279LaFNvncupDo7x8NVet1RW/IWnEc8s33foMLl9PCz3qQMFteCrp8sh75nHBjr5E24s7rhdtiyNkmlkgm0szMGSi1f1ICxzAE6138AoOXtPW34n/gT76o/7lOrBjC9vp0C06vpj9pGa8EtBU7DWpATv26+FpHZ2GZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CZSZrn14; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CZSZrn14"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731435819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sXCLoR2Sxgn/x96OPNA8FzE5cwbUziXs2VVd+3qPYsU=;
	b=CZSZrn14lNmeltt8QcXLCV7ThjQO+PLEfxx1bTb63NQ/f4TnBeah5KSk6f5k8WnHfXWMxg
	5gzPMx0ZaCloYXIELwwzM4w5vytUNkMvp7ythH9x08nEI0t105vFAd9GII69/iyfEbKPuM
	gwjmOlZDbsW44PEhP3vhTDzIe2OkEOY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH v2] ext4: Annotate struct fname with __counted_by()
Date: Tue, 12 Nov 2024 19:22:57 +0100
Message-ID: <20241112182257.172746-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Split the patch into two separate patches as suggested by Greg KH
- Link to v1: https://lore.kernel.org/r/20241104234214.8094-2-thorsten.blum@linux.dev/
---
 fs/ext4/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ef6a3c8f3a9a..233479647f1b 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -418,7 +418,7 @@ struct fname {
 	__u32		inode;
 	__u8		name_len;
 	__u8		file_type;
-	char		name[];
+	char		name[] __counted_by(name_len);
 };
 
 /*
-- 
2.47.0

