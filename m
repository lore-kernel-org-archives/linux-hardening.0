Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDF3B7B6E;
	Mon,  8 Jun 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=bayc8lCA7J2ggdwESeErCLpUaNcus22PrDyQ3By+UwsAqw0a6yYYdqXCsuhD41++/VZIKsEZI4Rd5iHQWKgOspwa840CRRgMzJS68ZUO+HwsuVeYS50lxT3t7UPuvvbnQBUtvQlAPTmnXV+x+Q5Pn2ZOgtL4lTqQrILCHTBHSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=fwkSclmv7zXrxMa7LixNPRcySgSLvRduB6rJl0SK4xE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6g8v0WlLvI4rcb413MTDJ1l1EuxyIVYueHb6rO+WHWLv1HiJa8lNEba5XA1KvzXPDDAbb3T5IIZUu9gTqSUr8sUgKkbCB6QSJg4yBnRSuCve90IFSOREwW3nQ9YiAeHLdDYw3qARY56qAQkSd0GQn1YqmpXMPmrW7jK7KzU22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=UxBFv1KO; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="UxBFv1KO"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhp-00BrAF-6C; Mon, 08 Jun 2026 11:55:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=M36WUcNSFtFDRlFNyuVbr++JtidnpZqb5ya4W1uD25Y=; b=UxBFv1
	KOOowH2J5s170TS4fqvaYcFabAqzB4ZI0hcKwcwUteZaIehwA2YGWkw9Qz2Ja3ZaME/FCExr+81eZ
	Rbs5RzKUB0Qocv2BvuacGrxBjaVQUEvoDjvGnvwjs/yxzm6fqnd0RvGLJEHPszn98H4PAtsfKDEB9
	NQ5dht9K7NxLVmie8LqNzLTOPKQtDbDbps3g8Fwc6iX7g0yl8Mt5NfnDl4yTsQxeCG3wXQ5oxyr6G
	WHGhsm3IcDM2jB05yvxKy/P0/COS1BmnbiIkukzwUg6CjrVuDrgRBWwgwkhxptDwsrx6CdCCwOdUb
	t+IeXtf5H4tLjEuMveBo+T3VRE+g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWho-0000FI-Lf; Mon, 08 Jun 2026 11:55:40 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhe-00Ag6G-8Y;
	Mon, 08 Jun 2026 11:55:30 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/devlink: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:56 +0100
Message-Id: <20260608095523.2606-12-david.laight.linux@gmail.com>
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

 net/devlink/param.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..dba0a0431052 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -540,7 +540,7 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 		if (len == nla_len(param_data) ||
 		    len >= __DEVLINK_PARAM_MAX_STRING_VALUE)
 			return -EINVAL;
-		strcpy(value->vstr, nla_data(param_data));
+		strscpy(value->vstr, nla_data(param_data));
 		break;
 	case DEVLINK_PARAM_TYPE_BOOL:
 		if (param_data && nla_len(param_data))
-- 
2.39.5

