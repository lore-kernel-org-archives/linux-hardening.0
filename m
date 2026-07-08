Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C233A9E9;
	Wed,  8 Jul 2026 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483723; cv=none; b=Jdb2FOuScWwuv7mj1o0epnLd8iq+wx7P5neSOLr6F1fr9NQ3eWAJWVxPeLjnRh5nyloRnzoxBqcbaJIMXNa0ljbEsQod5BmeBj/EbGAFf4bHQbQLvGnkI/619elh383JTJpHLqVtGsaCnWBOgB2Wvo/5EXcEKVnT+AmpS5Pp4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483723; c=relaxed/simple;
	bh=Xsav68/k8u2ibdNmt0N/AdtLRDqEprsyCa/ss6nVIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uBBzZBBew6Y00JxADjKFq0oDyrTPgh67pBR1GioiHuW9eO6trUybixRhpiRKzg31XJcOR6TqeivZ1wCanio7YeySjTi5v6GFjMoaRWDHzu4CcadH7pBEcWEoLB8MgiL0aL1WNH2IRNOaXXkpfgIxfYQgs5MOLyF39xsWao8Pkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=YzEAxt/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXlkEm0m; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="YzEAxt/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXlkEm0m"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 1AD7013008B9;
	Wed,  8 Jul 2026 00:08:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 00:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1783483719; x=1783487319; bh=CcPxx50ZDwk/QtaMvqR4RlJzWtNM/e0v
	5J0eo0yBm5s=; b=YzEAxt/wAd/i7dA0Qb63gTEYjiNEjHVEy0iOOjCee9mfkuAa
	6zPZ4ydx/RtvpMuFHV7GtRDK6nzL5wXC42aHdbe1B0MLdQVIhuB01XnNoOHCO/eR
	ZYdQsgcs4DvjEfH6fvYNUGjo2fbtJK7XC7uhHQqPEamCpoRQsN8lY01Rnma3mDny
	RYF4Q1+8k+Qiq235AB9O+Ci8KZE4ebjiOQOXc2pgoH9erT06RH7uti2TzseBOG0C
	Ze/gshvMNQZBVplUeMgedi1p+2UasVklq8zgj2dWSWJ0f42Qq/PWDtQFaxqsKmGz
	Cv4RcWpPlupo9FDPAin+9dImoR/z5YKxVtB8rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783483719; x=
	1783487319; bh=CcPxx50ZDwk/QtaMvqR4RlJzWtNM/e0v5J0eo0yBm5s=; b=P
	XlkEm0mJDHCT/pNbbEvPIuhWcES3hqUrf+z3uMvrHwg/o8ZTIOF7pc/XL9On8xRt
	D9pjwNZ4LYK628HMGqwVhxL9pVgoKSzhD+MKutYshNJjanKuNX71UGb/9nyBt2bW
	YZpwq84DCV7O1ijQR3ynu+PNSYFFOc1g+s8BOkGGJ/mNX/xy7A5U0lL3HbmFqRm8
	Bi13jVyX0VfAmgLLBENxZdaito3Oy6QRrftSnB3WOCJeIQVapHbqp2TLsE4wbisS
	/EyPY63mRTt6oyqWFbrH8G3JGDoEmd0zpvt6xHXXVOEwBTOX03IB/g13+hB8RmED
	VReUsuB5/HsmW+NXxmi3A==
X-ME-Sender: <xms:R81Nap_dSLF_IbuKIMOK0BKQgMmMb6Qi-7hZP5ranWPBlmkLLGzLww>
    <xme:R81NamqQsyd0-nHqepxdDro9waKdZoWrjEAfW6xwTzaJJ3vk2p5_eGO2RivqrTy8X
    UE_ozD7pBsughoaXP_2AaV_MP1XpMYKsuau-g4WDTm0Q7_YVWhpl0Q>
X-ME-Received: <xmr:R81NaikBJZ8vAAX3PIwxQNuy5yqIp-NEp8SXqq9RLfv9bfoMlwB2JkK2gxM>
X-ME-Proxy-Cause: dmFkZTEMpky7wJp+iMCZScKJbpk7BVLjsVcRTqBPAtRKMJnxESJpwF9a0lDxJaKLAa1eJh
    DH1F6BJkb+czvYruY1MDGH9ipuzT2ibWWc2T5+RPZa1az/pMfLBBqhH2DGEGFa6UjmCDQl
    w+G9z5T2MW0ejg6vrtxaX4BMNDZBesHPhPABEUdax3hU9J+afmZjdFugz6v/qnXnfuGFrM
    0cekerB5u9OF6rtr/yad58fgVlBx+bVbLLj2pXdMycLd6Mkdw7cyZ1KGkQNekspDlYNhL6
    dK+OpAeYHPczZW5qC8o/FMPzQYqJHTlU0icjgeg14hu+KPhTDLq2cxvasYE4IesMYR9UJe
    Z1c1hrl5qnRzaGXoG5vF0GK8e10XP4fzedyD63zCPT9yNuEuOHLtFVkFU4mf6ra+MM2dfQ
    BjgJ7b1UbtZT1fbyGSCABL7kYtHYTpubiNIKgmErclM50j6A/67AWmH+WSZSprZyMGbghg
    wjTup3A2T/hwWxSqj2cNXCLSrbFVHT0CBF4vR2YMBKpKohYFHzHuHXLMas041TTAa2jFOH
    JS8mABiaA/X0rycQieiIQyxx+XM5+UwpLputcSJIwqEG6XVwXYym2AlRnagcMH7sS+2k2n
    aKiCKNgu28TBvQsoMR0TMqqIbjXLU/KchGU1wV/gtU3LLGLqlgfLnLfiwUAA
