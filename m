Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F0E57D;
	Mon, 16 Dec 2024 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734312472; cv=none; b=OFtR79XIa1jPL8/usKo3GFepwmehk0lh1Fg9pCSv4REVoaYZo4f2xbgIzcCCfSf/4jO5JArMODjQpEAnRHidPPQuvVpbweysJ/7GXcngEjcLWYS3WCP+eKzmFH3yiNu2jmU9+4LgGK2kE7rZ+Cf5VDCwMJSaVEyM0GyOLA6fXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734312472; c=relaxed/simple;
	bh=8mG+G/lK51j1vgDOIaBJx5cjCjXLy2marSPSfx8iBC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a2L3Wa3AUVvT6Jf4k3vrDilYs+Mo4Najfn62kpMokBqefLmTaG/BorO7FxxYI8ibxYbrI/0PRlrBQgkNxVpSyPzcf27bl3qXdWzPlVJUtvnvSinKL+aCIItP4xyuxu3SIEN7Kj9pKnQeKqkYx/oxrQb+hCoh1ef9wU5sEqUY/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh+vrx8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh+vrx8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B1FC4CECE;
	Mon, 16 Dec 2024 01:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734312472;
	bh=8mG+G/lK51j1vgDOIaBJx5cjCjXLy2marSPSfx8iBC4=;
	h=From:To:Cc:Subject:Date:From;
	b=hh+vrx8xvhqD4CYZmHh0nAY6phw4RNYcY3BXm5Ilc4N5fMGn9tythzCWilO9fqeNB
	 3qqaxVdOZ7j6N2g5iUs6VpL/tNs8bpBBnAnYHzLM4hZb2hhCajk2+gRybkgZsGb8Ne
	 77Lq7BlIzpxDR1waboEXAWEcR2sFF+EH90T3/N27g3+PYYIjr3jeIdVuojPVg5hhLj
	 WB6Fxd6DIVeTzwaRn3Igy8XaH/NKAU9/PRKOOcD8wmo7F12rMdaHoCPNg2yWT3ZWQ4
	 iu0pkiMimLcXSGh3xBAlDDfx1FHX0oV4z420gjgs4B2sigZWONFeGnBaxqf115NDZ5
	 qErUpcoPbzzOA==
From: Kees Cook <kees@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	regressions@lists.linux.dev,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] docs: git SHA prefixes are for humans
Date: Sun, 15 Dec 2024 17:27:47 -0800
Message-Id: <20241216012743.work.705-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3675; i=kees@kernel.org; h=from:subject:message-id; bh=8mG+G/lK51j1vgDOIaBJx5cjCjXLy2marSPSfx8iBC4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnxTcLb9531ujFl9rnQdZ/YirbbPVmbb1x1v5X32F/Vm nXNzvuSO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACbyZQPDP5MMgd1HvcWfSXnp sXCt1WYPL9vZF75NqK40RulHfeH+ZQz/i24dSft1IpbdleulbfjCmV3uTs87zj7ZvDjWomGKj9B VBgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Clarify that the preferred git SHA abbreviation length for the Fixes
tag is 12 characters[1], as the tag is intended for humans (though, yes,
it is parsed by machines too). Collision resolution needs to be performed
using the parenthetical patch Subject that follows the abbreviated hash.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev
Cc: workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/process/handling-regressions.rst | 4 ++--
 Documentation/process/maintainer-tip.rst       | 4 ++--
 Documentation/process/submitting-patches.rst   | 6 ++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 1f5ab49c48a4..a0e8715c6cd3 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -29,9 +29,9 @@ The important bits (aka "The TL;DR")
     * For mailed reports, check if the reporter included a line like ``#regzbot
       introduced: v5.13..v5.14-rc1``. If not, send a reply (with the regressions
       list in CC) containing a paragraph like the following, which tells regzbot
-      when the issue started to happen::
+      when the issue started to happen, preferably with a full git SHA::
 
-       #regzbot ^introduced: 1f2e3d4c5b6a
+       #regzbot ^introduced: 1f2e3d4c5b6a1524e886b7f1b8a0c1fc7321cac2
 
     * When forwarding reports from a bug tracker to the regressions list (see
       above), include a paragraph like the following::
diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index e374b67b3277..658b489705be 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -284,7 +284,7 @@ following tag ordering scheme:
 
      Commit
 
-       abcdef012345678 ("x86/xxx: Replace foo with bar")
+       ab0123456789 ("x86/xxx: Replace foo with bar")
 
      left an unused instance of variable foo around. Remove it.
 
@@ -295,7 +295,7 @@ following tag ordering scheme:
      The recent replacement of foo with bar left an unused instance of
      variable foo around. Remove it.
 
-     Fixes: abcdef012345678 ("x86/xxx: Replace foo with bar")
+     Fixes: ab0123456789 ("x86/xxx: Replace foo with bar")
      Signed-off-by: J.Dev <j.dev@mail>
 
    The latter puts the information about the patch into the focus and
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1518bd57adab..efd4fb1109e9 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -163,6 +163,12 @@ An example call::
 	$ git log -1 --pretty=fixes 54a4f0239f2e
 	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
+Note that the "Fixes" tag, while it does get parsed by machines, is intended
+for humans (hence the Subject portion). It is preferred that hashes remain at
+12 characters even in the face of prefix collisions. When encountering hash
+prefix collisions, tools (and humans) need to resolve such collisions using
+the parenthetical patch Subject.
+
 .. _split_changes:
 
 Separate your changes
-- 
2.34.1

