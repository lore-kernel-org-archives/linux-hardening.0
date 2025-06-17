Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414341A5BBE;
	Tue, 17 Jun 2025 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124552; cv=none; b=Y6etizOay8OmXkyPita/u0oqTQ+w737g4ByT/0i38SIF4oAba+pbioXJzz31eRBM3ruX4TtaRRw2s3xiSXGwxkLQHeh7uD4TnyiMzywB3GhOSCiqf/pxIIdx5+wUhPHC6TiVFP06H8cn+Jsym3OO6EN69VM0xj1BDQjtv43Phhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124552; c=relaxed/simple;
	bh=vW8+vb1swfPDo3QTugetg1Qq57hrQn+fLgudj+eQrww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=emWbR1vyPGTQo/dO1UeAbvg6QtY6x3zWmspx65AmPTJo8Itb090EmYSwhNXUhxQxReXjn6InHD6o74WKr72/kRIIMR30sOc4HyTH1DQAlN8sd6vwMijdIYK3/PVoVKsAz/SnV14lQ3hGV9M+1RM8ycFtjwGONd+iyaxCweYPvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj/itKc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj/itKc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85F1C4CEEA;
	Tue, 17 Jun 2025 01:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124551;
	bh=vW8+vb1swfPDo3QTugetg1Qq57hrQn+fLgudj+eQrww=;
	h=Date:From:To:Cc:Subject:From;
	b=Kj/itKc6fK83Sk9qIDDIQcbumKnGslbe+PCAbB88N7M50IQh0YM0QxOzfBsFjx7TF
	 PFlziGG4IdqcmsMcu9ZJAKDEjFjFTm9cRThAN+x+72ClhJDJa6PB4I+8PBCiIWGxnJ
	 XiMYX55fvUdWyNKB8an/ied+hjnxPVgHjvxyFVc0M2jwMth4Z3D6k5QTMYrvLNTTWk
	 cyXFgpwXG/dU7xkA0vWgPGz5Z5y/IlNBRicwchFK/1QKfaqaU0BlNxxLJpEmj8yP4g
	 vWj0nBk5IQFiZG19m1Fpn/eIddC1vw/xSNEO04cRfPCdjVdrxgx/Z5Kl6N8pXnko43
	 NBnFOWbZTa2bA==
Date: Mon, 16 Jun 2025 19:42:28 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] stddef: Introduce TRAILING_OVERLAP() helper macro
Message-ID: <aFDIBBeYgRSx1ekO@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add new TRAILING_OVERLAP() helper macro to create a union between
a flexible-array member (FAM) in a struct and a set of additional
members that would otherwise follow it.

Co-developed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/stddef.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 929d67710cc5..635513ff2829 100644
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
+			unsigned char __offset_to_fam[offsetof(TYPE, FAM)];	\
+			MEMBERS							\
+		};								\
+	}
+
 #endif
-- 
2.43.0

