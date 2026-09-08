Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B90389455;
	Tue,  8 Sep 2026 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849296; cv=none; b=mBM4c7cBaOiYlub1qKqTfcXjhqH9xVobLcF/MyUNyz5dMDijoYkTvYrY3Dq9A7meroiJNgI0xv4DPHTS66ucJroUeUl3fIbsPjd1C2/eK1wZ/8bM1NWTQzt2JnrW6uTHRi+jot0P7cCwNHpJ1LypsJw83pQMnFbdkTeWZVC/ocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849296; c=relaxed/simple;
	bh=QQRzuXzmnjJsFgnnkNw8OhJEK0NRIXvV68+Qt6ORD8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKqPMdYfejC0ouCvj9xC7Qt9zIzWHw9CYh+j8EZEFMnnWymOdiOCw1Z82sc0NWnoPxGWiWM/WMXaes37NIxLKM9tx3AwHcTtmeDP7BAhsi76A15ypRAM6pwNHyQXvKXAMHWAy3j2cGV7iNTJrQvRJtoCleg+/xdZDufMbKbfnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFVblAv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFVblAv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99DE1F00A3A;
	Tue,  8 Sep 2026 06:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849295;
	bh=TjrSeuZzCJ2FALBUAAiSlq6f7kAqnkNBSiXYYiDD+9U=;
	h=From:To:Cc:Subject:Date;
	b=iFVblAv75Z30JxVeHUvaNZ6j97Ofr9sU/e9Y+3Z47BN8dcT2Yxxi8FCQ9GjquZ0Oc
	 lyNzQuX6dlOLLHMCySn16+Z7iwOiu3DtCqsXWLc9y0HZfdJeyaJ/trkDgptG6yxLq/
	 1w1wW7AXbb9pbSqI4vsFGvTJBlRQuBTW0CRuYGmCTNB+3/ZEfRVNaRcd3sNmdIhLBy
	 1xsGy8PoKSjbmpeJJrdNF5U76VlG7R5NCWcS7JVgUXkJvsz0cE93DoqKufG9JwcJ0Z
	 /XxDNV4FUrbITB1ycMSrcXTRAyU7nVRHYRHtpi1oHFR83Q0KFcRv0syNdBJ2ciDC9/
	 EfJQN7Z2vBohQ==
From: Thorsten Blum <blum@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] platform/x86/intel/vsec: Annotate deps with __counted_by_ptr()
Date: Tue,  8 Sep 2026 08:34:28 +0200
Message-ID: <20260908063427.301333-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=blum@kernel.org; h=from:subject; bh=QQRzuXzmnjJsFgnnkNw8OhJEK0NRIXvV68+Qt6ORD8w=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnz1xSvupD8J+qEdttTuc9qRw793L3v8/ZNghxN7y4xm b5mL0hd3FHKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATabzEyPBA9ppo/b0/jDLG K9d5sip+6jmerSn76UOu6Sspr5wzG10Y/ml/OM3UFhRwLF9xYl/Bn7z79r//C/y4Mkfip9DyuuT 9YbwA
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
index 843cda8f8644..7b9638e16e7c 100644
--- a/include/linux/intel_vsec.h
+++ b/include/linux/intel_vsec.h
@@ -122,7 +122,7 @@ struct vsec_feature_dependency {
 struct intel_vsec_platform_info {
 	struct device *parent;
 	struct intel_vsec_header **headers;
-	const struct vsec_feature_dependency *deps;
+	const struct vsec_feature_dependency *deps __counted_by_ptr(num_deps);
 	u32 (*acpi_disc)[PMT_DISC_DWORDS];
 	enum intel_vsec_disc_source src;
 	void *priv_data;
