Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1F14BF86;
	Fri, 20 Sep 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836609; cv=none; b=aEG57+UM3iN+ChylxP6BuRR6ZXoednTeWByj3E6mYGJynQQjrg9qkpL7YsVY6RH7AkRbXLsiOwsWSKPgdzpFH8cwh6Q//C8fPaDyCqfTAze6ky9Y9uGlV6XF6fjAGyTXyLov6huJrajX8csSlCTPV91oVZOrFAQdh9XLZQihL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836609; c=relaxed/simple;
	bh=p6YLJWz9U/S9OuyWWjwWAe0NXusxHGsFmbOEZJtk/3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lp3zEN8ar9e2cWu6GCtO0QqxS7v9oFnHDrDsXHHpkGLwNCztEtS71wPm9UPPvG+UEQLL+Lqn2LyPWIA3m6UJXqzd7oSoJM9UpoDeeFvODO0Xmk28ZUwd0WZKjiQITWB5aVaNKtcrddsvYuJlqMAvGF85vo8fXImpJ8eUbIM+paE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbiBChjB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbiBChjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621D4C4CEC3;
	Fri, 20 Sep 2024 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726836608;
	bh=p6YLJWz9U/S9OuyWWjwWAe0NXusxHGsFmbOEZJtk/3E=;
	h=Date:From:To:Cc:Subject:From;
	b=QbiBChjBccXSW/CVzTNDj8R/OSmQP/T8VNxwtjcCrj/OLhh+tgu57zMV+qQLx2wU5
	 beMuZogRRdczrT7J9/0CLQBFp2wpVap2asHUJz2ODIHZ2btYJ/9mMdWxn6D6KjB4r4
	 myK0cb5PWvh89yQY6Jm+tjhlObV16JHn4kzGMq5Pr2L4ad9skx4svVHNQUzvcybEXn
	 rLL0lDYm8b8Cy3NVUZujPtDOTmjnogi+uJRxCjPRd4/fF7ake9RiVvbqHitHPUaEPn
	 US4avSxL5zyRt4trWSwDA1TuzLa/URmVXoiVT+4W90xFCLZGQRBKxVKrWP7wi9p6mx
	 32BiGPEL8Vi+Q==
Date: Fri, 20 Sep 2024 14:50:02 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] container_of: add container_first() macro
Message-ID: <Zu1vekikKNR5oUoM@elsanto>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is like container_of() but it has an assert to ensure that it's
using the first struct member.

Co-developed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/container_of.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 713890c867be..928c5865c1b4 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -22,6 +22,24 @@
 		      "pointer type mismatch in container_of()");	\
 	((type *)(__mptr - offsetof(type, member))); })
 
+/**
+ * container_first - cast first member of a structure out to the containing
+ *		     structure
+ * @ptr:	     the pointer to the member.
+ * @type:	     the type of the container struct this is embedded in.
+ * @member:	     the name of the member within the struct.
+ *
+ * WARNING: any const qualifier of @ptr is lost.
+ */
+#define container_first(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);                                   \
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
+		      __same_type(*(ptr), void),                        \
+		      "pointer type mismatch in container_of()");       \
+	static_assert(offsetof(type, member) == 0, "not first member");	\
+	((type *)(__mptr - offsetof(type, member))); })
+
+
 /**
  * container_of_const - cast a member of a structure out to the containing
  *			structure and preserve the const-ness of the pointer
-- 
2.34.1

