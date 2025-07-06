Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F022BD590;
	Sun,  6 Jul 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823465; cv=none; b=i0z7NxAYizgC4xocyVlpW6GLfueo9p5LNi/q9ExO3DTwXWEpuXd/OWVfdTbW9I7/AH5pKqtIcxrpEiR14f7kIfva+N8dDWpN4a2XSKfCuTig7CUXk62IjogL3+jL9HhWzyQ+jAwn0YHaEQqc5CQU2O70gPqv6ZmfdKIHfVTA64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823465; c=relaxed/simple;
	bh=y/NagA9ATWYzQCU9rSacENdhdRjkHrBaR2aM75AXuY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnO+Apl5cR/J/b0tGe+1LyQm5sDSybCnFiwNZSm7m6pbKJnQouJ/ptZreXnRF5qLpTOZSWBUNWCjTGWe5G5ik4PCRMTGHbyxhS6KZmlHu+ROMoFmcDH2xZOml2C1mdtQAPF3bYaTJYSJYLsvEhmdIIkw7jF87gGuUE/TXOXhdEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orXVAk+F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orXVAk+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C44C4CEF2;
	Sun,  6 Jul 2025 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751823464;
	bh=y/NagA9ATWYzQCU9rSacENdhdRjkHrBaR2aM75AXuY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orXVAk+FU306mzqc4WhNNGyh/QPVlsfnq/ha7OFRjsYJOwSW73KjZW8tCUBpZgyDP
	 mbORBDmTYFZkpLbehJgkJhLq/4ZCIXhjynSsAGwf0EqUWpnGo/Muxyl1CI90UJJKtj
	 ezTaWG8VARDp4Moj71p1hYDbGgLV4RsFLq2LjYpilvFJoDjIE/TwQ1q+qt20QQdgxw
	 JBWIvDsbrB7vbp7xFHVyRLxEANRyUi9+tRBHqj0kmmt5xyTInSbKrGqGtdo4VNYKQl
	 wEZTKnNAeDUvtJTb5fRkixKidZjrtzA220veml1DsWHOnnKWfa5unpoP4QXeKE64pL
	 Mn9V6k6yePUzw==
Date: Sun, 6 Jul 2025 19:37:42 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v2 5/5] mm: Fix benign off-by-one bugs
Message-ID: <08cfdd2bf77911ca6ce3c0b6c310daea77eb307a.1751823326.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751823326.git.alx@kernel.org>

We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
doesn't write more than $2 bytes including the null byte, so trying to
pass 'size-1' there is wasting one byte.  Now that we use seprintf(),
the situation isn't different: seprintf() will stop writing *before*
'end' --that is, at most the terminating null byte will be written at
'end-1'--.

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 mm/kfence/kfence_test.c | 4 ++--
 mm/kmsan/kmsan_test.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index ff734c514c03..f02c3e23638a 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -110,7 +110,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expect[0];
-	end = &expect[0][sizeof(expect[0]) - 1];
+	end = ENDOF(expect[0]);
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
 		cur = seprintf(cur, end, "BUG: KFENCE: out-of-bounds %s",
@@ -140,7 +140,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Access information */
 	cur = expect[1];
-	end = &expect[1][sizeof(expect[1]) - 1];
+	end = ENDOF(expect[1]);
 
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index a062a46b2d24..882500807db8 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -105,7 +105,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expected_header;
-	end = &expected_header[sizeof(expected_header) - 1];
+	end = ENDOF(expected_header);
 
 	cur = seprintf(cur, end, "BUG: KMSAN: %s", r->error_type);
 
-- 
2.50.0

