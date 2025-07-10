Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489B2FE39D;
	Thu, 10 Jul 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183079; cv=none; b=cRNy22NWR3zMahcnZBEIw54mkS5SppDztX8rfuUOJCSk7W7IEX1jYP/6v58xy8hydAySgCYQgrSeFE6aqzWKwM/nYS7sX6pWZIV1fDCALZ70d4yqW14bZ/TZ4OIQcOjfuWLQo/KDibJp3GRH79a4/4XQsaDMwzAcXQI94a7jfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183079; c=relaxed/simple;
	bh=wFPXfnEZslZWUhJFarJBIrU2i1EIAu502D8Y+SMDH6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWJqAHIUP9pv9D8PZbpIhWshNGL9AAHiv9twD4t3z/7Dl7FbeF/eCVa8kHNzfWL1AKqJI3YgvmjSW2mPAHKNd+mGc8MxDqt/5LkBWGvlqKAg2jidT4Q1oPo6475s/Ep8LOf3n0weyW+bWHz92iVZrG1Sr14dt1iZe4rT9iEFhjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWuo1Zql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWuo1Zql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0DAC4CEF4;
	Thu, 10 Jul 2025 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752183077;
	bh=wFPXfnEZslZWUhJFarJBIrU2i1EIAu502D8Y+SMDH6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWuo1ZqlT8hDeYCOdQ83TdmvF3KTGpYjhd5zydhkKWryMLsY/yiK+N6Gb3hmh8X/T
	 AT6fkItdv8vi0RopIXquZcY2WFs4NBlcXWveYLG3SKhskex1XkYyHoMRFE8Pq7nPB3
	 crYWMOb94V+RVJyuUPctglxGyyzCbhKkWT2uzfxIefWUfg+Sz/9dQny5+GJ2fuz0Uv
	 xdbLu4BrdKkWrkzDFkqjrV3HQCOdPfSoAoD6/Bp8p5Tsa71nXhuP2XPQvCggDV5+th
	 VUF7d2SevWeaVFMTwzUITeFqMKVJWvf9fnbkuosGwlSy0jzVnGlzRaFkg6XYuwSTQv
	 INmQKlW3JVmxw==
Date: Thu, 10 Jul 2025 23:31:11 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, 
	Andrew Pinski <pinskia@gmail.com>, Jann Horn <jannh@google.com>
Subject: [RFC v5 5/7] mm: Fix benign off-by-one bugs
Message-ID: <515445ae064d4b8599899bf0d8b480dadd2ff843.1752182685.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752182685.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752182685.git.alx@kernel.org>

We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
doesn't write more than $2 bytes including the null byte, so trying to
pass 'size-1' there is wasting one byte.  Now that we use sprintf_end(),
the situation isn't different: sprintf_end() will stop writing *before*
'end' --that is, at most the terminating null byte will be written at
'end-1'--.

Acked-by: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marco Elver <elver@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 mm/kfence/kfence_test.c | 4 ++--
 mm/kmsan/kmsan_test.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index bae382eca4ab..c635aa9d478b 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -110,7 +110,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expect[0];
-	end = &expect[0][sizeof(expect[0]) - 1];
+	end = ENDOF(expect[0]);
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
 		cur = sprintf_end(cur, end, "BUG: KFENCE: out-of-bounds %s",
@@ -140,7 +140,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Access information */
 	cur = expect[1];
-	end = &expect[1][sizeof(expect[1]) - 1];
+	end = ENDOF(expect[1]);
 
 	switch (r->type) {
 	case KFENCE_ERROR_OOB:
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index e48ca1972ff3..9bda55992e3d 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -105,7 +105,7 @@ static bool report_matches(const struct expect_report *r)
 
 	/* Title */
 	cur = expected_header;
-	end = &expected_header[sizeof(expected_header) - 1];
+	end = ENDOF(expected_header);
 
 	cur = sprintf_end(cur, end, "BUG: KMSAN: %s", r->error_type);
 
-- 
2.50.0

