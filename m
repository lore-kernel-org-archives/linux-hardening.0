Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E017A584;
	Mon, 12 Aug 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487800; cv=none; b=hwxx5EiY2ixijNRqg0Fe7BKXGay8/T6lKcfVlwSmW2TidXqY05O974ECm89E5eh1RltnFkU6YvY7ljXkTIYvBbyoRJlwGMfb/2xPafcEKhwShRn6J3GCKHWdCB5vPaENQ5AVAWsfmgSQWGcfrqgRQVy6MoxbganGnRh1L3/QDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487800; c=relaxed/simple;
	bh=cQPr+So1SBLf4JDT0q7xmiL2DlYxMtP/xfHwRK21seY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pKmjeG1UuW4fYXF8HJ1OHZQXrh2CUUK9ODi1qLf0TrqVCMRBkJ8Z4BLgEMYKRLb8eCgd+tHDdXoXC7LDv/JFyLmDrST4obFKZSCd3L3sVTA0bcLfTf42qk1XcmtedKe4PAEbJ5xl3LydWhD7fBTgb7dOmUTpqBbm2KuiJBmtkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epF6kaum; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epF6kaum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFFBC32782;
	Mon, 12 Aug 2024 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487799;
	bh=cQPr+So1SBLf4JDT0q7xmiL2DlYxMtP/xfHwRK21seY=;
	h=From:To:Cc:Subject:Date:From;
	b=epF6kaumb9KQzWF/qZtZvUNkZjk35e8LThxYBnKrNtYiYeYAUjCad38laysl1LK74
	 VjJWu/Wvzs5F7DDZ8eE+8YWvl8Ob9teXaw9SRF/H7K6EiMlDGInmFy6oym8FNVuLpm
	 RRL1F8AVsvx5pZN5W0mIbgyVWDShG7QOqUcD0Zdk+NLVGsDizRwxGWwdeGXU5I0prR
	 dqhZuwExWhKlYHQ/RxllGQL0EzVRTQ2aqrzn5Ve32+zOb4jqSetWKO07xIe16mUwD2
	 GdwyGWYknn1kil9M1ZcL/aVA4cn70Y/JWU1pXb9Y3y2JN+He25+ihgMZcKF2OWMm4f
	 CLO/GGgsKnWgQ==
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-hardening@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: Add rules to find str_down_up() replacements
Date: Mon, 12 Aug 2024 11:36:38 -0700
Message-Id: <20240812183637.work.999-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=kees@kernel.org; h=from:subject:message-id; bh=cQPr+So1SBLf4JDT0q7xmiL2DlYxMtP/xfHwRK21seY=; b=owGbwMvMwCVmps19z/KJym7G02pJDGm7wsyKrmw96d2oyRiQ3Cj9r83oml3hisZCoWcbUmdEu AfYLi/uKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEilACPD4RtbxSesXb58mvCE NVpb/rIKWnuHZe08bugY5BFVxvQgheGf1TW2MyYPt8+PEHx6KL/3/0ajZzo/j/8M7nwsWvI9T+I IBwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As done with str_up_down(), add checks for str_down_up() opportunities.
5 cases currently exist in the tree.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-hardening@vger.kernel.org
Cc: cocci@inria.fr
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index d517f6bc850b..5e729f187f22 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -62,3 +62,26 @@ e << str_up_down_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_up_down(%s)" % e)
+
+@str_down_up depends on patch@
+expression E;
+@@
+(
+-      ((E) ? "down" : "up")
++      str_down_up(E)
+)
+
+@str_down_up_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*      ((E@P) ? "down" : "up")
+)
+
+@script:python depends on report@
+p << str_down_up_r.P;
+e << str_down_up_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e)
-- 
2.34.1

