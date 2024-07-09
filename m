Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0071DFCF;
	Tue,  9 Jul 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540200; cv=none; b=O0YnjFh8b0NT7wf0/ISEaUBat0HHBA7moD8zybkUr4/Cy005V7zOahQanbXYn75qaJVN8ycTeXusdx6O8HPFLEuZUh3Qg3XYD/f5nEUdAqjj5H5ZJks4mQ3ThAJK37uSoS0qQ4Yuv4fu9KjDVqNots+jDwZEF3t6ALSBAXgtDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540200; c=relaxed/simple;
	bh=9MrxDoNPhTi1XI4NxjDlhW/N0h70bpLtcvV0dqXfW+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsHifXNYwe080Wguno7OsWTWIh7z2rEQzSsgt96JyFIMK5NGSzNKjAfxwZ5H7X1AHNn62D3GPNC5YRdHQfoCZ373rJ76punm6LF2na/wVd3QqBkANNuF7X647Q/8V97yiFcqd52fsJUyHIh6f8XjpI/Uesbk9w98ma4Xzkgfueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFMPc4tZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFMPc4tZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CDEC3277B;
	Tue,  9 Jul 2024 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720540199;
	bh=9MrxDoNPhTi1XI4NxjDlhW/N0h70bpLtcvV0dqXfW+k=;
	h=From:To:Cc:Subject:Date:From;
	b=dFMPc4tZijAFt5E7miIzqmOv8UaDJkyCdGLYa6AqapQq59vw/gnOgwDW51JpXKFHJ
	 wTQCGVbsSuKjnU3nJ10yLuiawkAEhi4ytVmEVBVDO3LBfdfRAB1VLP89Kbd1rPYl0e
	 IfN+pYZKEJ6URea3KQnZnNjMveukZDmqtqclk/0ooe5dBiajYogw0P7eescFCibcMt
	 rhwaibker90/8Ec6ekigekJASKkOt4h1gfRk9s8BjvKn3rjE+c1Ifm2jQKD8ANCdmw
	 oAdW+Tq0HxjaInXSKs8/Z72MFT8po5dC2sAiRyEnaW6/Fzoa+f/V/lMr+h6ESdPVVh
	 V2fqZl/hoig8Q==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] usb: gadget: Use u16 types for 16-bit fields
Date: Tue,  9 Jul 2024 08:49:56 -0700
Message-Id: <20240709154953.work.953-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309; i=kees@kernel.org; h=from:subject:message-id; bh=9MrxDoNPhTi1XI4NxjDlhW/N0h70bpLtcvV0dqXfW+k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmjVwk0t22Uyu2+atEHAcV5lh9rZAh/DghXMDBf pwV37Mm4YiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZo1cJAAKCRCJcvTf3G3A JtyZD/0TajsMXBzlOFR/SgJkyNP2VxbKrBJbj1cOvS9BZl6LZoJW9d3zSFPJTd9ccLSOyTGazbi z04/mOErf464BXNQrY79sXaqEOk4oywlGUBAK3LddjBOHJdQy/TzwX0rT98YiqHyA1nsmdt95yX T4QLXFOcYddr/5HRQ+3rm2otfvhDJGzVoQWY7xsiIgqdckIUhXfyMGXQ6wQB2OFih0YkF4Eu0xv iOespH+8oFjxk+/eujupsRs/QY+Oj7hYrx9kl9gj1eEBrlJwjiG2BJQSP/bt1rSV18PsfBpIi7l ffLfREQJ16+IG3oPKVBgCS9jFHBDmxL4V0g/919G/JdP96OZdrqOtuPpUVhChOgMkvP6iw0SFi+ PlFbBpfjaALF2SK+DS+3azXgCSjJsnWqNP25wX0jUHgGCxhOa+zJ0ezH5SJMS6cX+QT+trDkMbY nlLdqCWbP/6gDps2eLFKUM0ktJ0sBCEZEDhZ1mWhWwoqWZaDVz+23joFEC2YxrPt9JMMcgyghDx zc5xCJnwbuZ3yP23UaBY9bPnu41K/5HjIRePJdPm4uojCNyAVyhxlYtZbjVuwHiehHAlz2AbtZm FbC2YHSsOAtJ/bdHc97c58x/FCSijXh6Ka7YWQETFmRldbhkp/lau0mtN+83ccnY+2OzT3hR8n2 tH1JzXaYiMCzW
 vw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since the beginning of time, struct usb_ep::maxpacket was a bitfield,
and when new 16-bit members were added, the convention was followed:

1da177e4c3f41 (Linus Torvalds   2005-04-16 236) unsigned maxpacket:16;
e117e742d3106 (Robert Baldyga   2013-12-13 237) unsigned maxpacket_limit:16;
a59d6b91cbca5 (Tatyana Brokhman 2011-06-28 238) unsigned max_streams:16;

However, there is no need for this as a simple u16 can be used instead,
simplifying the struct and the resulting compiler binary output. Switch
to u16 for all three, and rearrange struct slightly to minimize holes.
No change in the final size of the struct results; the 2 byte gap is
just moved to the end, as seen with pahole:

-       /* XXX 2 bytes hole, try to pack */
        ...
        /* size: 72, cachelines: 2, members: 15 */
        ...
+       /* padding: 2 */

Changing this simplifies future introspection[1] of maxpacket's type during
allocations:

drivers/usb/gadget/function/f_tcm.c:330:24: error: 'typeof' applied to a bit-field
     330 |  fu->cmd.buf = kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);

Link: https://lore.kernel.org/all/202407090928.6UaOAZAJ-lkp@intel.com [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb/gadget.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 56dda8e1562d..df33333650a0 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -229,18 +229,18 @@ struct usb_ep {
 
 	const char		*name;
 	const struct usb_ep_ops	*ops;
+	const struct usb_endpoint_descriptor	*desc;
+	const struct usb_ss_ep_comp_descriptor	*comp_desc;
 	struct list_head	ep_list;
 	struct usb_ep_caps	caps;
 	bool			claimed;
 	bool			enabled;
-	unsigned		maxpacket:16;
-	unsigned		maxpacket_limit:16;
-	unsigned		max_streams:16;
 	unsigned		mult:2;
 	unsigned		maxburst:5;
 	u8			address;
-	const struct usb_endpoint_descriptor	*desc;
-	const struct usb_ss_ep_comp_descriptor	*comp_desc;
+	u16			maxpacket;
+	u16			maxpacket_limit;
+	u16			max_streams;
 };
 
 /*-------------------------------------------------------------------------*/
-- 
2.34.1

