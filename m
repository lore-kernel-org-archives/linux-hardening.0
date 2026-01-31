Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D635771C;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=B4Wee1Cy2RUPKrLNNqtI8rYj1WwDvkICK14vyKN3JmLbplaD4fIPsW4OOakB3O1FBGWf0kBPaSwmZMT5Gr8nOEioi1Onj03dHqwbZIrGfmDnW08FbfJXwSJEwrL0dl6zdscvVo+dXWyBA6KrZeJmIoks5ARU1s2KXftwziRKJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=cDzNSL27IncK8WPRKmlP9JMukq5yWhzhTMzDMh9MrSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVov3wBEDYfTMwKz5YobSNymkxXie2BUcsJacFdPIliGLBFAXYcPa39dKP/5bIL92iuV0oW/o2C1vUlgl+M7Tmt3vqSPs/po6NysBdVRugZPi4/mtBRJl+BMxeWsXJddWlkjLjbGNFlBUM69vmVRZbchmNPXB36rPKHiE7qLyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEDWcGd3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEDWcGd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E77CC2BCB0;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=cDzNSL27IncK8WPRKmlP9JMukq5yWhzhTMzDMh9MrSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PEDWcGd36euZpi8nOiel3TXpYdJOL8abL9z7ynodbLLhy6rzLqH6A8vSGVIswFiDA
	 3y5hQspd0NPBIj/tAoDiMDAMaRyJ9qyRI3pSP1lif0B5157uLWHc6XKebCgeHgxaaa
	 whWaaVTQKCyrRQUroRgucN/UNavm1g/fH50aiq6ALDRfF+g1TiLRrSX4AAhuZb/luH
	 trXAg7Lp6wQYMHHRMh3baqgO/j/SwREzI1gjamVgtw8pwvJpTjeFCqUXf+Y5XIjpBn
	 FefP8nlRqqX6DwsYD353Icu7UoRIRA0woOB1cHIzO3Kj+ErLdVj+KJg84eorZ3P47G
	 LBDnMRsAFsxGw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVjs-1UXg;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 02/41] docs: kdoc_re: don't go past the end of a line
Date: Sat, 31 Jan 2026 15:24:36 +0100
Message-ID: <e7811e28fcdb928ba88d4cf510717fbb029989b3.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The logic which checks if the line ends with ";" is currently
broken: it may try to read past the buffer.

Fix it by checking before trying to access line[pos].

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 19e777e2c97e..a0402c065d3a 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -265,7 +265,7 @@ class NestedMatch:
             out += new_sub
 
             # Drop end ';' if any
-            if line[pos] == ';':
+            if pos < len(line) and line[pos] == ';':
                 pos += 1
 
             cur_pos = pos
-- 
2.52.0

