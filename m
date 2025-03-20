Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC42063EE
	for <linux-hardening@vger.kernel.org>; Thu, 20 Mar 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489887; cv=none; b=NDE8G8frLYPmWOvDnGaP4u75scaxKd6zAvE5Na+JsfMGgWa/HiVRadkEgPMj79xJ2MAH4kqEE+rVzZApzcrR1pc6aX9sALG8o93P669u6CP+4JG4PgVRPd6QLr8PyjJj/ZBKgeaIc1p2Ixw5hqTiTaVv+M0j1wAydtT2tIaTXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489887; c=relaxed/simple;
	bh=dyIhQWaY4fiplUjXQOOGrh2L5RiQUibHfO1gKrRs7O8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObsdsntH7kjn5PbQjZz64Bp8ewQ90ibe20vlbvw8uNoGNly0JoocszsrLJKR7HOOLwKJQyOfB9JDceY7eRUcLtXh+oPW9Rg76XGE+JO4vhmrOQdgA1b34eKoZgENqoYP0nM3kr9wE/ScwfHX+WYHyYN1kRExDaRwaBVrVDL/nO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JEuXukIP; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JEuXukIP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742489873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZHXa8rRgShcH/Fzedr+KAxXDW6SI/idDSVZI7FKt2Kk=;
	b=JEuXukIP+6vbMe5mDzrTcOcZ5R4dUvl4zXrcQGPU3pJQqoplt7o5Z+obT/6Ud0FYCzUe/d
	jpvcSaOJehYOe/MgUeipVZBY8D28xT2u4up3ZPvfIj14VgR0y3fqo/pRMdpzU2pJcP8FnT
	QCC2qb87dn0+n+zT18KyJ7AJBr6tjvI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: gadget: Replace deprecated strncpy() with strscpy()
Date: Thu, 20 Mar 2025 17:56:44 +0100
Message-ID: <20250320165647.34859-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers; use
strscpy() instead. Since kzalloc() already zeroes out the destination
buffer, the potential NUL-padding by strncpy() is unnecessary. strscpy()
copies only the required characters and guarantees NUL-termination.

Since the destination buffer has a fixed length, strscpy() automatically
determines its size using sizeof() when the argument is omitted. This
makes an explicit sizeof() call unnecessary.

The source string is also NUL-terminated and meets the __must_be_cstr()
requirement of strscpy().

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/usb/gadget/legacy/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index b6a30d88a800..fcce84a726f2 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1615,7 +1615,7 @@ static int activate_ep_files (struct dev_data *dev)
 		mutex_init(&data->lock);
 		init_waitqueue_head (&data->wait);
 
-		strncpy (data->name, ep->name, sizeof (data->name) - 1);
+		strscpy(data->name, ep->name);
 		refcount_set (&data->count, 1);
 		data->dev = dev;
 		get_dev (dev);
