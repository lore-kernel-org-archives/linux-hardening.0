Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD220D515;
	Tue,  9 Sep 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387838; cv=none; b=FRbL6Rv9rb87erf2VCEllWt8Ves4aM+IFneT3jHjc/8AHjBzEFaU25s57NHkaUOqFe48KGZidUQY1lQhB0+jb3KtTI/4+v2+SAXQrxdd8qHSJ2gc/4qVFAEgotSOxbR9A1OHLz00vg2FRN3cz07W8oT5ll9tGZCce56UR4s1lcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387838; c=relaxed/simple;
	bh=bmGEjE1BbbOZN0kN0rnz16hH12Hzuo0BVc3brUsgI2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dnlf/oWjIQQQ0BIzFUNxKdjgC3QVKdRY5l7Au6YXETm8TC27Qy51kAlXXiVrUNT16sL+ydGl15hm7qs1uSv32XTVM4jLlcjAjtI/S+1lviTyn/2P6DcCUfAQEHsXv3C8cpE8Cpwlsz8clHHKWwOtNeDcCik2c1aCZXk97zrVdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVHip9Sd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVHip9Sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DCCC4CEF1;
	Tue,  9 Sep 2025 03:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757387838;
	bh=bmGEjE1BbbOZN0kN0rnz16hH12Hzuo0BVc3brUsgI2c=;
	h=From:To:Cc:Subject:Date:From;
	b=oVHip9SdqiCIsONAGssvHSYWwccBgLjTnf2DTaccxlIt3U73uX9uQLTbnuMElSnWJ
	 CcA5uz7MCClzm6NKrgrp6TGrqhn3bPsI9oLZFLm3f99T8ST//AaWcGJHS08FWIsug5
	 MsQ4uGSAAkiGK4MxlogjXCQ1hNNBCOXpk5YS2Hvp1cLnu082Dopa2Nj8nv5X1m1xUy
	 j9lvOFXHaoNTNBho8cTFaSeYZTJd3akMl6Jfd7fSHZrBWAlZRAg2+oXv1J/W8V4cye
	 oTGMRr6urr0bg6fDkSn4bo7xWRvFCWiS7cSq6oFy9ylugghZzc26xmvwVPl2i8ynA4
	 vKZXmH9JM55Ww==
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Fiona Behrens <me@kloenk.dev>,
	Sami Tolvanen <samitolvanen@google.com>,
	Gary Guo <gary@garyguo.net>,
	Kris Van Hees <kris.van.hees@oracle.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Li Zhijian <lizhijian@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] .gitignore: Add Coding Assistants section
Date: Mon,  8 Sep 2025 20:17:17 -0700
Message-Id: <20250909031712.it.968-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=kees@kernel.org; h=from:subject:message-id; bh=bmGEjE1BbbOZN0kN0rnz16hH12Hzuo0BVc3brUsgI2c=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn759hMWCO+t+LPl/aX7wOzfqpoGa6cqFmxav4lX5/O9 f4LFsQv7yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiIhRwjw9PLKQ+ObZJjfbd3 40H2IBuNh84uLSdYXh+yUd57+GFkKR8jw6/eWZuf9/2O/8YgXn+K9Wjaf70125+ttOVJ/XLW6We VAwsA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Both Claude and Gemini save locally personalized configurations in their
respective .md files and dot-directories. Since these are continuously
updated by the developer (and agent) when working on projects, these
files must be ignored, much like how we ignore the debian/ directory, etc.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Link: https://lore.kernel.org/r/20250815064430.work.772-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: drop the trailing /s so symlinks will be ignored too
 v1: https://lore.kernel.org/lkml/20250815064430.work.772-kees@kernel.org/
---
 .gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitignore b/.gitignore
index 929054df5212..8b9ccfa8e3b7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -183,3 +183,11 @@ sphinx_*/
 
 # Rust analyzer configuration
 /rust-project.json
+
+#
+# Coding assistants
+#
+/CLAUDE.md
+/.claude
+/GEMINI.md
+/.gemini
-- 
2.34.1

