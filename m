Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD396FC3;
	Sat, 26 Apr 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648302; cv=none; b=DOtRVRZvQd/8PKT94rDbNYMWkKwYX+O2QEoi2LLjQlEMQENOmvx+JLDE5kyoio/dkRZsR3JHjXQcD5BGY08PH5NLPofT2xi+If6gsAue/HzVPe3rxiQp7QrRFJ879WdSS/8fFkKv3ZemvgGdYd1tT8+1BmzSFuIkZVwvwXMc6YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648302; c=relaxed/simple;
	bh=Zl6MCUVuR5/sOFL3PTbmTtWHb3JkB/O8G/FJ6J9P5FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKVw+566aTc8SjlpQIaAC8m4OpyKyOuiDRUjlqq6kfMFmAKLsegv8fhOxCWt5GKeMSycsQb3eTJusm9QEUoqmLKFcQ+tvSBz4wOzljgkUGDf2tOXpIWhzVeyF0HAMzUr2V9p1UMfkmg7ap3kAoMYCRCviq3Add/vPfhM3u3ZswY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHrVZ6o3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHrVZ6o3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF23C4CEE2;
	Sat, 26 Apr 2025 06:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648300;
	bh=Zl6MCUVuR5/sOFL3PTbmTtWHb3JkB/O8G/FJ6J9P5FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iHrVZ6o3jL0nNgYNOHZ61xPVu5ldeoIfz0OteXUpZ1GMqjpurvCKvqAUArFCx6QFo
	 AyWam3qLVTfh30UJLjEwU2NXu+ox3ifabeUbA+cC55cjp3lp1oT0yigK3IdSvBMZH+
	 lV/3ZFj6vCx0pXHcvjf2OzfOn3AF0MpoC3PiMA+at1OGrYJOPAzSjuaKgtS4Ij3RTu
	 LNbV6zw5JdZt6Yo706Su0PPt+oaNgYbEOODZv/drOs5+Vl6PWfTR/ia6wChdQYyojx
	 rUVvS1q+pIRYQ9NYr60prN4xUAFguEM2vfbB+4Mccwzbzvuo0HOpO427gEpGwkAdPH
	 6frZ5Vu2nvNFw==
From: Kees Cook <kees@kernel.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mei: Cast the cb->ext_hdr allocation type
Date: Fri, 25 Apr 2025 23:18:16 -0700
Message-Id: <20250426061815.work.435-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=kees@kernel.org; h=from:subject:message-id; bh=Zl6MCUVuR5/sOFL3PTbmTtWHb3JkB/O8G/FJ6J9P5FQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8VSsyrf3sHi104chbLpN9ZLGx2HcBqXnR7YcXccTNO 3jLeq15RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQayhj+ykkbftdr+1ewYjHL 59iVVUeCK1/urc65fXGO0FfWxH6PZIb/6Tdz7rzZpDUpRnfytIiHpnw/yt9qakReW79i6+9Wzjf qjAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct mei_ext_hdr *", but the returned type will
be "struct mei_ext_hdr_gsc_f2h *", which is a larger allocation size.
This is by design as struct mei_ext_hdr_gsc_f2h contains struct
mei_ext_hdr as its first member. Cast the allocation to the match the
assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index b09b79fedaba..c484f416fae4 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -133,7 +133,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 				break;
 			case MEI_EXT_HDR_GSC:
 				gsc_f2h = (struct mei_ext_hdr_gsc_f2h *)ext;
-				cb->ext_hdr = kzalloc(sizeof(*gsc_f2h), GFP_KERNEL);
+				cb->ext_hdr = (struct mei_ext_hdr *)kzalloc(sizeof(*gsc_f2h), GFP_KERNEL);
 				if (!cb->ext_hdr) {
 					cb->status = -ENOMEM;
 					goto discard;
-- 
2.34.1

