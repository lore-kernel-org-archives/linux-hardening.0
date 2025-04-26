Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443B2F56;
	Sat, 26 Apr 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647820; cv=none; b=Qa/LkPxQttmkiwrjlv9jtySfQKn0tbwtYwcAz3V9AQzV4AuBMjITcMh3+jZzVDwJwRNLyN8lUeDTHx+x+QxzbWO+xy6MdjQ154/Ld/SnYy2a0mHolou4LIUyadIPxzAV7FE7iwnBrr4XrRDm7FdHhk1XwVFz/wmacjoRYDfr5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647820; c=relaxed/simple;
	bh=zAsz6yOhq2ZrPGK6fruUAC5J1rKfLgIdeedR/Qm66Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6i3oLUYb7aaz+UzHLD/Gclp05ng4B6Of0OduWQFwhasgIkld+jpbYu+XN2ASpwcpTl8qGl5juGEfAbC+G7Kcge4NDotcyw16ZXiFlTs/jrz/dmCQHBlQ6XvnMKjgKvbJTlJxEQ7CTPLOQJtYqHb0lNHhq5KJUjT06L0dSxSeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU65THxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU65THxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250BC4CEE2;
	Sat, 26 Apr 2025 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745647820;
	bh=zAsz6yOhq2ZrPGK6fruUAC5J1rKfLgIdeedR/Qm66Og=;
	h=From:To:Cc:Subject:Date:From;
	b=uU65THxi0Uwu7yuH7DKvDXBVYQgzFhOEKmP8Ve58qqFugzVauBqY2D/7Z1gTwLNPu
	 IHhLOsVpqoIRHdk6XZVuLNVtwIX3DYrnGKmDuEBxQautErOuNdMIZq069dM52U6+lN
	 KUOkmrRbLqjwFVHHy3txlYLT51lHd/RPyUg2C0KWXSrwRsWESZRw9M2p9m0OcYIrar
	 E8WnadppGrwQDohkBc9pt2kByHAAjU2vIGYjWgRc1/W86a0AK1GF+81G6E329+HQeR
	 B2L5TZB8EFuj+TM2sOHfaq344JxzejpgFmKHIONEv9INOn6UBAy4nRHhsdApEaa0cw
	 1t0GsqH7G615g==
From: Kees Cook <kees@kernel.org>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Kees Cook <kees@kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] comedi: Adjust range_table_list allocation type
Date: Fri, 25 Apr 2025 23:10:16 -0700
Message-Id: <20250426061015.work.971-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=kees@kernel.org; h=from:subject:message-id; bh=zAsz6yOhq2ZrPGK6fruUAC5J1rKfLgIdeedR/Qm66Og=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8FSc+nCmOTn6lPvd7jL281p161oeewX5Ps/viXdlZj jYXnD3SUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJFFrxj+mZiYmfAll0wT/Xjw 4cm16z8LXJu1qUH9WP6kX6LHXJ6m6DIyHDa/NlmZ5dESiVL5hxWGF54/iw78NuO22aGZoqaLfut ZMgMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The returned type is "struct comedi_lrange **", but the assigned type,
while technically matching, is const qualified. Since there is no general
way to remove const qualifiers, switch the returned type to match the
assign type. No change in allocation size results.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 drivers/comedi/drivers/ni_670x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_670x.c b/drivers/comedi/drivers/ni_670x.c
index c875d251c230..563a9c790f12 100644
--- a/drivers/comedi/drivers/ni_670x.c
+++ b/drivers/comedi/drivers/ni_670x.c
@@ -199,7 +199,7 @@ static int ni_670x_auto_attach(struct comedi_device *dev,
 		const struct comedi_lrange **range_table_list;
 
 		range_table_list = kmalloc_array(32,
-						 sizeof(struct comedi_lrange *),
+						 sizeof(*range_table_list),
 						 GFP_KERNEL);
 		if (!range_table_list)
 			return -ENOMEM;
-- 
2.34.1

