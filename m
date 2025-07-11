Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B013D531;
	Fri, 11 Jul 2025 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752199045; cv=none; b=Jrtx2xx5gkMkonxwLzEM+uDGm3BXPHYvHWRfQzaooFWxUDrgastZRL8iVoLT7DucLheCjLMUvCk5dQhys9WAWOhaeDOrky49SFsEmzu4DSlb9F5nCVVt2Y5VK5fCG9D9fPNeOSxW9a5ZBr3KqTtySODocqScpQhdPpsEKugNBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752199045; c=relaxed/simple;
	bh=wFPXfnEZslZWUhJFarJBIrU2i1EIAu502D8Y+SMDH6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKpbpgrxdbV3XbAVSWtwB6wctRXM+WNadPAYz/1+yNKoH9sY5f8IfCjDdjLfVXlGaGVdGbYVmHmz0MpYR5cueWiFQWXNbE+gZRcYP/oLHgr2Q0rie5klYZBpUCtL7Xkjie8Nfu+b148cbBhzRL3WhKi9UgolC+vyEOmzcxoYd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roC9g9PB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roC9g9PB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922DFC4CEF6;
	Fri, 11 Jul 2025 01:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752199045;
	bh=wFPXfnEZslZWUhJFarJBIrU2i1EIAu502D8Y+SMDH6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roC9g9PB77gNhNlj66Cup0sdQVFzv8n2cuImhV6NeWw054uR2YtdJ5w3gv13YNayC
	 T+qeUiJwBXOnpGCeA8HuQMJSBuYSrLJji3PGOyXDrykwfQzgcVhGnxXjd8G9Kw5Qd9
	 iieOWBYqaD2apefAviM+gfdhQlL10dMjz1T4qvZFE8Hz4gpm5cehM3ztxYUKBOfoIF
	 Dq18+S6bwzcE2N+FPwtdb8pjhQ0Q/WYGMdH4JoeQystSeFf9zdaaetuL6UKHouVovh
	 R7ZFtlsDBqGdDnclfYfxTgHOguR8tzufFeG0IEeesnKtzR3R4mf3TL31WxnR2eWuMO
	 6TfugDFBAVfJA==
Date: Fri, 11 Jul 2025 03:57:18 +0200
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
Subject: [RFC v6 7/8] mm: Fix benign off-by-one bugs
Message-ID: <c88780354e13d8531f4f4118f251a070de7ef13e.1752193588.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
 <cover.1752193588.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1752193588.git.alx@kernel.org>

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

