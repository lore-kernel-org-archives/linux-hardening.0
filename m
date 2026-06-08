Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94E3921D6
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=ouMwvNK1cxukP0psR71TxisSp9XWUm44lPe8aiXSdtqAvLJzqUMC5kQOaMWEYuNNH/dklFt/nVEREBFgjG3px76B8jYGaLx5VSJWVPi+OTVx7jaD/PxVXDYvB7+EYrwmaeMTaJw0UpGOpIadPwZ/uM8mf9cmwg01unuq5252j2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=S0ZqpIOf/0geJXcSvOroE5JwOeLeVPGHx2YTwd7yYYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e5eHZbBKRypsG1EYajjVZ8XNp/puc/grjR0/Nv4+fTKfJgNAFngFq11pXfgBzSnEFL5xhVNGI36BmU2sP1n56OkooI3sT572d9yacIzfm+rElWybVAjjdNEuoL8/F2eTwBUY/kOX+p1aJbt1KRVvUIXX/LfzKzpdlQ4mOw8U4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=DxDywrKb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="DxDywrKb"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhr-00BrCt-Dj; Mon, 08 Jun 2026 11:55:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=I+NXORxswwyj4S6K4ECxTOvj3mkCctUpHmAmT3OuuLI=; b=DxDywr
	Kb9j86DrswUAGzk5pZ2zzZEFmBeT8A0k9MezePbI/kft2OAiCrYXknLV6fdyjU7hu5iOSjqTWoSKA
	KDRucjfOPqH6C2T6qMsvIHMoTmU4Dse1s3CihFuukoSkORfhacomsRPoUukP7DkD57E6U1Cr+7Zzm
	jQvc21ODDGG9Z/aW+HcJhGGENpJ3RkyXwexH9rW1KPM3iuN3WJ9vP1qdXFpfWFFPTwLR114BCB7Gq
	q5Ya9A26zUSnhKXraHw3pvDfjfsw1XEsjujR5Ko8LJ87AKco7a732aZRgFIo9Xo9DD/ggS4Dq9Wbw
	5PTMZonx9xeHLvUXcBsTlNI3xl7w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhq-0000HM-Tn; Mon, 08 Jun 2026 11:55:43 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWho-00Ag6G-TM;
	Mon, 08 Jun 2026 11:55:41 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] afs_lookup_atsys(): Use memcpy() instead of strcpy()
Date: Mon,  8 Jun 2026 10:55:22 +0100
Message-Id: <20260608095523.2606-38-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

strlen() has been called to validate the length, use the same length
to copy the string.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 fs/afs/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index aaaa55878ffd..41aa6a4b0987 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -914,7 +914,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	struct afs_net *net = afs_i2net(dir);
 	struct dentry *ret;
 	char *buf, *p, *name;
-	int len, i;
+	int name_len, len, i;
 
 	_enter("");
 
@@ -935,13 +935,14 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
-		len = dentry->d_name.len - 4 + strlen(name);
+		name_len = strlen(name);
+		len = dentry->d_name.len - 4 + name_len;
 		if (len >= AFSNAMEMAX) {
 			ret = ERR_PTR(-ENAMETOOLONG);
 			goto out_s;
 		}
 
-		strcpy(p, name);
+		memcpy(p, name, name_len + 1);
 		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
-- 
2.39.5

