Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D541EB5EA;
	Mon, 10 Mar 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645452; cv=none; b=egf9gY+eAMR6WeNyfuVrN9t/ilL5XRqg7s/9DjoQTcXZyE6Rnk42+uaqf5yy62VKSqHBRmi7K5qWf3FRtrKnz1l0+g28oyPqGeRY2eAw1bZpD3M0iU/gs/nIXQIzxUGR3L0+vbnjedFIRhDGgHr3tWgBzeGtQklorYgXNSdCV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645452; c=relaxed/simple;
	bh=shCIjbPgReuPgAMGVWg5sb62jJkaJW2ddA41QoK4XO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3DC3R1fZO9L5UZPfRlBPwR6ORee500yc+KzdJ9/wh9vp85nETWg0ynHcMA7hd0KnB8Pdv9lr/qdfdH/+l8p2dDEQap3/Xo9Ky9nsmTeOxm3ZM5xcHCodhZEu4WMq7eJF7ogH0V5J7PIOVwHsQYOB3wwELjCyizdUKNLs+HrG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8TxDOe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8TxDOe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00678C4CEE5;
	Mon, 10 Mar 2025 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645452;
	bh=shCIjbPgReuPgAMGVWg5sb62jJkaJW2ddA41QoK4XO0=;
	h=From:To:Cc:Subject:Date:From;
	b=m8TxDOe9+CV+hjKTWcQ8veQNfhK82KBHzuESX1IINh3Oanwd9HCbSQVocHPj++al1
	 +vpi5xg8lmWOxitoPO7FTaE1zTBwFqnPnT4QBsH0M3RNjB/fJZ4FH+SEW2xD3q9j8A
	 DEE2akM4Y3Z8ffQ2+hCMaNcZK/8BwXe/WurFh+NpphkuydMEXIGhlcq/WZznkBZnTw
	 EJ6/EYFtUy2hQS19sNskDp7c/uOUgTUrw0DJnmtK73mcoYG05xzq0dOXWYKo+d9mST
	 vRA4X71ccXCaXatN4FXMmvt3TDXAwXP9oW3ojToP4f8ONjiaYKDd07zksRcpc7Uf6g
	 nf0VoutOWBp+w==
From: Kees Cook <kees@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] regulator: hi6421v600: Truncate long strings for trailing NUL
Date: Mon, 10 Mar 2025 15:24:09 -0700
Message-Id: <20250310222408.work.339-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=kees@kernel.org; h=from:subject:message-id; bh=shCIjbPgReuPgAMGVWg5sb62jJkaJW2ddA41QoK4XO0=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn0zp/ByTuPPmj+hXr9eW9R6J2BnbPXVp24cOefZ0qf Ps8CiyNO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACYivJGRYcfXFW+lbiSIi2zr fXT6cJbJCyV2ecOsJt/mHSqKT1WPCzD8r+Vi0RC5OfXFcdELbunXLyls+JB/6bLEZZ7lcnNruf/ ZcwEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's -Wunterminated-string-initialization saw that these strings
were being truncated. Adjust the initializer so that the needed final
NUL character will be present.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index e5f6fbfc9016..e74f992fd85f 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -275,7 +275,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id hi6421_spmi_regulator_table[] = {
-	{ .name = "hi6421v600-regulator" },
+	{ .name = "hi6421v600-regulato" },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, hi6421_spmi_regulator_table);
@@ -283,7 +283,7 @@ MODULE_DEVICE_TABLE(platform, hi6421_spmi_regulator_table);
 static struct platform_driver hi6421_spmi_regulator_driver = {
 	.id_table = hi6421_spmi_regulator_table,
 	.driver = {
-		.name = "hi6421v600-regulator",
+		.name = "hi6421v600-regulato",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= hi6421_spmi_regulator_probe,
-- 
2.34.1

