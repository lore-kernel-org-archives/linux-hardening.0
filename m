Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC267FD;
	Wed, 29 Jan 2025 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128368; cv=none; b=U6Vauwcb9MXQLzW/xfOTOP2mOiiM0cpzAZHVWwGXA3rzYwGvQmZu601oZ+YZPdeqcntRunWK1fVoanKgfh9Lemh5qs9PtpoPNG/lKysI4qLgoxOgD9EhHdp6+TsSrudB0D+OJtraLA2nhoc4OOOZzVVKo572bF1kNXZcMYr04mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128368; c=relaxed/simple;
	bh=2PVVfsArcahutrRB2ALpGy9TbEusniEsRpat1x2Lcgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=URYCZKRlGeC4y1W9zayXf5rgF5d3ChA/ofWhq1FnS3l7ss+4wnNBTulFW4PgdzIEXaW7ZDXjmWVIVuOxJq+4GMfs3yUBxSaDE+bGAEj301HUkYy3xtFfiOwAN0ssEIPTz0r4Bfat8maCSurU1UsTMvsysfQCb5/hHQj+MA3Qikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK1JkESD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK1JkESD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94648C4CED3;
	Wed, 29 Jan 2025 05:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738128367;
	bh=2PVVfsArcahutrRB2ALpGy9TbEusniEsRpat1x2Lcgg=;
	h=Date:From:To:Cc:Subject:From;
	b=oK1JkESD1G+avMNnEguLG1TIhUb6faSQNK6RhP4SMCpCX3WsnwIbfAA+3yQb2Y2JD
	 I/wK2AkcGQPkyHSoCvbb8Mq+9OjKR1b2UjxQRNaFL2jfG5npuLARUmF4LMxZxdXv/X
	 i/SShnAi/EfPj0/1tAV32eUfl0QGLYf8zwBYTswZE1BjjD2wzsvNOrcbgIbRY286oQ
	 UIaLlC+XaHCKtTm5zEf9lp3yc3XzvA2PqgmrOeYcf1Eyu2JoMjad4Xy2VC/bo7qE+v
	 Jw5FEpeIR4KuPq56QzdivRtI032EM21YLzstuR/q1W+8RN508pIORG0hQNcafZ92G0
	 KzEn1Y+CgPymw==
Date: Wed, 29 Jan 2025 15:56:01 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <Z5m76U5zh34WbeQY@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is like container_of_const() but it contains an assert to
ensure that it's using the first member in the structure.

Co-developed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

I will be using this in my -Wflex-array-member-not-at-end patches. :)

Changes in v2:
 - Base this on container_of_const().

v1:
 - Link: https://lore.kernel.org/linux-hardening/Zu1vekikKNR5oUoM@elsanto/

 include/linux/container_of.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 713890c867be..1a5e5f32db92 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -35,4 +35,15 @@
 		default: ((type *)container_of(ptr, type, member))	\
 	)
 
+/**
+ * container_first - cast first member of a structure out to the containing
+ *                   structure and preserve the const-ness of the pointer.
+ * @ptr:             the pointer to the member.
+ * @type:            the type of the container struct this is embedded in.
+ * @member:          the name of the member within the struct.
+ */
+#define container_first(ptr, type, member) ({                           \
+	static_assert(offsetof(type, member) == 0, "not first member"); \
+	container_of_const(ptr, type, member); })
+
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
2.43.0

