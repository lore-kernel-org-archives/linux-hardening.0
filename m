Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224E49B47E;
	Thu, 17 Sep 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679492; cv=none; b=rYKsEBzaV7Utg+hvb8tRKL4jGdAnKiFMwWGbgRKCqAecqIXDjMPdcIz1ky8FvhU3DK/K7o0hLkEOFfeKG0Cqi/homI+1JMpZWPs1R/jP2+l/2obtb3aeNCoWNkIH1bGTRj4cZVnaZN5hg+KI3uiMYMPESf8y/0ShcAm/aYGBhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679492; c=relaxed/simple;
	bh=YknJ3x7gtR0qtpWPZcLXcCPFsIMFnFuoD7PFYugQ3uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5wHnFhHCs//Wgr4SMqAFrVXK+wJ4Geznel/w6eP8VYdxALlPZETNz9A0esgBOfmPakCWmY+xjAQ+FNJgvt1VUB6+URL25r3ePEyuNOMa00TDTWKzYLwU0Q1KE/Hdagx7nROAgZIuMqZWv0MGYiwz0d8X1aaob7tY8cGVoMKY3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIQyBQqV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIQyBQqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141001F000FF;
	Thu, 17 Sep 2026 21:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679491;
	bh=yYqlGRe2atNfqJegO8NiYKdXxkhDttq1Y6AyLq3n458=;
	h=From:To:Cc:Subject:Date;
	b=TIQyBQqVtTp9cLvtfPlb/ay/N7XsS3z0VyQENs3c0/gt/Y2ZiSeMeZKD3e28BY3Es
	 OLbMaaRpYpvvFeEIF/yKOIr/+Sjsmc04K5orrU2KnBNaEN+33DfPw5SX05yJ3BdJkv
	 cdE+aWjCRTVR84ofoEozJlBJAfNCY3vH+rsXn7ioUokF72h+WawmH0jHh2R0VjTDrE
	 fl4S0PWT6djWMT6KkB36PHUF5R4m2yJi2ZXPH5Ct6XMWaSoBxPSOIFB8sojMvMVMA2
	 EOdCfvd1hOMnFSuKzMeb7318pw6AuhHWkIg+id2X0pZ/OO5tpwAq3ZEcjv5/rE3PuK
	 H6mbvq03fLdvw==
From: Kees Cook <kees@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] gpio: it87: Remove const from labels_table allocation type
Date: Thu, 17 Sep 2026 14:11:26 -0700
Message-Id: <20260917211125.i.966-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=kees@kernel.org; h=from:subject:message-id; bh=kk3mmc6cLd0CT5dBaWEvdMI0pG39IJ2bjX/t5G9Vx5M=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwmtvTLvn8chBee+ntMe/Wl7OaMk3KU4XnJfqULRt+ 7eAFAWtjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImkrmD4wzlx3aniWff4Th1x MXp4yOutcQTrk2OvJv2Z1fK5bZfpnQ5GhrtvuJWeyamuDMx/yXb206+jBuWT56pNsrq+a9Ebxun TA9kA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

The assigned type is "char **", but the converted allocation type would
be "const char **", which is const qualified. As there is no general way
to remove const qualifiers, take the size from the assignment target
instead. No change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/gpio/gpio-it87.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: <linux-gpio@vger.kernel.org>
---
 drivers/gpio/gpio-it87.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-it87.c b/drivers/gpio/gpio-it87.c
index 2ad3c239367b..699325129a7d 100644
--- a/drivers/gpio/gpio-it87.c
+++ b/drivers/gpio/gpio-it87.c
@@ -362,7 +362,7 @@ static int __init it87_gpio_init(void)
 	 */
 	labels = kcalloc(it87_gpio->chip.ngpio, sizeof("it87_gpXY"),
 								GFP_KERNEL);
-	labels_table = kcalloc(it87_gpio->chip.ngpio, sizeof(const char *),
+	labels_table = kcalloc(it87_gpio->chip.ngpio, sizeof(*labels_table),
 								GFP_KERNEL);
 
 	if (!labels || !labels_table) {
-- 
2.34.1

