Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B93590D1;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=TAu8twgfii/bda07ACGAGApLETArhIuCkBBnMgGmm6A+IU6KFhsCyy1YgxgSJS88frGPROVUOB6YvvmxtOJhMtLbjJFSI0Y6sOw+zS5UIHF8Vjy9I1d9wttlObqIb1b6IaKenwAiQshTiGNEAWFz7LTXnvI+VFuvGQkwFBynUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=I/r87jAWKSx+9k53qSEfwjXKAwqwD5/EwejaTkqMOBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVh5rBv5qY+jifKVd8ITMMzztpVQkl0hCGBMxv1UrW2rmIPkL2655FSWihKuTOmgzU9gH29etjLTx9mswKE32C1/swSGE2DCbzUxkPCdFNzVMF0wpafEEG11iWq/ubJ398VXwhqtYD4ixOfNK/jYrs94T7TnCcV+/IzeLoWLUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls6wCREO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls6wCREO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8C2C4AF17;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=I/r87jAWKSx+9k53qSEfwjXKAwqwD5/EwejaTkqMOBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ls6wCREOsdkPS2BTmCqVOWdk0RKi1xRFTee7pRAQWejzpXdGMH6S1Hh9Na1813ySw
	 26AORe9EZE7bUOTYNO0dMl3b1hsqYSZkM6Nsc8V8v50Y74yttswcOUv0cuFkGIdyJi
	 aklMf1EzHWX0lj0jtHYhsJQOX+zKcc1cZEgwjbMckY2ydS+d3sz9dPsJpJ78bgvUJf
	 RUtbk80zbUoz1VbLWqo1Oa6kRd1nhaSFxvk3BdQtxwUSVDXbSKq1XuVKBfKfhmvfdr
	 j6qbCWbGDl0m7Uf9wbBqlBfjkHDTuUgqqfg06a41UeHtQ1NhP32rJxRWJwkWeWJdQk
	 wisdK+HAXSpRg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVlX-0Eaz;
	Sat, 31 Jan 2026 15:25:20 +0100
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
Subject: [PATCH v4 27/41] docs: kdoc_re: don't remove the trailing ";" with NestedMatch
Date: Sat, 31 Jan 2026 15:25:01 +0100
Message-ID: <68f663611c61411b0e638947347fb3b8f33c8630.1769867953.git.mchehab+huawei@kernel.org>
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

Removing it causes the parse to break some conversions, when
NestedMatch is used on macros like __attribute__().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index a49b42e3d189..294051dbc050 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -358,10 +358,6 @@ class NestedMatch:
 
             out += new_sub
 
-            # Drop end ';' if any
-            if pos < len(line) and line[pos] == ';':
-                pos += 1
-
             cur_pos = pos
             n += 1
 
-- 
2.52.0

