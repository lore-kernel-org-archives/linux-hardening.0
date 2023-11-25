Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740702FC31
	for <linux-hardening@vger.kernel.org>; Sat, 25 Nov 2023 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5EdWPOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BBFC433C7;
	Sat, 25 Nov 2023 21:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700948956;
	bh=p01SNS2qZBDCVzSPkDLOFpFyded+GzvCX/9pasvl/5c=;
	h=Date:From:To:Cc:Subject:From;
	b=p5EdWPOv9u1qJKMRE6lTDg9F6QiT6VyEGHnF+Dw7bajfbIxE1aBNMa0pu3hCgJeHy
	 uO+wXDbs6TC7LsZfDiQK/yGaL77QXcrH0ik5rJdbdFiVnjTTqLKfne2hQcV8UIBQZ3
	 1Cp5pPT+FXaP7AgvT7AnRJLgVhz4tQIzFu/X8j7NzTVP9jPKEFjrMgjm53gHDg1xxG
	 SV/6GuBLu3j1u9jjN+/yNHvMrU2t3zSHRMHlFgfrm1WvX/C+LsRDKN1hv+TrJ0GHfm
	 xnsIBiTzc5m8Nrn9GWPiXQvp89uCxZm00UmC7mMUQI+a8pnSPZOHzlPWgf6LohPEmS
	 HFwZaNWeT8Zzg==
Date: Sat, 25 Nov 2023 15:49:12 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] gcc-plugins: randstruct: Update code comment in
 relayout_struct()
Message-ID: <ZWJr2MWDjXLHE8ap@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Update code comment to clarify that the only element whose layout is
not randomized is a proper C99 flexible-array member. This update is
complementary to commit 1ee60356c2dc ("gcc-plugins: randstruct: Only
warn about true flexible arrays")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 910bd21d08f4..746ff2d272f2 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -339,8 +339,7 @@ static int relayout_struct(tree type)
 
 	/*
 	 * enforce that we don't randomize the layout of the last
-	 * element of a struct if it's a 0 or 1-length array
-	 * or a proper flexible array
+	 * element of a struct if it's a proper flexible array
 	 */
 	if (is_flexible_array(newtree[num_fields - 1])) {
 		has_flexarray = true;
-- 
2.34.1

