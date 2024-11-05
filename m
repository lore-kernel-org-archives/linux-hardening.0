Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25491D1747
	for <linux-hardening@vger.kernel.org>; Tue,  5 Nov 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801966; cv=none; b=FhyA6MLMsw+jLc89nw3M5Huoz5ckLCyGlfNrnreP+TnU6kHyE8HSs0rbp35p4QyO8p3vbiJJ96AXoe7hDvJ72RX29E2abcrGlBK9FGHbu447rfRAEHwofZ2v+cmqpMvsnYWjjAGmmUK/GBiIK7arfntDDlzBWSXdBzRTUNQYPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801966; c=relaxed/simple;
	bh=0XMQ4cQcnyjFHC31knVVs2kRruBd+6RlpPXxm9B/kg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDYO4Z+R7muEKj3aiUCsQ4LXakiCpX/yHhTtz+Tmuoa6sKsFhaXKKD2h21/CXaThFNefbIPEb7+OEUYUnj/hoNbJijxGoxFCWsh+8LSrqEC8Zc1FNR3siu270lNpBFi13KAPWTj2r/7APBU+emnQ1C0NJNzIuwD1YLBnYx1bCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sWFV6F0q; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sWFV6F0q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730801960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sXCLoR2Sxgn/x96OPNA8FzE5cwbUziXs2VVd+3qPYsU=;
	b=sWFV6F0q8lE/+8H4/wVQ6xjv33ekMQXBVaUAAzL9GTmwSbowqLMij1N5mIEJ7TtZuxTgmA
	2Maeq+DxyQFgPS0opG2CuqRbK/GsiDcQH9sHzHiRB4UE97uNiJYr/E996lUbueXb1P+tSk
	IwNxvVZfpMbpHwzjInlZrgQ941e9LmQ=
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
Subject: [PATCH v2] ext4: Annotate struct fname with __counted_by()
Date: Tue,  5 Nov 2024 11:18:14 +0100
Message-ID: <20241105101813.10864-2-thorsten.blum@linux.dev>
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

