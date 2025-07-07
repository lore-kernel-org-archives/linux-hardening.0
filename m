Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9C264612;
	Mon,  7 Jul 2025 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751864775; cv=none; b=SqN4smxyAmnhzScKEq/OMdPmWiSF/4X2+2nev2jSzeROJ61RuIch3cnZjg2P3Uv4qnruwvJ9ABfnnoJSpXwZvFpCGjsASUbQ0pZnQkXnoilnsQ7+ogWPKbFzINqiN5+zzLfn0MubF2tBcUXkk05opXCMHjg0rFboAZLR8SUv2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751864775; c=relaxed/simple;
	bh=kVIe30VQ/GPPK/rhv9AuQ5VCmpa6qJ5Bp1dxjM4sv6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLlLWTQEqaCwGdzwkh/KXQ9ylVS6czZsh+oEoluWa8dp90N1vRI0DsqtMmAL+TAMhNnOUGK5p2RY773yNRUYKsb4h7KTSO0L32LmMmYLFf0YJJm04JTrRCLpB2L9SgIA8xZZPf9ccV78EA7ELmCBPPKdtRmGDr+f4w1SqS0zbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWb0ois3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWb0ois3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2AEC4CEF9;
	Mon,  7 Jul 2025 05:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751864775;
	bh=kVIe30VQ/GPPK/rhv9AuQ5VCmpa6qJ5Bp1dxjM4sv6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rWb0ois3NFzBE2GH+RlVu3hYmfrQ8fuH3x8CqDoOXTyrtAygWEct/pYcctBP28El1
	 ILNB5V6cEWR77rM1KuYlyBmvm1YixklNCKOGUBfBcYotD0WfmFe5RySkee6jnmhATa
	 neP0/GQpNkRw+Jr4jLzhY919tGflrBfUXnp24QhRieMEdgMeUpt1g5DSrUR+3nmlwN
	 KFHJdM2tw5uYdzB/0PCOmWoAo8+O9abOVDCNsecIV5T5t6zsXP10OoR+N8MYn+nD3f
	 9op5UmA4tALDcGD2xd6tJMxA4zyTIh9kJvx9lT2UZgXPNkouxB1VZJLfQc9VPS6Bk1
	 nkKlmluSCaYDQ==
Date: Mon, 7 Jul 2025 07:06:13 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v3 4/7] array_size.h: Add ENDOF()
Message-ID: <d8bd0e1d308bc4344240f66c82a724dd67474467.1751862634.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751862634.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751862634.git.alx@kernel.org>

This macro is useful to calculate the second argument to seprintf(),
avoiding off-by-one bugs.

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/array_size.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index 06d7d83196ca..781bdb70d939 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,10 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * ENDOF - get a pointer to one past the last element in array @a
+ * @a: array
+ */
+#define ENDOF(a)  (a + ARRAY_SIZE(a))
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.50.0

