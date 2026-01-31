Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6D3542F6;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=BVqauaq0Vku5dwH8+lt+e1biLp++D09DjFi2SbRGrhBr3FQAKA3YOuREY3F6GYteesRc1F156qljdj+R0GDrP7VBCyeHv4hn611ILH1U6QYd5w2lUXLoXIWu/pvV2c82UpH9Gzzvm6IH/BpjHkoM5ylZuVaV5UY3erCXhkacFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=gMIMQCBzXE8M1JL5w9F3R5TyIvM3vcLDpK3YDNHeLyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki9zeVGLPYO+iPzez9xz3eavR33Lqms1SRNJleRQINEju+wqaht3h+vLqdisP2E1Vpqrta5D3GfmXJ+wuI8skwXFax+qrcxL9lcZ0A/udyIBvaC7/mJgDF0E9s0K2/Vv1B+Wq+6Av+1WPU056kvQPEqwrvbSnLnX4X2iv27QBiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itzFgM1h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itzFgM1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74611C2BC9E;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=gMIMQCBzXE8M1JL5w9F3R5TyIvM3vcLDpK3YDNHeLyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=itzFgM1hHQtINK9Tggf9nZluKqT1tfa33omgqV7sSa4Pogr/jZmmS3rJPEfY3DhiN
	 QjKK5oCCmyQxC2pIqEI/guZsIXdLh+bFKIPOZ4Ne6UrbsC3Ysdg768tiB3tP2XdNU0
	 IcP01cHajYZ2ff9yXY77rkpq0Iusq3XNv80hFLcy0TGna1bsaBIDkEclwuzxRgpOwf
	 amm4WJguATio9mS6n0oXrQ6vic4mPWBXPwk2VCUI5NgF/5RCKmwmF0rNt8GrR4O4lN
	 mnv3YsyHSG7vayq2JYn4QRUwmnstoq6Jz9YIGGoglJLdhetsm6rMpeVwT1I3u2fQu1
	 Ywk2eSmwuk4QA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVjo-1Mqq;
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
Subject: [PATCH v4 01/41] docs: kdoc_re: add support for groups()
Date: Sat, 31 Jan 2026 15:24:35 +0100
Message-ID: <fb753f9fe5ecbb218917da0b5787c66ecfa1a918.1769867953.git.mchehab+huawei@kernel.org>
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

Add an equivalent to re groups() method.
This is useful on debug messages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 2816bd9f90f8..19e777e2c97e 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -106,6 +106,13 @@ class KernRe:
 
         return self.last_match.group(num)
 
+    def groups(self):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.groups()
+
 
 class NestedMatch:
     """
-- 
2.52.0

