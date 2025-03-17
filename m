Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BFB8C11;
	Mon, 17 Mar 2025 00:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742172770; cv=none; b=nH8MtSSdlDRZtmodXVmiIoM7m2GlmP+qNq5Ml4aXlDgjKQbintMAvwdzkkq66sQbKPMDpHPuxNIlcl7s/Bx+nFWb7UeI76hBA4Ys4P4O9BOUeqcCHI0KXsusBKY8Aza4zwrZzuwt6//1fZE+bzD3KTN/TeZ5vhjcMei+OKseuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742172770; c=relaxed/simple;
	bh=5vKY3AnQvJxY4Hr3lxanztgNCokOGJe1QsE2uMl9vC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qj2BTLA0/91Z3pokW90RU60VnhwK7rSTWwkAioc+KTOAmBtuC/uc4YO/8aj+/8bfhVoKoVXlSmECnb14JH+J2Fbatjdw92PQ75NuUELUr2L4k8Vue+27LOva235cUWdIfLgpldj/ixw3UlviU62q2clk2zK7DrZXpnM+T0Yog6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3ALmTLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3ALmTLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81727C4CEDD;
	Mon, 17 Mar 2025 00:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742172769;
	bh=5vKY3AnQvJxY4Hr3lxanztgNCokOGJe1QsE2uMl9vC4=;
	h=Date:From:To:Cc:Subject:From;
	b=S3ALmTLhHnhDrzCQyEKK6mXLX0laW4Z4geBgolbVxhClw7P96yPRzj6Y/htJZMvnk
	 zWyKZCOXg2wPEnCZcNMsvQjz+64icFCN73mep9qcpLQQqP3ZmhQ39uCjAW/nC7c6HT
	 Jp8uOKJqXKXkG9NBd1OfAfGiwYnBlqwF3Dopdy2ix2S6Jk8VJ2YuGN0/ibofHk27gU
	 FVCvLSPH2YJWKKX1NxhRVQuT16U5RVcZAQjh+jun3n4cRJogNHItEe9qUnShQhJM7H
	 ziHAqoM442GdlasL/yzYWboqG9ZsX7KeWd6vwkQzbhogLrel5eST9JDKNqppi+GpMo
	 lUas5BTYWaJ0A==
Date: Mon, 17 Mar 2025 11:22:51 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: gadget: uvc: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <Z9dyY7_ydJiGqh_d@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct uvc_input_header_descriptor` is a flexible structure --a
structure that contains a flexible-array member.

With this, fix three of the following warnings:

drivers/usb/gadget/function/uvc_configfs.h:77:57: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/gadget/function/uvc_configfs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.h b/drivers/usb/gadget/function/uvc_configfs.h
index 2f78cd4f396f..9391614135e9 100644
--- a/drivers/usb/gadget/function/uvc_configfs.h
+++ b/drivers/usb/gadget/function/uvc_configfs.h
@@ -74,10 +74,12 @@ static inline struct uvcg_format *to_uvcg_format(struct config_item *item)
 
 struct uvcg_streaming_header {
 	struct config_item				item;
-	struct uvc_input_header_descriptor		desc;
 	unsigned					linked;
 	struct list_head				formats;
 	unsigned					num_fmt;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct uvc_input_header_descriptor		desc;
 };
 
 static inline struct uvcg_streaming_header *to_uvcg_streaming_header(struct config_item *item)
-- 
2.43.0

