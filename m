Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8A26528F;
	Mon,  7 Jul 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751864778; cv=none; b=ug04O5fpP+g81c2Xi2mjp7HZf/Y6GvvMJ5qGge6sbzw0aFb16UhXo9a9nlsrPqaR8xPDTsGS3TXtd3J4H1mheXAeg3CdZJ3Mbn4g1ktgUyyk9TqTMYjIZO5WwUlbbaqpkgssWar/zJijSpOnWpM6wAqs0vdQQlILtM70rdGjE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751864778; c=relaxed/simple;
	bh=NHyBpShfNxuRT7LHWtM7yTeZwYuB33fj2KjVFAvh+ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDMkkbLFB8bPJ7KK73JkO/cMp0641WwGDpty8MqzKhqkm1jxtx/v36T9YO96BYH33XykSr/29kMRdtSUohoUQIJuYRCF5ltrZku1wMx69pTG0LABOPJUr7B17khqm0+4zan/ttC+BRpuEwhUkTjVz/MKSoHERR8m9X4V8q+WZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZKs1LG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZKs1LG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ED7C4CEF3;
	Mon,  7 Jul 2025 05:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751864778;
	bh=NHyBpShfNxuRT7LHWtM7yTeZwYuB33fj2KjVFAvh+ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZKs1LG3kb0nVPIQgR1hXQuPVNnzQN5m23O/yq0nZ9XTycpu03iDudYeDmtJnPC+a
	 wJgFLf2bbflGQtVT2GqtWxcUwJQ8oGWUfXCjXy3FbAZ4LTGKK0WD0RH1NGH2XaXBja
	 eg9kUR6n8QaU7IzjMtYDJ8qD7iT952AAkB636Zym1YRRB5auZKCCpBOoT8vZA+KCd3
	 j03WUE5Lr3EEzWfAtxzlWNiA1p+bAJGzhmBMXzFe0Ll04XxVG2Fy2ghiFpP4Kn33Sb
	 SoqZbtPvMJv08ueHyE/wR+2fJ9luwRlrBU3PN4DxETUsJSYV0gXtukozRbdrIDN3RQ
	 7PJ07tG+x8ihw==
Date: Mon, 7 Jul 2025 07:06:15 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC v3 5/7] mm: Fix benign off-by-one bugs
Message-ID: <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751862634.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751862634.git.alx@kernel.org>

We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
doesn't write more than $2 bytes including the null byte, so trying to
pass 'size-1' there is wasting one byte.  Now that we use seprintf(),
the situation isn't different: seprintf() will stop writing *before*
'end' --that is, at most the terminating null byte will be written at
'end-1'--.

Fixes: bc8fbc5f305a (2021-02-26; "kfence: add test suite")
Fixes: 8ed691b02ade (2022-10-03; "kmsan: add tests for KMSAN")
Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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