X-ME-Proxy: <xmx:R81NatiVCZn0dr7I2G2_WP5UBRJlqf28lJ0tz3bDggv0OkD--NVBVA>
    <xmx:R81Naqc3mIGOfj_1LeIhYx4yraIFnJTQ0jdulhxZiF9ICXJU54OAww>
    <xmx:R81NatgrsfOTnQwKUZGn85iTKPo-4uf_sYkfnpmHUpwDm1VX84pmcA>
    <xmx:R81NaiyKaRGBNtReF9Ygv-pYZouuShUkypx2Z7SP3eNyhsdxbhPeJQ>
    <xmx:R81Nasd2agCxCJBMqfvlqlZqrRxAc6yZHB4PovMzs0qPfi9EZQTtPCYT>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 00:08:39 -0400 (EDT)
Date: Tue, 7 Jul 2026 23:08:37 -0500
From: Ian Bridges <icb@fastmail.org>
To: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] orangefs: replace strlcat() with seq_buf and strscpy()
Message-ID: <ak3NRWYJ5JuEscve@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In preparation for removing the strlcat() API[1], replace its uses in
orangefs_prepare_debugfs_help_string().

The function accumulates a variable number of keyword lines into a
fixed buffer, which is what seq_buf is for. Each keyword line becomes
a single seq_buf_printf(). The old code detected overflow through the
return value of the last strlcat(). The seq_buf_has_overflowed()
function reports the same condition directly. The final transfer into
debug_help_string lands in a buffer that was just zeroed, so it is a
plain copy and becomes strscpy(). The output is unchanged in all
cases.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
The patch was tested as follows:
 - An x86_64 build of fs/orangefs/orangefs-debugfs.o at W=1 produces
   no warnings.
 - A userspace comparison of the old and new construction ran with
   randomized keyword lists and buffer sizes. The buffer bytes, the
   overflow decisions, and the final copies were identical in every
   case.
 - Base and patched orangefs.ko were loaded in a QEMU guest. The
   complete /sys/kernel/debug/orangefs/debug-help file is identical
   before and after the change.

 fs/orangefs/orangefs-debugfs.c | 38 ++++++++++++++--------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 69bd73a2b556..107942ce1adf 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -36,6 +36,7 @@
  * 			no need for a "verbose".
  */
 #include <linux/debugfs.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 
 #include <linux/uaccess.h>
@@ -622,7 +623,7 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 	char *client_title = "Client Debug Keywords:\n";
 	char *kernel_title = "Kernel Debug Keywords:\n";
 	size_t string_size =  DEBUG_HELP_STRING_SIZE;
-	size_t result_size;
+	struct seq_buf sb;
 	size_t i;
 	char *new;
 	int rc = -EINVAL;
@@ -640,16 +641,13 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 	}
 
 	/*
-	 * strlcat(dst, src, size) will append at most
-	 * "size - strlen(dst) - 1" bytes of src onto dst,
-	 * null terminating the result, and return the total
-	 * length of the string it tried to create.
-	 *
 	 * We'll just plow through here building our new debug
-	 * help string and let strlcat take care of assuring that
-	 * dst doesn't overflow.
+	 * help string in a seq_buf, which is bounded by the buffer
+	 * size, keeps the string terminated, and records whether
+	 * anything failed to fit.
 	 */
-	strlcat(new, client_title, string_size);
+	seq_buf_init(&sb, new, string_size);
+	seq_buf_printf(&sb, "%s", client_title);
 
 	if (!at_boot) {
 
@@ -664,24 +662,18 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 			goto out;
 		}
 
-		for (i = 0; i < cdm_element_count; i++) {
-			strlcat(new, "\t", string_size);
-			strlcat(new, cdm_array[i].keyword, string_size);
-			strlcat(new, "\n", string_size);
-		}
+		for (i = 0; i < cdm_element_count; i++)
+			seq_buf_printf(&sb, "\t%s\n", cdm_array[i].keyword);
 	}
 
-	strlcat(new, "\n", string_size);
-	strlcat(new, kernel_title, string_size);
+	seq_buf_printf(&sb, "\n%s", kernel_title);
 
-	for (i = 0; i < num_kmod_keyword_mask_map; i++) {
-		strlcat(new, "\t", string_size);
-		strlcat(new, s_kmod_keyword_mask_map[i].keyword, string_size);
-		result_size = strlcat(new, "\n", string_size);
-	}
+	for (i = 0; i < num_kmod_keyword_mask_map; i++)
+		seq_buf_printf(&sb, "\t%s\n",
+			       s_kmod_keyword_mask_map[i].keyword);
 
 	/* See if we tried to put too many bytes into "new"... */
-	if (result_size >= string_size) {
+	if (seq_buf_has_overflowed(&sb)) {
 		kfree(new);
 		goto out;
 	}
@@ -691,7 +683,7 @@ int orangefs_prepare_debugfs_help_string(int at_boot)
 	} else {
 		mutex_lock(&orangefs_help_file_lock);
 		memset(debug_help_string, 0, DEBUG_HELP_STRING_SIZE);
-		strlcat(debug_help_string, new, string_size);
+		strscpy(debug_help_string, new, string_size);
 		mutex_unlock(&orangefs_help_file_lock);
 		kfree(new);
 	}
-- 
2.47.3

