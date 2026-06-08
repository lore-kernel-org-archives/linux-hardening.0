Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E043B8BC5
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=VHvGOgRrgrwNjufODVxplS0M9jQSH9iDl7gTapE3LUKeSrYXdMDddkQsmfoBEDedHHsADUSVU61EeZSjbuCZ++Z/uQHVW0F/th8sLLZX8Q7mZlHwVYOnogxUPcp+1jHBFv5bwNch0G0nkGtWgfe7JM93PiuUF3gTX0RHVPoJAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=CUnk1x4Eyy6ryZSFFNaF6TJX8Udx6rdz9M3iokDqJFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6ksAtbuyU0a3v+MfFalMmz6XesD678luQL53fRMB7IEyKsU4krOFrO/PeXm0dEdB2E+i5akxiG6XYfQm/ApVNxuknANxMHDrSp+K1dY24OoY5yeJsQaZFx3J1nvxXvDVp+Mft6uK9bAxBvWWIboP5qf6AP9SorsszppFXID+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=biNIzAz6; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="biNIzAz6"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhq-00BrCj-VB; Mon, 08 Jun 2026 11:55:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=r8QChCZOPOfFyXua0/xPt0BiIg2IJIRKQo24+m6hMA0=; b=biNIzA
	z6OYJb8x1jNUvoqgC6J61I/yeG5JlSTZJwXxQmCVzHOUe+hYXlwzl7JVgPmrCNjjrGLEYaTOGTXay
	XDYfCxh02BRRWgIjeB/tulJFpl7Qv/ngGNI9Sgn1fuUPwPJVOsJsmRORKHJLmkOi5WZZ+73rMvB3h
	gS0AFYQ7S9AZWd7mQ/T78khtdgXqeFkqIFuVxX89ejlD04Ptz+2ywPQS8zGT/DVc89H16b1rv4PKg
	RhOyRCm4735Y9LFE5K1YM8noeInoJPRTFgnr2Xwl856OcVYWEHAzikcfERrJVciMF6TtQI+JiKkvj
	Z+od1DI+tOGjqD/J4Vag3rzhO8sg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhq-0003fC-2a; Mon, 08 Jun 2026 11:55:42 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWho-00Ag6G-H1;
	Mon, 08 Jun 2026 11:55:40 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] usb_string_copy: Use kzalloc() to avoid leaking old data
Date: Mon,  8 Jun 2026 10:55:21 +0100
Message-Id: <20260608095523.2606-37-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

If the string is read while being updated (which is why the copy is done
in place) and the new string is longer than the old one, then the reader
can read memory that isnt part of either string.

Use memcpy() to copy the known length string instead of strcpy.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/usb/gadget/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 183a25f65ac8..4518dc6bb5af 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -125,11 +125,11 @@ static int usb_string_copy(const char *s, char **s_copy)
 	if (copy) {
 		str = copy;
 	} else {
-		str = kmalloc(USB_MAX_STRING_WITH_NULL_LEN, GFP_KERNEL);
+		str = kzalloc(USB_MAX_STRING_WITH_NULL_LEN, GFP_KERNEL);
 		if (!str)
 			return -ENOMEM;
 	}
-	strcpy(str, s);
+	memcpy(str, s, ret + 1);
 	if (str[ret - 1] == '\n')
 		str[ret - 1] = '\0';
 	*s_copy = str;
-- 
2.39.5

