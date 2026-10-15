Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE0372661
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093522; cv=none; b=AbgFq7tm+XneCtUAbo+AA0IutHGi79nnRIwG6fnzbDMSz70wh5exB3dQ2uA8pLOJZHe4thfGdSWgRC7+jvjbjFzouuNudWxG8WOg5/iuFBXzjV8H4N/d3NBSKYndqxEJH5rDJsGNaMMEXfFzh1mKdD63e6JSiQPRaXE7lZKI3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093522; c=relaxed/simple;
	bh=JWp2mtU9lr0BnKEV7Wae/4AVq1QTMY0QyVTTc9Q8bsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZMK+S8NreGNM3tbluDGv6aP1TlQXKftLJ2HXujL5yYltsBu7APE1oqoxMVsbPVxuoW0yfkJzYJR2ZiZkVzq8Df3Q/xzmS7fAJKiiYwdxSjAe+nxGU8XfjRB0GoF0Kb6HlgFH311rxE1PCkFsY4Y8FCYfuS+2zYBlrs2pyTXsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDSJFjvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDSJFjvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D051F000C4;
	Thu, 15 Oct 2026 19:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093520;
	bh=dj7omeB1mFYkRStGH6ELxBSEuwYXTlEGXwtx8CPvles=;
	h=From:To:Cc:Subject:Date;
	b=fDSJFjvtkmkbvO2jMjY47bzKWvFytWi6X3ROaZhZ9tcrRuor9cizUi6SNApFcYeAf
	 q+IK/NUn0BdW5++fP5EKV+Rx96JrpbYXAxZQUVLH8/vbwnJwgxZfwoXP2LfMa/5i/L
	 hpv/UA6hG95GrS2kUVZKPxAv38HPzo3g3xkyDabNGcxRZgxVw1gXe7fbV/UYXw8iuL
	 4RV9Ge+Pe0SSaQIntYrYe4ONxdx8NzXbipq/RU/L0zA8IIv++D0pYgucA2F3gLGoB2
	 6QVO2ZYxT/BJV5oHbefOLuK1+3PKrYjYAVnX3V+GHcPuZlcxipU5357YoyJZ6uo9y7
	 SNjD7Bw7HFwKA==
From: Kees Cook <kees@kernel.org>
To: Jan Hubicka <hubicka@ucw.cz>
Cc: Kees Cook <kees@kernel.org>,
	Richard Biener <rguenther@suse.de>,
	=?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
	gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ipa-icf: Step to the next caller past a thunk in redirect_all_callers
Date: Thu, 15 Oct 2026 12:45:18 -0700
Message-ID: <20261015194513.i.609-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=kees@kernel.org; h=from:subject:message-id; bh=JWp2mtU9lr0BnKEV7Wae/4AVq1QTMY0QyVTTc9Q8bsA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkXdX3XR56L8/7vY/tm0Tq9HW/87sxZUqFcMeHKnXUhz h6RjlGrOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZiup2Rof377R0heydIz4/V K1+R0rTZkeN6hxv/1J/sGzjSH747wMPIMPn0ZvdVTlm8rrM0sj/8jDaULtnHu/rb34zzjF55288 /ZgYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

redirect_all_callers walks the callers of N, but steps past a thunk
caller with next_callee, the next call the thunk makes.  A thunk makes
only that one call, so the walk ends there, and so the callers after
the thunk in the list would not be redirected.  This came with the thunk
check in commit 17d1bf760f8 ("re PR target/65263").

gcc/ChangeLog:

	* ipa-icf.cc (redirect_all_callers): Step to the next caller, not
	the next callee, past a thunk.

Signed-off-by: Kees Cook <kees@kernel.org>
---
I found this while looking through ICF code and Richard's recently
proposed changes with inlining, so it's technically unrelated, but it
looked wrong.  But I haven't found a way to reach it: on targets with
symbol aliases a thunk calls a local alias of its function (.LTHUNKn),
whose other callers come from redirections and so are ahead of the thunk
in the list, and on targets without them, such as Darwin, thunks are
expanded to GIMPLE before ICF.  So I have not been able to build a test
case for this, and I suspect it may just be accidentally/effectively
dead code?  But the intent of the function didn't seem to match the
result of the "else"'s list-walk.
---
 gcc/ipa-icf.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gcc/ipa-icf.cc b/gcc/ipa-icf.cc
index 64cc722bd7aa..7b524bdf16b1 100644
--- a/gcc/ipa-icf.cc
+++ b/gcc/ipa-icf.cc
@@ -995,7 +995,7 @@ redirect_all_callers (cgraph_node *n, cgraph_node *to)
           nredirected++;
 	}
       else
-	e = e->next_callee;
+	e = e->next_caller;
     }
   for (unsigned i = 0; n->iterate_direct_aliases (i, ref);)
     {
-- 
2.55.0

