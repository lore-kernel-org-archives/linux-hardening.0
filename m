Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431A2641C6;
	Mon, 23 Feb 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883028; cv=none; b=rxIKLbW1ztu01nuEeJWRnZKAuZG0mXkIumbKsiDp8Bq7Nhxu56cmrsrc6Fbt88271AOUZWTx9OoQwz0wQ7S1Dfo6XRt8AV7bAQYbD7D1uIXo4oQNQaa66Ktv6kIycWdYf1tvLp4WijRBg+xnU1lcuf2ciDt2v2Ay5Ap8uOIFSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883028; c=relaxed/simple;
	bh=le7nxH2n1wzBURuB5NLlqkQiOQh+DSw2VYcDL5WOhdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gZgoIdpGviBW8x3tnQMZtOZGRJwLOvKkv2/zFnc1mlhkQ0eI6MsSnxctydrAlxoFhGy4JgRw+HVZaj6p5eLGNH11QBJm3u/MP44NKZd7VLXpQhhQxNSdwXkgkMDK8QvJk9oL2boGc3ILHoJCVPJfTKRe8vqt3Qiq/Lr0gcGAh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cViLij+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cViLij+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D8DC116C6;
	Mon, 23 Feb 2026 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771883027;
	bh=le7nxH2n1wzBURuB5NLlqkQiOQh+DSw2VYcDL5WOhdM=;
	h=From:To:Cc:Subject:Date:From;
	b=cViLij+8fPVHZNBtPQI04qbTq4VNDwsrNC0MlQMvmtdSYtEOQeCZ6dMbisKKxlFv6
	 /67Mu1darC0fJrG4qUCy+SmHg3SZXozLY0UK03+oYSrt6meZgjjyD1ceM0Sw/8JfpK
	 z/V4RvRGugrYGeYjA6MDmlSRAnZoEhN5MLXJAxJJ8jGBioMVoW57MOFiJv6BgJcZI/
	 BoWFDRfAwl1xrDpONgPb09+6L0OCfyceyDyEdtQxzrJB/4+pSKVbUNvLYAeT8YrwHz
	 510tTYDeO5M4rvxdj4AC/IKUB9vSRmcvFNAW2woikfVayifDUnFlLMcJlo3o5TdK+i
	 JIJDXkpzfpwGg==
From: Kees Cook <kees@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ubd: Use pointer-to-pointers for io_thread_req arrays
Date: Mon, 23 Feb 2026 13:43:45 -0800
Message-Id: <20260223214341.work.846-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2496; i=kees@kernel.org; h=from:subject:message-id; bh=le7nxH2n1wzBURuB5NLlqkQiOQh+DSw2VYcDL5WOhdM=; b=owGbwMvMwCVmps19z/KJym7G02pJDJlzTgmozeuv/uB6ddqTgOwG5el/V0pnVwScb2YLkbK2q I07XXCio5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCK7FzL8FavTORv7I5gpwItv 8yWPB4WT3+9bwtGw7PWpCUfiXpZtMGL4KyUSxr+HR3f9tMUbbqe81zNK8N/kpPhI5Pi971Pf9WR x8wAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Having an unbounded array for irq_req_buffer and io_req_buffer doesn't
provide any bounds safety, and confuses the needed allocation type,
which is returning a pointer to pointers. Instead of the implicit cast,
switch the variable types.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/b04b6c13-7d0e-4a89-9e68-b572b6c686ac@roeck-us.net
Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: <linux-um@lists.infradead.org>
---
 arch/um/drivers/ubd_kern.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 012b2bcaa8a0..20fc33300a95 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -69,11 +69,11 @@ struct io_thread_req {
 };
 
 
-static struct io_thread_req * (*irq_req_buffer)[];
+static struct io_thread_req **irq_req_buffer;
 static struct io_thread_req *irq_remainder;
 static int irq_remainder_size;
 
-static struct io_thread_req * (*io_req_buffer)[];
+static struct io_thread_req **io_req_buffer;
 static struct io_thread_req *io_remainder;
 static int io_remainder_size;
 
@@ -398,7 +398,7 @@ static int thread_fd = -1;
 
 static int bulk_req_safe_read(
 	int fd,
-	struct io_thread_req * (*request_buffer)[],
+	struct io_thread_req **request_buffer,
 	struct io_thread_req **remainder,
 	int *remainder_size,
 	int max_recs
@@ -465,7 +465,7 @@ static irqreturn_t ubd_intr(int irq, void *dev)
 			&irq_remainder, &irq_remainder_size,
 			UBD_REQ_BUFFER_SIZE)) >= 0) {
 		for (i = 0; i < len / sizeof(struct io_thread_req *); i++)
-			ubd_end_request((*irq_req_buffer)[i]);
+			ubd_end_request(irq_req_buffer[i]);
 	}
 
 	if (len < 0 && len != -EAGAIN)
@@ -1512,7 +1512,7 @@ void *io_thread(void *arg)
 		}
 
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
-			struct io_thread_req *req = (*io_req_buffer)[count];
+			struct io_thread_req *req = io_req_buffer[count];
 			int i;
 
 			io_count++;
-- 
2.34.1

