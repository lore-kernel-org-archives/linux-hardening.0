Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B18442387;
	Mon,  7 Sep 2026 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770674; cv=none; b=UvMdpzhDxYnin5wlm3luviSngMEkeV5AgbrqhbsIVSX3JcQyshE0UhnE0FUlvEKLIaz5tPj7OLHy9E27qC9FtJFgDDubHqZ7kkRIK9dehorjuERZY47U7uZtuutWbJ0vXG1vjDY7rHRwmKdsFwTP0TU6B90i3Hnktj+cQsAdr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770674; c=relaxed/simple;
	bh=mieOW8W0NHFL18v7IALtWZKuWPG2+bUmFSLg+x5/b2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NImGflNYlozfBTdwHFyGOjPAKX7+34qcJgno+2sqfDXHMSt7Ho5TsVJAbGvdP2sdEubuHb4B71WNgCZ6F+rM0oMY0tYE9LiPYYYNM+FURc2ZSPEjCB/TFFisUupV8uPeJachL2zQArExgkI8YXE5zrjTGlKVk1aS13dSAbm51WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaenURjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaenURjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E6E1F00A3D;
	Mon,  7 Sep 2026 08:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770673;
	bh=GnpRfOzBViOPXWjXc5vLsfTKF6r2NMDcyBw74cBLVAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaenURjw9Qoz9iEJHwan48KTu47kg8/x89rWr2JuppFagEK8l22yD4Anub6dvuTMT
	 ilXQzCQsboZt15HSFD6O9ItyQP+1QdIbIX0jucDylhjLv/FSFAXum7a5tGR97EQToh
	 chyIcAarrVQ0DzMrJTd59k3f+3j0v9p+sGeBdmXjVFLOI0LVfzXjtyMokgPcCtEsfs
	 wAccaIh5M9N9gyQMIyFvYKZ/7erm8bjTsywfCr/J66as6oG06w55Pr8WzpSNigHtxU
	 7IMyBHYmx5TtRDropcPEXqpN0bXdh4FoCU0TUWoojCAGJDWt7s3PQiPxdZLjx6Pnkv
	 Ac9QwOReSeLbQ==
From: Thorsten Blum <blum@kernel.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH v2 1/2] lib/string_choices: Add str_supported_unsupported() helper
Date: Mon,  7 Sep 2026 10:43:20 +0200
Message-ID: <20260907084319.351688-5-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907084319.351688-4-blum@kernel.org>
References: <20260907084319.351688-4-blum@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=blum@kernel.org; h=from:subject; bh=mieOW8W0NHFL18v7IALtWZKuWPG2+bUmFSLg+x5/b2w=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnzKh2tvdqWfdxrqu0REitjUT358abWWZpLd0sfa1KUZ 1K2dXXvKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIm4HmVkuOYUGH3s27+zm4Vj n1lPPvyU3V3DKNc+Tn/ZhROxU1LEyhj+mW7pfcHpd/7njbvN23WWFr8syvZ/a28QufyX6AdViZU mzAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add str_supported_unsupported() to return "supported" or "unsupported"
depending on the boolean argument. Also add the inverse
str_unsupported_supported().

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index ee84087d4b26..a2eba454004f 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -65,6 +65,12 @@ static inline const char *str_read_write(bool v)
 }
 #define str_write_read(v)		str_read_write(!(v))
 
+static inline const char *str_supported_unsupported(bool v)
+{
+	return v ? "supported" : "unsupported";
+}
+#define str_unsupported_supported(v)	str_supported_unsupported(!(v))
+
 static inline const char *str_true_false(bool v)
 {
 	return v ? "true" : "false";
