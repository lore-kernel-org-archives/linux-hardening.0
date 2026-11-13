Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573122;
	b=b+4MycW+7mWb/F6ACgTpYO6gg4OoZHUcFvOm1UYLMAYDkREt8LI9dCEaKUBks9gvZa0w
	 rd+Qq4fXCU5pTBWkPnSMeSmR5D6DAnegbPs4aDdacgNpMS4Ozn+lScBl5PUimBJQthfLl
	 yNt1LLw9MVJJHcfem6woux5ZZQqB+kK6b3xLzQv2i54OB61YzUehN3ikMa2b/wCmZBMkx
	 irM/ParD8AleJPXfIObYSCVCiptFEq+lK/uFGdeAz/613D8LN7T301reDOpN2iwMHAWgA
	 5BzyUrzlk6ZiH6pA04v9chnajDu7+DWszkL0Bzr6pPDfI6p/DA4qcn6FW1SNB2VoDpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=H9BRq0CMwOYikoDYjR+d8bkPKBACR5GlMk0xvfd5V1E=;
	b=BalJRno94zq5HufVn+cZDqNrSGYU/Xp6XT7pgV7qzM3yuGRFhGXKB8nejgkYy6YVPC9G
	 laYkHZlt/H7xcYU8feL3aZ3cJfm95Hjm09DDKDpi8M+JOyPeravlzBrtae/ZSbdQfi01r
	 v0l5ev61mvaAOPHre5KucE2KEW1tcPoLt7aAXdysnNtFnK5yFa0qYIM8+YsgpIc42gPSG
	 rSbl6BJ6woV+Ek/RLakWOtqrBUy3Qk/Pmn9rr2ejvfB1XtcYYlsMFYvzOiWqLLOVIVenX
	 YBxn5FCbdOPOJdF2bgnU7NF3mkU3Sxzhq5tHJt7uQTMTka+vCsYq9JXVgkEWKcfTdrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cv8WZMRb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6B606A32D;
	Fri, 13 Nov 2026 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cv8WZMRb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4B01F000C9;
	Fri, 13 Nov 2026 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573122;
	bh=H9BRq0CMwOYikoDYjR+d8bkPKBACR5GlMk0xvfd5V1E=;
	h=From:To:Cc:Subject:Date;
	b=cv8WZMRbqd0iDuOUr4iq5s6k3s+sZIfkxMsgu7s9ktOnOhRppDwEUzARCHwcJH/si
	 Bmc1fGm3hOfKvlj20tGCD6zwdikK63fKj3AihvoykNXpE6Mh0Bs73B4RQXsMIQVK1O
	 LRclg12V70lakOGRu0Qjh8zlMffZ2XCX0Jjh8LkS98S0QHjbrRSsKYVH2E5TqdL6Yv
	 P2tBK/jY2bUekv+fE/cvFVmFgBsM3GX/BCDG1Gc1DPAI3jAHaOde7MhIGza//iMi0N
	 5e8R3YyuBkgZOBAXsnemhAmdgWd0tFE+8bfvV37TqLJwCfd8/osnURWFGprg9MdIPo
	 sRYKNXc8Hi2Ng==
From: Thorsten Blum <blum@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] platform/x86/intel/vsec: Annotate deps with __counted_by_ptr()
Date: Fri, 13 Nov 2026 13:31:41 +0100
Message-ID: <20261113123140.69197-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=blum@kernel.org; h=from:subject; bh=43AmQad/Oo+MM7tdt5zfbToLMOSA8xmLpAEWKcR9ihE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnfmXUCrj+dn7VLhXPHncm/OVk1RU8sL8uffaKG+We/L JfsDYGajlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZiI/2JGhlfxn6UZ7F4579ly YsHJrR8XTWNb1cs4P6vLYVpi2abFX9MY/jsIvbH+e3y1gcc7ne9L2H/+CXD75nw4f9OW/ozGDcE 8CswA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add __counted_by_ptr() to intel_vsec_platform_info::deps to enable
access bounds checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 include/linux/intel_vsec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel_vsec.h b/include/linux/intel_vsec.h
index 8686e79c4f75..6471823dc3a3 100644
--- a/include/linux/intel_vsec.h
+++ b/include/linux/intel_vsec.h
@@ -134,7 +134,7 @@ struct vsec_feature_dependency {
 struct intel_vsec_platform_info {
 	struct device *parent;
 	struct intel_vsec_header **headers;
-	const struct vsec_feature_dependency *deps;
+	const struct vsec_feature_dependency *deps __counted_by_ptr(num_deps);
 	u32 (*acpi_disc)[PMT_DISC_DWORDS];
 	enum intel_vsec_disc_source src;
 	void *priv_data;
