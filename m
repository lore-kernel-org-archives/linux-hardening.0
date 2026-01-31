Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42387358D3A;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=FNob03bQjTuIY7U/jySsgwHzluvfUh01uW9lYqjxemQlDpyyHw9XBlHneUjlTk4pAzqxrMkLK5ksYqEN0AnocYR5y8FPO5y1az1PmisS/rbWYgcxYFduWoPj2NxO/+YaYQMWXOoGuM9wjNs3ez78I2cx/+6VvMEzXujh1MMU99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=3ksnXE7vkIV4Gy30ihYdParnXgZsaJn15iVxtzuvJ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNJRLt5hfswOfCA+A/sKeuQL2b1CdxJSHhlf/RgPeKE7VFwExFqL6DZnm/aBN+kpjOdj15jJkxJWEBhk+ddUUFsHu0R1A5Ts6B6jMqN815J2cjyDwuomXTU9tMnoryL7SRfcCh2BxD4SPRlA+cJhk5EuxFeSucbxrZEiO1zkWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maeQ6NIQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maeQ6NIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7430C2BD00;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=3ksnXE7vkIV4Gy30ihYdParnXgZsaJn15iVxtzuvJ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maeQ6NIQqyOmmMZ1bq5xg5TRiG9YE2TRuw+KFDcCAsstytrpri5AUbDdMoLYCiXr/
	 Rzio2GydR6Dv/NeY8AaELoinK8d3kO8b14GsDxBQOXiKDSIfrvkW8VRmUcxB9cEZgC
	 fXjwoxKc20EccgAV+k3X/REHlwxfOR/k6YuxvsezhNWh+8S+X8rPO6+cVeCa2XjZOM
	 GnM0CzQiWWMBEOlM30V2pP+ybuhnqmpUJToGMueBZ32g3EaVRy1gC7nL+NVQabpkRV
	 UqhQyt5cLn+oBww9CIfdBLoka3VzVOScA55A2YjFcQ6k823LBoIjCs56dpbGTYn3wR
	 8nre1pj0Z7i+g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVlE-3xBx;
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
Subject: [PATCH v4 23/41] docs: kdoc_re: add a helper class to declare C function matches
Date: Sat, 31 Jan 2026 15:24:57 +0100
Message-ID: <019e85b047f25aa5472d447e1ed087cd077a79f6.1769867953.git.mchehab+huawei@kernel.org>
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

Add a more convenient class to match C functions and avoiding
issues at the beginning and ending of NestedMatch inits.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 5f455ffff7b2..a49b42e3d189 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -380,3 +380,14 @@ class NestedMatch:
         """
 
         return f'NestedMatch("{self.regex.regex.pattern}")'
+
+
+class CFunction(NestedMatch):
+    r"""
+    Variant of NestedMatch.
+
+    It overrides the init method to ensure that the regular expression will
+    start with a ``\b`` and end with a C function delimiter (open parenthesis).
+    """
+    def __init__(self, regex):
+        self.regex = KernRe(r"\b" + regex + r"\s*\(")
-- 
2.52.0

