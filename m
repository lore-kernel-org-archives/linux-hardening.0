Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92C2EF9A6;
	Tue, 17 Jun 2025 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187140; cv=none; b=qQVEMJuH3ayO7wTeyAjKbwWlqx6BLeCPfP6/2m0I2+UjJ7FYhUPfw31+4MOzlF5f1lLpWoz/Qn6q9pxpSjPqXmPYwDg7q25ZYYc6RLjR6qeax/tkkq1shkFXOYWNZOtnsJ/x4OXpMg29YkNvYKTYJHPGp5fS2o9d4gTLyapcqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187140; c=relaxed/simple;
	bh=dbDKOsBz9dJlbqgtvG7nKkHg1onXG2S9EsH8HaBLgGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e6wpqFmhyvrbZG8kXBiNETm/Cr+omIBlDQMZOYi1Tvc01AJ3Fz9FfJ2egRtnG7UAizQDHDeOYw4jBmwPuukrIUCjwKnQ/OSeJiPzMYfcQKemACtQQ5ocT0ZZbBqbKKVvuml3+cl4fqds0G8GLvowejUhMRdcqhqqv6a5KuSJENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF6/B995; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF6/B995"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209ACC4CEE3;
	Tue, 17 Jun 2025 19:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750187139;
	bh=dbDKOsBz9dJlbqgtvG7nKkHg1onXG2S9EsH8HaBLgGE=;
	h=Date:From:To:Cc:Subject:From;
	b=bF6/B995Xf+rT0H1YlbOklofkR1DZ4mEz1Dpi99+wCz2GlUTzIT3iEWkttuMjMJvn
	 SzGT0lvoi+eNhcuHZ6QCOl42n+Gk35N/JNdp29tcHcH/OQ7Kc12i3CT6c/vDq72Hqu
	 g/zp1W+VMy579MUxS6u74HjmUP8FZNLFXr8WFBDJfqNIjxj2D2LRCm+zqAuRFs4lYF
	 B/R9IE9jGO69rNMpFUYOycAQR6S/CAIY/wSDmRoMoAvR32SyQwI5fGNyLxhPDt7haq
	 4SvzIPEP4LP9fe2uwX2qqiWo1pT7wj5JkxGESIh5U07/c6bAnIo8qLGFlNxEIRetk8
	 yupgRRbR8XQZw==
Date: Tue, 17 Jun 2025 13:05:36 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] stddef: Introduce TRAILING_OVERLAP() helper macro
Message-ID: <aFG8gEwKXAWWIvX0@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add new TRAILING_OVERLAP() helper macro to create a union between
a flexible-array member (FAM) and a set of members that would
otherwise follow it. This overlays the trailing members onto the
FAM while preserving the original memory layout.

Co-developed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use `__offset_of_##FAM` instead of `__offset_of_fam` for the
   offset variable.
 - Update changelog text.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aFDIBBeYgRSx1ekO@kspp/

 include/linux/stddef.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 929d67710cc5..dab49e2ec8c0 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -93,4 +93,24 @@ enum {
 #define DECLARE_FLEX_ARRAY(TYPE, NAME) \
 	__DECLARE_FLEX_ARRAY(TYPE, NAME)
 
+/**
+ * TRAILING_OVERLAP() - Overlap a flexible-array member with trailing members.
+ *
+ * Creates a union between a flexible-array member (FAM) in a struct and a set
+ * of additional members that would otherwise follow it.
+ *
+ * @TYPE: Flexible structure type name, including "struct" keyword.
+ * @NAME: Name for a variable to define.
+ * @FAM: The flexible-array member within @TYPE
+ * @MEMBERS: Trailing overlapping members.
+ */
+#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
+	union {									\
+		TYPE NAME;							\
+		struct {							\
+			unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];	\
+			MEMBERS							\
+		};								\
+	}
+
 #endif
-- 
2.43.0

