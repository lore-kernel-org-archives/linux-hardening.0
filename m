Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619161;
	b=f+BpSNAc11tiKaIz8YJlSu+WXzhY2YSuYDkwJ7AvnS2YClVy/NuriXuF3R2+7euoxQXc
	 VMC4NAY2K1Iq/PVr243yozLHryHwjSjzzEEqYbGOBCkyXWcEXjLt/ybLE7CaFZgkODoum
	 OpLV2OpCYpfSxoHZaeMe0j9la/TPl93ZLaYFhr+hyfBoqxd9yJMBCyc7fBRhX+7sPHZbO
	 2yWAhqCCUxm1hR44y9yY2vd/nrIeiXDceW5zBmlgh0OmpyAG7obfS0XihF6n6jrMnvA4b
	 7qTbps7raWL5I5pdF9RrVxK5Yo/ilKFPK46Gsw7DRQu9vwGWKr3qwHSGbsD4bdGE85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=LjKk0srtI1K5SrmFvikHzgWRkQar4AFheDwlU5TRYH0=;
	b=4QmmELh6afziqMp+E1YcVn4UnDkKGTWyvQFIXevXd1oBX9HJzzjUrZF4mkhBFaZ14PrS
	 47RPhpeS9cZt9xdD0NW8GYalCzGHPyip7S9kHX7LCTktP1QTJvPlhvOhgSEWtnMs8TFip
	 m6liScS91QIGFo4WL42xxXYh9TglncxvSgfNC2bgMxjWMFI7rrGD0FsIhMd60o2vLtIrr
	 ZK7M7CzGzh3+i0rt0Ki079d0GJNVNNsj4uoekNF3LzlevC3dnv/QCQQgdAC29/HWe+JUU
	 BTaNKkKEZeGSIktUUC19ya8SsXIVUiqq+c1faSf3BGFLFS8JZZasUYnH/HLys6RmXvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i+0a/UMX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1984606A324;
	Mon,  2 Nov 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+0a/UMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0161F00A16;
	Mon,  2 Nov 2026 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619160;
	bh=LjKk0srtI1K5SrmFvikHzgWRkQar4AFheDwlU5TRYH0=;
	h=From:To:Cc:Subject:Date;
	b=i+0a/UMXoYM3PVHhucyzMzzQwN5OhYTrY9kOGxLdf31G/Otv/7EILmhaWX2mVRLHJ
	 6L+0TWe/736ifb0aCyCn6M8zIoXjdi5kIwfGTebI2omWeLzGq8/bYyuEpTqkfXgOK8
	 WBGBXodhRBk2FA4W4mhzhBwZ7wRrvRZ7SU75TVPgAVspFOxcGoo1BFnzArahpTvhe/
	 zU+x/Js8J6gl5LTiS3bPf/3mj3s8rG8TEuj+sIKhiacTfQT+CGvFEEKgnVwk6bIAQO
	 s7Sf/jJdqKBgzELa0P7vOVGr0vX1Eyw1LCKjXP7NstnnqFKvwTPUUCESviIQI5xOqD
	 GRFcmM6oKm1QQ==
From: Thorsten Blum <blum@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] regmap: Annotate regmap_access_table members with __counted_by_ptr()
Date: Mon,  2 Nov 2026 12:30:20 +0100
Message-ID: <20261102113019.265822-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=blum@kernel.org; h=from:subject; bh=OIfpaBPGxZ9VM1pOT/Tf1iGmH2vnUYMGiWMla28rclE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkvSnw2Tcyc/uc+h8zZ4r7Fj37sqJ/o+6ZY/4XvM31WI UGvvqNRHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjAR1y5Ghu51j7vENpQ85Hr7 yn4Sk/vdrW2xp6Z9DeG+3/ji+UvB5CpGhlcPorarxHzl/G85P/Jg4s4L7Xltyx2XzBNUbXx1smL RBUYA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add __counted_by_ptr() to regmap_access_table::yes_ranges and
regmap_access_table::no_ranges to improve access bounds checking via
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 include/linux/regmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index c8aebd148e08..a72f17ab6264 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -248,9 +248,9 @@ struct regmap_range {
  * check function will return true. "no_ranges" are searched first.
  */
 struct regmap_access_table {
-	const struct regmap_range *yes_ranges;
+	const struct regmap_range *yes_ranges __counted_by_ptr(n_yes_ranges);
 	unsigned int n_yes_ranges;
-	const struct regmap_range *no_ranges;
+	const struct regmap_range *no_ranges __counted_by_ptr(n_no_ranges);
 	unsigned int n_no_ranges;
 };
 
