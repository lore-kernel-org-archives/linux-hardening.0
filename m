Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE134DCD2;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409609; cv=none; b=I5iEA0ukexmRm3yR2FdzuEGFjG61AarSVzd2kFvJfhn/KaYX2SpcdpoQEJfetN7CBqTpi9p5JrRacYlTbXLopknLautl+YEC6v4qmCMq+ZCG9yNT5fJzldQW1aCdRoRQJkLhtw8LYVOK8XTdn/5TJjsWk83rwRsPKCAltloF7m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409609; c=relaxed/simple;
	bh=P5m12KaIRlLZkIbryHITxBCt1b6WqbNCa3v60HgP3pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iImC5dTtDsIdY9j+gyrk/1gw+LzbEE/7MfZEYmRicYrKei5KI30hBL+KZkPtGOaIoMSY98xhYSoOcohxbByX+fydgw16Po9HNlRXtBqf/G0/5Y3a82NBDj+SUkdynKgNR7p9PwrGHlUXZV17WE5hlhOZGzbfx0AX9qE5J2gc9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAcfGmf6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAcfGmf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E00C19425;
	Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409608;
	bh=P5m12KaIRlLZkIbryHITxBCt1b6WqbNCa3v60HgP3pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AAcfGmf63U6yk5n0NQY3nvBCQc9k0oCir9opirkc6aJj22+wR6i+ExY4JcFXV6lHL
	 AlpJRtLXH0n8p7tzAOryvoSZ3bJYT0FTzib176Y21ZYCkhFkJjzyUBUudRykL+LAIV
	 JkqNrDWo2oF1HI/eWoKXX9oYDtfA3fvHsERAk8kcdYLZA4I9H7IUreFLH54eGAEO3Y
	 CXB9kn6Icb+6pNpn+2cWxQIkx1bVVSPHdAWU1YhBChEa6noGwMM4RdcNBRlwEoZlMN
	 EOMOLG8k3FRMJ79uWF3keNgTU1suiFh/O/1Aa8TEMi36YSfCWjfUW9A2qELOzv9zCD
	 kfEtW5H+6WcdQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYh-00000000LrO-0bkQ;
	Wed, 18 Feb 2026 11:13:27 +0100
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
Subject: [PATCH 27/38] docs: kdoc_re: don't remove the trailing ";" with NestedMatch
Date: Wed, 18 Feb 2026 11:12:57 +0100
Message-ID: <a472199335411724935cf11a75916b78071cb24b.1771408406.git.mchehab+huawei@kernel.org>
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

Removing it causes the parse to break some conversions, when
NestedMatch is used on macros like __attribute__().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index f72b80ea4f1b..e3809aaa0310 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -361,10 +361,6 @@ class NestedMatch:
 
             out += new_sub
 
-            # Drop end ';' if any
-            if pos < len(line) and line[pos] == ';':
-                pos += 1
-
             cur_pos = pos
             n += 1
 
-- 
2.52.0

