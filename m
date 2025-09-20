Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695636B;
	Sat, 20 Sep 2025 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758411927; cv=none; b=ky1Ive+Zb7UkGMtg8V4bYbjyXlTPk2wJOekIxX26YO2fIVawgjBHregkxFDJ9PmTfvkJ1GLp1jsTul6Z9qRaIWflM6nvhL7gw9vPIHe9C1n41drd0tS4DaQUxOZMbJ168EXxeelP0Nfy6HfJbh1JVEM0oWTnjxLdCjWB0seHRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758411927; c=relaxed/simple;
	bh=nPQYeWOqG0yaQ2jHVrf6PnxG9t5HqHsq6zQRyD1fYbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dHfRQNfWgiDpcZnClX0c63QDGl8JnNnVkF4X7N1B73tGKnVchnTMGyShZLC5kE1qjAWb7q1znnq7Fk/Pt+qLmlsxFIy/HxsRnQKlBYw5tZ2MsyAdW+pYcDGtw8PUe61y89bRWwvFE0UGnOUzl2CFfj2SZLYLzTJImtYqA2OrCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+knQZNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+knQZNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564EEC4CEEB;
	Sat, 20 Sep 2025 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758411927;
	bh=nPQYeWOqG0yaQ2jHVrf6PnxG9t5HqHsq6zQRyD1fYbo=;
	h=From:To:Cc:Subject:Date:From;
	b=F+knQZNUyzxHa+n0GHFT8CBZk7th+H/BuDrBA4mfi6lss81kPFrL34oLSrwwXEJvk
	 mXtrGzgYGtegbkDtl/EzARZ4Vgagv3QvDB/CNPeiRDw5XoQUCII3/5QETgOD1C/buc
	 N8dLtck412Sr1O7ATgJsPlJ0YqQaCfAyuen3wEChdmisZ2IBbB9Ok9ef3y2jrx/7Bo
	 +tunUqMWslIfgIROxxGBooyNadQkXua3wn4TUpxMieFlnZy9mwxL46PGOfaJ+QL5Wf
	 PXA6TMreggMqY0Rs/n9rKJXLYDA0MF3PSGKTDaDyMfY0nhC9NIeChRd2oMoaEyuqXX
	 y6goJxO2590Ug==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	Christopher Fore <csfore@posteo.net>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: Remove TODO_verify_il for GCC >= 16
Date: Sat, 20 Sep 2025 16:45:23 -0700
Message-Id: <20250920234519.work.915-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=kees@kernel.org; h=from:subject:message-id; bh=nPQYeWOqG0yaQ2jHVrf6PnxG9t5HqHsq6zQRyD1fYbo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnnbSaV39QrFzdalZ0aZfu54OyXRVfSJp13MayNqss73 WC6vWZqRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwES+ljMy7Baye7w4psNQ4Xe+ 8E/Xu9ef+5/ZrnLk/NZqt8/5J69MKWD4pzrx+vm1Fayf/90Ja/kQnZmXFBT3fsE7ufeB3QyuS7o vMgIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC now runs TODO_verify_il automatically[1], so it is no longer exposed to
plugins. Only use the flag on GCC < 16.

Suggested-by: Christopher Fore <csfore@posteo.net>
Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8
Signed-off-by: Kees Cook <kees@kernel.org>
---
How about like this, so it'll still work on GCC <16?
Cc: <linux-hardening@vger.kernel.org>
---
 scripts/gcc-plugins/gcc-common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 6cb6d1051815..8f1b3500f8e2 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -173,10 +173,17 @@ static inline opt_pass *get_pass_for_id(int id)
 	return g->get_passes()->get_pass_for_id(id);
 }
 
+#if BUILDING_GCC_VERSION < 16000
 #define TODO_verify_ssa TODO_verify_il
 #define TODO_verify_flow TODO_verify_il
 #define TODO_verify_stmts TODO_verify_il
 #define TODO_verify_rtl_sharing TODO_verify_il
+#else
+#define TODO_verify_ssa 0
+#define TODO_verify_flow 0
+#define TODO_verify_stmts 0
+#define TODO_verify_rtl_sharing 0
+#endif
 
 #define INSN_DELETED_P(insn) (insn)->deleted()
 
-- 
2.34.1

