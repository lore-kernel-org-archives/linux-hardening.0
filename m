Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9B48FF7B;
	Thu, 17 Sep 2026 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679521; cv=none; b=IpIfTphDP/R9jlWZbogi1Myat9ezYiZGRmkqECJrffyOZuUTuIkqjh2ZTYw3MyUuoBXZm0j3sSyKdKGR2BwzNmadgpTgoCMlJoXy0gGCX7eVMwI2blMIiQZdJrsD1PpROrV228aAGaUlQgWowA5dJAyCb+18JjtQIqFt68Jfi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679521; c=relaxed/simple;
	bh=yYJdJktxv6SmdwbH72DdlJ7DZZjc/VLvBTn0FUqQ93M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbN02AcEfrZTBQZ/41jcgt4ZTGELrg06eyH7P5Mc0uAK1L/REJ26W1FDKYonAFMPnXRfQdCmRUv6NSc3copWDsyxVXdHbnd6KhAexbcojaEIBXLCBxCWmZiWanF9JWtHKHFSqijJPwPb2xM+z7H4vcrq9pU9toqx7iecWkNJYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp4vw4aC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp4vw4aC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962C61F000FF;
	Thu, 17 Sep 2026 21:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679520;
	bh=4sH8FfJgHrsFtML3yksq13yWqqfP0VV+WMgF70KYqEM=;
	h=From:To:Cc:Subject:Date;
	b=dp4vw4aCpF3BUue31pTDqi8sfYJ8qEsgT64kpGB3wSehRo7PqGZInljmLLvjJMtOm
	 EUFuE8CYjCmSP4VLvAR9mq4/iD/7yIadfDIzXrd0O8ckC1kWybFwCEcs/zHeDTULzk
	 n3UJOC/NpUml3EajQhrSoXTFuSr0AvNqXF+IdeOCGUClv0lGXqUFk2Kuww7+H2KozC
	 D37lOIr2p5ApqdLc1bV8F0m/A4V0Jysf3DfvZMQ4r6TicvtxYXWmhkSdR1l/4wrqWw
	 PXm/CWKpzy2lG+1a5Md2lG1qY8xx9oTMKk2sHeq1bFIUQUfVS3G+o26hgqE2xAGzeV
	 +HmhewNY2Dn8w==
From: Kees Cook <kees@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] 9p: Add const and unsigned to wnames allocation type
Date: Thu, 17 Sep 2026 14:11:59 -0700
Message-Id: <20260917211158.i.129-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=kees@kernel.org; h=from:subject:message-id; bh=VDxcphf5qMk3sXbUDyiWqc6nSnhoFpZtrzxznn/pkK4=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwuc7hT06s5T1nm/gxLmWuT3ld2V/iMvLb0xp0Uk2r mcTXDino5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJHNjAyzHVYfGVZIAfb59h6 7vPc3JxbP3ufvfEgYp5Q7wV2m5etsgz/dHP81sVFLcm69XjtHFXRI30OS62i9czmOgnq3U+/neH ODwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

The assigned type is "const unsigned char **", but the converted
allocation type would be "char **", which differs in both the const
qualifier and the signedness of the character type. Take the size from
the assignment target instead. No change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
fs/9p/fid.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: <v9fs@lists.linux.dev>
---
 fs/9p/fid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 76242d450aa7..65dc7972b396 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -154,7 +154,7 @@ static int build_path_from_dentry(struct v9fs_session_info *v9ses,
 	for (ds = dentry; !IS_ROOT(ds); ds = ds->d_parent)
 		n++;
 
-	wnames = kmalloc_array(n, sizeof(char *), GFP_KERNEL);
+	wnames = kmalloc_array(n, sizeof(*wnames), GFP_KERNEL);
 	if (!wnames)
 		goto err_out;
 
-- 
2.34.1

