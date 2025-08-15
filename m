Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114401B4138;
	Fri, 15 Aug 2025 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240286; cv=none; b=EYCf2tjfmKBnsLm9KEKAPIqjzosGLQixtaCtt2istvzqktgJ5Ap56yNwrqPdmA1nxc86t6GxmIHoGwyPgAm81LiMSRvlZFPrBueYj6Po0MA2cC2RzioXKxJeutvkR2HJdEflHvKbb4JwLqAnDlOqJlExoZ6O5yLmUmuObQpFKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240286; c=relaxed/simple;
	bh=Lk+xxqQCMU/OYUeoU/yDHcOkie+3BU4YsUlOnJeHynA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IHlrX6rExmeDLsq/YQosGwYYoTkU1jo0ccnWSQkItTApqfZRTlaXECE2SLWkyv2T5+lSiNshjDtvGOUdXa2/1Rw6bxy8XVXhGU6PH8CYCddFo68OYba6rsxWp3cdIm4q5PoJvewbegjtDd6kMC8j9MgTd5eOJz4STQiT4NhY6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5NReNUK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5NReNUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EF1C4CEEB;
	Fri, 15 Aug 2025 06:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755240285;
	bh=Lk+xxqQCMU/OYUeoU/yDHcOkie+3BU4YsUlOnJeHynA=;
	h=From:To:Cc:Subject:Date:From;
	b=q5NReNUKrngNZHZq/ZnQWzcCp/avfGjWQpHb3CIkLAidaQEpSY7RlfINMK0jj4Ylv
	 q5VNJCOpFoHvTtEP1nRzaAevs0bLq+X3Qxv/yce9iGMNKHOiEdK1cNvBmgMMBu2F9Y
	 qKXIQvxGHqZJKujUAPqsdVUBIf5asSWISkgtNOO1CKvHMP5iJSn7vgemOYn5LV0kFg
	 9LieY8UySdFxkPt6Osn4WUUH6ngxY03yHB5mLX3FokixGzWYD76KNDrMgg3Ad4ff8Y
	 eEor6XuHgFE0i4TiK0X3X+/JQ9YzibVo1xYWgbBJj9ni+mR2h6aOSM3S+61TfePIZg
	 9Uae0Lbq19Z4A==
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
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
	Tamir Duberstein <tamird@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] .gitignore: Add Coding Assistants section
Date: Thu, 14 Aug 2025 23:44:43 -0700
Message-Id: <20250815064430.work.772-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=kees@kernel.org; h=from:subject:message-id; bh=Lk+xxqQCMU/OYUeoU/yDHcOkie+3BU4YsUlOnJeHynA=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnzrkcxhray9JwNvmYn9Dr1UXLCSvmni+eumLeiPIJvE R9rkE1mRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESW72D4n/500ulFTv9stwW6 cH8PXfGo4PvGJMefXVIb7FTY88MrpjL8jzv4Iygsa/MV57m6y/bovejXuSz+3/FlyWUfdf9GO5v t7AA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Both Claude and Gemini save locally personalized configurations in their
respective .md files and dot-directories. Since these are continuously
updated by the developer (and agent) when working on projects, these
files must be ignored, much like how we ignore the debian/ directory, etc.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 .gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitignore b/.gitignore
index bf5ee6e01cd4..0459a44a3d64 100644
--- a/.gitignore
+++ b/.gitignore
@@ -182,3 +182,11 @@ sphinx_*/

 # Rust analyzer configuration
 /rust-project.json
+
+#
+# Coding assistants
+#
+/CLAUDE.md
+/.claude/
+/GEMINI.md
+/.gemini/
--
2.34.1

