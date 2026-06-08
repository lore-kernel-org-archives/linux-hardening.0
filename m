Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960351DDC28;
	Mon,  8 Jun 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912529; cv=none; b=KW/Ezq63oaTQysJNp4WAwRt6hOSQKT+veYDo08a2ROg4ZPVMuHqyEZHTXZ2N8qDpH/rGENsVuuc1+twif74DVhq7EmOeV8bvxR8t3C5OvHRwz4UIOdOge2Zix1w+sb2RYn1oV/zQifsNKLrJdTTjyT62mwwN8lljWi5s1DZjI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912529; c=relaxed/simple;
	bh=8xZTCMT1S4DywamflLNbNoywCGXTThmHwn6krkZadPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFwjLmhDLGytqYa5gSYQb/JsvIUybvl+o+M1gwG5i2QEL+Z3+OXNIgVf1OdgaBpYe4bgtBx1TuvmX6YaCGqEpKYxWdfPQ31pY61ubJOCpGRMzV9q1/9F2UZFmHGHy0n285MkyJ1+y8cx1HZrq45OoMqXTHVS55XovuaW9ElBaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=M/SGKXW2; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="M/SGKXW2"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhR-00BRu7-7X; Mon, 08 Jun 2026 11:55:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=YJxqU3/Bh65yY+mdsy2M8hRFDTrWYAZvZQi8IuYPC5A=; b=M/SGKX
	W2mlUXfh003hqndNrqDHL+Ea68Z6Z+BuGmmL0Bj1k5iJotyKCD/mwhnseIM2Uo+59el/sFJYg7Mh4
	sJZN+BYN43MVm87VWJLeCqYgI8e6rVxoOKe1CGsiE1PCvZa0KQZqTCxclTBqoXTQG5hKzcE8MHq5p
	i5j8DA5rKwxOGrna1p4iakOTDfFC+nV9kFifBOtWUDpXUd65W0GCNvqPxjiWzEz6VGM52C74vL7IX
	WBqUGyQYZEnfP+UBciv5hI3cMoegcbfmHzj6vzpqkcKVG6mUbC2yU11VsRffg3iZLMSW6/x9GlFgt
	dRtkPTQXI4GJQDv6ZQUe4wa8KK4g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhQ-0003ZO-Es; Mon, 08 Jun 2026 11:55:16 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhG-00Afz8-Fv;
	Mon, 08 Jun 2026 11:55:06 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/sfc/ethtool_common: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:55:00 +0100
Message-Id: <20260608095500.2567-5-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

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

 drivers/net/ethernet/sfc/ethtool_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 54f8e4626568..deb4d3e54573 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -270,7 +270,7 @@ static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 			snprintf(unit_str, sizeof(unit_str),
 				 unit_format, unit_id);
 		else
-			strcpy(unit_str, unit_format);
+			strscpy(unit_str, unit_format);
 		snprintf(test_str, sizeof(test_str), test_format, test_id);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
 			 ETH_GSTRING_LEN,
-- 
2.39.5

