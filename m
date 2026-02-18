Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD0342C92;
	Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409601; cv=none; b=OIueI+iTn4sX3FMDHEswF5WMsHW+VY2npeUYZtV7OvM2z/8TRiZB7e6X0WGSllDT0zqXP7lQi+Z9OGRW7G8JiWVT83eF3/ctVWONp2qaAbipdb+Vz7mckaIscCDO1Qu4MrAp6YTkkunwjyg00jBc1jT68eHb6gRVkUGQ1LqMRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409601; c=relaxed/simple;
	bh=4U9S92uLRAA+mWktHmpbTnn1LtPaRCq0xSK6dVoNpwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRm31Y3h2ofAPLYFbzrHjY0igPIILNuJqPK0vylid10559v6ZucYuIhZryKIRTgUPb2NXqbygGHy74CmcJPiEhzF41+8mcxcGP9pjxuP4kUGF1AX+PRZltiEY2HVXJQ7XPsgXcwsyr1/B/cYmpLVEm5pw4eInWT/jWC5VX8vkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUD/rytU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUD/rytU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C01C2BC87;
	Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409601;
	bh=4U9S92uLRAA+mWktHmpbTnn1LtPaRCq0xSK6dVoNpwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUD/rytUPezekhvGG4gguYlNKlT0NYLFimevTVRcd45FYlndGdTYGxw8bTV6Jdi2J
	 Mt/PB5/+kNrEnS8Exwz5EhrewWnsXSmeWQl0YqWEnFaT++QZSgWXoQmi0G8KhzgeI3
	 DRQavt8OfkLpJcZzzPPI6IrctkL0RM/8oqgVQHsrsAKv45NyjKZoi+OB9Ic/DoixTv
	 LNl0/2H/4zpAIIq2w3y7cp7+j9JPs1Wr5ZDlHt4BGhbGWrG47oAqeilMOEaUyfHEFP
	 ssHavLBu0u3s+iKiw2MMrbxl6KfBR9N9UmAtvdJTKgKgrLinVnjS0pp7TQ78wLgG9Y
	 tIKQeBIymGc9w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYZ-00000000LW4-2dI7;
	Wed, 18 Feb 2026 11:13:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 10/38] docs: kdoc_parser: don't exclude defaults from prototype
Date: Wed, 18 Feb 2026 11:12:40 +0100
Message-ID: <b283bdb3073ad6396345dda5875571bc47dd6215.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

If we do that, the defaults won't be parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 9559cbfd5e4c..d8e96c6c4ebc 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -208,7 +208,6 @@ var_xforms = [
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-    (KernRe(r"=.*"), ""),
 ]
 
 #
-- 
2.52.0

