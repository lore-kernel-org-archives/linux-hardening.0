Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AF33A70F
	for <linux-hardening@vger.kernel.org>; Mon,  5 Jan 2026 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615691; cv=none; b=ndhfRzbxOgQjUlX6UTtJlEiFpgHfWB4g4jrJ4RDPXEcSAOzbSPLSLwHRUxiXhoO42eaecEhuxqBoV8NTQ/GTop7auzw+2jKxHhC8t9vm8LQ/jjwY1+VTadDkQSSWY51968DJdUigY35MS/g0A2pIXQQsGv5Sj3WgggaEeBfW+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615691; c=relaxed/simple;
	bh=+eJZOy87qTqESD3sHAYUl+EqJENuvLdwzhzcmLrI0io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNS0d/LUHWYGzXfdpoxwhvGD9O/Gei+Ek+54YdL9k0p3QBlVJPuHvUORIC6BXTowpDiZLLOQ9RcaFPk4js0Cm0h1LeJBeIhwkahMMj0DZhygLTeNze43v8GyldWs7LMV222Q5ZFSnMOJ4Vh0uuYo6KZFMIJX1tKIKKvI636SoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M5Q7K9AW; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M5Q7K9AW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767615688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DKOpbNEcZ6q+6Ts/s5XyaIdQWqdzDTQFyfq539CKAzU=;
	b=M5Q7K9AW6RR9Lxu7N0Res/SUFuG4K85kRlW4DaPJi16Z91WF9VcDVDguvxLrH504Ohqusw
	2RZtBMIfoUcQMDloTkpDiIbljqi75Y0uquP44T/8LN6ZGKlj2gn04sNaH40+cyvCXL3GwY
	+o5IEAnzTKnxjAastuUntso3+sd1moM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] fs/xattr: Annotate struct simple_xattr with __counted_by
Date: Mon,  5 Jan 2026 13:20:53 +0100
Message-ID: <20260105122057.2347-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'value' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/xattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 64e9afe7d647..296b5ee5c979 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -114,7 +114,7 @@ struct simple_xattr {
 	struct rb_node rb_node;
 	char *name;
 	size_t size;
-	char value[];
+	char value[] __counted_by(size);
 };
 
 void simple_xattrs_init(struct simple_xattrs *xattrs);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

