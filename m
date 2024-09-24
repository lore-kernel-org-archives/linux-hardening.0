Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319817B4F5
	for <linux-hardening@vger.kernel.org>; Tue, 24 Sep 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173426; cv=none; b=NPneD56Qnrs4LzasEDVysZMU5gReJdnP94yW6AgmYQFjKdbIhJOm3VR1cQresv9Fbjske9Er6iu/3IIsCmzZ0yv+Xz5YHkYLGiOHQEyaOScJsQWs6OMZ15onmcjiqZkjSNj86QZfr0i6TvQndm1YZQvaRKZ0ds9gBBMS8ZnIkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173426; c=relaxed/simple;
	bh=99zKOLCWuUMnN9DB5g9ScYpxibi+BJ616Z0/z11v098=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBV6P4YVK3ellpsFQrPgILGr+ytTXZ4fxDpwsHoTQ1bcnF9PCg4kBKHJDsYuDfvo3wczMOWS+KFvRkK/4SMejWKYypkDv3ozGA5Xg1TeQqhlymUpH4qGdSTcnm2iCr4GNNNvYJLSmlpC8W6rbhdG1gleCRWVQAOjyuqzg8eq2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A4pwfpmK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A4pwfpmK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727173421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P/EHYtGClPmz/TRgBbXk5kCLvo/IRFq1tMieEnr4/nE=;
	b=A4pwfpmKq2U8KhWAB5o1HdkMe0xaT/RF4GMDC0sPZdoW0M8okfGGfGQH1RGY5lqrT7O78P
	Sur4XINYqJAs4BuHG9sd9OWWEZHFi7qAt75W95PLBEPr0ABVUJ110M4WdLH3nrA60J9h2M
	BrqNj9G5aENbTiAzZJRNvwxH/uQUoMs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ksmbd: Annotate struct copychunk_ioctl_req with __counted_by_le()
Date: Tue, 24 Sep 2024 12:22:44 +0200
Message-ID: <20240924102243.239811-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by_le compiler attribute to the flexible array member
Chunks to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Read Chunks[0] after checking that ChunkCount is not 0.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/smb/server/smb2pdu.c | 2 +-
 fs/smb/server/smb2pdu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 461c4fc682ac..0670bdf3e167 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7565,7 +7565,6 @@ static int fsctl_copychunk(struct ksmbd_work *work,
 	ci_rsp->TotalBytesWritten =
 		cpu_to_le32(ksmbd_server_side_copy_max_total_size());
 
-	chunks = (struct srv_copychunk *)&ci_req->Chunks[0];
 	chunk_count = le32_to_cpu(ci_req->ChunkCount);
 	if (chunk_count == 0)
 		goto out;
@@ -7579,6 +7578,7 @@ static int fsctl_copychunk(struct ksmbd_work *work,
 		return -EINVAL;
 	}
 
+	chunks = (struct srv_copychunk *)&ci_req->Chunks[0];
 	for (i = 0; i < chunk_count; i++) {
 		if (le32_to_cpu(chunks[i].Length) == 0 ||
 		    le32_to_cpu(chunks[i].Length) > ksmbd_server_side_copy_max_chunk_size())
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 73aff20e22d0..f01121dbf358 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -194,7 +194,7 @@ struct copychunk_ioctl_req {
 	__le64 ResumeKey[3];
 	__le32 ChunkCount;
 	__le32 Reserved;
-	__u8 Chunks[]; /* array of srv_copychunk */
+	__u8 Chunks[] __counted_by_le(ChunkCount); /* array of srv_copychunk */
 } __packed;
 
 struct srv_copychunk {
-- 
2.46.1

