Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FA18C008;
	Wed, 16 Apr 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824561; cv=none; b=azPJZVlmfIfgsoJCVf0771gPR2/FVcCza4AgpZT9rPI5gZUdkgErxE+rJi/ZtepoSI80yqoqMykfwq27f/YU3NXFecmjsI6NtP4I+aDbyTK3f7J6sRU5anALk2QxZqGZpHGDfSi50rNiSjgktFue4RGFrLbGF4T/i2kRTIXF/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824561; c=relaxed/simple;
	bh=IS+AnMtNNmo5iw0UsIeBZDVhix4TQOgH5T2zI3ph0+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kzmhXpS+gWXr6QX0gXrkOkXlWQ/WWVGYfHPmj4CwLuOaBj0Y6FucnZX3/YOXSEYPiweF2aG73vZaR7D2xmK1PRqt+WOAQPd82caeLxqtHrU9ChhJIcF8EYzxWNoJh3kllvnHJoiGGURACMGv5Yqa1ckkzyEn3m3yj020tTmCtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHfdqbB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHfdqbB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72321C4CEE4;
	Wed, 16 Apr 2025 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744824559;
	bh=IS+AnMtNNmo5iw0UsIeBZDVhix4TQOgH5T2zI3ph0+o=;
	h=From:To:Cc:Subject:Date:From;
	b=pHfdqbB+TA/HqvfzV6DY5+gFyBT3Sv8sby7WZRD53sxjYd8X3v+Ln0rIoV9jhh/pX
	 cDaOOqwgxbzl5rNZ2iqhEdWajDzNJoj8vtkciBJzgAlf6sLDfNrs5Oc9T5774eRqzh
	 wTqBlEpNf0ottv430H5wXk3wNxDrWnaM6Xqq80ZzJuwcXXSzep1IomDJMwEe0+pHqH
	 j+sIvnfqOyUT1jIs7/BTaXWggYdfdFrTRn/Ia75a/AqVA2Rwn37wUwU+nBxUWo1er9
	 iKCOKQWDL2C+WVDF0X4TE7/F97A2GzDUpGJql19sCbD28s2sscostR50yaRl62tAAh
	 UZJEsU0LYIMpg==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] overflow: Clarify expectations for getting DEFINE_FLEX variable sizes
Date: Wed, 16 Apr 2025 10:29:15 -0700
Message-Id: <20250416172911.work.854-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=kees@kernel.org; h=from:subject:message-id; bh=IS+AnMtNNmo5iw0UsIeBZDVhix4TQOgH5T2zI3ph0+o=; b=owGbwMvMwCVmps19z/KJym7G02pJDOn/X7wyWV6zu3Tdpt9mzjF+M9xNyhTf+PTavLSdY+pkO U2QWXlvRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETytzP8z339WfpSxO1pbtLN QocFFb0frTplrDtPx+WaYJXzv4gtUxkZXp1QtbQzU/Odc/3uF6cLeVaf5+i1750y/8+rMC4Gqwn HGQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Mention the use of __member_size() for DEFINE_FLEX variables as a hint
for getting at the compile-time size of the resulting flexible array
member.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/overflow.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 0c7e3dcfe867..6ee67c20b575 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -419,6 +419,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Define a zeroed, on-stack, instance of @type structure with a trailing
  * flexible array member.
  * Use __struct_size(@name) to get compile-time size of it afterwards.
+ * Use __member_size(@name->member) to get compile-time size of @name members.
  */
 #define DEFINE_RAW_FLEX(type, name, member, count)	\
 	_DEFINE_FLEX(type, name, member, count, = {})
@@ -436,6 +437,7 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Define a zeroed, on-stack, instance of @TYPE structure with a trailing
  * flexible array member.
  * Use __struct_size(@NAME) to get compile-time size of it afterwards.
+ * Use __member_size(@NAME->member) to get compile-time size of @NAME members.
  */
 #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
 	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
-- 
2.34.1

