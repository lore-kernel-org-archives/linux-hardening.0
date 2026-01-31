Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5F354AC6;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869521; cv=none; b=AWOTvaxbeY8i9D8Utf3daKbiPSDxwm6WhrfD1LQZGKX+knFB5hW5bvLvRRLMe3OHc28xfyphu7HqfwjE/bi6FIiE+cmWqPpK5H2zN8b+3lub+Eh6Z6kOMwpklQZ50QWCKVe7seyuKl6giP0ryaCyAj9IlqtgBB+R0OcM+KbwGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869521; c=relaxed/simple;
	bh=QZmQg75J0lv0h13oBHLpIAAeXL/qqKinXYAYwI6HMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fal1e6SMdD8m0zL2kQT9a9SDB/NIHImpJkVfOOggjdVEYooEBqNAvk+IV7nrz6ewoQVrVF8A9bbnB2FDgz0nQqJzKslAtMFLLXns3qWT6Wv2uwiXVTzjeNT5OiVGNY5fk1Znu8y8BVpv/vlI7nH/IgdQrD7V8xSchowQwy9X6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb52ZuNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb52ZuNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E05C19422;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=QZmQg75J0lv0h13oBHLpIAAeXL/qqKinXYAYwI6HMj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sb52ZuNdHSAwnw9jy/Z/wDHDrcVla27f/hRVnMlGy/aibPbxaldBrAqR2uYMLC2v8
	 ZQ0WlxPuXkkhFzv58wNqN28fh+RXHqX/pIAkOBwAiK/LdMBfTuIE0OaVjCxWk0M1Mc
	 inzeV2TvC9xmm2wt1Ddh8FLWgQ3yfPlfO87QJVYnk2PdWGQ8Sld5tjtokXTi4E6rm+
	 RTaxpbtpnKS2T5qcfzCvX5SqLQlY7w0OlBKm5gBvPvGPX/syJnbMCMiMmfg7GrMy/1
	 pBz+M5ZZIFlvX1iK+GNNIeQYa6Dncl1XHhs8UwvnzDiEqjYLMB5aJ54SmUUaARt44B
	 uE4n8/2GxRguA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkO-2RA7;
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
Subject: [PATCH v4 10/41] docs: kdoc_parser: don't exclude defaults from prototype
Date: Sat, 31 Jan 2026 15:24:44 +0100
Message-ID: <1d202b0774652e5b7258b50735955da6948dc633.1769867953.git.mchehab+huawei@kernel.org>
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

If we do that, the defaults won't be parsed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index ccee4e0bcaab..0b6cba442d72 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -207,7 +207,6 @@ var_xforms = [
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-    (KernRe(r"=.*"), ""),
 ]
 
 #
-- 
2.52.0

