Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17130289E30;
	Wed, 17 Sep 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115693; cv=none; b=ZCZ6TrVLA9EjVDw/bj6iaQ1PX7LGftMGm0vanOjt7jDuqpPPxTzT6g+tp6Ij3Kh0FhcRTaNpj/07Y8TKvlLp8G5ZalNkzvwLBWTd/GcBgowucYbnAeRCsi3sLIdFtsiGH0QhDU48Rd2Ipof9DViJjXJ3ZKwg3w+aTtDyzdMjgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115693; c=relaxed/simple;
	bh=Pp0/V885PF2VJtaQYsMbzixHvU+DoQN0BSBd9KlTu4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw6en5qyPYWTNsprbXQ546vVfi+C2WVVMuisbikEir/eDI70DKc7L6cLoOM17MoV6r4W33gJd+Ra0Vxaq9uXSTJvO2y4/EX/unE9U+0cIY5DEeZntPVaTrmjdWNQemMhb/MrRk8Q+VE8VFgna/W250nUnO2aLP8kd7rFXo6dZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwIHhhl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwIHhhl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26965C4CEF0;
	Wed, 17 Sep 2025 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115692;
	bh=Pp0/V885PF2VJtaQYsMbzixHvU+DoQN0BSBd9KlTu4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwIHhhl8Kagm6SFBSopn/omKdJ5eDUGFN+ZiZf6ztCE+UDinaiIDWke6TDXwSusn1
	 xH1jKP82V904yeuxkZw7hFhOZq2xj7ZEpKDkP9+L2CO1yu9ClYfThkI7vpe1gr+R6S
	 0JffMu3tKASDsALntTtN44b35hHvONkyQn7T8VO4aSsuAA8A+o5peLU+AYQzcuOy33
	 PQ6rM6fAxqiKk3mNYedm6ZEGDVdzFMhz1Phqa+yvCWdBdMzl3zr4qEBV4YOs/m3DHp
	 rPcdgu/irhq/i49oe8wr24KitG9uTSMQq3hUqswMSmsDDRwq+vT3xvhQzhFHXKvSIL
	 JmfvpTY09swVQ==
Date: Wed, 17 Sep 2025 15:28:07 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/2][next] stddef: Introduce __TRAILING_OVERLAP()
Message-ID: <f80c529b239ce11f0a51f714fe00ddf839e05f5e.1758115257.git.gustavoars@kernel.org>
References: <cover.1758115257.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758115257.git.gustavoars@kernel.org>

Introduce underlying __TRAILING_OVERLAP() macro to let callers apply
atributes to trailing overlapping members.

For instance, the code below:

| struct flex {
| 	size_t count;
| 	int data[];
| };

| struct {
| 	struct flex f;
| 	struct foo a;
| 	struct boo b;
| } __packed instance;

can now be changed to the following, and preserve the __packed
attribute:

| __TRAILING_OVERLAP(struct flex, f, data, __packed,
| 	struct foo a;
| 	struct boo b;
| ) instance;

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/stddef.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 701099c67c24..80b6bfb944f0 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -94,7 +94,8 @@ enum {
 	__DECLARE_FLEX_ARRAY(TYPE, NAME)
 
 /**
- * TRAILING_OVERLAP() - Overlap a flexible-array member with trailing members.
+ * __TRAILING_OVERLAP() - Overlap a flexible-array member with trailing
+ *			  members.
  *
  * Creates a union between a flexible-array member (FAM) in a struct and a set
  * of additional members that would otherwise follow it.
@@ -102,15 +103,30 @@ enum {
  * @TYPE: Flexible structure type name, including "struct" keyword.
  * @NAME: Name for a variable to define.
  * @FAM: The flexible-array member within @TYPE
+ * @ATTRS: Any struct attributes (usually empty)
  * @MEMBERS: Trailing overlapping members.
  */
-#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)				\
+#define __TRAILING_OVERLAP(TYPE, NAME, FAM, ATTRS, MEMBERS)			\
 	union {									\
 		TYPE NAME;							\
 		struct {							\
 			unsigned char __offset_to_FAM[offsetof(TYPE, FAM)];	\
 			MEMBERS							\
-		};								\
+		} ATTRS;							\
 	}
 
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
+	__TRAILING_OVERLAP(TYPE, NAME, FAM, /* no attrs */, MEMBERS)
+
 #endif
-- 
2.43.0

