Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D2328B6
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2KeOstZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBB8C433C8;
	Thu, 16 Nov 2023 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700160902;
	bh=JwQgKXdyVFHDeYy2JqIrcrbfOB3OycZsBTQgBU7qjPM=;
	h=Date:From:To:Cc:Subject:From;
	b=Q2KeOstZqpSdN4JhKTSNmJecY3BmKrmxV0TKxlDYtF5gv7UBoA9ki8l+3oU7WT0Hx
	 SGmSc3VfEncIDsy7g1gUdu/dUurdmxWoNKqVqXpNG0JIQn/9CRKtLj4EZby3gR0ebM
	 W29DzH+9f5rXc4ky/j82PuHjBZxanaXp2OXpLgfdOeYwEyc8H6InT7BIuTjYwI2twZ
	 K2Q59QirBuKsjjD1uHuCUq6Vt0CT0Ut1+Mc3R70pFEkwWmeLddoRJdAqfYUx+Un6j7
	 onTVWGPMm6W16RlorLGNo7T/80qIpz+vuwThsSHkscF6lBwIA6x+UPnUOlCQ+Gw8al
	 9yTiFS6TTIGSg==
Date: Thu, 16 Nov 2023 12:54:59 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] xen: privcmd: Replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <ZVZlg3tPMPCRdteh@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fake flexible arrays (zero-length and one-element arrays) are deprecated,
and should be replaced by flexible-array members. So, replace
zero-length array with a flexible-array member in `struct
privcmd_kernel_ioreq`.

Also annotate array `ports` with `__counted_by()` to prepare for the
coming implementation by GCC and Clang of the `__counted_by` attribute.
Flexible array members annotated with `__counted_by` can have their
accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).

This fixes multiple -Warray-bounds warnings:
drivers/xen/privcmd.c:1239:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1240:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1241:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1245:33: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1258:67: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]

This results in no differences in binary output.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 1ce7f3c7a950..0eb337a8ec0f 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1115,7 +1115,7 @@ struct privcmd_kernel_ioreq {
 	spinlock_t lock; /* Protects ioeventfds list */
 	struct list_head ioeventfds;
 	struct list_head list;
-	struct ioreq_port ports[0];
+	struct ioreq_port ports[] __counted_by(vcpus);
 };
 
 static irqreturn_t ioeventfd_interrupt(int irq, void *dev_id)
-- 
2.34.1

