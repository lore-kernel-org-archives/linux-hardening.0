Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBA154B1
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5t4oZoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F04BC433C7;
	Mon,  9 Oct 2023 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696877733;
	bh=GFc4Q5qaXcf/ZjZp9N+g0hF8nyG1r4y/dZRvyq8Du9A=;
	h=Date:From:To:Cc:Subject:From;
	b=E5t4oZoZGUwok3/PFxqTFm3bx+BQDZJJ+vyjeQKx5qfH3NW3T8avl6qgl+bnyUYJC
	 zO1yvhHO+sP4fFX8+Jb4cqmWJslQJwmigAelDrmyPqCA58TgriU+tkTzbfJb5SuovZ
	 jmqfndJSghzEQXm51nn5/kzyOz9T/Y1tXPAfnCjNoUTr4bTsLW0LPDmZeCVakppUDH
	 jEcJR2BKfR9ECTm+7FG2ekhXkNGfJJsXybno9Pv1LFe6AsPro4qWuKH7WRyXxsIk1O
	 o7ESnWSiQu2Nh1It7cAwnSiFhLfLU8drWQ2MQTfz+NjJJgjGI/aYtvnD6rJ7+HzeyS
	 ydCrTBcQ7J1Mg==
Date: Mon, 9 Oct 2023 12:55:30 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] xen/xenbus: Add __counted_by for struct read_buffer
 and use struct_size()
Message-ID: <ZSRMosLuJJS5Y/io@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/xen/xenbus/xenbus_dev_frontend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 0792fda49a15..6f56640092a9 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -82,7 +82,7 @@ struct read_buffer {
 	struct list_head list;
 	unsigned int cons;
 	unsigned int len;
-	char msg[];
+	char msg[] __counted_by(len);
 };
 
 struct xenbus_file_priv {
@@ -195,7 +195,7 @@ static int queue_reply(struct list_head *queue, const void *data, size_t len)
 	if (len > XENSTORE_PAYLOAD_MAX)
 		return -EINVAL;
 
-	rb = kmalloc(sizeof(*rb) + len, GFP_KERNEL);
+	rb = kmalloc(struct_size(rb, msg, len), GFP_KERNEL);
 	if (rb == NULL)
 		return -ENOMEM;
 
-- 
2.34.1

