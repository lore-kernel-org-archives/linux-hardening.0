Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD711E5B6E;
	Mon, 10 Mar 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645362; cv=none; b=u/Leo1tfkDPtx8I1yqesMXSWnn/E0Jrq+dGyzsmRSfNOY03aImxIlTZkMQMrK/KboY6ue1C8J6+aZTE0Li6hyR/P1E1P83bwEziJi+5+rgiD2IsZtkNmYy9fZ9IzOpYvU/PfC12PV2UnR+gUe1ZuWwFxeLgGl+s5AVWpy9WDMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645362; c=relaxed/simple;
	bh=LCXo4DfrSJdUJ1t33RWhYUBGCFMNSfeyc9xn9l9EOP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sEdcd/+G24PLUHw4cFeJnRG1jTdtGGjERkPBWZT54PcrOQiIbjQA2SHLvLlyLP+fDBa21ToKdJu88nLVI3iTmkLsnZCC2yag/tAlyhM8WSX+44dCVcE2bCxlu0nbYeQuSNb9qxnXHSPEz73Lh5kOYhSaklGEf0nSMr7QA7M15HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyR1Ooib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyR1Ooib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1073BC4CEE5;
	Mon, 10 Mar 2025 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645362;
	bh=LCXo4DfrSJdUJ1t33RWhYUBGCFMNSfeyc9xn9l9EOP4=;
	h=From:To:Cc:Subject:Date:From;
	b=eyR1OoibFhYvcVGWRY2mIfOEfrczBqywVjPNO9glntGPPDG+7MdyxSueKDW80rZtJ
	 f5ETa/ulDQgYDqiu6PbkjOc+fRN16s1xKopuTYr1Mwc4pxd6E5d+1rEeH2K+ZDjW+q
	 dHRv8DDfGayt9/zdeHkPjnJEu/MhSl4JqFzfWKv2aTjk5dqcMcYleHwiMqgQTdlwK8
	 O/ozc/3LUW4kAzKmEHzPW9q9/mnnfL8/7GCmROvNSNrTiafiYvQ4UGWZtdWAIwJ3yj
	 trZmPpp8zphiXQhAbdk2JFt70YXP8lTUoS0VBSZoEvp7nL7t/gqM95nYXjdHwafxBM
	 uhkhRUg0tfVlw==
From: Kees Cook <kees@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <kees@kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] xen/mcelog: Add __nonstring annotations for unterminated strings
Date: Mon, 10 Mar 2025 15:22:38 -0700
Message-Id: <20250310222234.work.473-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=kees@kernel.org; h=from:subject:message-id; bh=LCXo4DfrSJdUJ1t33RWhYUBGCFMNSfeyc9xn9l9EOP4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn03Tv395t7BM52ejbP6GL1Smil6PnLJuw5J6LAXOJs Ubz0sX9HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOplWNkWJ+/OkepMFJSyMHP wr89d8Osk61rb+W0f/B8qVI06dF6DkaG1uWssseljx0122Ld+1/yslpJyh1+x1Mnvqx/O/tOCPc XZgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/xen/interface/xen-mca.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 464aa6b3a5f9..1c9afbe8cc26 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -372,7 +372,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
-- 
2.34.1

